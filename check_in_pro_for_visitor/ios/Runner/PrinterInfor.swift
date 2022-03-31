//
//  PrinterInfor.swift
//  Runner
//
//  Created by Lee Wong Hao on 7/27/20.
//

import Foundation

struct PrinterInfor: Codable {
    var type: String?
    var ipAddress: String?
    var model: String?
    var isConnect: Bool?
    var numberOfCopy: Int32?
}
