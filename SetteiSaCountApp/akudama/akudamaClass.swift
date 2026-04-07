//
//  akudamaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/05.
//

import Foundation
import SwiftUI
import Combine

class Akudama: ObservableObject {
    // --------
    // 通常時
    // --------
    let ratioPtCzHit: [Double] = [21.9,22.7,24.2,28.9,33.6,36.7]
    @AppStorage("akudamaPtCountFull") var ptCountFull: Int = 0
    @AppStorage("akudamaPtCountCzHit") var ptCountCzHit: Int = 0
    
    func resetNormal() {
        ptCountFull = 0
        ptCountCzHit = 0
        minusCheck = false
    }
    
    // -----------
    // 初当り
    // -----------
    let ratioFirstHitCz: [Double] = [166.1,165.3,163.8,159.3,154.8,152.1]
    let ratioFirstHitBonus: [Double] = [321.2,319.3,315.8,307,296.9,291.1]
    let ratioFirstHitAt: [Double] = [555.5,550.7,543.6,517.8,487.7,472]
    @AppStorage("akudamaFirstHitCz") var firstHitCz: Int = 0
    @AppStorage("akudamaFirstHitEpisode") var firstHitEpisode: Int = 0
    @AppStorage("akudamaFirstHitAkudama") var firstHitAkudama: Int = 0
    @AppStorage("akudamaFirstHitAt") var firstHitAt: Int = 0
    @AppStorage("akudamaFirstHitBonusSum") var firstHitBonusSum: Int = 0
    @AppStorage("akudamaNormalGame") var normalGame: Int = 0
    
    func bonusSumFunc() {
        firstHitBonusSum = firstHitAkudama + firstHitEpisode
    }
    
    func resetFirstHit() {
        firstHitCz = 0
        firstHitEpisode = 0
        firstHitAkudama = 0
        firstHitAt = 0
        firstHitBonusSum = 0
        normalGame = 0
        minusCheck = false
    }
    
    // ---------
    // 終了画面
    // ---------
    @AppStorage("akudamaScreenCount1") var screenCount1: Int = 0
    @AppStorage("akudamaScreenCount2") var screenCount2: Int = 0
    @AppStorage("akudamaScreenCount3") var screenCount3: Int = 0
    @AppStorage("akudamaScreenCount4") var screenCount4: Int = 0
    @AppStorage("akudamaScreenCount5") var screenCount5: Int = 0
    @AppStorage("akudamaScreenCount6") var screenCount6: Int = 0
    @AppStorage("akudamaScreenCount7") var screenCount7: Int = 0
    @AppStorage("akudamaScreenCount8") var screenCount8: Int = 0
    @AppStorage("akudamaScreenCount9") var screenCount9: Int = 0
    @AppStorage("akudamaScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
            screenCount4,
            screenCount5,
            screenCount6,
            screenCount7,
            screenCount8,
            screenCount9,
        )
    }
    
    func resetScreen() {
        screenCount1 = 0
        screenCount2 = 0
        screenCount3 = 0
        screenCount4 = 0
        screenCount5 = 0
        screenCount6 = 0
        screenCount7 = 0
        screenCount8 = 0
        screenCount9 = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "アクダマドライブ"
    @AppStorage("akudamaMinusCheck") var minusCheck: Bool = false
    @AppStorage("akudamaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
    }
}
