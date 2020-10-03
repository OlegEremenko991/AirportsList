//
//  RequestType.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import Foundation

enum RequestType {
    
    case signIn(String, String)
    case gatherData(String, String)
    
    // MARK: Public properties
    
    var url: URL? {
        return URL(string: stringURL)
    }
    
    var stringURL: String {
        switch self {
        case .signIn(let login, let password):
            return "http://www.alarstudios.com/test/auth.cgi?username=\(login)&password=\(password)"
        case .gatherData(let code, let pageNumber):
            return "http://www.alarstudios.com/test/data.cgi?code=\(code)&p=\(pageNumber)"
        }
    }
    
}
