//
//  APIClient.swift
//  xites_iOs_app
//
//  Created by MAC on 02.01.24.
//

import Foundation

extension TransactionAPI{
    class Client{
        static let shared = Client()
        private let encoder = JSONEncoder()
        private let decoder = JSONDecoder()
        
        func fetch<Request, Response>(_ endpoint: Types.Endpoint,method: Types.Method = .get, body: Request? = nil, then callback : ((Result<Response, Types.Error>) -> Void)? = nil)where Request: Encodable, Response: Decodable{
            var urlRequest = URLRequest(url:endpoint.url)
            urlRequest.httpMethod = method.rawValue
            
            if let body = body{
                do{
                    let bearer :String = Bearer.token
                    let jsonData = try encoder.encode(body)
                    urlRequest.httpBody = jsonData
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    urlRequest.setValue("Bearer \(bearer)", forHTTPHeaderField: "Authorization")
                
                    
                } catch {
                    callback?(.failure(.internal(reason: "could not encode body ")))
                    return
                }
            }
            
            let dataTask = URLSession.shared
                .dataTask(with: urlRequest){data, response, error in
                    if let error = error{
                        print(error)
                        callback?(.failure(.generic(reason: "could not fetch data")))
                    } else {
                        if let data = data{
                            do{
                                let result = try self.decoder.decode(Response.self, from: data)
                                callback?(.success(result))
                            } catch {
                                print(error )
                                callback?(.failure(.generic(reason: "could not decode data ")))
                            }
                        }
                    }
                    
                }
            dataTask.resume() 
        }
        func get<Response>(_ endpoint: Types.Endpoint, then callback: ((Result<Response, Types.Error>) -> Void)? = nil) where Response : Decodable
        {
            let body : Types.Request.Empty? = nil
            fetch(endpoint, method:.get, body: body){
                result in callback?(result)
            }
        }
        func post<Response>(_ endpoint: Types.Endpoint, body: Types.Request.RegistrationRequest, then callback: ((Result<Response, Types.Error>) -> Void)? = nil) where Response : Decodable
        {
            print(body)
            let body : Types.Request.RegistrationRequest = body
            fetch(endpoint, method:.post, body: body){
                result in callback?(result)
            }
        }
        
    }
}
