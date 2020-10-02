//
//  JsonData.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import Foundation

struct JsonData: Codable {
    var id: String? = nil
    var name: String? = nil
    var country: String? = nil
    var lat: Double? = nil
    var lon: Double? = nil
}
