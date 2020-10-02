//
//  DataModel.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import Foundation

struct DataModel: Codable {
    var status: String = ""
    var page: Int = 0
    var data: [JsonData] = []
}
