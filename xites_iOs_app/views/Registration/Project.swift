//
//  Project.swift
//  xites_iOs_app
//
//  Created by MAC on 02.01.24.
//

import Foundation
struct Project: Identifiable {
    let id :Int
    let naam: String
    
    
    init(id:Int, naam: String) {
        self.id = id
        self.naam = naam
    }
}
