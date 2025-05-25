//
//  countUpDownFixNumber.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/21.
//

import Foundation
import SwiftUI

func countUpDownFixNumber(count: Int, plusNumber: Int, minusCheck: Bool) -> Int {
    var newCount = count
    
    // カウントダウン処理
    if minusCheck {
        // 0以上ならカウントダウン
        if newCount > 0 {
            newCount -= plusNumber
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
        // 0ならば何もしない
        else {
            
        }
    }
    // カウントアップ処理
    else {
        newCount += plusNumber
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    
    return newCount > 0 ? newCount : 0
}
