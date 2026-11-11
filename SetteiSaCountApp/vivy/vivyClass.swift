//
//  vivyClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Vivy: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------

    func resetFirstHit() {
        minusCheck = false
    }

    // --------
    // 終了画面
    // --------
    @AppStorage("vivyScreenCount1") var screenCount1: Int = 0
    @AppStorage("vivyScreenCount2") var screenCount2: Int = 0
    @AppStorage("vivyScreenCount3") var screenCount3: Int = 0
    @AppStorage("vivyScreenCount4") var screenCount4: Int = 0
    @AppStorage("vivyScreenCount5") var screenCount5: Int = 0
    @AppStorage("vivyScreenCount6") var screenCount6: Int = 0
    @AppStorage("vivyScreenCount7") var screenCount7: Int = 0
    @AppStorage("vivyScreenCount8") var screenCount8: Int = 0
    @AppStorage("vivyScreenCount9") var screenCount9: Int = 0
    @AppStorage("vivyScreenCountSum") var screenCountSum: Int = 0

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
    let machineName: String = "Vivy"
    @AppStorage("vivyMinusCheck") var minusCheck: Bool = false
    @AppStorage("vivySelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
    }
}


class VivyMemory1: ObservableObject {
    @AppStorage("vivyMemoMemory1") var memo = ""
    @AppStorage("vivyDateMemory1") var dateDouble = 0.0
}


class VivyMemory2: ObservableObject {
    @AppStorage("vivyMemoMemory2") var memo = ""
    @AppStorage("vivyDateMemory2") var dateDouble = 0.0
}


class VivyMemory3: ObservableObject {
    @AppStorage("vivyMemoMemory3") var memo = ""
    @AppStorage("vivyDateMemory3") var dateDouble = 0.0
}
