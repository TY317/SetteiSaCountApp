//
//  splashScreenView.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/12.
//

import SwiftUI
import UIKit
import GoogleMobileAds

struct splashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opsity = 0.0
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Image("splashLogo2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250.0)
                    .scaleEffect(self.size)
                    .opacity(self.opsity)
                    .onAppear() {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            self.size = 1.0
                            self.opsity = 1.0
                        }
                    }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}
#Preview {
    splashScreenView()
}
