//
//  jormungandClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import Foundation
import SwiftUI
import Combine

class Jormungand: ObservableObject {
    // ---------
    // 通常時
    // ---------
    // レア役からのCZ
    let ratioRareCzNormalChance: [Double] = [10.16,11.33,14.06,16.02,16.41,16.80]
    let ratioRareCzNormalKyoCherry: [Double] = [25,26.95,32.03,34.38,34.77,35.16]
    let ratioRareCzHighChance: [Double] = [33.59,36.72,46.09,50,50,50]
    let ratioRareCzHighKyoCherry: [Double] = [66.80,68.36,75,80.08,80.08,80.08,]
    @AppStorage("jormungandRareCzCountChance") var rareCzCountChance: Int = 0
    @AppStorage("jormungandRareCzCountChanceHit") var rareCzCountChanceHit: Int = 0
    @AppStorage("jormungandRareCzCountKyoCherry") var rareCzCountKyoCherry: Int = 0
    @AppStorage("jormungandRareCzCountKyoCherryHit") var rareCzCountKyoCherryHit: Int = 0
    
    // 天井短縮
    let ratioTenjoCut: [Double] = [33.59,40.23,45.31,49.22,49.61,50]
    @AppStorage("jormungandTenjoCountMiss") var tenjoCountMiss: Int = 0
    @AppStorage("jormungandTenjoCountHit") var tenjoCountHit: Int = 0
    @AppStorage("jormungandTenjoCountSum") var tenjoCountSum: Int = 0
    
    func tenjoSumFunc() {
        tenjoCountSum = tenjoCountMiss + tenjoCountHit
    }
    
    func resetNormal() {
        rareCzCountChance = 0
        rareCzCountChanceHit = 0
        rareCzCountKyoCherry = 0
        rareCzCountKyoCherryHit = 0
        tenjoCountMiss = 0
        tenjoCountHit = 0
        tenjoCountSum = 0
        minusCheck = false
    }
    
    // ----------
    // CZ
    // ----------
    let ratioFirstHitCz: [Double] = [194.2,188.6,175.7,169.4,167.8,167.2]
    @AppStorage("jormungandNormalGame") var normalGame: Int = 0
    @AppStorage("jormungandFirstHitCountCz") var firstHitCountCz: Int = 0
    
    func resetCz() {
        normalGame = 0
        firstHitCountCz = 0
        minusCheck = false
    }
    
    // -----------
    // 初当り
    // -----------
    let ratioFirstHitAt: [Double] = [333.8,323.3,305.4,291.6,291.1,290.1]
    @AppStorage("jormungandFirstHitCountAt") var firstHitCountAt: Int = 0
    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountAt = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ヨルムンガンド"
    @AppStorage("jormungandMinusCheck") var minusCheck: Bool = false
    @AppStorage("jormungandSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetCz()
        resetFirstHit()
    }
}


class JormungandMemory1: ObservableObject {
    @AppStorage("jormungandNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("jormungandFirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("jormungandFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("jormungandMemoMemory1") var memo = ""
    @AppStorage("jormungandDateMemory1") var dateDouble = 0.0
}


class JormungandMemory2: ObservableObject {
    @AppStorage("jormungandNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("jormungandFirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("jormungandFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("jormungandMemoMemory2") var memo = ""
    @AppStorage("jormungandDateMemory2") var dateDouble = 0.0
}


class JormungandMemory3: ObservableObject {
    @AppStorage("jormungandNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("jormungandFirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("jormungandFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("jormungandMemoMemory3") var memo = ""
    @AppStorage("jormungandDateMemory3") var dateDouble = 0.0
}
