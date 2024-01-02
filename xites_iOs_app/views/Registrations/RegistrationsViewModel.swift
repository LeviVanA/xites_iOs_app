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
        Registration(date: "Juan", user: "Chavez", project: "juanchavez@icloud.com"),
        Registration(date: "Mei", user: "Chen", project: "meichen@icloud.com"),
        Registration(date: "Tom", user: "Clark", project: "tomclark@icloud.com"),
        Registration(date: "Gita", user: "Kumar", project: "gitakumar@icloud.com")
    ]

    enum ViewState {
        case START
        case LOADING
        case SUCCESS(registrations: [Registration])
        case FAILURE(error: String)
    }

    @Published var currentState: ViewState = .START
    private var cancelables = Set<AnyCancellable>()

    init() {
        getRegistrations()
    }
    

    func getRegistrations() {
        self.currentState = .LOADING
        TransactionAPIService.shared.getRegistrations()
            .sink { completion in
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
    }
}
