package vn.com.unit.checkinpro

class PrinterInfor {
    var type = ""

    var ipAddress = ""

    var model = ""

    var isConnect = false

    var numberOfCopy = 1

    constructor(type: String, ipAddress: String, model: String, isConnect: Boolean, numberOfCopy: Int) {
        this.type = type
        this.ipAddress = ipAddress
        this.model = model
        this.isConnect = isConnect
        this.numberOfCopy = numberOfCopy
    }

    constructor()
}