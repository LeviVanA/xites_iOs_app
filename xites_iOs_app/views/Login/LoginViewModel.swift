//
//  LoginViewModel.swift
//  xites_iOs_app
//
//  Created by MAC on 29.12.23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    
    
    func login() -> Bool{
        // Implement your login logic here
        // You can access the entered username and password using self.username and self.password
        let isLoginSuccessful = true
                
        if isLoginSuccessful {
            // Navigate to HomeView when login is successful
            // You can handle navigation using a coordinator or a dedicated navigation view model
            return true
        } else {
            return false
        }
        
    }
}
