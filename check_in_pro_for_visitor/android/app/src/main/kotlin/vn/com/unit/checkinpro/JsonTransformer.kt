package vn.com.unit.checkinpro

import com.google.gson.Gson
import com.google.gson.JsonObject
import com.google.gson.reflect.TypeToken
import vn.com.unit.checkinpro.NativeRequest
import vn.com.unit.checkinpro.NativeResponse
import vn.com.unit.checkinpro.PrinterInfor
import org.json.JSONObject

/**
 * Json convert.
 *
 * @author Khoadd
 * 17/09/2019
 */
class JsonTransformer {

    var gson = Gson()

    fun jsonStringToPrinterInfor(jsonString: String): PrinterInfor {
        return gson.fromJson(jsonString, PrinterInfor::class.java)
    }

    fun jsonStringToArrayPrinterInfor(jsonArrayString: String): ArrayList<PrinterInfor> {
        return gson.fromJson(jsonArrayString, object : TypeToken<ArrayList<PrinterInfor>>() {
        }.type)
    }
    
    fun printerInforToJsonString(printerInfor: PrinterInfor): String {
        return gson.toJson(printerInfor)
    }

    fun arrayPrinterInforToJsonString(array: ArrayList<PrinterInfor>): String {
        return gson.toJson(array)
    }

    fun jsonStringToJsonObject(jsonString: String): JsonObject {
        return gson.fromJson(jsonString, JsonObject::class.java) as JsonObject
    }

    fun jsonStringToJSONObject(jsonString: String): JSONObject {
        return gson.fromJson(jsonString, JSONObject::class.java) as JSONObject
    }

    fun jsonStringToNativeResponse(jsonString: String): NativeResponse {
        return gson.fromJson(jsonString, NativeResponse::class.java)
    }

    fun nativeResponseToJsonString(nativeResponse: NativeResponse): String {
        return gson.toJson(nativeResponse)
    }

    fun jsonStringToNativeRequest(jsonString: String): NativeRequest {
        return gson.fromJson(jsonString, NativeRequest::class.java)
    }

    fun nativeRequestToJsonString(nativeResponse: NativeRequest): String {
        return gson.toJson(nativeResponse)
    }

    companion object {
        // Singleton instance
        private var instance: JsonTransformer? = null

        /**
         * Get singleton instance.
         *
         * @return Singleton instance
         */
        fun getInstance(): JsonTransformer {
            if (instance == null) {
                instance = JsonTransformer()
            }
            return instance as JsonTransformer
        }
    }
}