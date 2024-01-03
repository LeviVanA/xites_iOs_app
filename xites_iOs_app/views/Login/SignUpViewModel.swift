//
//  SignUpViewModel.swift
//  xites_iOs_app
//
//  Created by MAC on 29.12.23.
//

import Foundation
import Foundation

class SignUpViewModel: ObservableObject {
    enum ViewState {
        case START
        case LOADING
        case SUCCESS(succes:String)
        case FAILURE(error: String)
    }
    @Published var viewState: ViewState = .START
    
    func register(register:User, completion: @escaping (Bool) -> Void){
        let user = parseUser(register)
        print(user)
        UserAPI.Client.shared.post(.register, body: user){
            (result: Result<UserAPI.Types.Response.GetBearer, UserAPI.Types.Error>) in
            DispatchQueue.main.async{
                switch result{
                case .success(let registrationResponse):
                    print("succes")
                    print(registrationResponse)
                    completion(true)
                    Bearer.token = try! result.get().bearer
                    self.viewState = .SUCCESS(succes: "registration saved")
                    
                case .failure(let failure):
                    print("fail")
                    completion(false)
                    self.viewState = .FAILURE(error: failure.localizedDescription)
                }
            }
        }
     }

    private func parseUser(_ result: User) -> UserAPI.Types.Request.UserRequest{
         
         var localresult: UserAPI.Types.Request.UserRequest
         
        localresult = UserAPI.Types.Request.UserRequest(name: result.username, password: result.password)
         print(localresult)
         return localresult
     }}
