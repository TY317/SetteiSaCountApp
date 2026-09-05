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
    @AppStorage("ricoricoNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("ricoricoFirstHitCountBattleCzMemory1") var firstHitCountBattleCz: Int = 0
    @AppStorage("ricoricoFirstHitCountYoshokiCzMemory1") var firstHitCountYoshokiCz: Int = 0
    @AppStorage("ricoricoFirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("ricoricoFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("ricoricoScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("ricoricoScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("ricoricoScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("ricoricoScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("ricoricoScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("ricoricoScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("ricoricoScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("ricoricoScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("ricoricoPrologueCount1Memory1") var prologueCount1: Int = 0
    @AppStorage("ricoricoPrologueCount2Memory1") var prologueCount2: Int = 0
    @AppStorage("ricoricoPrologueCount3Memory1") var prologueCount3: Int = 0
    @AppStorage("ricoricoPrologueCountSumMemory1") var prologueCountSum: Int = 0
    @AppStorage("ricoricoRushEpiboCount1Memory1") var rushEpiboCount1: Int = 0
    @AppStorage("ricoricoRushEpiboCount2Memory1") var rushEpiboCount2: Int = 0
    @AppStorage("ricoricoRushEpiboCount3Memory1") var rushEpiboCount3: Int = 0
    @AppStorage("ricoricoRushEpiboCountSumMemory1") var rushEpiboCountSum: Int = 0
    @AppStorage("ricoricoWRushEpiboCount1Memory1") var wRushEpiboCount1: Int = 0
    @AppStorage("ricoricoWRushEpiboCount2Memory1") var wRushEpiboCount2: Int = 0
    @AppStorage("ricoricoWRushEpiboCount3Memory1") var wRushEpiboCount3: Int = 0
    @AppStorage("ricoricoWRushEpiboCountSumMemory1") var wRushEpiboCountSum: Int = 0
    @AppStorage("ricoricoMemoMemory1") var memo = ""
    @AppStorage("ricoricoDateMemory1") var dateDouble = 0.0
}


class RicoricoMemory2: ObservableObject {
    @AppStorage("ricoricoNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("ricoricoFirstHitCountBattleCzMemory2") var firstHitCountBattleCz: Int = 0
    @AppStorage("ricoricoFirstHitCountYoshokiCzMemory2") var firstHitCountYoshokiCz: Int = 0
    @AppStorage("ricoricoFirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("ricoricoFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("ricoricoScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("ricoricoScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("ricoricoScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("ricoricoScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("ricoricoScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("ricoricoScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("ricoricoScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("ricoricoScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("ricoricoPrologueCount1Memory2") var prologueCount1: Int = 0
    @AppStorage("ricoricoPrologueCount2Memory2") var prologueCount2: Int = 0
    @AppStorage("ricoricoPrologueCount3Memory2") var prologueCount3: Int = 0
    @AppStorage("ricoricoPrologueCountSumMemory2") var prologueCountSum: Int = 0
    @AppStorage("ricoricoRushEpiboCount1Memory2") var rushEpiboCount1: Int = 0
    @AppStorage("ricoricoRushEpiboCount2Memory2") var rushEpiboCount2: Int = 0
    @AppStorage("ricoricoRushEpiboCount3Memory2") var rushEpiboCount3: Int = 0
    @AppStorage("ricoricoRushEpiboCountSumMemory2") var rushEpiboCountSum: Int = 0
    @AppStorage("ricoricoWRushEpiboCount1Memory2") var wRushEpiboCount1: Int = 0
    @AppStorage("ricoricoWRushEpiboCount2Memory2") var wRushEpiboCount2: Int = 0
    @AppStorage("ricoricoWRushEpiboCount3Memory2") var wRushEpiboCount3: Int = 0
    @AppStorage("ricoricoWRushEpiboCountSumMemory2") var wRushEpiboCountSum: Int = 0
    @AppStorage("ricoricoMemoMemory2") var memo = ""
    @AppStorage("ricoricoDateMemory2") var dateDouble = 0.0
}


class RicoricoMemory3: ObservableObject {
    @AppStorage("ricoricoNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("ricoricoFirstHitCountBattleCzMemory3") var firstHitCountBattleCz: Int = 0
    @AppStorage("ricoricoFirstHitCountYoshokiCzMemory3") var firstHitCountYoshokiCz: Int = 0
    @AppStorage("ricoricoFirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("ricoricoFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("ricoricoScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("ricoricoScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("ricoricoScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("ricoricoScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("ricoricoScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("ricoricoScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("ricoricoScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("ricoricoScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("ricoricoPrologueCount1Memory3") var prologueCount1: Int = 0
    @AppStorage("ricoricoPrologueCount2Memory3") var prologueCount2: Int = 0
    @AppStorage("ricoricoPrologueCount3Memory3") var prologueCount3: Int = 0
    @AppStorage("ricoricoPrologueCountSumMemory3") var prologueCountSum: Int = 0
    @AppStorage("ricoricoRushEpiboCount1Memory3") var rushEpiboCount1: Int = 0
    @AppStorage("ricoricoRushEpiboCount2Memory3") var rushEpiboCount2: Int = 0
    @AppStorage("ricoricoRushEpiboCount3Memory3") var rushEpiboCount3: Int = 0
    @AppStorage("ricoricoRushEpiboCountSumMemory3") var rushEpiboCountSum: Int = 0
    @AppStorage("ricoricoWRushEpiboCount1Memory3") var wRushEpiboCount1: Int = 0
    @AppStorage("ricoricoWRushEpiboCount2Memory3") var wRushEpiboCount2: Int = 0
    @AppStorage("ricoricoWRushEpiboCount3Memory3") var wRushEpiboCount3: Int = 0
    @AppStorage("ricoricoWRushEpiboCountSumMemory3") var wRushEpiboCountSum: Int = 0
    @AppStorage("ricoricoMemoMemory3") var memo = ""
    @AppStorage("ricoricoDateMemory3") var dateDouble = 0.0
}
