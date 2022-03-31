import UIKit
import Flutter
import BRPtouchPrinterKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, BRPtouchNetworkDelegate{
    
    
   //pritner
   private var networkManager: BRPtouchNetworkManager?
   private var result: FlutterResult?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }
    guard let controller = window?.rootViewController as? FlutterViewController else {
         fatalError("rootViewController is not type FlutterViewController")
       }
    
    let channel = FlutterMethodChannel(name: "hardware", binaryMessenger: controller as! FlutterBinaryMessenger)
    channel.setMethodCallHandler({
        (call: FlutterMethodCall, result: FlutterResult) -> Void in
        guard call.method == Constant.ACTION_MEMORY else {
            result(FlutterMethodNotImplemented)
            return
        }
        self.getMemory(result: result)
    })
    
    GeneratedPluginRegistrant.register(with: self)
    let _: FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "flutter.native/helper", binaryMessenger: controller.binaryMessenger)
       batteryChannel.setMethodCallHandler({
           [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        let nativeReq: NativeRequest? = self?.getRequestInfo(jsonStr: call.method)
        let actionName = nativeReq?.actions ?? ""
        self?.result = result
        if(actionName == Constant.ACTION_PRINTER_FIND) {
            self?.startSearchWiFiPrinter()
            self?.yourGreatFeature(ipAddress: nativeReq?.data?.ipAddress ?? "")
        } else if(actionName == Constant.ACTION_PRINTER_PRINT) {
            self?.printImage(printerRequest: nativeReq?.data)
        } else if(actionName == Constant.ACTION_PRINTER_TEST) {
            self?.printTest(printerRequest: nativeReq?.data)
        } else {
            result(FlutterMethodNotImplemented)
            return
         }
     })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
   
    func getMemory(result: FlutterResult) {
      result(ProcessInfo.processInfo.physicalMemory)
    }
    
  func startSearchWiFiPrinter() {
      print("start search ")
     let manager = BRPtouchNetworkManager()
      manager.delegate = self
      manager.setPrinterName("Brother QL-810W")
      manager.startSearch(5)
      self.networkManager = manager
      print("end search ")
  }
    
    
    func yourGreatFeature(ipAddress: String) {
        guard let printer = BRPtouchPrinter(printerName: "QL-810W", interface: .WLAN) else {
            print("Unknown printer")
            return
        }
        printer.setIPAddress(ipAddress)
        if printer.startCommunication() {
            // Put any code to use printer
            printer.endCommunication()
        } else {
            print("Failed to connect")
        }
    }
    
    func printTest(printerRequest: PrinterInfor?) {
            let flutterViewController = FlutterViewController()
            //flutterViewController = scv  as! FlutterViewController
            let key = flutterViewController.lookupKey(forAsset:"assets/images/card_exmp.png")
            let path = Bundle.main.path(forResource: key, ofType: nil)
            var image : UIImage?
            image = UIImage(contentsOfFile: path ?? "")
            
        // Specify printer
             guard let printer = BRPtouchPrinter(printerName: "QL-810W", interface: .WLAN) else {
                 print("Unknown printer")
                 return
             }

            printer.setIPAddress(printerRequest?.ipAddress)
             // Print Settings
             let settings = BRPtouchPrintInfo()
             settings.strPaperName = "62mm"
             settings.nPrintMode = PRINT_FIT_TO_PAGE
             settings.nPrintQuality = PRINTQUALITY_HIGH_RESOLUTION
             settings.nAutoCutFlag = OPTION_AUTOCUT
//            settings.nAutoCutCopies = printerRequest?.numberOfCopy ?? 1
             
             printer.setPrintInfo(settings)

             // Connect, then print
             if printer.startCommunication() {
                 let errorCode = printer.print(image?.cgImage, copy: printerRequest?.numberOfCopy ?? 1)
                 if errorCode != ERROR_NONE_ {
                    print("ERROR - \(errorCode)")
                    self.result?(self.makeJsonError(errorCode: self.getMessageError(errorCode: self.getErrorCode(errorCode: errorCode)), mes: "Cannot find a Brother printer"))
                    return
                 } else {
                    printer.endCommunication()
                    self.result?(self.makeJsonSuccess(mes:"printer success"))
                    return
                }
             } else {
                self.result?(self.makeJsonError(errorCode: self.getMessageError(errorCode: "COMMUNICATION_ERROR"), mes: "Cannot find a Brother printer"))
                return
            }
           //result!(self.makeJsonSuccess(mes:"printer sucess"))
           print("End finish ")
    }
    
  //function printer image card
    func printImage(printerRequest: PrinterInfor?) {
        DispatchQueue.global(qos: .userInteractive).async {
            print("start finish ")
              var image : UIImage?
             
              //get file image card
              let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
              let userDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
              let paths             = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
              if let dirPath        = paths.first
              {
              
                 let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("/badge/card_printer.png")
                  print(imageURL)
                  print(imageURL.path)
                  image    = UIImage(contentsOfFile: imageURL.path)?.rotate(radians: .pi / 2)
                  //image    = UIImage(contentsOfFile: imageURL.path)
              }
              //roatate image

              // Specify printer
              guard let printer = BRPtouchPrinter(printerName: "QL-810W", interface: .WLAN) else {
                  print("Unknown printer")
                  return
              }

            printer.setIPAddress(printerRequest?.ipAddress)
              // Print Settings
              let settings = BRPtouchPrintInfo()
              settings.strPaperName = "62mm"
              settings.nPrintMode = PRINT_FIT_TO_PAGE
              settings.nPrintQuality = PRINTQUALITY_HIGH_RESOLUTION
              settings.nAutoCutFlag = OPTION_AUTOCUT
//            settings.nAutoCutCopies = printerRequest?.numberOfCopy ?? 1
              
              printer.setPrintInfo(settings)

              // Connect, then print
              if printer.startCommunication() {
                  let errorCode = printer.print(image?.cgImage, copy: printerRequest?.numberOfCopy ?? 1)
                  if errorCode != ERROR_NONE_ {
                      print("ERROR - \(errorCode)")
                    self.result?(self.makeJsonError(errorCode: self.getMessageError(errorCode: self.getErrorCode(errorCode: errorCode)), mes: "Cannot find a Brother printer"))
                      return
                  } else {
                    printer.endCommunication()
                    self.result?(self.makeJsonSuccess(mes:"Printer success"))
                    return
                }
              } else {
                self.result?(self.makeJsonError(errorCode: self.getMessageError(errorCode: "COMMUNICATION_ERROR"), mes: "Cannot find a Brother printer"))
                return
            }
            print("End finish ")
        }
   }
    
    func flutterAssetLottieFilePath(imageName : String) -> String {
        var flutterViewController = FlutterViewController()
        flutterViewController = UIWindow.init(frame: UIScreen.main.bounds).rootViewController as! FlutterViewController
        let key = flutterViewController.lookupKey(forAsset:"assets/images/\(imageName).png")
        let path = Bundle.main.path(forResource: key, ofType: nil)
        return path ?? ""
    }

    
  func didFinishSearch(_ sender: Any!) {
    print("start finish")
    guard let manager = sender as? BRPtouchNetworkManager else {
        result!(self.makeJsonError(errorCode: self.getMessageError(errorCode: self.getErrorCode(errorCode: ERROR_BROTHER_PRINTER_NOT_FOUND_)), mes: "Cannot find a Brother printer"))
        return
    }
    guard let devices = manager.getPrinterNetInfo() else {
        result!(self.makeJsonError(errorCode: self.getMessageError(errorCode: self.getErrorCode(errorCode: ERROR_BROTHER_PRINTER_NOT_FOUND_)), mes: "Cannot find a Brother printer"))
        return
    }
    print(devices)
    var lstPrinterInfo: [PrinterInfor] = []
    for deviceInfo in devices {
        if let deviceInfo = deviceInfo as? BRPtouchDeviceInfo {
            print("Model: \(String(describing: deviceInfo.strModelName ?? "")), IP Address: \(String(describing: deviceInfo.strIPAddress ?? ""))")
            var printerInfo: PrinterInfor = PrinterInfor()
            printerInfo.model = String(describing: deviceInfo.strModelName ?? "")
            printerInfo.ipAddress = String(describing: deviceInfo.strIPAddress ?? "")
            printerInfo.type = "brother"
            printerInfo.isConnect = false
            
            lstPrinterInfo.append(printerInfo)
        }
    }
    result!(self.makeJsonSuccessSearch(lstPrinterInfo))
      
    if(devices.count <= 0) {
        result!(self.makeJsonError(errorCode: self.getMessageError(errorCode: self.getErrorCode(errorCode: ERROR_BROTHER_PRINTER_NOT_FOUND_)), mes: "Cannot find a Brother printer"))
        return
    }
    print("end finish ")
  }

}

