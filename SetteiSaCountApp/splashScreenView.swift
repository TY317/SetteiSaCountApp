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
//    @ObservedObject var common = commonVar()
    @StateObject var common = commonVar()
    var body: some View {
        if isActive {
//            ContentView(common: common)
            ContentView()
                .environmentObject(common)
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
                        common.appLaunchCountUp()
//                        common.lastLaunchAppVersion = nil
                        common.lastLaunchAppVersion = "3.13.0"
                        common.ver3100FirstLaunch()
                        common.ver3110FirstLaunch()
                        common.ver3120FirstLaunch()
                        common.ver3130FirstLaunch()
                        common.ver3131FirstLaunch()
                        common.saveAppVersions()
                    }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
//            .onAppear {
//                common.saveInitialVersionIfNeeded()
//                common.lastLaunchAppVersion = nil
//                common.lastLaunchAppVersion = "3.9.1"
//                common.ver3100FirstLaunch()
//                common.saveAppVersions()
//            }
        }
    }
}
#Preview {
    splashScreenView()
}
