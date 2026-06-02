//
//  otome5Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/02.
//

import Foundation
import SwiftUI
import Combine

class Otome5: ObservableObject {
    // ----------
    // 通常時
    // ----------
    // 乙女アタック
    let ratioOtomeAttack: [Double] = [20.3,21.4,23.2,24.7,25.2,25.7]
    @AppStorage("otome5OtomeAttackCountMiss") var otomeAttackMiss: Int = 0
    @AppStorage("otome5OtomeAttackCountHit") var otomeAttackHit: Int = 0
    @AppStorage("otome5OtomeAttackCountSum") var otomeAttackSum: Int = 0
    
    func attackSumFunc() {
        otomeAttackSum = otomeAttackHit + otomeAttackMiss
    }
    
    func resetNormal() {
        otomeAttackMiss = 0
        otomeAttackHit = 0
        otomeAttackSum = 0
        minusCheck = false
    }
    
    
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "戦国乙女5"
    @AppStorage("otome5MinusCheck") var minusCheck: Bool = false
    @AppStorage("otome5SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
    }
}
