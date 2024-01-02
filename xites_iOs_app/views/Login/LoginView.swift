//
//  LoginView.swift
//  xites_iOs_app
//
//  Created by MAC on 25.12.23.
//

import Foundation
import SwiftUI

struct LoginView: View {@ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    @State private var navigateToHome = false
    
    var body: some View {
        NavigationView{
        VStack {
            
            Spacer()
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 100.0, height: 100.0, alignment: .topLeading)
                    .ignoresSafeArea()
                    .cornerRadius(20.0)
                    
                TextField(
                    "Username",
                    text: $viewModel.username
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                Divider()
                
                SecureField(
                    "Password",
                    text: $viewModel.password
                )
                .padding(.top, 20)
                
                Divider()
                NavigationLink(destination: HomeView(), isActive: $navigateToHome)
                {
                    EmptyView()
                }
                Button(action: {
                    // Set navigateToHome to true when login is successful
                    if viewModel.login() {
                        navigateToHome = true
                    }
                }) {
                    Text("Log in")
                        .font(.system(size: 24, weight: .bold, design: .default))
                }.buttonStyle(MyButtonStyle())
                    .padding(.top, 20)
        
                NavigationLink(
                    destination:SignUpView()                ){
                    Text("Register")
                        .font(.system(size: 24, weight: .bold, design: .default))
                }.buttonStyle(MyButtonStyle())
                Spacer()
            }
            
            
        }
        .padding(30)
        }.navigationBarBackButtonHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