extension AppDelegate {
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func getRequestInfo(jsonStr: String) -> NativeRequest? {
        let jsonData = Data(jsonStr.utf8)
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(NativeRequest.self, from: jsonData)
            return result
        }
        catch {
            return nil
        }
    }
    
    func getModelPrinter(text: String) -> String {
    
        if let data = text.data(using: .utf8){
            do{
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                    if let ipAddress = json["model"] as? String{
                        return ipAddress
                    }
                }
                
            } catch {
                return ""
            }
        }
        return ""
    }
    
    func makeJsonSuccess(mes: String)->  String{
        var nativerespone = NativeResponse()
        nativerespone.status = "SUCCESS"
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(nativerespone)
            let jsonString = String(data: data, encoding: .utf8)!
            
            return jsonString
        }
        catch {
            return ""
        }
    }
    
    func makeJsonSuccessSearch(_ lstPrinterInfo: [PrinterInfor])->  String{
        var nativerespone = NativeResponse()
        nativerespone.status = "SUCCESS"
        nativerespone.errorCode = ""
        nativerespone.data = lstPrinterInfo
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(nativerespone)
            let jsonString = String(data: data, encoding: .utf8)!
            
            return jsonString
        }
        catch {
            return ""
        }
    }

    
    func makeJsonError(errorCode: String, mes: String)->  String {
        var nativerespone = NativeResponse()
        nativerespone.status = "FAIL"
        nativerespone.errorCode = errorCode
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(nativerespone)
            let jsonString = String(data: data, encoding: .utf8)!
            
            return jsonString
        }
        catch {
            return ""
        }
    }
    
    func getErrorCode(errorCode: Int32) -> String{
        switch errorCode {
        case ERROR_BADPAPERRES:
            return "ERROR_BADPAPERRES"
        case ERROR_PAPER_EMPTY_:
            return "ERROR_PAPER_EMPTY_"
        case ERROR_BROTHER_PRINTER_NOT_FOUND_:
            return "ERROR_BROTHER_PRINTER_NOT_FOUND_"
        case ERROR_COVER_OPEN_:
            return "ERROR_COVER_OPEN_"
        default:
            return "ERROR_BROTHER_PRINTER_NOT_FOUND_"
        }
    }
    
    func getMessageError(errorCode: String) -> String{
        switch errorCode {
        case "ERROR_PAPER_EMPTY_":
            return "paperempty"
        case "ERROR_BROTHER_PRINTER_NOT_FOUND_":
            return "brotherprinternotfound"
        case "ERROR_BADPAPERRES":
            return "communicationerror"
        case "ERROR_COVER_OPEN_":
            return "coveropen"
        case "COMMUNICATION_ERROR":
            return "communicationerror"
        default:
            return "communicationerror"
        }

    }
}

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
     var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
     // Trim off the extremely small float value to prevent core graphics from rounding it up
     newSize.width = floor(newSize.width)
     newSize.height = floor(newSize.height)

     UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
     let context = UIGraphicsGetCurrentContext()!

     // Move origin to middle
     context.translateBy(x: newSize.width/2, y: newSize.height/2)
     // Rotate around middle
     context.rotate(by: CGFloat(radians))
     // Draw the image at its center
     self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

     let newImage = UIGraphicsGetImageFromCurrentImageContext()
     UIGraphicsEndImageContext()

     return newImage
    }
}
