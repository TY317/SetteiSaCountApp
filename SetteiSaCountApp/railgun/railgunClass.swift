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
    let ratioCoinCzHit: [Double] = [37.7,-1,-1,-1,-1,-1]
    @AppStorage("railgunCoinCount") var coinCount: Int = 0
    @AppStorage("railgunCoinCountCzHit") var coinCountCzHit: Int = 0
    
    func resetNormal() {
        coinCount = 0
        coinCountCzHit = 0
        minusCheck = false
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
}
