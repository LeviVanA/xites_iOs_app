//
//  LoadingView.swift
//  xites_iOs_app
//
//  Created by MAC on 27.12.23.
//

import SwiftUI
func loaderView() -> some View {
        ZStack {
            Color.black.opacity(0.05)
                .ignoresSafeArea()
            ProgressView()
                .scaleEffect(1, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
        }
    }
