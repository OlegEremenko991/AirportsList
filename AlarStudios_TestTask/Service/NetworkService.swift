//
//  NetworkManager.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import Foundation

class NetworkService {
    
    static func signIn (userName: String, password: String, completion: @escaping (ResponseModel?, Error?) -> ()) {
        guard let request = RequestType.logIn(userName, password).finalURL else { return }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(nil, error)
                print("\(error!)")
                return
            }
            do {
                guard let goodData = data else { return }
                let auth = try JSONDecoder().decode(ResponseModel.self, from: goodData)
                completion(auth, nil)
            } catch {
                print(error)
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    static func getData (code: String, pageNumber: Int, completion: @escaping (DataModel?, Error?) -> ()) {
        guard let request = RequestType.gatherData(code, String(pageNumber)).finalURL else { return }
        print(request)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let goodData = data else { return }
            do {
                guard let dataModel = try JSONDecoder().decode(DataModel?.self, from: goodData) else { return }
                completion(dataModel, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}
