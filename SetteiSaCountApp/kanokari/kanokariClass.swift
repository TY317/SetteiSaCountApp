//
//  kanokariClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Kanokari: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [172,169,164,154,151,149]
    let ratioFirstHitBonus: [Double] = [269,263,254,235,231,226]
    @AppStorage("kanokariNormalGame") var normalGame: Int = 0
    @AppStorage("kanokariFirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("kanokariFirstHitCountBonus") var firstHitCountBonus: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountBonus = 0
        minusCheck = false
    }

    // -------
    // 画面選択
    // -------
    let ratioScreenOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioScreenOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioScreenOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioScreenOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("kanokariScreenCount1") var screenCount1: Int = 0
    @AppStorage("kanokariScreenCount2") var screenCount2: Int = 0
    @AppStorage("kanokariScreenCount3") var screenCount3: Int = 0
    @AppStorage("kanokariScreenCount4") var screenCount4: Int = 0
    @AppStorage("kanokariScreenCount5") var screenCount5: Int = 0
    @AppStorage("kanokariScreenCount6") var screenCount6: Int = 0
    @AppStorage("kanokariScreenCount7") var screenCount7: Int = 0
    @AppStorage("kanokariScreenCountSum") var screenCountSum: Int = 0

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
    // シナリオ選択
    // -------
    @AppStorage("kanokariCharaSenarioCount1") var charaSenarioCount1: Int = 0
    @AppStorage("kanokariCharaSenarioCount2") var charaSenarioCount2: Int = 0
    @AppStorage("kanokariCharaSenarioCount3") var charaSenarioCount3: Int = 0
    @AppStorage("kanokariCharaSenarioCount4") var charaSenarioCount4: Int = 0
    @AppStorage("kanokariCharaSenarioCount5") var charaSenarioCount5: Int = 0
    @AppStorage("kanokariCharaSenarioCount6") var charaSenarioCount6: Int = 0
    @AppStorage("kanokariCharaSenarioCount7") var charaSenarioCount7: Int = 0
    @AppStorage("kanokariCharaSenarioCount8") var charaSenarioCount8: Int = 0
    @AppStorage("kanokariCharaSenarioCountSum") var charaSenarioCountSum: Int = 0

    func charaSenarioSumFunc() {
        charaSenarioCountSum = countSum(
            charaSenarioCount1,
            charaSenarioCount2,
            charaSenarioCount3,
            charaSenarioCount4,
            charaSenarioCount5,
            charaSenarioCount6,
            charaSenarioCount7,
            charaSenarioCount8,
        )
    }

    func resetCharaSenario() {
        charaSenarioCount1 = 0
        charaSenarioCount2 = 0
        charaSenarioCount3 = 0
        charaSenarioCount4 = 0
        charaSenarioCount5 = 0
        charaSenarioCount6 = 0
        charaSenarioCount7 = 0
        charaSenarioCount8 = 0
        charaSenarioCountSum = 0
        minusCheck = false
    }

    // -------
    // キャラ選択（1Gレンチャンス）
    // -------
    @AppStorage("kanokariKoryakuCharaCount1") var koryakuCharaCount1: Int = 0   // 偶数設定示唆
    @AppStorage("kanokariKoryakuCharaCount2") var koryakuCharaCount2: Int = 0   // 奇数設定示唆
    @AppStorage("kanokariKoryakuCharaCountSum") var koryakuCharaCountSum: Int = 0

    func koryakuCharaSumFunc() {
        koryakuCharaCountSum = countSum(
            koryakuCharaCount1,
            koryakuCharaCount2,
        )
    }

    func resetKoryakuChara() {
        koryakuCharaCount1 = 0
        koryakuCharaCount2 = 0
        koryakuCharaCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "彼女、お借りします"
    @AppStorage("kanokariMinusCheck") var minusCheck: Bool = false
    @AppStorage("kanokariSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetCharaSenario()
        resetKoryakuChara()
    }
}


