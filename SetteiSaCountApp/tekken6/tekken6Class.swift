//
//  tekken6Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/29.
//

import Foundation
import SwiftUI

class Tekken6: ObservableObject {
    // ----------
    // 初当り
    // ----------
    let ratioFirstHitCz: [Double] = [486.6,485.3,470.5,461.8,458,452.8]
    let ratioFirstHitBonus: [Double] = [264.7,261.5,255.3,227.6,220.3,218.5]
    let ratioFirstHitAt: [Double] = [497,484.1,456.8,397.6,366.4,358.5]
    let ratioDirectAt: [Double] = [12580.4,10774.5,7471.1,5347.1,3840.1,3565.2]
    @AppStorage("tekken6NormalGame") var normalGame: Int = 0
    @AppStorage("tekken6FirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("tekken6FirstHitCountBonusBlue") var firstHitCountBonusBlue: Int = 0
    @AppStorage("tekken6FirstHitCountBonusRed") var firstHitCountBonusRed: Int = 0
    @AppStorage("tekken6FirstHitCountBonusSum") var firstHitCountBonusSum: Int = 0
    @AppStorage("tekken6FirstHitCountAt") var firstHitCountAt: Int = 0
    
    func bonusSumFunc() {
        firstHitCountBonusSum = firstHitCountBonusBlue + firstHitCountBonusRed
    }
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountBonusBlue = 0
        firstHitCountBonusRed = 0
        firstHitCountBonusSum = 0
        firstHitCountAt = 0
        minusCheck = false
    }
    
    // ----------
    // 引き戻し
    // ----------
    let ratioBack: [Double] = [10.2,10.9,12.5,14.1,16.4,17.2]
    @AppStorage("tekken6BackCountHit") var backCountHit: Int = 0
    @AppStorage("tekken6BackCountMiss") var backCountMiss: Int = 0
    @AppStorage("tekken6BackCountSum") var backCountSum: Int = 0
    
    func backSumFunc() {
        backCountSum = backCountHit + backCountMiss
    }
    
    func resetBack() {
        backCountHit = 0
        backCountMiss = 0
        backCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "鉄拳6"
    @AppStorage("tekken6MinusCheck") var minusCheck: Bool = false
    @AppStorage("tekken6SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
        resetBack()
    }
}
