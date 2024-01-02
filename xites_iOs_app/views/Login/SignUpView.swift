import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel = SignUpViewModel()
    @State private var navigateToHome = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack {
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 100.0, height: 100.0, alignment: .topLeading)
                        .ignoresSafeArea()
                        .cornerRadius(20.0)

                    TextField("Username", text: $viewModel.username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.top, 20)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding(.top, 20)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Confirm Password", text: $viewModel.confirmPassword)
                        .padding(.top, 20)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                        EmptyView()
                    }
                    
                    Button(action: {
                        if viewModel.register() {
                            navigateToHome = true
                        }
                    }) {
                        Text("Register")
                            .font(.system(size: 24, weight: .bold, design: .default))
                    }
                    .buttonStyle(MyButtonStyle())
                    .padding(.top, 20)

                    Spacer()
                }
            }
            .padding(30)
        
            
        }.navigationBarBackButtonHidden(true)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
