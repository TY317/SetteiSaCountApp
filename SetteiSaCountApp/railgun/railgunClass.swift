//
//  railgunClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/19.
//

import Foundation
import SwiftUI

class Railgun: ObservableObject {
    // ------------
    // 通常時
    // ------------
    let ratioCoinCzHit: [Double] = [37.7,38.6,39.5,42.9,47.1,50.2]
    @AppStorage("railgunCoinCount") var coinCount: Int = 0
    @AppStorage("railgunCoinCountCzHit") var coinCountCzHit: Int = 0
    
    func resetNormal() {
        coinCount = 0
        coinCountCzHit = 0
        minusCheck = false
        rareCzCountCherry = 0
        rareCzCountCherryHit = 0
        rareCzCountSuika = 0
        rareCzCountSuikaHit = 0
    }
    
    // --------------
    // 初当り
    // --------------
    let ratioFirstHitCz: [Double] = [175.7,172.6,168.5,156.6,145.7,137.5]
    let ratioFirstHitAt: [Double] = [317.8,311.8,304.4,272.4,248.1,235.2]
    @AppStorage("railgunNormalGame") var normalGame: Int = 0
    @AppStorage("railgunCzCount") var czCount: Int = 0
    @AppStorage("railgunAtCount") var atCount: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        czCount = 0
        atCount = 0
        minusCheck = false
        czCountPremium = 0
    }
    
    // ----------
    // AT中
    // ----------
    @AppStorage("railgunIchimaieCount1") var ichimaieCount1: Int = 0
    @AppStorage("railgunIchimaieCount2") var ichimaieCount2: Int = 0
    @AppStorage("railgunIchimaieCount3") var ichimaieCount3: Int = 0
    @AppStorage("railgunIchimaieCount4") var ichimaieCount4: Int = 0
    @AppStorage("railgunIchimaieCount5") var ichimaieCount5: Int = 0
    @AppStorage("railgunIchimaieCount6") var ichimaieCount6: Int = 0
    @AppStorage("railgunIchimaieCount7") var ichimaieCount7: Int = 0
    @AppStorage("railgunIchimaieCountSum") var ichimaieCountSum: Int = 0
    
    func ichimaieSumFunc() {
        ichimaieCountSum = countSum(
            ichimaieCount1,
            ichimaieCount2,
            ichimaieCount3,
            ichimaieCount4,
            ichimaieCount5,
            ichimaieCount6,
            ichimaieCount7,
        )
    }
    
    func resetAt() {
        ichimaieCount1 = 0
        ichimaieCount2 = 0
        ichimaieCount3 = 0
        ichimaieCount4 = 0
        ichimaieCount5 = 0
        ichimaieCount6 = 0
        ichimaieCount7 = 0
        ichimaieCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // 終了画面
    // -----------
    @AppStorage("railgunScreenCountDefault") var screenCountDefault: Int = 0
    @AppStorage("railgunScreenCountGusu") var screenCountGusu: Int = 0
    @AppStorage("railgunScreenCountHighJaku") var screenCountHighJaku: Int = 0
    @AppStorage("railgunScreenCountHighKyo") var screenCountHighKyo: Int = 0
    @AppStorage("railgunScreenCountOver2") var screenCountOver2: Int = 0
    @AppStorage("railgunScreenCountOver3") var screenCountOver3: Int = 0
    @AppStorage("railgunScreenCountOver4") var screenCountOver4: Int = 0
    @AppStorage("railgunScreenCountOver5") var screenCountOver5: Int = 0
    @AppStorage("railgunScreenCountOver6") var screenCountOver6: Int = 0
    @AppStorage("railgunScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCountDefault,
            screenCountGusu,
            screenCountHighJaku,
            screenCountHighKyo,
            screenCountOver2,
            screenCountOver3,
            screenCountOver4,
            screenCountOver5,
            screenCountOver6,
        )
    }
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountGusu = 0
        screenCountHighJaku = 0
        screenCountHighKyo = 0
        screenCountOver2 = 0
        screenCountOver3 = 0
        screenCountOver4 = 0
        screenCountOver5 = 0
        screenCountOver6 = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "とある科学の超電磁砲2"
    @AppStorage("railgunMinusCheck") var minusCheck: Bool = false
    @AppStorage("railgunSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetAt()
    }
    
    // -------------
    // ver3.14.0で追加
    // -------------
    let ratioRareCzCherry: [Double] = [0.78,0.78,1.17,1.56,1.56,1.95]
    let ratioRareCzSuika: [Double] = [25,25,25.78,28.52,29.3,30.08]
    @AppStorage("railgunRareCzCountCherry") var rareCzCountCherry: Int = 0
    @AppStorage("railgunRareCzCountCherryHit") var rareCzCountCherryHit: Int = 0
    @AppStorage("railgunRareCzCountSuika") var rareCzCountSuika: Int = 0
    @AppStorage("railgunRareCzCountSuikaHit") var rareCzCountSuikaHit: Int = 0
    
    // 初当り
    let ratioFirstHitCzNormal: [Double] = [179.99,177.69,173.44,163.19,153.54,145.25]
    let ratioFirstHitCzPremium: [Double] = [7456.18,6024.31,5925.19,3852.39,2861.31,2586.86]
    @AppStorage("railgunCzCountPremium") var czCountPremium: Int = 0
}


