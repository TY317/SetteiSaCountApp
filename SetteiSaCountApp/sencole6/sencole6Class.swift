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

    // -------
    // AT中
    // -------
    let ratioTenmaIssen300: [Double] = [40.2,39.5,37.8,29.5,24.7,20.2]
    let ratioTenmaIssen550: [Double] = [14.8,13.7,12.8,9.5,7.9,6.5]
    let ratioTenmaIssen800: [Double] = [9.8,9.9,9.2,7.3,6.2,5.1]
    let ratioTenmaIssen1050: [Double] = [35.2,36.9,40.2,53.7,61.2,68.2]
    @AppStorage("sencole6TenmaIssenCount300") var tenmaIssenCount300: Int = 0
    @AppStorage("sencole6TenmaIssenCount550") var tenmaIssenCount550: Int = 0
    @AppStorage("sencole6TenmaIssenCount800") var tenmaIssenCount800: Int = 0
    @AppStorage("sencole6TenmaIssenCount1050") var tenmaIssenCount1050: Int = 0
    @AppStorage("sencole6TenmaIssenCountSum") var tenmaIssenCountSum: Int = 0

    func tenmaIssenSumFunc() {
        tenmaIssenCountSum = countSum(
            tenmaIssenCount300,
            tenmaIssenCount550,
            tenmaIssenCount800,
            tenmaIssenCount1050,
        )
    }

    func resetDuringAt() {
        tenmaIssenCount300 = 0
        tenmaIssenCount550 = 0
        tenmaIssenCount800 = 0
        tenmaIssenCount1050 = 0
        tenmaIssenCountSum = 0
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
        resetDuringAt()
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
    @AppStorage("sencole6TenmaIssenCount300Memory1") var tenmaIssenCount300: Int = 0
    @AppStorage("sencole6TenmaIssenCount550Memory1") var tenmaIssenCount550: Int = 0
    @AppStorage("sencole6TenmaIssenCount800Memory1") var tenmaIssenCount800: Int = 0
    @AppStorage("sencole6TenmaIssenCount1050Memory1") var tenmaIssenCount1050: Int = 0
    @AppStorage("sencole6TenmaIssenCountSumMemory1") var tenmaIssenCountSum: Int = 0
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
    @AppStorage("sencole6TenmaIssenCount300Memory2") var tenmaIssenCount300: Int = 0
    @AppStorage("sencole6TenmaIssenCount550Memory2") var tenmaIssenCount550: Int = 0
    @AppStorage("sencole6TenmaIssenCount800Memory2") var tenmaIssenCount800: Int = 0
    @AppStorage("sencole6TenmaIssenCount1050Memory2") var tenmaIssenCount1050: Int = 0
    @AppStorage("sencole6TenmaIssenCountSumMemory2") var tenmaIssenCountSum: Int = 0
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
    @AppStorage("sencole6TenmaIssenCount300Memory3") var tenmaIssenCount300: Int = 0
    @AppStorage("sencole6TenmaIssenCount550Memory3") var tenmaIssenCount550: Int = 0
    @AppStorage("sencole6TenmaIssenCount800Memory3") var tenmaIssenCount800: Int = 0
    @AppStorage("sencole6TenmaIssenCount1050Memory3") var tenmaIssenCount1050: Int = 0
    @AppStorage("sencole6TenmaIssenCountSumMemory3") var tenmaIssenCountSum: Int = 0
    @AppStorage("sencole6MemoMemory3") var memo = ""
    @AppStorage("sencole6DateMemory3") var dateDouble = 0.0
}
