import SwiftUI

struct RegistrationView: View {
    @State var registration = RegistrationModel()
    @StateObject private var viewModel = RegistrationViewModel()
    
    @State private var date = Date.now
    @State private var project = "Project"
    @State private var dienst = "Dienst"
    @State private var toggleState = true
    @State private var tijdsduur = ""
    @State private var geredenKilometers = ""
    @State private var textBox = "Beschrijving"
    @State private var teControleren = true
    
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Registratie")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 1, green: 0.32941176470588235, blue: 0.28627450980392155))
            
            DatePicker("Date", selection: $date, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
                .accentColor(Color(red: 1, green: 0.32941176470588235, blue: 0.28627450980392155))
            
            HStack {
                if case .LOADING = viewModel.projectState {
                    ProgressView()
                } else if case .PROJECTSUCCESS(let projects) = viewModel.projectState{
                    
                    Menu {
                        
                        ForEach(projects) { (project:Project) in
                            
                            Button(action: {
                                self.project = project.naam
                            }) {
                                Text(project.naam)
                            }
                        }
                    } label: {
                        Label(title: { Text("\(self.project)") }, icon: { Image(systemName: "arrowtriangle.down.circle.fill") })
                            .font(.title)
                            .foregroundColor(Color(red: 1, green: 0.32941176470588235, blue: 0.28627450980392155))
                    }
                }
                else if case .FAILURE(let error) = viewModel.projectState {
                    VStack(alignment: .center) {
                        Spacer()
                        Text(error)
                            .font(.headline.bold())
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding()
                }
                
                Spacer()
                if case .LOADING = viewModel.dienstState {
                    ProgressView()
                } else if case .DIENSTSUCCESS(let diensten) = viewModel.dienstState{
                    
                    Menu {
                        
                        ForEach(diensten) { (dienst:Dienst) in
                            
                            Button(action: {
                                self.dienst = dienst.naam
                            }) {
                                Text(dienst.naam)
                            }
                        }
                    } label: {
                        Label(title: { Text("\(self.dienst)") }, icon: { Image(systemName: "arrowtriangle.down.circle.fill") })
                            .font(.title)
                            .foregroundColor(Color(red: 1, green: 0.32941176470588235, blue: 0.28627450980392155))
                    }
                }
                else if case .FAILURE(let error) = viewModel.dienstState {
                    VStack(alignment: .center) {
                        Spacer()
                        Text(error)
                            .font(.headline.bold())
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding()
                }
                
            }
            
            Toggle("Factureerbaar", isOn: $toggleState)
                .toggleStyle(SwitchToggleStyle(tint: Color(red: 1, green: 0.32941176470588235, blue: 0.28627450980392155)))
                .padding(.vertical, 5)
            
            HStack {
                TextField("Tijdsduur", text: $tijdsduur)
                    .font(.title)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color(red: 1, green: 0.32941176470588235, blue: 0.28627450980392155)))
                
                Spacer()
                
                TextField("Gereden kilometers", text: $geredenKilometers)
                    .font(.title)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color(red: 1, green: 0.32941176470588235, blue: 0.28627450980392155)))
            }
            
            TextEditor(text: $textBox)
                .border(Color(red: 1, green: 0.32941176470588235, blue: 0.28627450980392155), width: 1)
                .cornerRadius(10)
                .padding()
                .frame(height: 100)
            
            HStack {
                Toggle(isOn: $teControleren) {
                    Text("Te controleren")
                }
                .toggleStyle(SwitchToggleStyle(tint: Color(red: 1, green: 0.32941176470588235, blue: 0.28627450980392155)))
                .foregroundColor(.black)
                
                Spacer()
            }
            
            Button(action: {
                registration.date = date
                registration.project = project
                registration.dienst = dienst
                registration.toggleState = toggleState
                registration.tijdsduur = tijdsduur
                registration.geredenKilomenter = geredenKilometers
                registration.teControleren = teControleren
                registration.beschrijving = textBox
                viewModel.saveRegistration(registration: registration)
                showAlert = true
            }) {
                Text("Opslaan")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 1, green: 0.32941176470588235, blue: 0.28627450980392155))
                    .cornerRadius(10)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Saved"),
                    message: Text("The registration is saved! of \(registration.project)"),
                    dismissButton: .default(Text("OK"))
                )
            }
            .padding(.top, 20)
        }//VStack
        .padding(20)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
        .padding()
        .onAppear {
            viewModel.loadData()
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
