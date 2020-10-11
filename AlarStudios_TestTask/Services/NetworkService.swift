//
//  NetworkManager.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import Foundation

public final class NetworkService {
     
    static func signIn (userName: String, password: String, completion: @escaping (Result<ResponseModel, ErrorType>) -> ()) {
        guard let request = RequestType.signIn(userName, password).url else { return }
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            do {
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                let auth = try JSONDecoder().decode(ResponseModel.self, from: data)
                completion(.success(auth))
            } catch {
                completion(.failure(.invalidLoginPassword))
            }
        }
        task.resume()
    }
    
    static func getData (code: String, pageNumber: Int, completion: @escaping (Result<DataModel, ErrorType>) -> ()) {
        guard let request = RequestType.gatherData(code, String(pageNumber)).url else { return }

        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                guard let dataModel = try JSONDecoder().decode(DataModel?.self, from: data) else { return }
                completion(.success(dataModel))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
}
