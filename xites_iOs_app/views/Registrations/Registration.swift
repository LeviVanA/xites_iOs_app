//
//  Registration.swift
//  xites_iOs_app
//
//  Created by MAC on 27.12.23.
//

import Foundation

struct Registration: Codable, Identifiable {
    let date: String
    let user: String
    let project: String
    let id = UUID()
    
    init(date: String, user: String, project: String) {
        self.date = date
        self.user = user
        self.project = project
    }
}


