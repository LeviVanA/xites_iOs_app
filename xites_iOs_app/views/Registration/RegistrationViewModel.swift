//
//  RegistrationViewModel.swift
//  xites_iOs_app
//
//  Created by MAC on 27.12.23.
//

import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    
    enum ViewState {
        case START
        case LOADING
        case SUCCESS(registrations: [RegistrationModel])
        case FAILURE(error: String)
    }

    // Published property to observe changes in ViewState
    @Published private(set) var viewState: ViewState = .START
    
    @Published var showAlert = false
    private var cancellables: Set<AnyCancellable> = []

    func saveRegistration(registration:RegistrationModel) {
        viewState = .LOADING
        // Perform your API call here
        let registrationPublisher = TransactionAPIService.shared.createRegistration(registration)
        
        registrationPublisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break // Handle success if needed
                case .failure(let error):
                    self.viewState = .FAILURE(error: error.localizedDescription)
                }
            }, receiveValue: { createdRegistration in
                self.viewState = .SUCCESS(registrations: [createdRegistration])
                self.showAlert = true
                // Handle the createdRegistration as needed
            })
            .store(in: &cancellables)
    }
}
