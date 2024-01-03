//
//  LoginView.swift
//  xites_iOs_app
//
//  Created by MAC on 25.12.23.
//

import Foundation
import SwiftUI

struct LoginView: View {@ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    @State private var user = User()
    @State private var navigateToHome = false
    @State private var username = ""
    @State private var password = ""
    
    @State private var showAlert = false
    
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
                    text: $username
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                
                Divider()
                
                SecureField(
                    "Password",
                    text: $password
                )
                .padding(.top, 20)
                
                Divider()
                NavigationLink(destination: HomeView(), isActive: $navigateToHome)
                {
                    EmptyView()
                }
                Button(action: {
                    user.username = self.username
                    user.password = self.password
                    viewModel.login(login: user) { succes in
                        if succes{navigateToHome = true }
                        else{ showAlert = true}
                    }
                }) {
                    Text("Log in")
                        .font(.system(size: 24, weight: .bold, design: .default))
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text("wrong credtials"),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .padding(.top, 20)
                .buttonStyle(MyButtonStyle())
        
                NavigationLink(
                    destination:SignUpView()                ){
                    Text("Register")
                        .font(.system(size: 24, weight: .bold, design: .default))
                }.buttonStyle(MyButtonStyle())
                Spacer()
            }
            
            
        }
        .padding(30)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
