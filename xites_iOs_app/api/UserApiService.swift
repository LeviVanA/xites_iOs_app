//
//  UserApiService.swift
//  xites_iOs_app
//
//  Created by MAC on 29.12.23.
//

import Foundation
import Combine

class UserAPIService {
    static let shared = UserAPIService()

    private init() {}

    func loginUser(username: String, password: String) -> AnyPublisher<User, Error> {
        guard let url = URL(string: "http://localhost:9000/api/user/login") else {
            return Fail(error: "Unable to generate url" as! Error).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let credentials = ["username": username, "password": password]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: credentials)
            request.httpBody = jsonData
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: User.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func registerUser(username: String, password: String, email: String) -> AnyPublisher<User, Error> {
        guard let url = URL(string: "http://localhost:9000/api/user/register") else {
            return Fail(error: "Unable to generate url" as! Error).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let newUser = User(username: username, password: password)

        do {
            let jsonData = try JSONEncoder().encode(newUser)
            request.httpBody = jsonData
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: User.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func promoteUserToAdmin(userId: String) -> AnyPublisher<User, Error> {
        guard let url = URL(string: "http://localhost:9000/api/promote/\(userId)") else {
            return Fail(error: "Unable to generate url" as! Error).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: User.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
