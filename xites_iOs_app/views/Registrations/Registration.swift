//
//  Registration.swift
//  xites_iOs_app
//
//  Created by MAC on 02.01.24.
//

import Foundation
struct Registration: Identifiable {
    let id :Int
    let date: String
    let user: String
    let project: String
    
    
    init(id:Int, date: String, user: String, project: String) {
        self.id = id
        self.date = date
        self.user = user
        self.project = project
    }
}
