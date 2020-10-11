//
//  JsonModel.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import Foundation

struct ResponseModel: Codable {
    var status: String = ""
    var code: String = ""
}

struct DataModel: Codable {
    var page: Int = 0
    var data: [JsonData] = []
}

struct JsonData: Codable {
    var name: String? = nil
    var country: String? = nil
    var lat: Double? = nil
    var lon: Double? = nil
}

