//
//  ResetBadgeOnAppear.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/24.
//

import Foundation
import SwiftUI

struct ResetBadgeOnAppear: ViewModifier {
    @Binding var badgeStatus: String

    func body(content: Content) -> some View {
        content
            .onAppear {
                if badgeStatus != "none" {
                    badgeStatus = "none"
                }
            }
    }
}

extension View {
    func resetBadgeOnAppear(_ badgeStatus: Binding<String>) -> some View {
        self.modifier(ResetBadgeOnAppear(badgeStatus: badgeStatus))
    }
}
