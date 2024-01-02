//
//  SignUpViewModel.swift
//  xites_iOs_app
//
//  Created by MAC on 29.12.23.
//

import Foundation
import Foundation

class SignUpViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var registrationError = ""
    @Published var isRegistrationSuccessful = false

    func register() -> Bool {
        // Basic validation
        /*guard !username.isEmpty else {
            registrationError = "Username cannot be empty."
            return false
        }

        guard !password.isEmpty else {
            registrationError = "Password cannot be empty."
            return false
        }

        guard password == confirmPassword else {
            registrationError = "Passwords do not match."
            return false
        }*/

        // Perform actual registration logic here
        // You can call your backend service or authentication provider
        // and handle the registration response accordingly
        // For the sake of this example, we'll assume registration is successful
        isRegistrationSuccessful = true

        return true
    }
}
