//
//  yajikitaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Yajikita: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [231.1,222.7,209.5,191.5,173.1,157.5]
    let ratioFirstHitAt: [Double] = [473.9,457.5,431.6,388.1,352.1,318.3]
    @AppStorage("yajikitaNormalGame") var normalGame: Int = 0
    @AppStorage("yajikitaFirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("yajikitaFirstHitCountAt") var firstHitCountAt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountAt = 0
        minusCheck = false
    }


    // --------
    // 終了画面
    // --------
    @AppStorage("yajikitaScreenCount1") var screenCount1: Int = 0
    @AppStorage("yajikitaScreenCount2") var screenCount2: Int = 0
    @AppStorage("yajikitaScreenCount3") var screenCount3: Int = 0
    @AppStorage("yajikitaScreenCountSum") var screenCountSum: Int = 0

    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
        )
    }

    func resetScreen() {
        screenCount1 = 0
        screenCount2 = 0
        screenCount3 = 0
        screenCountSum = 0
        minusCheck = false
    }


    // --------
    // 手形
    // --------
    @AppStorage("yajikitaEndingCount1") var endingCount1: Int = 0
    @AppStorage("yajikitaEndingCount2") var endingCount2: Int = 0
    @AppStorage("yajikitaEndingCountSum") var endingCountSum: Int = 0

    func endingSumFunc() {
        endingCountSum = countSum(
            endingCount1,
            endingCount2,
        )
    }

    func resetEnding() {
        endingCount1 = 0
        endingCount2 = 0
        endingCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "やじきた道中記参る！"
    @AppStorage("yajikitaMinusCheck") var minusCheck: Bool = false
    @AppStorage("yajikitaSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetEnding()
    }
}


class YajikitaMemory1: ObservableObject {
    @AppStorage("yajikitaMemoMemory1") var memo = ""
    @AppStorage("yajikitaDateMemory1") var dateDouble = 0.0
}


class YajikitaMemory2: ObservableObject {
    @AppStorage("yajikitaMemoMemory2") var memo = ""
    @AppStorage("yajikitaDateMemory2") var dateDouble = 0.0
}


class YajikitaMemory3: ObservableObject {
    @AppStorage("yajikitaMemoMemory3") var memo = ""
    @AppStorage("yajikitaDateMemory3") var dateDouble = 0.0
}
