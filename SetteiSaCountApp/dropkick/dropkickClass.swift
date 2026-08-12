//
//  dropkickClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Dropkick: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitBonus: [Double] = [253.1,248.1,241.6,222.5,211.8,210.0]
    let ratioFirstHitAt: [Double] = [758.2,746.3,722.8,655.9,615.9,606.2]
    @AppStorage("dropkickNormalGame") var normalGame: Int = 0
    @AppStorage("dropkickFirstHitCountBonus") var firstHitCountBonus: Int = 0
    @AppStorage("dropkickFirstHitCountAt") var firstHitCountAt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountBonus = 0
        firstHitCountAt = 0
        minusCheck = false
    }


    // --------
    // 終了画面
    // --------
    let ratioScreenOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioScreenOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioScreenOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioScreenOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("dropkickScreenCount1") var screenCount1: Int = 0
    @AppStorage("dropkickScreenCount2") var screenCount2: Int = 0
    @AppStorage("dropkickScreenCount3") var screenCount3: Int = 0
    @AppStorage("dropkickScreenCount4") var screenCount4: Int = 0
    @AppStorage("dropkickScreenCount5") var screenCount5: Int = 0
    @AppStorage("dropkickScreenCount6") var screenCount6: Int = 0
    @AppStorage("dropkickScreenCount7") var screenCount7: Int = 0
    @AppStorage("dropkickScreenCount8") var screenCount8: Int = 0
    @AppStorage("dropkickScreenCount9") var screenCount9: Int = 0
    @AppStorage("dropkickScreenCount10") var screenCount10: Int = 0
    @AppStorage("dropkickScreenCount11") var screenCount11: Int = 0
    @AppStorage("dropkickScreenCountSum") var screenCountSum: Int = 0

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
        screenCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "邪神ちゃんドロップキック"
    @AppStorage("dropkickMinusCheck") var minusCheck: Bool = false
    @AppStorage("dropkickSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
    }
}


class DropkickMemory1: ObservableObject {
    @AppStorage("dropkickMemoMemory1") var memo = ""
    @AppStorage("dropkickDateMemory1") var dateDouble = 0.0
}


class DropkickMemory2: ObservableObject {
    @AppStorage("dropkickMemoMemory2") var memo = ""
    @AppStorage("dropkickDateMemory2") var dateDouble = 0.0
}


class DropkickMemory3: ObservableObject {
    @AppStorage("dropkickMemoMemory3") var memo = ""
    @AppStorage("dropkickDateMemory3") var dateDouble = 0.0
}
