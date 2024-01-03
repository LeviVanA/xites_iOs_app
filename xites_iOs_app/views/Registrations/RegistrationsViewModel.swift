//
//  RegistrationsViewModel.swift
//  xites_iOs_app
//
//  Created by MAC on 27.12.23.
//

import Foundation
import Combine

class RegistrationsViewModel: ObservableObject {
    //mock data
    private var data = [
        Registration(id: 1, date: "Juan", user: "Chavez", project: "juanchavez@icloud.com"),
        Registration(id: 2, date: "Mei", user: "Chen", project: "meichen@icloud.com"),
        Registration(id:3, date: "Tom", user: "Clark", project: "tomclark@icloud.com"),
        Registration(id:4, date: "Gita", user: "Kumar", project: "gitakumar@icloud.com")
    ]
    private var results:[Registration] = []

    enum ViewState {
        case START
        case LOADING
        case SUCCESS(registrations: [Registration])
        case FAILURE(error: String)
    }

    @Published var currentState: ViewState = .START
    private var cancelables = Set<AnyCancellable>()

    func loadData(){
        GetRegistraions()
    }
    
    func GetRegistraions(){
        TransactionAPI.Client.shared.get(.gettransactions){
            (result: Result<TransactionAPI.Types.Response.GetTransactions, TransactionAPI.Types.Error>) in
            DispatchQueue.main.async{
                switch result{
                case .success(let succes):
                    self.parseResult(succes)
                    self.currentState = .SUCCESS(registrations: self.results)
                case .failure(let failure):
                    self.currentState = .FAILURE(error: failure.localizedDescription)
                }
            }
        }
    }
    
    private func parseResult(_ results: TransactionAPI.Types.Response.GetTransactions){
        var localresults = [Registration]()
        
        for result in results.items{
            let localresult = Registration(id: result.id, date: result.date, user: result.user, project: result.project)
            localresults.append(localresult)
        }
        self.results = localresults
    }
    /*
    func getRegistrations() {
        print(TransactionAPIService.shared.getRegistrations())
        self.currentState = .LOADING
        TransactionAPIService.shared.getRegistrations()
            .sink { completion in
                print(completion)
                switch completion {
                case .finished:
                    print("Execution Finihsed.")
                case .failure(let error):
                    //mock-data
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.currentState = .SUCCESS(registrations: self.data)
                    }
                    //self.currentState = .FAILURE(error: error.localizedDescription)
                }
            } receiveValue: { registrations in
                self.currentState = .SUCCESS(registrations: registrations)
            }.store(in: &cancelables)
    }*/
    
}

