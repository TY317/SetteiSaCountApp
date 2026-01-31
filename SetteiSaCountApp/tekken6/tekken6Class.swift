//
//  tekken6Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/29.
//

import Foundation
import SwiftUI
import Combine

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
        resetNormal()
    }
    
    // -------
    // ver3.18.0で追加
    // -------
    // レアやくからのボーナス直撃
    let ratioRareDirectJaku: [Double] = [0.4,0.4,0.4,1.6,1.6,1.6]
    let ratioRareDirectKyo: [Double] = [12.5,12.5,12.5,18,18,18]
    @AppStorage("tekken6RareDirectCountJakuCherry") var rareDirectCountJakuCherry: Int = 0
    @AppStorage("tekken6RareDirectCountSuika") var rareDirectCountSuika: Int = 0
    @AppStorage("tekken6RareDirectCountChance") var rareDirectCountChance: Int = 0
    @AppStorage("tekken6RareDirectCountJakuSum") var rareDirectCountJakuSum: Int = 0
    @AppStorage("tekken6RareDirectCountJakuHit") var rareDirectCountJakuHit: Int = 0
    @AppStorage("tekken6RareDirectCountKyoCherry") var rareDirectCountKyoCherry: Int = 0
    @AppStorage("tekken6RareDirectCountKyoHit") var rareDirectCountKyoHit: Int = 0
    
    func jakuRareSumFunc() {
        rareDirectCountJakuSum = rareDirectCountJakuCherry + rareDirectCountSuika + rareDirectCountChance
    }
    
    func resetNormal() {
        rareDirectCountJakuCherry = 0
        rareDirectCountSuika = 0
        rareDirectCountChance = 0
        rareDirectCountJakuSum = 0
        rareDirectCountJakuHit = 0
        rareDirectCountKyoCherry = 0
        rareDirectCountKyoHit = 0
        minusCheck = false
    }
}


class Tekken6Memory1: ObservableObject {
    @AppStorage("tekken6NormalGameMemory1") var normalGame: Int = 0
    @AppStorage("tekken6FirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("tekken6FirstHitCountBonusBlueMemory1") var firstHitCountBonusBlue: Int = 0
    @AppStorage("tekken6FirstHitCountBonusRedMemory1") var firstHitCountBonusRed: Int = 0
    @AppStorage("tekken6FirstHitCountBonusSumMemory1") var firstHitCountBonusSum: Int = 0
    @AppStorage("tekken6FirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("tekken6BackCountHitMemory1") var backCountHit: Int = 0
    @AppStorage("tekken6BackCountMissMemory1") var backCountMiss: Int = 0
    @AppStorage("tekken6BackCountSumMemory1") var backCountSum: Int = 0
    @AppStorage("tekken6MemoMemory1") var memo = ""
    @AppStorage("tekken6DateMemory1") var dateDouble = 0.0
    
    // -------
    // ver3.18.0で追加
    // -------
    @AppStorage("tekken6RareDirectCountJakuCherryMemory1") var rareDirectCountJakuCherry: Int = 0
    @AppStorage("tekken6RareDirectCountSuikaMemory1") var rareDirectCountSuika: Int = 0
    @AppStorage("tekken6RareDirectCountChanceMemory1") var rareDirectCountChance: Int = 0
    @AppStorage("tekken6RareDirectCountJakuSumMemory1") var rareDirectCountJakuSum: Int = 0
    @AppStorage("tekken6RareDirectCountJakuHitMemory1") var rareDirectCountJakuHit: Int = 0
    @AppStorage("tekken6RareDirectCountKyoCherryMemory1") var rareDirectCountKyoCherry: Int = 0
    @AppStorage("tekken6RareDirectCountKyoHitMemory1") var rareDirectCountKyoHit: Int = 0
}


class Tekken6Memory2: ObservableObject {
    @AppStorage("tekken6NormalGameMemory2") var normalGame: Int = 0
    @AppStorage("tekken6FirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("tekken6FirstHitCountBonusBlueMemory2") var firstHitCountBonusBlue: Int = 0
    @AppStorage("tekken6FirstHitCountBonusRedMemory2") var firstHitCountBonusRed: Int = 0
    @AppStorage("tekken6FirstHitCountBonusSumMemory2") var firstHitCountBonusSum: Int = 0
    @AppStorage("tekken6FirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("tekken6BackCountHitMemory2") var backCountHit: Int = 0
    @AppStorage("tekken6BackCountMissMemory2") var backCountMiss: Int = 0
    @AppStorage("tekken6BackCountSumMemory2") var backCountSum: Int = 0
    @AppStorage("tekken6MemoMemory2") var memo = ""
    @AppStorage("tekken6DateMemory2") var dateDouble = 0.0
    
    // -------
    // ver3.18.0で追加
    // -------
    @AppStorage("tekken6RareDirectCountJakuCherryMemory2") var rareDirectCountJakuCherry: Int = 0
    @AppStorage("tekken6RareDirectCountSuikaMemory2") var rareDirectCountSuika: Int = 0
    @AppStorage("tekken6RareDirectCountChanceMemory2") var rareDirectCountChance: Int = 0
    @AppStorage("tekken6RareDirectCountJakuSumMemory2") var rareDirectCountJakuSum: Int = 0
    @AppStorage("tekken6RareDirectCountJakuHitMemory2") var rareDirectCountJakuHit: Int = 0
    @AppStorage("tekken6RareDirectCountKyoCherryMemory2") var rareDirectCountKyoCherry: Int = 0
    @AppStorage("tekken6RareDirectCountKyoHitMemory2") var rareDirectCountKyoHit: Int = 0
}


class Tekken6Memory3: ObservableObject {
    @AppStorage("tekken6NormalGameMemory3") var normalGame: Int = 0
    @AppStorage("tekken6FirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("tekken6FirstHitCountBonusBlueMemory3") var firstHitCountBonusBlue: Int = 0
    @AppStorage("tekken6FirstHitCountBonusRedMemory3") var firstHitCountBonusRed: Int = 0
    @AppStorage("tekken6FirstHitCountBonusSumMemory3") var firstHitCountBonusSum: Int = 0
    @AppStorage("tekken6FirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("tekken6BackCountHitMemory3") var backCountHit: Int = 0
    @AppStorage("tekken6BackCountMissMemory3") var backCountMiss: Int = 0
    @AppStorage("tekken6BackCountSumMemory3") var backCountSum: Int = 0
    @AppStorage("tekken6MemoMemory3") var memo = ""
    @AppStorage("tekken6DateMemory3") var dateDouble = 0.0
    
    // -------
    // ver3.18.0で追加
    // -------
    @AppStorage("tekken6RareDirectCountJakuCherryMemory3") var rareDirectCountJakuCherry: Int = 0
    @AppStorage("tekken6RareDirectCountSuikaMemory3") var rareDirectCountSuika: Int = 0
    @AppStorage("tekken6RareDirectCountChanceMemory3") var rareDirectCountChance: Int = 0
    @AppStorage("tekken6RareDirectCountJakuSumMemory3") var rareDirectCountJakuSum: Int = 0
    @AppStorage("tekken6RareDirectCountJakuHitMemory3") var rareDirectCountJakuHit: Int = 0
    @AppStorage("tekken6RareDirectCountKyoCherryMemory3") var rareDirectCountKyoCherry: Int = 0
    @AppStorage("tekken6RareDirectCountKyoHitMemory3") var rareDirectCountKyoHit: Int = 0
}
