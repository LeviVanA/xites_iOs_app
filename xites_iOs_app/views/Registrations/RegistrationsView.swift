//
//  RegistrationsView.swift
//  xites_iOs_app
//
//  Created by MAC on 26.12.23.
//

import SwiftUI



struct RegistrationsView: View {
    
    //viewmodel
    @ObservedObject var viewModel = RegistrationsViewModel()
    
    @State private var filterUser = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
            TextField("Search User", text: $filterUser)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
           if case .LOADING = viewModel.currentState {
               loaderView()
           } else if case .SUCCESS(let registrations) = viewModel.currentState {
               List {
                   ForEach(registrations.filter {
                       filterUser.isEmpty || $0.user.lowercased().contains(filterUser.lowercased())
                   }) { registration in
                       userCell(registration: registration)
                           .frame( height: 80)
                   }
               }
           } else if case .FAILURE(let error) = viewModel.currentState {
               VStack(alignment: .center) {
                   Spacer()
                   Text(error)
                       .font(.headline.bold())
                       .multilineTextAlignment(.center)
                   Spacer()
               }
               .padding()
           }
        }//vstack
    }.onAppear {
        viewModel.loadData()
    }
    }//view
}
    
func userCell(registration: Registration) -> some View {
    VStack(alignment: .leading, spacing: 8) {
        Text("Datum: \(registration.date)")
            .font(.subheadline)
            .multilineTextAlignment(.leading)
        Text("User: \(registration.user)")
            .font(.subheadline)
            .multilineTextAlignment(.leading)
        Text("Project: \(registration.project)")
            .font(.subheadline)
            .multilineTextAlignment(.leading)
    }
}
    
struct RegistrationsView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationsView()
    }
}
