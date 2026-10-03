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

    let ratioMegami333G: [Double] = [30.1,31.6,33.2,34.8,39.1,44.9]
    @AppStorage("tonskillMegami333GCountMiss") var megami333GCountMiss: Int = 0
    @AppStorage("tonskillMegami333GCountHit") var megami333GCountHit: Int = 0
    @AppStorage("tonskillMegami333GCountSum") var megami333GCountSum: Int = 0

    func megami333GSumFunc() {
        megami333GCountSum = megami333GCountHit + megami333GCountMiss
    }

    func resetNormal() {
        resetPt()
        megami333GCountMiss = 0
        megami333GCountHit = 0
        megami333GCountSum = 0
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

    // --------
    // 終了画面
    // --------
    let ratioScreenOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioScreenOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioScreenOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("tonskillScreenCount1") var screenCount1: Int = 0
    @AppStorage("tonskillScreenCount2") var screenCount2: Int = 0
    @AppStorage("tonskillScreenCount3") var screenCount3: Int = 0
    @AppStorage("tonskillScreenCount4") var screenCount4: Int = 0
    @AppStorage("tonskillScreenCount5") var screenCount5: Int = 0
    @AppStorage("tonskillScreenCount6") var screenCount6: Int = 0
    @AppStorage("tonskillScreenCount7") var screenCount7: Int = 0
    @AppStorage("tonskillScreenCount8") var screenCount8: Int = 0
    @AppStorage("tonskillScreenCountSum") var screenCountSum: Int = 0

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
    let machineName: String = "とんでもスキルで異世界放浪メシ"
    @AppStorage("tonskillMinusCheck") var minusCheck: Bool = false
    @AppStorage("tonskillSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
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
    @AppStorage("tonskillScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("tonskillScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("tonskillScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("tonskillScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("tonskillScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("tonskillScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("tonskillScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("tonskillScreenCount8Memory1") var screenCount8: Int = 0
    @AppStorage("tonskillScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("tonskillMegami333GCountMissMemory1") var megami333GCountMiss: Int = 0
    @AppStorage("tonskillMegami333GCountHitMemory1") var megami333GCountHit: Int = 0
    @AppStorage("tonskillMegami333GCountSumMemory1") var megami333GCountSum: Int = 0
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
    @AppStorage("tonskillScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("tonskillScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("tonskillScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("tonskillScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("tonskillScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("tonskillScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("tonskillScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("tonskillScreenCount8Memory2") var screenCount8: Int = 0
    @AppStorage("tonskillScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("tonskillMegami333GCountMissMemory2") var megami333GCountMiss: Int = 0
    @AppStorage("tonskillMegami333GCountHitMemory2") var megami333GCountHit: Int = 0
    @AppStorage("tonskillMegami333GCountSumMemory2") var megami333GCountSum: Int = 0
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
    @AppStorage("tonskillScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("tonskillScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("tonskillScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("tonskillScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("tonskillScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("tonskillScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("tonskillScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("tonskillScreenCount8Memory3") var screenCount8: Int = 0
    @AppStorage("tonskillScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("tonskillMegami333GCountMissMemory3") var megami333GCountMiss: Int = 0
    @AppStorage("tonskillMegami333GCountHitMemory3") var megami333GCountHit: Int = 0
    @AppStorage("tonskillMegami333GCountSumMemory3") var megami333GCountSum: Int = 0
    @AppStorage("tonskillMemoMemory3") var memo = ""
    @AppStorage("tonskillDateMemory3") var dateDouble = 0.0
}
