//
//  NetworkManager.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import Foundation

class NetworkManager {
    
    class func signIn (userName: String, password: String, completionHandler: @escaping (ResponseModel?, Error?) -> ()) {
        guard let request = RequestType.getAuthorization(userName, password).finalURL else { return }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error)
                print("\(error!)")
                return
            }
            do {
                guard let goodData = data else { return }
                let auth = try JSONDecoder().decode(ResponseModel.self, from: goodData)
                completionHandler(auth, nil)
            } catch {
                print(error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
    class func getData (code: String, pageNumber: Int, completionHandler: @escaping (DataModel?, Error?) -> ()) {
        guard let request = RequestType.getData(code, String(pageNumber)).finalURL else { return }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let goodData = data else { return }
            do {
                guard let dataModel = try JSONDecoder().decode(DataModel?.self, from: goodData) else { return }
                completionHandler(dataModel, nil)
            } catch {
                completionHandler(nil, error)
            }
        }
        
        task.resume()
    }
}
