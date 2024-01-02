//
//  CustomTextfieldView.swift
//  xites_iOs_app
//
//  Created by MAC on 29.12.23.
//

import SwiftUI

struct CustomTextfieldView: View {
    @Binding var data: String
    var title: String?
    var body: some View {
      ZStack {
        TextField("", text: $data)
          .padding(.horizontal, 10)
          .frame(height: 42)
          .overlay(
            RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                .stroke(Color.gray, lineWidth: 1)
          )
        HStack {
          Text(title ?? "Input")
            .font(.headline)
            .fontWeight(.thin)
            .foregroundColor(Color.gray)
            .multilineTextAlignment(.leading)
            .padding(4)
            .background(.white)
          Spacer()
        }
        .padding(.leading, 8)
        .offset(CGSize(width: 0, height: -20))
      }.padding(4)
    }
}

struct CustomTextfieldView_Previews:PreviewProvider{
    @State static var data = ""

    static var previews: some View {
        CustomTextfieldView(data:$data, title:"password")
    }
}
