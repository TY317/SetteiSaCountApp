//
//  streetFighter6Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class StreetFighter6: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitFb: [Double] = [278.6,272.1,264.6,258.9,255.3,252.6]
    let ratioFirstHitBonus: [Double] = [487.6,473.3,447.2,425.6,405.9,389.9]
    @AppStorage("streetFighter6NormalGame") var normalGame: Int = 0
    @AppStorage("streetFighter6FirstHitCountFb") var firstHitCountFb: Int = 0
    @AppStorage("streetFighter6FirstHitCountBonus") var firstHitCountBonus: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountFb = 0
        firstHitCountBonus = 0
        minusCheck = false
    }


    // --------
    // 終了画面
    // --------
    let ratioScreenOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioScreenOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioScreenOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("streetFighter6ScreenCount1") var screenCount1: Int = 0
    @AppStorage("streetFighter6ScreenCount2") var screenCount2: Int = 0
    @AppStorage("streetFighter6ScreenCount3") var screenCount3: Int = 0
    @AppStorage("streetFighter6ScreenCount4") var screenCount4: Int = 0
    @AppStorage("streetFighter6ScreenCount5") var screenCount5: Int = 0
    @AppStorage("streetFighter6ScreenCount6") var screenCount6: Int = 0
    @AppStorage("streetFighter6ScreenCount7") var screenCount7: Int = 0
    @AppStorage("streetFighter6ScreenCount8") var screenCount8: Int = 0
    @AppStorage("streetFighter6ScreenCountSum") var screenCountSum: Int = 0

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
        screenCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "ストリートファイター6"
    @AppStorage("streetFighter6MinusCheck") var minusCheck: Bool = false
    @AppStorage("streetFighter6SelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
    }
}


class StreetFighter6Memory1: ObservableObject {
    @AppStorage("streetFighter6MemoMemory1") var memo = ""
    @AppStorage("streetFighter6DateMemory1") var dateDouble = 0.0
}


class StreetFighter6Memory2: ObservableObject {
    @AppStorage("streetFighter6MemoMemory2") var memo = ""
    @AppStorage("streetFighter6DateMemory2") var dateDouble = 0.0
}


class StreetFighter6Memory3: ObservableObject {
    @AppStorage("streetFighter6MemoMemory3") var memo = ""
    @AppStorage("streetFighter6DateMemory3") var dateDouble = 0.0
}
