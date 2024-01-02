//
//  RegistrationModel.swift
//  xites_iOs_app
//
//  Created by MAC on 27.12.23.
//

import Foundation
import JWTDecode

struct RegistrationModel: Codable {
    var date: Date
    var project: String
    var dienst: String
    var toggleState: Bool
    var tijdsduur : String
    var geredenKilomenter:String
    var teControleren:Bool
    var beschrijving:String
    
    
    init() {
        self.date = Date.now
        self.project = "project"
        self.dienst="dienst"
        self.toggleState=true
        self.tijdsduur = "0"
        self.geredenKilomenter = "12km"
        self.teControleren = true
        self.beschrijving = "beschrijving"
        
    }
}
