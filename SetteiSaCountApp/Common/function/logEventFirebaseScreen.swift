//
//  logEventFirebaseScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/24.
//

import Foundation
import SwiftUI
import FirebaseAnalytics

func logEventFirebaseScreen(screenName: String, screenClass: String) {
    Analytics.logEvent(AnalyticsEventScreenView, parameters: [
        AnalyticsParameterScreenName: screenName,
        AnalyticsParameterScreenClass: screenClass
    ])
    
    print("Firebase Analytics: \(screenClass) appeared.") // デバッグ用ログ
}
