package vn.com.unit.checkinpro

import android.annotation.TargetApi
import android.app.ActivityManager
import android.app.ActivityManager.LOCK_TASK_MODE_NONE
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.admin.DevicePolicyManager
import android.app.admin.SystemUpdatePolicy
import android.content.*
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Matrix
import android.os.*
import android.provider.Settings
import android.util.Log
import android.view.KeyEvent
import android.view.View
import com.brother.ptouch.sdk.LabelInfo
import com.brother.ptouch.sdk.NetPrinter
import com.brother.ptouch.sdk.Printer
import com.brother.ptouch.sdk.PrinterInfo
import com.brother.ptouch.sdk.PrinterInfo.ErrorCode
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.loader.FlutterLoader
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.BufferedInputStream
import java.io.File
import java.io.InputStream
import java.util.concurrent.Callable
import java.util.concurrent.ExecutionException
import java.util.concurrent.Executors

class MainActivity : FlutterActivity() {
    private var disableVolume: Boolean = false
    private lateinit var nativeRequest: NativeRequest
    var result: MethodChannel.Result? = null
    private lateinit var mAdminComponentName: ComponentName
    private lateinit var mDevicePolicyManager: DevicePolicyManager

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        this.registerChannel()
        MethodChannel(flutterEngine.dartExecutor, Contanst.CHANNEL_PRINTER).setMethodCallHandler { call, rawResult ->
            this.result = MethodResultWrapper(rawResult)
            nativeRequest = JsonTransformer.getInstance().jsonStringToNativeRequest(call.method)
            PrinterTask(this).execute(nativeRequest.actions)
        }
        MethodChannel(flutterEngine.dartExecutor, Contanst.CHANNEL_MEMORY).setMethodCallHandler { call, rawResult ->
            val result = MethodResultWrapper(rawResult)
            when (call.method) {
                Contanst.ACTION_MEMORY -> {
                    val memory = getMemory()
                    result.success(memory)
                }
                Contanst.ACTION_ENABLE_LOCK -> {
                    setKioskPolicies(true, isAdmin())
                    result.success(true)
                }
                Contanst.ACTION_DISABLE_LOCK -> {
                    setKioskPolicies(false, isAdmin())
                    result.success(true)
                }
                Contanst.ACTION_IS_LOCK -> {
                    result.success(isInLockTask())
                }
                Contanst.ACTION_GO_HOME -> {
                    resetPreferredLauncherAndOpenChooser()
                    result.success(true)
                }
                Contanst.ACTION_IS_LAUNCHER -> {
                    result.success(isMyLauncherDefault())
                }
            }
        }
        mAdminComponentName = MyDeviceAdminReceiver.getComponentName(this)
        mDevicePolicyManager = getSystemService(Context.DEVICE_POLICY_SERVICE) as DevicePolicyManager
        val componentName = ComponentName(this, FakeLauncherActivity::class.java)
        packageManager.setComponentEnabledSetting(componentName, PackageManager.COMPONENT_ENABLED_STATE_DISABLED, PackageManager.DONT_KILL_APP)
    }

    private fun isAdmin() = mDevicePolicyManager.isDeviceOwnerApp(packageName)

    private fun isInLockTask(): Boolean {
        val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        if (activityManager.lockTaskModeState != LOCK_TASK_MODE_NONE) {
            return true
        }
        return false
    }

    private fun setKioskPolicies(enable: Boolean, isAdmin: Boolean) {
        disableVolume = enable
        if (isAdmin) {
            setRestrictions(enable)
            enableStayOnWhilePluggedIn(enable)
            setUpdatePolicy(enable)
            setAsHomeApp(enable)
            setKeyGuardEnabled(enable)
        }
        setLockTask(enable, isAdmin)
        setImmersiveMode(enable)
    }

    private fun isMyLauncherDefault(): Boolean {
        return ArrayList<ComponentName>().apply {
            packageManager.getPreferredActivities(
                    arrayListOf(IntentFilter(Intent.ACTION_MAIN).apply { addCategory(Intent.CATEGORY_HOME) }),
                    this,
                    packageName
            )
        }.isNotEmpty()
    }

    private fun resetPreferredLauncherAndOpenChooser() {
        val componentName = ComponentName(this, FakeLauncherActivity::class.java)
        packageManager.setComponentEnabledSetting(componentName, PackageManager.COMPONENT_ENABLED_STATE_ENABLED, PackageManager.DONT_KILL_APP)

        val startMain = Intent(Intent.ACTION_MAIN)
        startMain.addCategory(Intent.CATEGORY_HOME)
        startMain.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(startMain)

        packageManager.setComponentEnabledSetting(componentName, PackageManager.COMPONENT_ENABLED_STATE_DISABLED, PackageManager.DONT_KILL_APP)
    }

    override fun dispatchKeyEvent(event: KeyEvent): Boolean {
        return when (event.keyCode) {
            KeyEvent.KEYCODE_VOLUME_UP, KeyEvent.KEYCODE_VOLUME_DOWN -> disableVolume
            else -> super.dispatchKeyEvent(event)
        }
    }

    // region restrictions
    private fun setRestrictions(disallow: Boolean) {
        setUserRestriction(UserManager.DISALLOW_SAFE_BOOT, disallow)
        setUserRestriction(UserManager.DISALLOW_FACTORY_RESET, disallow)
        setUserRestriction(UserManager.DISALLOW_ADD_USER, disallow)
        setUserRestriction(UserManager.DISALLOW_MOUNT_PHYSICAL_MEDIA, disallow)
        setUserRestriction(UserManager.DISALLOW_ADJUST_VOLUME, disallow)
        mDevicePolicyManager.setStatusBarDisabled(mAdminComponentName, disallow)
    }

    private fun setUserRestriction(restriction: String, disallow: Boolean) = if (disallow) {
        mDevicePolicyManager.addUserRestriction(mAdminComponentName, restriction)
    } else {
        mDevicePolicyManager.clearUserRestriction(mAdminComponentName, restriction)
    }
    // endregion

    private fun enableStayOnWhilePluggedIn(active: Boolean) = if (active) {
        mDevicePolicyManager.setGlobalSetting(mAdminComponentName,
                Settings.Global.STAY_ON_WHILE_PLUGGED_IN,
                (BatteryManager.BATTERY_PLUGGED_AC
                        or BatteryManager.BATTERY_PLUGGED_USB
                        or BatteryManager.BATTERY_PLUGGED_WIRELESS).toString())
    } else {
        mDevicePolicyManager.setGlobalSetting(mAdminComponentName, Settings.Global.STAY_ON_WHILE_PLUGGED_IN, "0")
    }

    private fun setLockTask(start: Boolean, isAdmin: Boolean) {
        if (isAdmin) {
            mDevicePolicyManager.setLockTaskPackages(
                    mAdminComponentName, if (start) arrayOf(packageName) else arrayOf())
        }
        if (start) {
            startLockTask()
        } else {
            stopLockTask()
            packageManager.clearPackagePreferredActivities(packageName)
        }
    }

    private fun setUpdatePolicy(enable: Boolean) {
        if (enable) {
            mDevicePolicyManager.setSystemUpdatePolicy(mAdminComponentName,
                    SystemUpdatePolicy.createWindowedInstallPolicy(60, 120))
        } else {
            mDevicePolicyManager.setSystemUpdatePolicy(mAdminComponentName, null)
        }
    }

    private fun setAsHomeApp(enable: Boolean) {
        if (enable) {
            val intentFilter = IntentFilter(Intent.ACTION_MAIN).apply {
                addCategory(Intent.CATEGORY_HOME)
                addCategory(Intent.CATEGORY_DEFAULT)
            }
            mDevicePolicyManager.addPersistentPreferredActivity(
                    mAdminComponentName, intentFilter, ComponentName(packageName, MainActivity::class.java.name))
        } else {
            mDevicePolicyManager.clearPackagePersistentPreferredActivities(
                    mAdminComponentName, packageName)
        }
    }

    private fun setKeyGuardEnabled(enable: Boolean) {
        mDevicePolicyManager.setKeyguardDisabled(mAdminComponentName, !enable)
    }

    private fun setImmersiveMode(enable: Boolean) {
        if (enable) {
            val flags = (View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                    or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                    or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                    or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                    or View.SYSTEM_UI_FLAG_FULLSCREEN
                    or View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY)
            window.decorView.systemUiVisibility = flags
        } else {
            val flags = (View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                    or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                    or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN)
            window.decorView.systemUiVisibility = flags
        }
    }

    private fun createIntentSender(context: Context?, sessionId: Int, packageName: String?): IntentSender? {
        val intent = Intent("INSTALL_COMPLETE")
        if (packageName != null) {
            intent.putExtra("PACKAGE_NAME", packageName)
        }
        val pendingIntent = PendingIntent.getBroadcast(
                context,
                sessionId,
                intent,
                0)
        return pendingIntent.intentSender
    }

    private fun getFlutterView(): BinaryMessenger? {
        return flutterEngine?.dartExecutor?.binaryMessenger
    }

    private fun getMemory(): Long {
        val mi = ActivityManager.MemoryInfo()
        val activityManager: ActivityManager? = context.getSystemService(ACTIVITY_SERVICE) as ActivityManager
        activityManager?.getMemoryInfo(mi)
        return mi.totalMem
    }

    @TargetApi(Build.VERSION_CODES.O)
    private fun registerChannel() {
        val channel = NotificationChannel(
                getString(R.string.default_notification_channel_id),
                "CheckinPro",
                NotificationManager.IMPORTANCE_HIGH
        )
        val manager: NotificationManager = getSystemService(NotificationManager::class.java) as NotificationManager
        manager.createNotificationChannel(channel)
    }

    private class PrinterTask(var mainActivity: MainActivity) : AsyncTask<String, Void, String>() {

        override fun doInBackground(vararg params: String?): String? {
            return when (params[0]) {
                Contanst.ACTION_PRINTER_FIND -> {
                    findPrinter()
                }
                Contanst.ACTION_PRINTER_TEST -> {
                    printTest()
                }
                Contanst.ACTION_PRINTER_PRINT -> {
                    printImage()
                }
                else -> {
                    null
                }
            }
        }

        override fun onPostExecute(result: String?) {
            result?.let {
                mainActivity.result?.success(result)
            } ?: run {
                mainActivity.result?.notImplemented()
            }
            super.onPostExecute(result)
        }

        @Throws(InterruptedException::class, ExecutionException::class)
        fun findPrinter(): String {
            val executor = Executors.newSingleThreadExecutor()
            val callable: Callable<String?> = Callable {
                val nativeResponse: NativeResponse?
                val printer = Printer()
                val printerList: ArrayList<NetPrinter> = ArrayList()
                printerList.addAll(printer.getNetPrinters(Contanst.PRINTER_QL810W))
                nativeResponse = if (printerList.isNotEmpty()) {
                    val listPrinterInfor = ArrayList<PrinterInfor>()
                    for (value in printerList) {
                        val printerInfor = PrinterInfor(Contanst.BROTHER, value.ipAddress, value.modelName, false, 1)
                        listPrinterInfor.add(printerInfor)
                    }
                    NativeResponse(Contanst.SUCCESS, listPrinterInfor, null)
                } else {
                    NativeResponse(Contanst.FAIL, null, Contanst.ErrorCode.NO_PRINTER)
                }
                JsonTransformer.getInstance().nativeResponseToJsonString(nativeResponse)
            }
            val future = executor.submit(callable)
            return future.get().toString()//returns 2 or raises an exception if the thread dies, so safer
        }

        private fun printImage(): String {
            var nativeResponse = NativeResponse(Contanst.FAIL, null, Contanst.ErrorCode.COMMUNICATION_ERROR)
            val file = File(mainActivity.filesDir?.absolutePath + Contanst.FOLDER_BADGE, Contanst.BADGE_FILE_TEMPLATE)
            if (file.exists()) {
                val option = BitmapFactory.Options()
                option.inSampleSize = 8
                val bitmap = BitmapFactory.decodeStream(file.inputStream())
                val matrix = Matrix()
                matrix.postRotate(90f)
                val rotatedBitmap = Bitmap.createBitmap(bitmap, 0, 0, bitmap.width, bitmap.height, matrix, true)
                // Specify printer
                val printer = Printer()
                val settings: PrinterInfo = printer.printerInfo
                settings.printerModel = PrinterInfo.Model.QL_810W
                settings.port = PrinterInfo.Port.NET
                settings.ipAddress = mainActivity.nativeRequest.data?.ipAddress
                settings.workPath = mainActivity.filesDir.absolutePath
                settings.numberOfCopies = mainActivity.nativeRequest.data?.numberOfCopy ?: 1
                // Print Settings
                settings.labelNameIndex = LabelInfo.QL700.W62.ordinal
                settings.printMode = PrinterInfo.PrintMode.FIT_TO_PAGE
                settings.isAutoCut = true
                settings.printQuality = PrinterInfo.PrintQuality.HIGH_RESOLUTION
                printer.printerInfo = settings

                if (printer.startCommunication()) {
                    val result = printer.printImage(rotatedBitmap)
                    nativeResponse = if (result.errorCode != ErrorCode.ERROR_NONE) {
                        NativeResponse(Contanst.FAIL, null, getErrorCode(result.errorCode))
                    } else {
                        NativeResponse(Contanst.SUCCESS, null, null)
                    }
                    printer.endCommunication()
                } else {
                    nativeResponse = NativeResponse(Contanst.FAIL, null, Contanst.ErrorCode.COMMUNICATION_ERROR)
                }
            } else {
                nativeResponse = NativeResponse(Contanst.FAIL, null, Contanst.ErrorCode.NO_TEST_IMAGE)
            }
            return JsonTransformer.getInstance().nativeResponseToJsonString(nativeResponse)
        }

        private fun printTest(): String {
            var nativeResponse = NativeResponse(Contanst.FAIL, null, Contanst.ErrorCode.COMMUNICATION_ERROR)
            val myAssetPath = "assets/images/${Contanst.BADGE_FILE_TEST}"
            val assetLookupKey = FlutterLoader.getInstance().getLookupKeyForAsset(myAssetPath)
            val inputStream: InputStream = mainActivity.applicationContext.assets.open(assetLookupKey)

            val bufferedInputStream = BufferedInputStream(inputStream)
            val bitmap = BitmapFactory.decodeStream(bufferedInputStream)
            if (bitmap != null) {
                val printer = Printer()
                val settings: PrinterInfo = printer.printerInfo
                settings.printerModel = PrinterInfo.Model.QL_810W
                settings.port = PrinterInfo.Port.NET
                settings.ipAddress = mainActivity.nativeRequest.data?.ipAddress
                settings.workPath = mainActivity.filesDir.absolutePath
                settings.numberOfCopies = mainActivity.nativeRequest.data?.numberOfCopy ?: 1
                // Print Settings
                settings.labelNameIndex = LabelInfo.QL700.W62.ordinal
                settings.printMode = PrinterInfo.PrintMode.FIT_TO_PAGE
                settings.isAutoCut = true
                settings.printQuality = PrinterInfo.PrintQuality.HIGH_RESOLUTION
                printer.printerInfo = settings

                if (printer.startCommunication()) {
                    Log.d("PRINTER", "start communication")
                    val result = printer.printImage(bitmap)
                    nativeResponse = if (result.errorCode != ErrorCode.ERROR_NONE) {
                        NativeResponse(Contanst.FAIL, null, getErrorCode(result.errorCode))
                    } else {
                        NativeResponse(Contanst.SUCCESS, null, null)
                    }
                    printer.endCommunication()
                } else {
                    Log.d("PRINTER", "cannot start communication")
                    nativeResponse = NativeResponse(Contanst.FAIL, null, Contanst.ErrorCode.COMMUNICATION_ERROR)
                }
            } else {
                nativeResponse = NativeResponse(Contanst.FAIL, null, Contanst.ErrorCode.NO_TEST_IMAGE)
            }
            Log.d("PRINTER", nativeResponse.toString())
            return JsonTransformer.getInstance().nativeResponseToJsonString(nativeResponse)
        }



        fun getErrorCode(errorCode: ErrorCode): String {
            when (errorCode) {
                ErrorCode.ERROR_NOT_SAME_MODEL ->
                    return Contanst.ErrorCode.NOT_SAME_MODEL
                ErrorCode.ERROR_BROTHER_PRINTER_NOT_FOUND ->
                    return Contanst.ErrorCode.BROTHER_PRINTER_NOT_FOUND
                ErrorCode.ERROR_PAPER_EMPTY ->
                    return Contanst.ErrorCode.PAPER_EMPTY
                ErrorCode.ERROR_BATTERY_EMPTY ->
                    return Contanst.ErrorCode.BATTERY_EMPTY
                ErrorCode.ERROR_COMMUNICATION_ERROR ->
                    return Contanst.ErrorCode.COMMUNICATION_ERROR
                ErrorCode.ERROR_OVERHEAT ->
                    return Contanst.ErrorCode.OVERHEAT
                ErrorCode.ERROR_PAPER_JAM ->
                    return Contanst.ErrorCode.PAPER_JAM
                ErrorCode.ERROR_HIGH_VOLTAGE_ADAPTER ->
                    return Contanst.ErrorCode.HIGH_VOLTAGE_ADAPTER
                ErrorCode.ERROR_FEED_OR_CASSETTE_EMPTY ->
                    return Contanst.ErrorCode.FEED_OR_CASSETTE_EMPTY
                ErrorCode.ERROR_SYSTEM_ERROR ->
                    return Contanst.ErrorCode.SYSTEM_ERROR
                ErrorCode.ERROR_NO_CASSETTE ->
                    return Contanst.ErrorCode.NO_CASSETTE
                ErrorCode.ERROR_WRONG_CASSETTE_DIRECT ->
                    return Contanst.ErrorCode.WRONG_CASSETTE_DIRECT
                ErrorCode.ERROR_CREATE_SOCKET_FAILED ->
                    return Contanst.ErrorCode.CREATE_SOCKET_FAILED
                ErrorCode.ERROR_CONNECT_SOCKET_FAILED ->
                    return Contanst.ErrorCode.CONNECT_SOCKET_FAILED
                ErrorCode.ERROR_GET_OUTPUT_STREAM_FAILED ->
                    return Contanst.ErrorCode.GET_OUTPUT_STREAM_FAILED
                ErrorCode.ERROR_GET_INPUT_STREAM_FAILED ->
                    return Contanst.ErrorCode.GET_INPUT_STREAM_FAILED
                ErrorCode.ERROR_CLOSE_SOCKET_FAILED ->
                    return Contanst.ErrorCode.CLOSE_SOCKET_FAILED
                ErrorCode.ERROR_OUT_OF_MEMORY ->
                    return Contanst.ErrorCode.OUT_OF_MEMORY
                ErrorCode.ERROR_SET_OVER_MARGIN ->
                    return Contanst.ErrorCode.SET_OVER_MARGIN
                ErrorCode.ERROR_NO_SD_CARD ->
                    return Contanst.ErrorCode.NO_SD_CARD
                ErrorCode.ERROR_FILE_NOT_SUPPORTED ->
                    return Contanst.ErrorCode.FILE_NOT_SUPPORTED
                ErrorCode.ERROR_EVALUATION_TIMEUP ->
                    return Contanst.ErrorCode.EVALUATION_TIMEUP
                ErrorCode.ERROR_WRONG_CUSTOM_INFO ->
                    return Contanst.ErrorCode.WRONG_CUSTOM_INFO
                ErrorCode.ERROR_NO_ADDRESS ->
                    return Contanst.ErrorCode.NO_ADDRESS
                ErrorCode.ERROR_NOT_MATCH_ADDRESS ->
                    return Contanst.ErrorCode.NOT_MATCH_ADDRESS
                ErrorCode.ERROR_FILE_NOT_FOUND ->
                    return Contanst.ErrorCode.FILE_NOT_FOUND
                ErrorCode.ERROR_TEMPLATE_FILE_NOT_MATCH_MODEL ->
                    return Contanst.ErrorCode.TEMPLATE_FILE_NOT_MATCH_MODEL
                ErrorCode.ERROR_TEMPLATE_NOT_TRANS_MODEL ->
                    return Contanst.ErrorCode.TEMPLATE_NOT_TRANS_MODEL
                ErrorCode.ERROR_COVER_OPEN ->
                    return Contanst.ErrorCode.COVER_OPEN
                ErrorCode.ERROR_WRONG_LABEL ->
                    return Contanst.ErrorCode.WRONG_LABEL
                ErrorCode.ERROR_PORT_NOT_SUPPORTED ->
                    return Contanst.ErrorCode.PORT_NOT_SUPPORTED
                ErrorCode.ERROR_WRONG_TEMPLATE_KEY ->
                    return Contanst.ErrorCode.WRONG_TEMPLATE_KEY
                ErrorCode.ERROR_BUSY ->
                    return Contanst.ErrorCode.BUSY
                ErrorCode.ERROR_TEMPLATE_NOT_PRINT_MODEL ->
                    return Contanst.ErrorCode.TEMPLATE_NOT_PRINT_MODEL
                ErrorCode.ERROR_CANCEL ->
                    return Contanst.ErrorCode.CANCEL
                ErrorCode.ERROR_PRINTER_SETTING_NOT_SUPPORTED ->
                    return Contanst.ErrorCode.PRINTER_SETTING_NOT_SUPPORTED
                ErrorCode.ERROR_INVALID_PARAMETER ->
                    return Contanst.ErrorCode.INVALID_PARAMETER
                ErrorCode.ERROR_INTERNAL_ERROR ->
                    return Contanst.ErrorCode.INTERNAL_ERROR
                ErrorCode.ERROR_TEMPLATE_NOT_CONTROL_MODEL ->
                    return Contanst.ErrorCode.TEMPLATE_NOT_CONTROL_MODEL
                ErrorCode.ERROR_TEMPLATE_NOT_EXIST ->
                    return Contanst.ErrorCode.TEMPLATE_NOT_EXIST
                ErrorCode.ERROR_BUFFER_FULL ->
                    return Contanst.ErrorCode.BUFFER_FULL
                ErrorCode.ERROR_TUBE_EMPTY ->
                    return Contanst.ErrorCode.TUBE_EMPTY
                ErrorCode.ERROR_TUBE_RIBBON_EMPTY ->
                    return Contanst.ErrorCode.TUBE_RIBBON_EMPTY
                ErrorCode.ERROR_UPDATE_FRIM_NOT_SUPPORTED ->
                    return Contanst.ErrorCode.UPDATE_FRIM_NOT_SUPPORTED
                ErrorCode.ERROR_OS_VERSION_NOT_SUPPORTED ->
                    return Contanst.ErrorCode.OS_VERSION_NOT_SUPPORTED
                ErrorCode.ERROR_RESOLUTION_MODE ->
                    return Contanst.ErrorCode.RESOLUTION_MODE
                ErrorCode.ERROR_POWER_CABLE_UNPLUGGING ->
                    return Contanst.ErrorCode.POWER_CABLE_UNPLUGGING
                ErrorCode.ERROR_BATTERY_TROUBLE ->
                    return Contanst.ErrorCode.BATTERY_TROUBLE
                ErrorCode.ERROR_UNSUPPORTED_MEDIA ->
                    return Contanst.ErrorCode.UNSUPPORTED_MEDIA
                ErrorCode.ERROR_TUBE_CUTTER ->
                    return Contanst.ErrorCode.TUBE_CUTTER
                ErrorCode.ERROR_UNSUPPORTED_TWO_COLOR ->
                    return Contanst.ErrorCode.UNSUPPORTED_TWO_COLOR
                ErrorCode.ERROR_UNSUPPORTED_MONO_COLOR ->
                    return Contanst.ErrorCode.UNSUPPORTED_MONO_COLOR
                ErrorCode.ERROR_MINIMUM_LENGTH_LIMIT ->
                    return Contanst.ErrorCode.MINIMUM_LENGTH_LIMIT
                else ->
                    return Contanst.ErrorCode.COMMUNICATION_ERROR
            }
        }
    }

    private class MethodResultWrapper(private val methodResult: MethodChannel.Result) : MethodChannel.Result {
        private val handler: Handler = Handler(Looper.getMainLooper())
        override fun success(result: Any?) {
            handler.post { methodResult.success(result) }
        }

        override fun error(
                errorCode: String?, errorMessage: String?, errorDetails: Any?) {
            handler.post { methodResult.error(errorCode, errorMessage, errorDetails) }
        }

        override fun notImplemented() {
            handler.post { methodResult.notImplemented() }
        }

    }

}
