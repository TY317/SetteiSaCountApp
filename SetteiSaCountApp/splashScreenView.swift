//
//  splashScreenView.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/12.
//

import SwiftUI
import UIKit
import GoogleMobileAds

enum AppearanceMode: Int, CaseIterable {
    case system, light, dark

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light:  return .light
        case .dark:   return .dark
        }
    }
}

struct splashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opsity = 0.0
//    @ObservedObject var common = commonVar()
    @StateObject var common = commonVar()
    @AppStorage("appearanceMode") private var appearanceModeRaw: Int = AppearanceMode.system.rawValue
    private var appearanceMode: AppearanceMode {
        AppearanceMode(rawValue: appearanceModeRaw) ?? .system
    }
    @StateObject var rewardViewModel = RewardedViewModel()
    var body: some View {
        if isActive {
//            ContentView(common: common)
            ContentView()
                .environmentObject(common)
                .preferredColorScheme(appearanceMode.colorScheme)
                .environmentObject(rewardViewModel)
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
                        // ----- リリース前にコメントアウト！！！
//                        common.firstLaunchAppVersion = nil
//                        common.lastLaunchAppVersion = nil
//                        common.lastLaunchAppVersion = "3.15.0"
                        // --------------------------------
//                        common.ver3100FirstLaunch()
//                        common.ver3110FirstLaunch()
//                        common.ver3120FirstLaunch()
                        common.ver3130FirstLaunch()
                        common.ver3131FirstLaunch()
                        common.ver3140FirstLaunch()
                        common.ver3150FirstLaunch()
                        common.ver3160FirstLaunch()
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
