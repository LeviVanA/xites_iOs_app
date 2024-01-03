//
//  APITypes.swift
//  xites_iOs_app
//
//  Created by MAC on 02.01.24.
//

import Foundation
extension UserAPI{
    enum Types{
        enum Response{
            struct GetValidatedBearer : Decodable  {
                let token : String
                let validated:Bool
            }
            struct GetBearer : Decodable  {
                let bearer : String
            }
            
            
            
        }
        enum Request{
            
            
            struct UserRequest: Codable{
                var name: String
                var password:String
            }
            
        }
        enum Error : LocalizedError{
            case generic(reason: String)
            case `internal`(reason: String )
            
            var errorDescription: String?{
                switch self{
                case .generic(let reason):
                    return reason
                case .internal(let reason):
                    return reason
                }
            }
        }
        enum Endpoint{
            case register
            case login
            var url : URL{
                var components = URLComponents()
                components.host = "localhost"
                components.port = 9000
                components.scheme = "http"
                switch self{
                case .login:
                    components.path = "/api/user/login"
                case .register:
                    components.path = "/api/user/register"
                
                }
                print(components.url!)
                return components.url!
            }
        }
        enum Method : String{
            case get
            case post
        }
    }
}
