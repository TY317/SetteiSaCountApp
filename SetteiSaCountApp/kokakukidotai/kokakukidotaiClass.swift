//
//  kokakukidotaiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/12.
//

import Foundation
import SwiftUI
import Combine

class Kokakukidotai: ObservableObject {
    
    // ----------
    // 初当り
    // ----------
    let ratioFirstHitCz: [Double] = [238.0,236.3,231.7,220.9,214,210.1]
    let ratioFirstHitAt: [Double] = [336.3,332,319.6,298.7,285.8,278]
    @AppStorage("kokakukidotaiNormalGame") var normalGame: Int = 0
    @AppStorage("kokakukidotaiFirstHitCountAt") var firstHitCountAt: Int = 0
    @AppStorage("kokakukidotaiFirstHitCountCz") var firstHitCountCz: Int = 0
    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        firstHitCountCz = 0
        minusCheck = false
    }
    
    // ---------
    // AT中
    // ---------
    let ratioReboot: [Double] = [3.3,4.6,5.8,7.1,8.3,9.6]
    @AppStorage("kokakukidotaiRebootCountMiss") var rebootCountMiss: Int = 0
    @AppStorage("kokakukidotaiRebootCountSuccess") var rebootCountSuccess: Int = 0
    @AppStorage("kokakukidotaiRebootCountSum") var rebootCountSum: Int = 0
    
    func rebootSumFunc() {
        rebootCountSum = rebootCountMiss + rebootCountSuccess
    }
    
    func resetAt() {
        rebootCountMiss = 0
        rebootCountSuccess = 0
        rebootCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "攻殻機動隊"
    @AppStorage("kokakukidotaiMinusCheck") var minusCheck: Bool = false
    @AppStorage("kokakukidotaiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
        resetAt()
    }
}
