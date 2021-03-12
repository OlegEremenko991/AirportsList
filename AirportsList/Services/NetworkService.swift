//
//  NetworkManager.swift
//  AirportsList_TestTask
//
//  Created by Олег Еременко on 02.10.2020.
//

import Foundation

final class NetworkService {

    typealias ResultCompletion<T> = (Result<T, ErrorType>) -> ()

    static let shared = NetworkService()

    // MARK: - Public methods

    func signIn (userName: String, password: String, completion: @escaping ResultCompletion<ResponseModel>) {
        guard let request = RequestType.signIn(userName, password).url else { return }
        dataTask(decodingType: ResponseModel.self,
                 with: request,
                 specificErrorType: .invalidLoginPassword,
                 completion: completion)
    }

    func getData(code: String, pageNumber: Int, completion: @escaping ResultCompletion<DataModel>) {
        guard let request = RequestType.gatherData(code, String(pageNumber)).url else { return }
        dataTask(decodingType: DataModel.self,
                 with: request,
                 specificErrorType: .invalidData,
                 completion: completion)
    }

    // MARK: - Private methods

    private func dataTask<T:Decodable>(decodingType: T.Type, with request: URL, specificErrorType: ErrorType, completion: @escaping ResultCompletion<T>) {
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
                let dataModel = try JSONDecoder().decode(decodingType, from: data)
                completion(.success(dataModel))
            } catch {
                completion(.failure(specificErrorType))
            }
        }
        task.resume()
    }

}
