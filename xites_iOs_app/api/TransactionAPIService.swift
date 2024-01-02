//
//  APIService.swift
//  xites_iOs_app
//
//  Created by MAC on 27.12.23.
//

import Foundation
import Combine

class TransactionAPIService {

    static let shared = TransactionAPIService()

    func getRegistrations() -> AnyPublisher<[Registration], Error> {
        guard let url = URL(string: "http://localhost:9000/api/transactions/") else {
            return Fail(error: "Unable to generate url" as! Error).eraseToAnyPublisher()
        }
        return Future { promise in
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                DispatchQueue.main.async {
                    do {
                        guard let data = data else {
                            return promise(.failure("Something went wrong" as! Error))
                        }
                        let registrations = try JSONDecoder().decode([Registration].self, from: data)
                        return promise(.success(registrations))
                    } catch let error {
                        return promise(.failure(error))
                    }
                }
            }.resume()
        }.eraseToAnyPublisher()
    }
    func createRegistration(_ registration: RegistrationModel) -> AnyPublisher<RegistrationModel, Error> {
            guard let url = URL(string: "http://localhost:9000/api/transactions/") else {
                return Fail(error: "Unable to generate url" as! Error).eraseToAnyPublisher()
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                let jsonData = try JSONEncoder().encode(registration)
                request.httpBody = jsonData
            } catch {
                return Fail(error: error).eraseToAnyPublisher()
            }

            return Future { promise in
                URLSession.shared.dataTask(with: request) { (data, _, _) in
                    DispatchQueue.main.async {
                        do {
                            guard let data = data else {
                                return promise(.failure("Something went wrong" as! Error))
                            }
                            let createdRegistration = try JSONDecoder().decode(RegistrationModel.self, from: data)
                            return promise(.success(createdRegistration))
                        } catch let error {
                            return promise(.failure(error))
                        }
                    }
                }.resume()
            }.eraseToAnyPublisher()
        }
}
