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
    @StateObject var common = commonVar()
    @AppStorage("appearanceMode") private var appearanceModeRaw: Int = AppearanceMode.system.rawValue
    private var appearanceMode: AppearanceMode {
        AppearanceMode(rawValue: appearanceModeRaw) ?? .system
    }
    @StateObject var rewardViewModel = RewardedViewModel()
    
    // 新トップページ切り替え時に有効化
//    @StateObject var bayes = Bayes()
//    @StateObject var viewModel = InterstitialViewModel()
    // ------
    
    var body: some View {
        if isActive {
            ContentView()
                .environmentObject(common)
                .preferredColorScheme(appearanceMode.colorScheme)
                .environmentObject(rewardViewModel)
//            ContentViewVer2()
//                .environmentObject(common)
//                .preferredColorScheme(appearanceMode.colorScheme)
//                .environmentObject(rewardViewModel)
//                .environmentObject(bayes)
//                .environmentObject(viewModel)
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
                        common.lastLaunchAppVersion = "3.22.0"
                        // --------------------------------
//                        common.ver3171FirstLaunch()
//                        common.ver3180FirstLaunch()
                        common.ver3190FirstLaunch()
                        common.ver3200FirstLaunch()
                        common.ver3210FirstLaunch()
                        common.ver3211FirstLaunch()
                        common.ver3220FirstLaunch()
                        common.ver3221FirstLaunch()
                        common.saveAppVersions()
                        common.forcedUnlockReward()
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
