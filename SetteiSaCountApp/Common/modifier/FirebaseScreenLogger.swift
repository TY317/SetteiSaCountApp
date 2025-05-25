//
//  FirebaseScreenLogger.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/24.
//

import Foundation
import SwiftUI
import FirebaseAnalytics

struct FirebaseScreenTrackingModifier: ViewModifier {
    let screenName: String

        func body(content: Content) -> some View {
            content
                .onAppear {
                    let screenClass = String(describing: Self.self)
                    Analytics.logEvent(AnalyticsEventScreenView, parameters: [
                        AnalyticsParameterScreenName: screenName,
                        AnalyticsParameterScreenClass: screenClass
                    ])
                    print("Firebase Analytics: \(screenClass) appeared.") // デバッグ用ログ
                }
        }
}

extension View {
    func logFirebaseScreenView(screenName: String) -> some View {
        self.modifier(FirebaseScreenTrackingModifier(screenName: screenName))
    }
}

