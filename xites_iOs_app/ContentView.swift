//
//  ContentView.swift
//  xites_iOs_app
//
//  Created by MAC on 09.11.23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingFirst = false
    @State private var showingSecond = false
    
    var body: some View {
        LoginView()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
