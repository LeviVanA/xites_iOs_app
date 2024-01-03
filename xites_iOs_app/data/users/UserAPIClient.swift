//
//  UserAPIClient.swift
//  xites_iOs_app
//
//  Created by MAC on 03.01.24.
//

import Foundation
extension UserAPI{
    class Client{
        static let shared = Client()
        private let encoder = JSONEncoder()
        private let decoder = JSONDecoder()
        
        func fetch<Request, Response>(_ endpoint: Types.Endpoint,method: Types.Method = .post, body: Request? = nil, then callback : ((Result<Response, Types.Error>) -> Void)? = nil)where Request: Encodable, Response: Decodable{
            var urlRequest = URLRequest(url:endpoint.url)
            urlRequest.httpMethod = method.rawValue
            print(method.rawValue)
            
            if let body = body{
                do{
                    print("body")
                    let jsonData = try encoder.encode(body)
                    urlRequest.httpBody = jsonData
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    print(String(data: jsonData, encoding: .utf8)!)
                    print(urlRequest)
                    
                
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
        
        func post<Response>(_ endpoint: Types.Endpoint, body: Types.Request.UserRequest, then callback: ((Result<Response, Types.Error>) -> Void)? = nil) where Response : Decodable
        {
            print(body)
            fetch(endpoint, method:.post, body: body){
                result in callback?(result)
            }
        }
        
    }
}
