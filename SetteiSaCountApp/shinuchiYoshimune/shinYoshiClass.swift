//
//  shinYoshiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/29.
//

import Foundation
import SwiftUI
import Combine

class ShinYoshi: ObservableObject {
    // ----------
    // 初当り
    // ----------
    let ratioFirstHitAt: [Double] = [488.9,471.5,438.5,398.1,377,354.9]
    @AppStorage("shinYoshiNormalGame") var normalGame: Int = 0
    @AppStorage("shinYoshiFirstHitCountAt") var firstHitCountAt: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "真打 吉宗"
    @AppStorage("shinYoshiMinusCheck") var minusCheck: Bool = false
    @AppStorage("shinYoshiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
        resetNormal()
        resetCz()
    }
    
    // ---------
    // ver4.2.1
    // ---------
    // 抜刀チャンス当選率
    let ratioBattoChance: [Double] = [20.31,22.27,22.27,24.22,24.22,25.78]
    @AppStorage("shinYoshiBattoCountMiss") var battoCountMiss: Int = 0
    @AppStorage("shinYoshiBattoCountHit") var battoCountHit: Int = 0
    @AppStorage("shinYoshiBattoCountSum") var battoCountSum: Int = 0
    
    func battoSumFunc() {
        battoCountSum = battoCountMiss + battoCountHit
    }
    
    func resetNormal() {
        battoCountMiss = 0
        battoCountHit = 0
        battoCountSum = 0
        minusCheck = false
    }
    
    // 柳生選択率
    let ratioCzYagyu: [Double] = [3.7,3.9,4.7,6.2,7.81,8.7]
    @AppStorage("shinYoshiCzCharaCountOther") var czCharaCountOther: Int = 0
    @AppStorage("shinYoshiCzCharaCountYagyu") var czCharaCountYagyu: Int = 0
    @AppStorage("shinYoshiCzCharaCountSum") var czCharaCountSum: Int = 0
    
    func czCharaSumFunc() {
        czCharaCountSum = czCharaCountOther + czCharaCountYagyu
    }
    
    func resetCz() {
        czCharaCountOther = 0
        czCharaCountYagyu = 0
        czCharaCountSum = 0
        minusCheck = false
    }
}


class ShinYoshiMemory1: ObservableObject {
    @AppStorage("shinYoshiNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("shinYoshiFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("shinYoshiBattoCountMissMemory1") var battoCountMiss: Int = 0
    @AppStorage("shinYoshiBattoCountHitMemory1") var battoCountHit: Int = 0
    @AppStorage("shinYoshiBattoCountSumMemory1") var battoCountSum: Int = 0
    @AppStorage("shinYoshiCzCharaCountOtherMemory1") var czCharaCountOther: Int = 0
    @AppStorage("shinYoshiCzCharaCountYagyuMemory1") var czCharaCountYagyu: Int = 0
    @AppStorage("shinYoshiCzCharaCountSumMemory1") var czCharaCountSum: Int = 0
    @AppStorage("shinYoshiMemoMemory1") var memo = ""
    @AppStorage("shinYoshiDateMemory1") var dateDouble = 0.0
}


class ShinYoshiMemory2: ObservableObject {
    @AppStorage("shinYoshiNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("shinYoshiFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("shinYoshiBattoCountMissMemory2") var battoCountMiss: Int = 0
    @AppStorage("shinYoshiBattoCountHitMemory2") var battoCountHit: Int = 0
    @AppStorage("shinYoshiBattoCountSumMemory2") var battoCountSum: Int = 0
    @AppStorage("shinYoshiCzCharaCountOtherMemory2") var czCharaCountOther: Int = 0
    @AppStorage("shinYoshiCzCharaCountYagyuMemory2") var czCharaCountYagyu: Int = 0
    @AppStorage("shinYoshiCzCharaCountSumMemory2") var czCharaCountSum: Int = 0
    @AppStorage("shinYoshiMemoMemory2") var memo = ""
    @AppStorage("shinYoshiDateMemory2") var dateDouble = 0.0
}


class ShinYoshiMemory3: ObservableObject {
    @AppStorage("shinYoshiNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("shinYoshiFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("shinYoshiBattoCountMissMemory3") var battoCountMiss: Int = 0
    @AppStorage("shinYoshiBattoCountHitMemory3") var battoCountHit: Int = 0
    @AppStorage("shinYoshiBattoCountSumMemory3") var battoCountSum: Int = 0
    @AppStorage("shinYoshiCzCharaCountOtherMemory3") var czCharaCountOther: Int = 0
    @AppStorage("shinYoshiCzCharaCountYagyuMemory3") var czCharaCountYagyu: Int = 0
    @AppStorage("shinYoshiCzCharaCountSumMemory3") var czCharaCountSum: Int = 0
    @AppStorage("shinYoshiMemoMemory3") var memo = ""
    @AppStorage("shinYoshiDateMemory3") var dateDouble = 0.0
}
