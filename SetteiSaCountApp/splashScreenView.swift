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

    var uiStyle: UIUserInterfaceStyle {
        switch self {
        case .system: return .unspecified
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
    @StateObject var bayes = Bayes()
    @StateObject var viewModel = InterstitialViewModel()
    // ------
    
    var body: some View {
        if isActive {
//            ContentView()
//                .environmentObject(common)
//                .preferredColorScheme(appearanceMode.colorScheme)
//                .environmentObject(rewardViewModel)
            ContentViewVer2()
                .environmentObject(common)
                .environmentObject(rewardViewModel)
                .environmentObject(bayes)
                .environmentObject(viewModel)
                // 外観モードはウィンドウの overrideUserInterfaceStyle で一括制御
                // （preferredColorSchemeはサブツリーに独自overrideを張りpush先で打ち消すため使わない）
                .onAppear { applyAppInterfaceStyle(appearanceMode) }
                .onChange(of: appearanceModeRaw) { _, _ in applyAppInterfaceStyle(appearanceMode) }
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
                        common.lastLaunchAppVersion = "4.1.0"
                        // --------------------------------
                        common.ver3260FirstLaunch()
                        common.ver3270FirstLaunch()
                        common.ver3271FirstLaunch()
                        common.ver400FirstLaunch()
                        common.ver410FirstLaunch()
                        common.ver411FirstLaunch()
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

// 外観モードをウィンドウの overrideUserInterfaceStyle で全体に即時適用
// （splashScreenのonAppear/onChangeと、ContentViewVer2のツールバーから直接呼ぶ）
func applyAppInterfaceStyle(_ mode: AppearanceMode) {
    let style = mode.uiStyle
    for scene in UIApplication.shared.connectedScenes {
        guard let windowScene = scene as? UIWindowScene else { continue }
        for window in windowScene.windows {
            window.overrideUserInterfaceStyle = style
            forceInterfaceStyle(window.rootViewController, style)
        }
    }
}

// 全VC（入れ子のNavigationStack/push先/presented含む）に直接スタイルを適用
private func forceInterfaceStyle(_ vc: UIViewController?, _ style: UIUserInterfaceStyle) {
    guard let vc = vc else { return }
    vc.overrideUserInterfaceStyle = style
    for child in vc.children { forceInterfaceStyle(child, style) }
    forceInterfaceStyle(vc.presentedViewController, style)
}

#Preview {
    splashScreenView()
}
