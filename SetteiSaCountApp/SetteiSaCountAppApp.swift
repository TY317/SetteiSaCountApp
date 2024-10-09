//
//  SetteiSaCountAppApp.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/06.
//

import SwiftUI
import TipKit
import GoogleMobileAds
import UIKit

// Google-Mobile-Ads-SDKの初期化処理
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}


@main
struct SetteiSaCountAppApp: App {
//    @AppStorage("shouldResetTips") var shouldResetTips: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            //            ContentView()
            splashScreenView()
        }
    }
    
        init() {
            try? Tips.configure()
        }
    
    // Tipを毎回表示させるための機能、上のshuldResetTipsとセット
//    init() {
//        setupTips()
//    }
//    
//    // Configure tips in the app.
//    func setupTips() {
//        do {
//            if shouldResetTips {
//                try Tips.resetDatastore()
//            }
//            try Tips.configure([
//                .displayFrequency(.immediate),
//                .datastoreLocation(.applicationDefault)
//            ])
//        }
//        catch {
//            print("Error initializing TipKit \(error.localizedDescription)")
//        }
//    }
}
