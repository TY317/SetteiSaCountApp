//
//  ResetMachineBadgeOnAppear.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/28.
//

import Foundation
import SwiftUI

extension View {
    /// 特定の機種のバッジをリセットするためのカスタムモディファイア
    func resetMachineBadgeOnAppear(machines: Binding<[Machine]>, targetId: String) -> some View {
        self.modifier(ResetMachineBadgeOnAppear(machines: machines, targetId: targetId))
    }
}

// Modifier本体も「IDで探す」タイプに合わせます
struct ResetMachineBadgeOnAppear: ViewModifier {
    @Binding var machines: [Machine]
    let targetId: String

    func body(content: Content) -> some View {
        content
            .onAppear {
                if let index = machines.firstIndex(where: { $0.id == targetId }) {
                    if machines[index].badgeStatus != "none" {
                        machines[index].badgeStatus = "none"
                    }
                }
            }
    }
}
