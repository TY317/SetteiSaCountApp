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
        
        screenCountTenjoSum = countSum(
            screenCount4,
            screenCount5,
            screenCount6,
            screenCount7,
            screenCount8,
        )
        
        screenCountWithoutTenjoSum = screenCountSum - screenCountTenjoSum
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
        
        screenCountTenjoSum = 0
        screenCountWithoutTenjoSum = 0
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
    
    // ----------
    // ver3.24.0
    // ----------
    @AppStorage("akudamaScreenCountTenjoSum") var screenCountTenjoSum: Int = 0
    @AppStorage("akudamaScreenCountWithoutTenjoSum") var screenCountWithoutTenjoSum: Int = 0
}


class AkudamaMemory1: ObservableObject {
    @AppStorage("akudamaPtCountFullMemory1") var ptCountFull: Int = 0
    @AppStorage("akudamaPtCountCzHitMemory1") var ptCountCzHit: Int = 0
    @AppStorage("akudamaFirstHitCzMemory1") var firstHitCz: Int = 0
    @AppStorage("akudamaFirstHitEpisodeMemory1") var firstHitEpisode: Int = 0
    @AppStorage("akudamaFirstHitAkudamaMemory1") var firstHitAkudama: Int = 0
    @AppStorage("akudamaFirstHitAtMemory1") var firstHitAt: Int = 0
    @AppStorage("akudamaFirstHitBonusSumMemory1") var firstHitBonusSum: Int = 0
    @AppStorage("akudamaNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("akudamaScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("akudamaScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("akudamaScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("akudamaScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("akudamaScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("akudamaScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("akudamaScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("akudamaScreenCount8Memory1") var screenCount8: Int = 0
    @AppStorage("akudamaScreenCount9Memory1") var screenCount9: Int = 0
    @AppStorage("akudamaScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("akudamaMemoMemory1") var memo = ""
    @AppStorage("akudamaDateMemory1") var dateDouble = 0.0
    
    @AppStorage("akudamaScreenCountTenjoSumMemory1") var screenCountTenjoSum: Int = 0
    @AppStorage("akudamaScreenCountWithoutTenjoSumMemory1") var screenCountWithoutTenjoSum: Int = 0
}


class AkudamaMemory2: ObservableObject {
    @AppStorage("akudamaPtCountFullMemory2") var ptCountFull: Int = 0
    @AppStorage("akudamaPtCountCzHitMemory2") var ptCountCzHit: Int = 0
    @AppStorage("akudamaFirstHitCzMemory2") var firstHitCz: Int = 0
    @AppStorage("akudamaFirstHitEpisodeMemory2") var firstHitEpisode: Int = 0
    @AppStorage("akudamaFirstHitAkudamaMemory2") var firstHitAkudama: Int = 0
    @AppStorage("akudamaFirstHitAtMemory2") var firstHitAt: Int = 0
    @AppStorage("akudamaFirstHitBonusSumMemory2") var firstHitBonusSum: Int = 0
    @AppStorage("akudamaNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("akudamaScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("akudamaScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("akudamaScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("akudamaScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("akudamaScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("akudamaScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("akudamaScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("akudamaScreenCount8Memory2") var screenCount8: Int = 0
    @AppStorage("akudamaScreenCount9Memory2") var screenCount9: Int = 0
    @AppStorage("akudamaScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("akudamaMemoMemory2") var memo = ""
    @AppStorage("akudamaDateMemory2") var dateDouble = 0.0
    
    @AppStorage("akudamaScreenCountTenjoSumMemory2") var screenCountTenjoSum: Int = 0
    @AppStorage("akudamaScreenCountWithoutTenjoSumMemory2") var screenCountWithoutTenjoSum: Int = 0
}


class AkudamaMemory3: ObservableObject {
    @AppStorage("akudamaPtCountFullMemory3") var ptCountFull: Int = 0
    @AppStorage("akudamaPtCountCzHitMemory3") var ptCountCzHit: Int = 0
    @AppStorage("akudamaFirstHitCzMemory3") var firstHitCz: Int = 0
    @AppStorage("akudamaFirstHitEpisodeMemory3") var firstHitEpisode: Int = 0
    @AppStorage("akudamaFirstHitAkudamaMemory3") var firstHitAkudama: Int = 0
    @AppStorage("akudamaFirstHitAtMemory3") var firstHitAt: Int = 0
    @AppStorage("akudamaFirstHitBonusSumMemory3") var firstHitBonusSum: Int = 0
    @AppStorage("akudamaNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("akudamaScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("akudamaScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("akudamaScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("akudamaScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("akudamaScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("akudamaScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("akudamaScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("akudamaScreenCount8Memory3") var screenCount8: Int = 0
    @AppStorage("akudamaScreenCount9Memory3") var screenCount9: Int = 0
    @AppStorage("akudamaScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("akudamaMemoMemory3") var memo = ""
    @AppStorage("akudamaDateMemory3") var dateDouble = 0.0
    
    @AppStorage("akudamaScreenCountTenjoSumMemory3") var screenCountTenjoSum: Int = 0
    @AppStorage("akudamaScreenCountWithoutTenjoSumMemory3") var screenCountWithoutTenjoSum: Int = 0
}
