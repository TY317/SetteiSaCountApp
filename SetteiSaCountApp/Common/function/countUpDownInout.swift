//
//  countUpDownInout.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/26.
//

import Foundation
import SwiftUI

func countUpDownInout(minusCheck: Bool, count: inout Int) {
    // カウントダウン処理
    if minusCheck {
        if count > 0 {
            count -= 1
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
    } else {
        count += 1
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}
