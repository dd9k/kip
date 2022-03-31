package vn.com.unit.checkinpro

class NativeResponse {
    private var status = Contanst.SUCCESS

    private var data: ArrayList<PrinterInfor>? = ArrayList()

    private var errorCode: String? = null

    constructor(status: String, data: ArrayList<PrinterInfor>?, errorCode: String?) {
        this.status = status
        this.data = data
        this.errorCode = errorCode
    }
    
    constructor()
}