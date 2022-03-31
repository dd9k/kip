//
//  NativeResponse.swift
//  Runner
//
//  Created by Lee Wong Hao on 7/27/20.
//

import Foundation

struct NativeResponse: Codable {
    var status: String?
    var data: [PrinterInfor]?
    var errorCode: String?
}
