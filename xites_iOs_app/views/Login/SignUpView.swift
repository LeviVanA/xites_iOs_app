import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel = SignUpViewModel()
    @State private var user = User()
    @State private var navigateToHome = false
    @State private var passwordFault = false
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var snackBarIsShowing = false
    
    @State private var showAlert = false
    @State private var showUserAlert = false
    
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
                    
                    TextField("Username", text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.top, 20)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Password", text: $password)
                        .padding(.top, 20)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding(.top, 20)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                        EmptyView()
                    }
                    
                    Button(action: {
                        showUserAlert = false
                        if(password==confirmPassword){
                            user.username = self.username
                            user.password = self.password
                            viewModel.register(register: user) { succes in
                                if succes{
                                    print("test")
                                    navigateToHome = true
                                }
                                else{
                                    showUserAlert = true
                                    showAlert = true
                                }
                                
                            }
                            
                        }
                        else {
                            print("mismatch")
                            showAlert = true
                            
                        }
                        
                        
                    }) {
                        Text("Register")
                            .font(.system(size: 24, weight: .bold, design: .default))
                        
                    }.alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text(showUserAlert ? "User already exists" : "Password mismatch"),
                            dismissButton: .default(Text("OK"))
                        )
                        
                        
                    }
                    .padding(.top, 20)
                    .buttonStyle(MyButtonStyle())
                    
                    
                    Spacer()
                    
                    
                }//VSTack
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
