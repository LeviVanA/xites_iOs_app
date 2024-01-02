//
//  HomeView.swift
//  xites_iOs_app
//
//  Created by MAC on 29.12.23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("logo")
                    .resizable()
                    .frame(width: 150.0, height: 150.0, alignment: .topLeading)
                    .ignoresSafeArea()
                    .cornerRadius(30.0)
                
                Text("Welcome")
                    .font(.system(size: 50, weight: .bold, design: .default))
                
                NavigationLink(destination: LoginView()) {
                    Text("Log out")
                        .font(.system(size: 24, weight: .bold, design: .default))
                }
                .buttonStyle(MyButtonStyle())
                .padding(.top, 20)
                
                NavigationLink(destination: RegistrationView()) {
                    Text("Registreer uur")
                        .font(.system(size: 24, weight: .bold, design: .default))
                }
                .buttonStyle(MyButtonStyle())
                .padding(.top, 20)
                
                NavigationLink(destination: RegistrationsView()) {
                    Text("Registraties")
                        .font(.system(size: 24, weight: .bold, design: .default))
                }
                .buttonStyle(MyButtonStyle())
                .padding(.top, 20)
            }
            
        }.navigationBarBackButtonHidden(true)
    }
}
    

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