class KanokariMemory1: ObservableObject {
    @AppStorage("kanokariNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("kanokariFirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("kanokariFirstHitCountBonusMemory1") var firstHitCountBonus: Int = 0
    @AppStorage("kanokariScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("kanokariScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("kanokariScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("kanokariScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("kanokariScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("kanokariScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("kanokariScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("kanokariScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("kanokariCharaSenarioCount1Memory1") var charaSenarioCount1: Int = 0
    @AppStorage("kanokariCharaSenarioCount2Memory1") var charaSenarioCount2: Int = 0
    @AppStorage("kanokariCharaSenarioCount3Memory1") var charaSenarioCount3: Int = 0
    @AppStorage("kanokariCharaSenarioCount4Memory1") var charaSenarioCount4: Int = 0
    @AppStorage("kanokariCharaSenarioCount5Memory1") var charaSenarioCount5: Int = 0
    @AppStorage("kanokariCharaSenarioCount6Memory1") var charaSenarioCount6: Int = 0
    @AppStorage("kanokariCharaSenarioCount7Memory1") var charaSenarioCount7: Int = 0
    @AppStorage("kanokariCharaSenarioCount8Memory1") var charaSenarioCount8: Int = 0
    @AppStorage("kanokariCharaSenarioCountSumMemory1") var charaSenarioCountSum: Int = 0
    @AppStorage("kanokariKoryakuCharaCount1Memory1") var koryakuCharaCount1: Int = 0
    @AppStorage("kanokariKoryakuCharaCount2Memory1") var koryakuCharaCount2: Int = 0
    @AppStorage("kanokariKoryakuCharaCountSumMemory1") var koryakuCharaCountSum: Int = 0
    @AppStorage("kanokariMemoMemory1") var memo = ""
    @AppStorage("kanokariDateMemory1") var dateDouble = 0.0
}


class KanokariMemory2: ObservableObject {
    @AppStorage("kanokariNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("kanokariFirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("kanokariFirstHitCountBonusMemory2") var firstHitCountBonus: Int = 0
    @AppStorage("kanokariScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("kanokariScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("kanokariScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("kanokariScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("kanokariScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("kanokariScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("kanokariScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("kanokariScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("kanokariCharaSenarioCount1Memory2") var charaSenarioCount1: Int = 0
    @AppStorage("kanokariCharaSenarioCount2Memory2") var charaSenarioCount2: Int = 0
    @AppStorage("kanokariCharaSenarioCount3Memory2") var charaSenarioCount3: Int = 0
    @AppStorage("kanokariCharaSenarioCount4Memory2") var charaSenarioCount4: Int = 0
    @AppStorage("kanokariCharaSenarioCount5Memory2") var charaSenarioCount5: Int = 0
    @AppStorage("kanokariCharaSenarioCount6Memory2") var charaSenarioCount6: Int = 0
    @AppStorage("kanokariCharaSenarioCount7Memory2") var charaSenarioCount7: Int = 0
    @AppStorage("kanokariCharaSenarioCount8Memory2") var charaSenarioCount8: Int = 0
    @AppStorage("kanokariCharaSenarioCountSumMemory2") var charaSenarioCountSum: Int = 0
    @AppStorage("kanokariKoryakuCharaCount1Memory2") var koryakuCharaCount1: Int = 0
    @AppStorage("kanokariKoryakuCharaCount2Memory2") var koryakuCharaCount2: Int = 0
    @AppStorage("kanokariKoryakuCharaCountSumMemory2") var koryakuCharaCountSum: Int = 0
    @AppStorage("kanokariMemoMemory2") var memo = ""
    @AppStorage("kanokariDateMemory2") var dateDouble = 0.0
}


class KanokariMemory3: ObservableObject {
    @AppStorage("kanokariNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("kanokariFirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("kanokariFirstHitCountBonusMemory3") var firstHitCountBonus: Int = 0
    @AppStorage("kanokariScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("kanokariScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("kanokariScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("kanokariScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("kanokariScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("kanokariScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("kanokariScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("kanokariScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("kanokariCharaSenarioCount1Memory3") var charaSenarioCount1: Int = 0
    @AppStorage("kanokariCharaSenarioCount2Memory3") var charaSenarioCount2: Int = 0
    @AppStorage("kanokariCharaSenarioCount3Memory3") var charaSenarioCount3: Int = 0
    @AppStorage("kanokariCharaSenarioCount4Memory3") var charaSenarioCount4: Int = 0
    @AppStorage("kanokariCharaSenarioCount5Memory3") var charaSenarioCount5: Int = 0
    @AppStorage("kanokariCharaSenarioCount6Memory3") var charaSenarioCount6: Int = 0
    @AppStorage("kanokariCharaSenarioCount7Memory3") var charaSenarioCount7: Int = 0
    @AppStorage("kanokariCharaSenarioCount8Memory3") var charaSenarioCount8: Int = 0
    @AppStorage("kanokariCharaSenarioCountSumMemory3") var charaSenarioCountSum: Int = 0
    @AppStorage("kanokariKoryakuCharaCount1Memory3") var koryakuCharaCount1: Int = 0
    @AppStorage("kanokariKoryakuCharaCount2Memory3") var koryakuCharaCount2: Int = 0
    @AppStorage("kanokariKoryakuCharaCountSumMemory3") var koryakuCharaCountSum: Int = 0
    @AppStorage("kanokariMemoMemory3") var memo = ""
    @AppStorage("kanokariDateMemory3") var dateDouble = 0.0
}
