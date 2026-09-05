//
//  ricoricoClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Ricorico: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [198.7,196.9,191.3,183.3,175.9,169.4]
    let ratioFirstHitBattleCz: [Double] = [209.2,-1,-1,-1,-1,184.4]
    let ratioFirstHitYoshokiCz: [Double] = [3965,-1,-1,-1,-1,2084.8]
    let ratioFirstHitAt: [Double] = [328.8,323.4,312.1,288.3,271.6,256.7]
    @AppStorage("ricoricoNormalGame") var normalGame: Int = 0
    @AppStorage("ricoricoFirstHitCountBattleCz") var firstHitCountBattleCz: Int = 0
    @AppStorage("ricoricoFirstHitCountYoshokiCz") var firstHitCountYoshokiCz: Int = 0
    @AppStorage("ricoricoFirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("ricoricoFirstHitCountAt") var firstHitCountAt: Int = 0

    func firstHitCzSumFunc() {
        firstHitCountCz = firstHitCountBattleCz + firstHitCountYoshokiCz
    }

    func resetFirstHit() {
        normalGame = 0
        firstHitCountBattleCz = 0
        firstHitCountYoshokiCz = 0
        firstHitCountCz = 0
        firstHitCountAt = 0
        minusCheck = false
    }

    // --------
    // 終了画面
    // --------
    @AppStorage("ricoricoScreenCount1") var screenCount1: Int = 0
    @AppStorage("ricoricoScreenCount2") var screenCount2: Int = 0
    @AppStorage("ricoricoScreenCount3") var screenCount3: Int = 0
    @AppStorage("ricoricoScreenCount4") var screenCount4: Int = 0
    @AppStorage("ricoricoScreenCount5") var screenCount5: Int = 0
    @AppStorage("ricoricoScreenCount6") var screenCount6: Int = 0
    @AppStorage("ricoricoScreenCount7") var screenCount7: Int = 0
    @AppStorage("ricoricoScreenCountSum") var screenCountSum: Int = 0

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

    // --------
    // AT中 エピソードボーナス画面
    // --------
    @AppStorage("ricoricoPrologueCount1") var prologueCount1: Int = 0
    @AppStorage("ricoricoPrologueCount2") var prologueCount2: Int = 0
    @AppStorage("ricoricoPrologueCount3") var prologueCount3: Int = 0
    @AppStorage("ricoricoPrologueCountSum") var prologueCountSum: Int = 0
    @AppStorage("ricoricoRushEpiboCount1") var rushEpiboCount1: Int = 0
    @AppStorage("ricoricoRushEpiboCount2") var rushEpiboCount2: Int = 0
    @AppStorage("ricoricoRushEpiboCount3") var rushEpiboCount3: Int = 0
    @AppStorage("ricoricoRushEpiboCountSum") var rushEpiboCountSum: Int = 0
    @AppStorage("ricoricoWRushEpiboCount1") var wRushEpiboCount1: Int = 0
    @AppStorage("ricoricoWRushEpiboCount2") var wRushEpiboCount2: Int = 0
    @AppStorage("ricoricoWRushEpiboCount3") var wRushEpiboCount3: Int = 0
    @AppStorage("ricoricoWRushEpiboCountSum") var wRushEpiboCountSum: Int = 0

    func prologueSumFunc() {
        prologueCountSum = countSum(
            prologueCount1,
            prologueCount2,
            prologueCount3,
        )
    }

    func rushEpiboSumFunc() {
        rushEpiboCountSum = countSum(
            rushEpiboCount1,
            rushEpiboCount2,
            rushEpiboCount3,
        )
    }

    func wRushEpiboSumFunc() {
        wRushEpiboCountSum = countSum(
            wRushEpiboCount1,
            wRushEpiboCount2,
            wRushEpiboCount3,
        )
    }

    func resetDuringAt() {
        prologueCount1 = 0
        prologueCount2 = 0
        prologueCount3 = 0
        prologueCountSum = 0
        rushEpiboCount1 = 0
        rushEpiboCount2 = 0
        rushEpiboCount3 = 0
        rushEpiboCountSum = 0
        wRushEpiboCount1 = 0
        wRushEpiboCount2 = 0
        wRushEpiboCount3 = 0
        wRushEpiboCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "リコリス・リコイル"
    @AppStorage("ricoricoMinusCheck") var minusCheck: Bool = false
    @AppStorage("ricoricoSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetDuringAt()
    }
}


class RicoricoMemory1: ObservableObject {
    @AppStorage("ricoricoMemoMemory1") var memo = ""
    @AppStorage("ricoricoDateMemory1") var dateDouble = 0.0
}


class RicoricoMemory2: ObservableObject {
    @AppStorage("ricoricoMemoMemory2") var memo = ""
    @AppStorage("ricoricoDateMemory2") var dateDouble = 0.0
}


class RicoricoMemory3: ObservableObject {
    @AppStorage("ricoricoMemoMemory3") var memo = ""
    @AppStorage("ricoricoDateMemory3") var dateDouble = 0.0
}
