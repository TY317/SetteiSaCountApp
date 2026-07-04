//
//  karakuri2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/27.
//

import Foundation
import SwiftUI
import Combine

class Karakuri2: ObservableObject {
    // -------
    // 通常時
    // -------
    
    func resetNormal() {
        minusCheck = false
    }
    
    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [342,341,339,339,327,318]
    let ratioFirstHitAt: [Double] = [519,504,474,458,430,410]
    @AppStorage("karakuri2NormalGame") var normalGame: Int = 0
    @AppStorage("karakuri2FirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("karakuri2FirstHitCountAt") var firstHitCountAt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountAt = 0
        minusCheck = false
    }

    // --------
    // 終了画面
    // --------
    @AppStorage("karakuri2ScreenCount1") var screenCount1: Int = 0
    @AppStorage("karakuri2ScreenCount2") var screenCount2: Int = 0
    @AppStorage("karakuri2ScreenCount3") var screenCount3: Int = 0
    @AppStorage("karakuri2ScreenCount4") var screenCount4: Int = 0
    @AppStorage("karakuri2ScreenCount5") var screenCount5: Int = 0
    @AppStorage("karakuri2ScreenCount6") var screenCount6: Int = 0
    @AppStorage("karakuri2ScreenCountSum") var screenCountSum: Int = 0

    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
            screenCount4,
            screenCount5,
            screenCount6,
        )
    }

    func resetScreen() {
        screenCount1 = 0
        screenCount2 = 0
        screenCount3 = 0
        screenCount4 = 0
        screenCount5 = 0
        screenCount6 = 0
        screenCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "からくりサーカス2"
    @AppStorage("karakuri2MinusCheck") var minusCheck: Bool = false
    @AppStorage("karakuri2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
    }
}


class Karakuri2Memory1: ObservableObject {
    @AppStorage("karakuri2MemoMemory1") var memo = ""
    @AppStorage("karakuri2DateMemory1") var dateDouble = 0.0
}


class Karakuri2Memory2: ObservableObject {
    @AppStorage("karakuri2MemoMemory2") var memo = ""
    @AppStorage("karakuri2DateMemory2") var dateDouble = 0.0
}


class Karakuri2Memory3: ObservableObject {
    @AppStorage("karakuri2MemoMemory3") var memo = ""
    @AppStorage("karakuri2DateMemory3") var dateDouble = 0.0
}
