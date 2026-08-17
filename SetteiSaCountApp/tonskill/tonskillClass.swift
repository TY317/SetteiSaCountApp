//
//  tonskillClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Tonskill: ObservableObject {
    // -------
    // 通常時
    // -------
    // ポイント推定
    @AppStorage("tonskillPtSui") var ptSui: Int = 0
    @AppStorage("tonskillPtMukoda") var ptMukoda: Int = 0
    @AppStorage("tonskillPtFeru") var ptFeru: Int = 0

    func resetPtSui() {
        ptSui = 0
    }

    func resetPtMukoda() {
        ptMukoda = 0
    }

    func resetPtFeru() {
        ptFeru = 0
    }

    func resetPt() {
        ptSui = 0
        ptMukoda = 0
        ptFeru = 0
    }

    func resetNormal() {
        resetPt()
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [216.7,215.6,212.7,203.7,195.3,189.5]
    let ratioFirstHitBonus: [Double] = [349.3,339.2,322.4,286.5,263.7,247.3]
    @AppStorage("tonskillNormalGame") var normalGame: Int = 0
    @AppStorage("tonskillFirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("tonskillFirstHitCountBonus") var firstHitCountBonus: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountBonus = 0
        minusCheck = false
    }


    // --------
    // エンディング枠
    // --------
    let ratioEndingOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioEndingOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("tonskillEndingCount1") var endingCount1: Int = 0
    @AppStorage("tonskillEndingCount2") var endingCount2: Int = 0
    @AppStorage("tonskillEndingCount3") var endingCount3: Int = 0
    @AppStorage("tonskillEndingCount4") var endingCount4: Int = 0
    @AppStorage("tonskillEndingCount5") var endingCount5: Int = 0
    @AppStorage("tonskillEndingCount6") var endingCount6: Int = 0
    @AppStorage("tonskillEndingCountSum") var endingCountSum: Int = 0

    func endingSumFunc() {
        endingCountSum = countSum(
            endingCount1,
            endingCount2,
            endingCount3,
            endingCount4,
            endingCount5,
            endingCount6,
        )
    }

    func resetEnding() {
        endingCount1 = 0
        endingCount2 = 0
        endingCount3 = 0
        endingCount4 = 0
        endingCount5 = 0
        endingCount6 = 0
        endingCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "とんでもスキルで異世界放浪メシ"
    @AppStorage("tonskillMinusCheck") var minusCheck: Bool = false
    @AppStorage("tonskillSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetEnding()
    }
}


class TonskillMemory1: ObservableObject {
    // ポイント推定
    @AppStorage("tonskillPtSuiMemory1") var ptSui: Int = 0
    @AppStorage("tonskillPtMukodaMemory1") var ptMukoda: Int = 0
    @AppStorage("tonskillPtFeruMemory1") var ptFeru: Int = 0
    // 初当り
    @AppStorage("tonskillNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("tonskillFirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("tonskillFirstHitCountBonusMemory1") var firstHitCountBonus: Int = 0
    // エンディング枠
    @AppStorage("tonskillEndingCount1Memory1") var endingCount1: Int = 0
    @AppStorage("tonskillEndingCount2Memory1") var endingCount2: Int = 0
    @AppStorage("tonskillEndingCount3Memory1") var endingCount3: Int = 0
    @AppStorage("tonskillEndingCount4Memory1") var endingCount4: Int = 0
    @AppStorage("tonskillEndingCount5Memory1") var endingCount5: Int = 0
    @AppStorage("tonskillEndingCount6Memory1") var endingCount6: Int = 0
    @AppStorage("tonskillEndingCountSumMemory1") var endingCountSum: Int = 0
    @AppStorage("tonskillMemoMemory1") var memo = ""
    @AppStorage("tonskillDateMemory1") var dateDouble = 0.0
}


class TonskillMemory2: ObservableObject {
    // ポイント推定
    @AppStorage("tonskillPtSuiMemory2") var ptSui: Int = 0
    @AppStorage("tonskillPtMukodaMemory2") var ptMukoda: Int = 0
    @AppStorage("tonskillPtFeruMemory2") var ptFeru: Int = 0
    // 初当り
    @AppStorage("tonskillNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("tonskillFirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("tonskillFirstHitCountBonusMemory2") var firstHitCountBonus: Int = 0
    // エンディング枠
    @AppStorage("tonskillEndingCount1Memory2") var endingCount1: Int = 0
    @AppStorage("tonskillEndingCount2Memory2") var endingCount2: Int = 0
    @AppStorage("tonskillEndingCount3Memory2") var endingCount3: Int = 0
    @AppStorage("tonskillEndingCount4Memory2") var endingCount4: Int = 0
    @AppStorage("tonskillEndingCount5Memory2") var endingCount5: Int = 0
    @AppStorage("tonskillEndingCount6Memory2") var endingCount6: Int = 0
    @AppStorage("tonskillEndingCountSumMemory2") var endingCountSum: Int = 0
    @AppStorage("tonskillMemoMemory2") var memo = ""
    @AppStorage("tonskillDateMemory2") var dateDouble = 0.0
}


class TonskillMemory3: ObservableObject {
    // ポイント推定
    @AppStorage("tonskillPtSuiMemory3") var ptSui: Int = 0
    @AppStorage("tonskillPtMukodaMemory3") var ptMukoda: Int = 0
    @AppStorage("tonskillPtFeruMemory3") var ptFeru: Int = 0
    // 初当り
    @AppStorage("tonskillNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("tonskillFirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("tonskillFirstHitCountBonusMemory3") var firstHitCountBonus: Int = 0
    // エンディング枠
    @AppStorage("tonskillEndingCount1Memory3") var endingCount1: Int = 0
    @AppStorage("tonskillEndingCount2Memory3") var endingCount2: Int = 0
    @AppStorage("tonskillEndingCount3Memory3") var endingCount3: Int = 0
    @AppStorage("tonskillEndingCount4Memory3") var endingCount4: Int = 0
    @AppStorage("tonskillEndingCount5Memory3") var endingCount5: Int = 0
    @AppStorage("tonskillEndingCount6Memory3") var endingCount6: Int = 0
    @AppStorage("tonskillEndingCountSumMemory3") var endingCountSum: Int = 0
    @AppStorage("tonskillMemoMemory3") var memo = ""
    @AppStorage("tonskillDateMemory3") var dateDouble = 0.0
}