class RailgunMemory1: ObservableObject {
    @AppStorage("railgunCoinCountMemory1") var coinCount: Int = 0
    @AppStorage("railgunCoinCountCzHitMemory1") var coinCountCzHit: Int = 0
    @AppStorage("railgunNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("railgunCzCountMemory1") var czCount: Int = 0
    @AppStorage("railgunAtCountMemory1") var atCount: Int = 0
    @AppStorage("railgunIchimaieCount1Memory1") var ichimaieCount1: Int = 0
    @AppStorage("railgunIchimaieCount2Memory1") var ichimaieCount2: Int = 0
    @AppStorage("railgunIchimaieCount3Memory1") var ichimaieCount3: Int = 0
    @AppStorage("railgunIchimaieCount4Memory1") var ichimaieCount4: Int = 0
    @AppStorage("railgunIchimaieCount5Memory1") var ichimaieCount5: Int = 0
    @AppStorage("railgunIchimaieCount6Memory1") var ichimaieCount6: Int = 0
    @AppStorage("railgunIchimaieCount7Memory1") var ichimaieCount7: Int = 0
    @AppStorage("railgunIchimaieCountSumMemory1") var ichimaieCountSum: Int = 0
    @AppStorage("railgunScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("railgunScreenCountGusuMemory1") var screenCountGusu: Int = 0
    @AppStorage("railgunScreenCountHighJakuMemory1") var screenCountHighJaku: Int = 0
    @AppStorage("railgunScreenCountHighKyoMemory1") var screenCountHighKyo: Int = 0
    @AppStorage("railgunScreenCountOver2Memory1") var screenCountOver2: Int = 0
    @AppStorage("railgunScreenCountOver3Memory1") var screenCountOver3: Int = 0
    @AppStorage("railgunScreenCountOver4Memory1") var screenCountOver4: Int = 0
    @AppStorage("railgunScreenCountOver5Memory1") var screenCountOver5: Int = 0
    @AppStorage("railgunScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("railgunScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("railgunMemoMemory1") var memo = ""
    @AppStorage("railgunDateMemory1") var dateDouble = 0.0
}


class RailgunMemory2: ObservableObject {
    @AppStorage("railgunCoinCountMemory2") var coinCount: Int = 0
    @AppStorage("railgunCoinCountCzHitMemory2") var coinCountCzHit: Int = 0
    @AppStorage("railgunNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("railgunCzCountMemory2") var czCount: Int = 0
    @AppStorage("railgunAtCountMemory2") var atCount: Int = 0
    @AppStorage("railgunIchimaieCount1Memory2") var ichimaieCount1: Int = 0
    @AppStorage("railgunIchimaieCount2Memory2") var ichimaieCount2: Int = 0
    @AppStorage("railgunIchimaieCount3Memory2") var ichimaieCount3: Int = 0
    @AppStorage("railgunIchimaieCount4Memory2") var ichimaieCount4: Int = 0
    @AppStorage("railgunIchimaieCount5Memory2") var ichimaieCount5: Int = 0
    @AppStorage("railgunIchimaieCount6Memory2") var ichimaieCount6: Int = 0
    @AppStorage("railgunIchimaieCount7Memory2") var ichimaieCount7: Int = 0
    @AppStorage("railgunIchimaieCountSumMemory2") var ichimaieCountSum: Int = 0
    @AppStorage("railgunScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("railgunScreenCountGusuMemory2") var screenCountGusu: Int = 0
    @AppStorage("railgunScreenCountHighJakuMemory2") var screenCountHighJaku: Int = 0
    @AppStorage("railgunScreenCountHighKyoMemory2") var screenCountHighKyo: Int = 0
    @AppStorage("railgunScreenCountOver2Memory2") var screenCountOver2: Int = 0
    @AppStorage("railgunScreenCountOver3Memory2") var screenCountOver3: Int = 0
    @AppStorage("railgunScreenCountOver4Memory2") var screenCountOver4: Int = 0
    @AppStorage("railgunScreenCountOver5Memory2") var screenCountOver5: Int = 0
    @AppStorage("railgunScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("railgunScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("railgunMemoMemory2") var memo = ""
    @AppStorage("railgunDateMemory2") var dateDouble = 0.0
}


class RailgunMemory3: ObservableObject {
    @AppStorage("railgunCoinCountMemory3") var coinCount: Int = 0
    @AppStorage("railgunCoinCountCzHitMemory3") var coinCountCzHit: Int = 0
    @AppStorage("railgunNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("railgunCzCountMemory3") var czCount: Int = 0
    @AppStorage("railgunAtCountMemory3") var atCount: Int = 0
    @AppStorage("railgunIchimaieCount1Memory3") var ichimaieCount1: Int = 0
    @AppStorage("railgunIchimaieCount2Memory3") var ichimaieCount2: Int = 0
    @AppStorage("railgunIchimaieCount3Memory3") var ichimaieCount3: Int = 0
    @AppStorage("railgunIchimaieCount4Memory3") var ichimaieCount4: Int = 0
    @AppStorage("railgunIchimaieCount5Memory3") var ichimaieCount5: Int = 0
    @AppStorage("railgunIchimaieCount6Memory3") var ichimaieCount6: Int = 0
    @AppStorage("railgunIchimaieCount7Memory3") var ichimaieCount7: Int = 0
    @AppStorage("railgunIchimaieCountSumMemory3") var ichimaieCountSum: Int = 0
    @AppStorage("railgunScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("railgunScreenCountGusuMemory3") var screenCountGusu: Int = 0
    @AppStorage("railgunScreenCountHighJakuMemory3") var screenCountHighJaku: Int = 0
    @AppStorage("railgunScreenCountHighKyoMemory3") var screenCountHighKyo: Int = 0
    @AppStorage("railgunScreenCountOver2Memory3") var screenCountOver2: Int = 0
    @AppStorage("railgunScreenCountOver3Memory3") var screenCountOver3: Int = 0
    @AppStorage("railgunScreenCountOver4Memory3") var screenCountOver4: Int = 0
    @AppStorage("railgunScreenCountOver5Memory3") var screenCountOver5: Int = 0
    @AppStorage("railgunScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("railgunScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("railgunMemoMemory3") var memo = ""
    @AppStorage("railgunDateMemory3") var dateDouble = 0.0
}
