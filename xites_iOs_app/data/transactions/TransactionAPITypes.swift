//
//  APITypes.swift
//  xites_iOs_app
//
//  Created by MAC on 02.01.24.
//

import Foundation
extension TransactionAPI{
    enum Types{
        enum Response{
            struct GetTransactions : Decodable  {
                let items : [Registrations]
                
                struct Registrations : Decodable{
                    let id :Int
                    let date: String
                    let user: String
                    let project: String
                }
            }
            struct GetProjects : Decodable  {
                let items : [Projects]
                
                struct Projects : Decodable{
                    let id :Int
                    let naam: String
                }
            }
            struct GetDiensten : Decodable  {
                let items : [Diensten]
                
                struct Diensten : Decodable{
                    let id :Int
                    let naam: String
                }
            }
            struct GetRegistration : Decodable{
                let id : Int
                let date: String
                let dienstId: Int
                let projectId: Int
                let beschrijving:String
                let kilomenter:String
                let factureerbaar: Bool
                let tijdsduur : String
                let teControleren:Bool
                
            }
            
        }
        enum Request{
            struct Empty : Encodable{ }
            struct RegistrationRequest: Encodable{
                var dienst: String
                var project: String
                var beschrijving:String
                var kilometers:String
                var factureerbaar: Bool
                var tijdsduur : String
                var teControleren:Bool
                var date: String
                
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
            case gettransactions
            case getprojects
            case getdiensten
            case posttransaction
            var url : URL{
                var components = URLComponents()
                components.host = "localhost"
                components.port = 9000
                components.scheme = "http"
                switch self{
                case .gettransactions:
                    components.path = "/api/transactions"
                case .getprojects:
                    components.path = "/api/projects"
                case .getdiensten:
                    components.path = "/api/diensten"
                case .posttransaction:
                    components.path = "/api/transactions"
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
