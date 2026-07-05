//
//  sencole6Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Sencole6: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitAt: [Double] = [363.6,350.4,329.8,289.4,268.5,252.2]
    @AppStorage("sencole6NormalGame") var normalGame: Int = 0
    @AppStorage("sencole6FirstHitCountAt") var firstHitCountAt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        minusCheck = false
    }
    
    // --------
    // 終了画面
    // --------
    @AppStorage("sencole6ScreenCount1") var screenCount1: Int = 0
    @AppStorage("sencole6ScreenCount2") var screenCount2: Int = 0
    @AppStorage("sencole6ScreenCount3") var screenCount3: Int = 0
    @AppStorage("sencole6ScreenCount4") var screenCount4: Int = 0
    @AppStorage("sencole6ScreenCount5") var screenCount5: Int = 0
    @AppStorage("sencole6ScreenCount6") var screenCount6: Int = 0
    @AppStorage("sencole6ScreenCount7") var screenCount7: Int = 0
    @AppStorage("sencole6ScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
            screenCount4,
            screenCount5,
            screenCount6,
            screenCount7,
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
        screenCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "戦国コレクション6"
    @AppStorage("sencole6MinusCheck") var minusCheck: Bool = false
    @AppStorage("sencole6SelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
    }
}


class Sencole6Memory1: ObservableObject {
    @AppStorage("sencole6NormalGameMemory1") var normalGame: Int = 0
    @AppStorage("sencole6FirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("sencole6ScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("sencole6ScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("sencole6ScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("sencole6ScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("sencole6ScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("sencole6ScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("sencole6ScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("sencole6ScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("sencole6MemoMemory1") var memo = ""
    @AppStorage("sencole6DateMemory1") var dateDouble = 0.0
}


class Sencole6Memory2: ObservableObject {
    @AppStorage("sencole6NormalGameMemory2") var normalGame: Int = 0
    @AppStorage("sencole6FirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("sencole6ScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("sencole6ScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("sencole6ScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("sencole6ScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("sencole6ScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("sencole6ScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("sencole6ScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("sencole6ScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("sencole6MemoMemory2") var memo = ""
    @AppStorage("sencole6DateMemory2") var dateDouble = 0.0
}


class Sencole6Memory3: ObservableObject {
    @AppStorage("sencole6NormalGameMemory3") var normalGame: Int = 0
    @AppStorage("sencole6FirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("sencole6ScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("sencole6ScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("sencole6ScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("sencole6ScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("sencole6ScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("sencole6ScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("sencole6ScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("sencole6ScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("sencole6MemoMemory3") var memo = ""
    @AppStorage("sencole6DateMemory3") var dateDouble = 0.0
}
