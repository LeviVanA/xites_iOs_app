//
//  ButtonStyle.swift
//  xites_iOs_app
//
//  Created by MAC on 26.12.23.
//

import Foundation
import SwiftUI

struct MyButtonStyle: ButtonStyle {
    let red = Color(red: 1, green: 0.32941176470588235, blue: 0.28627450980392155)
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .background(red)
      .foregroundColor(.white)
      .clipShape(Capsule())
  }
}
