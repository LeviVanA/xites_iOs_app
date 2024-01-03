//
//  Dienst.swift
//  xites_iOs_app
//
//  Created by MAC on 02.01.24.
//

import Foundation
struct Dienst: Identifiable {
    let id :Int
    let naam: String
    
    
    init(id:Int, naam: String) {
        self.id = id
        self.naam = naam
    }
}
