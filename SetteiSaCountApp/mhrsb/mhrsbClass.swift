//
//  mhrsbClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Mhrsb: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitAt: [Double] = [349.9,337.0,319.8,283.6,264.0,242.3]
    @AppStorage("mhrsbNormalGame") var normalGame: Int = 0
    @AppStorage("mhrsbFirstHitCountAt") var firstHitCountAt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        minusCheck = false
    }

    // --------
    // 終了画面
    // --------
    let ratioScreenNegate2: [Double] = [0.1,0,0.1,0.1,0.1,0.1,]
    let ratioScreenNegate3: [Double] = [0.1,0.1,0,0.1,0.1,0.1,]
    let ratioScreenOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioScreenOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioScreenOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("mhrsbScreenCount1") var screenCount1: Int = 0
    @AppStorage("mhrsbScreenCount2") var screenCount2: Int = 0
    @AppStorage("mhrsbScreenCount3") var screenCount3: Int = 0
    @AppStorage("mhrsbScreenCount4") var screenCount4: Int = 0
    @AppStorage("mhrsbScreenCount5") var screenCount5: Int = 0
    @AppStorage("mhrsbScreenCount6") var screenCount6: Int = 0
    @AppStorage("mhrsbScreenCount7") var screenCount7: Int = 0
    @AppStorage("mhrsbScreenCount8") var screenCount8: Int = 0
    @AppStorage("mhrsbScreenCount9") var screenCount9: Int = 0
    @AppStorage("mhrsbScreenCount10") var screenCount10: Int = 0
    @AppStorage("mhrsbScreenCount11") var screenCount11: Int = 0
    @AppStorage("mhrsbScreenCount12") var screenCount12: Int = 0
    @AppStorage("mhrsbScreenCountSum") var screenCountSum: Int = 0

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
            screenCount10,
            screenCount11,
            screenCount12,
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
        screenCount10 = 0
        screenCount11 = 0
        screenCount12 = 0
        screenCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "モンスターハンターライズ：サンブレイク"
    @AppStorage("mhrsbMinusCheck") var minusCheck: Bool = false
    @AppStorage("mhrsbSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
    }
}


class MhrsbMemory1: ObservableObject {
    @AppStorage("mhrsbMemoMemory1") var memo = ""
    @AppStorage("mhrsbDateMemory1") var dateDouble = 0.0
}


class MhrsbMemory2: ObservableObject {
    @AppStorage("mhrsbMemoMemory2") var memo = ""
    @AppStorage("mhrsbDateMemory2") var dateDouble = 0.0
}


class MhrsbMemory3: ObservableObject {
    @AppStorage("mhrsbMemoMemory3") var memo = ""
    @AppStorage("mhrsbDateMemory3") var dateDouble = 0.0
}
