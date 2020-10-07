//
//  NetworkManager.swift
//  AlarStudios_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import Foundation

public final class NetworkService {
    
    static func signIn (userName: String, password: String, completion: @escaping (Result<ResponseModel, Error>) -> ()) {
        guard let request = RequestType.signIn(userName, password).url else { return }
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard error == nil else {
                completion(.failure(error!))
                print(error!)
                return
            }
            do {
                guard let goodData = data else { return }
                let auth = try JSONDecoder().decode(ResponseModel.self, from: goodData)
                completion(.success(auth))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    static func getData (code: String, pageNumber: Int, completion: @escaping (Result<DataModel, Error>) -> ()) {
        guard let request = RequestType.gatherData(code, String(pageNumber)).url else { return }

        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data else { return }
            do {
                guard let dataModel = try JSONDecoder().decode(DataModel?.self, from: data) else { return }
                completion(.success(dataModel))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
