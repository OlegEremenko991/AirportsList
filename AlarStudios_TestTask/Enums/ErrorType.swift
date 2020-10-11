//
//  ErrorModel.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 07.10.2020.
//

import Foundation

enum ErrorType: String, Error {
    case invalidLoginPassword = "Incorrect login/password"
    case invalidData = "The data recieved is invalid"
    case requestFailed = "The request failed, check your Internet connection"
    case noLoginPassword = "Please enter your login and password"
}
