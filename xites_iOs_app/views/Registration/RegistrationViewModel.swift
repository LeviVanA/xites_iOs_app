//
//  RegistrationViewModel.swift
//  xites_iOs_app
//
//  Created by MAC on 27.12.23.
//

import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    
    var projects:[Project] = []
    var diensten:[Dienst] = []
    
    enum ViewState {
        case START
        case LOADING
        case SUCCESS(succes:String)
        case PROJECTSUCCESS(projects: [Project])
        case DIENSTSUCCESS(diensten: [Dienst])
        case FAILURE(error: String)
    }


    // Published property to observe changes in ViewState
    @Published var viewState: ViewState = .START
    @Published var projectState: ViewState = .START
    @Published var dienstState: ViewState = .START
    

    func loadData() {
            GetProjects()
            GetDiensten()
        }
    
    func GetProjects(){
        TransactionAPI.Client.shared.get(.getprojects){
            (result: Result<TransactionAPI.Types.Response.GetProjects, TransactionAPI.Types.Error>) in
            DispatchQueue.main.async{
                switch result{
                case .success(let succes):
                    self.parseProject(succes)
                    print(self.projects)
                    self.projectState = .PROJECTSUCCESS(projects: self.projects)
                case .failure(let failure):
                    self.projectState = .FAILURE(error: failure.localizedDescription)
                }
            }
        }
    }
    
    private func parseProject(_ results: TransactionAPI.Types.Response.GetProjects){
        var localresults = [Project]()
        
        for result in results.items{
            let localresult = Project(id: result.id, naam: result.naam)
            localresults.append(localresult)
        }
        self.projects = localresults
    }
    func GetDiensten(){
        TransactionAPI.Client.shared.get(.getdiensten){
            (result: Result<TransactionAPI.Types.Response.GetDiensten, TransactionAPI.Types.Error>) in
            DispatchQueue.main.async{
                switch result{
                case .success(let succes):
                    self.parseDienst(succes)
                    self.dienstState = .DIENSTSUCCESS(diensten: self.diensten)
                case .failure(let failure):
                    self.dienstState = .FAILURE(error: failure.localizedDescription)
                }
            }
        }
    }
    
    private func parseDienst(_ results: TransactionAPI.Types.Response.GetDiensten){
        var localresults = [Dienst]()
        
        for result in results.items{
            let localresult = Dienst(id: result.id, naam: result.naam)
            localresults.append(localresult)
        }
        self.diensten = localresults
    }

   func saveRegistration(registration:RegistrationModel) {
       let transaction = parseRegistration(registration)
       TransactionAPI.Client.shared.post(.posttransaction,body: transaction){
           (result: Result<TransactionAPI.Types.Response.GetRegistration, TransactionAPI.Types.Error>) in
           DispatchQueue.main.async{
               switch result{
               case .success(let registrationResponse):
                   print(registrationResponse)
                   self.viewState = .SUCCESS(succes: "registration saved")
               case .failure(let failure):
                   self.viewState = .FAILURE(error: failure.localizedDescription)
               }
           }
       }
    }

    private func parseRegistration(_ result: RegistrationModel) -> TransactionAPI.Types.Request.RegistrationRequest{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YY/MM/dd"
        var localresult: TransactionAPI.Types.Request.RegistrationRequest
        
        localresult = TransactionAPI.Types.Request.RegistrationRequest(dienst: result.dienst, project: result.project, beschrijving: result.beschrijving, kilometers: result.geredenKilomenter, factureerbaar: result.toggleState, tijdsduur: result.tijdsduur, teControleren: result.teControleren, date: dateFormatter.string(from:result.date))
        print(localresult)
        return localresult
    }
}
