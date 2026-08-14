//
//  dropkickClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Dropkick: ObservableObject {
    // -------
    // 通常時
    // -------
    // ポイント推定
    @AppStorage("dropkickPtMigisagari") var ptMigisagari: Int = 0
    @AppStorage("dropkickPtUpper") var ptUpper: Int = 0
    @AppStorage("dropkickPtMiddle") var ptMiddle: Int = 0
    @AppStorage("dropkickPtLower") var ptLower: Int = 0
    @AppStorage("dropkickPtMigiagari") var ptMigiagari: Int = 0

    func resetPtMigisagari() {
        ptMigisagari = 0
    }

    func resetPtUpper() {
        ptUpper = 0
    }

    func resetPtMiddle() {
        ptMiddle = 0
    }

    func resetPtLower() {
        ptLower = 0
    }

    func resetPtMigiagari() {
        ptMigiagari = 0
    }

    func resetPt() {
        ptMigisagari = 0
        ptUpper = 0
        ptMiddle = 0
        ptLower = 0
        ptMigiagari = 0
    }

    func resetNormal() {
        resetPt()
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitBonus: [Double] = [253.1,248.1,241.6,222.5,211.8,210.0]
    let ratioFirstHitAt: [Double] = [758.2,746.3,722.8,655.9,615.9,606.2]
    @AppStorage("dropkickNormalGame") var normalGame: Int = 0
    @AppStorage("dropkickFirstHitCountBonus") var firstHitCountBonus: Int = 0
    @AppStorage("dropkickFirstHitCountAt") var firstHitCountAt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountBonus = 0
        firstHitCountAt = 0
        minusCheck = false
    }


    // --------
    // 終了画面
    // --------
    let ratioScreenOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioScreenOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioScreenOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioScreenOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("dropkickScreenCount1") var screenCount1: Int = 0
    @AppStorage("dropkickScreenCount2") var screenCount2: Int = 0
    @AppStorage("dropkickScreenCount3") var screenCount3: Int = 0
    @AppStorage("dropkickScreenCount4") var screenCount4: Int = 0
    @AppStorage("dropkickScreenCount5") var screenCount5: Int = 0
    @AppStorage("dropkickScreenCount6") var screenCount6: Int = 0
    @AppStorage("dropkickScreenCount7") var screenCount7: Int = 0
    @AppStorage("dropkickScreenCount8") var screenCount8: Int = 0
    @AppStorage("dropkickScreenCount9") var screenCount9: Int = 0
    @AppStorage("dropkickScreenCount10") var screenCount10: Int = 0
    @AppStorage("dropkickScreenCount11") var screenCount11: Int = 0
    @AppStorage("dropkickScreenCountSum") var screenCountSum: Int = 0

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
            screenCount10,
            screenCount11,
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
        screenCount10 = 0
        screenCount11 = 0
        screenCountSum = 0
        minusCheck = false
    }


    // --------
    // 小悪魔ボーナス キャラ
    // --------
    let ratioCharaNegate1: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioCharaNegate2: [Double] = [0.1,0,0.1,0.1,0.1,0.1,]
    let ratioCharaNegate3: [Double] = [0.1,0.1,0,0.1,0.1,0.1,]
    let ratioCharaOver3: [Double] = [0,0,0.1,0.1,0.1,0.1,]
    let ratioCharaNegate13: [Double] = [0,0.1,0,0.1,0.1,0.1,]
    let ratioCharaOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioCharaOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("dropkickCharaCount1") var charaCount1: Int = 0
    @AppStorage("dropkickCharaCount2") var charaCount2: Int = 0
    @AppStorage("dropkickCharaCount3") var charaCount3: Int = 0
    @AppStorage("dropkickCharaCount4") var charaCount4: Int = 0
    @AppStorage("dropkickCharaCount5") var charaCount5: Int = 0
    @AppStorage("dropkickCharaCount6") var charaCount6: Int = 0
    @AppStorage("dropkickCharaCount7") var charaCount7: Int = 0
    @AppStorage("dropkickCharaCount8") var charaCount8: Int = 0
    @AppStorage("dropkickCharaCount9") var charaCount9: Int = 0
    @AppStorage("dropkickCharaCount10") var charaCount10: Int = 0
    @AppStorage("dropkickCharaCount11") var charaCount11: Int = 0
    @AppStorage("dropkickCharaCount12") var charaCount12: Int = 0
    @AppStorage("dropkickCharaCountSum") var charaCountSum: Int = 0

    func charaSumFunc() {
        charaCountSum = countSum(
            charaCount1,
            charaCount2,
            charaCount3,
            charaCount4,
            charaCount5,
            charaCount6,
            charaCount7,
            charaCount8,
            charaCount9,
            charaCount10,
            charaCount11,
            charaCount12,
        )
    }

    func resetChara() {
        charaCount1 = 0
        charaCount2 = 0
        charaCount3 = 0
        charaCount4 = 0
        charaCount5 = 0
        charaCount6 = 0
        charaCount7 = 0
        charaCount8 = 0
        charaCount9 = 0
        charaCount10 = 0
        charaCount11 = 0
        charaCount12 = 0
        charaCountSum = 0
        minusCheck = false
    }


    // --------
    // とにかくうれしいちゃんす シール
    // --------
    let ratioTucSealOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioTucSealOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("dropkickTucSealCount1") var tucSealCount1: Int = 0
    @AppStorage("dropkickTucSealCount2") var tucSealCount2: Int = 0
    @AppStorage("dropkickTucSealCount3") var tucSealCount3: Int = 0
    @AppStorage("dropkickTucSealCount4") var tucSealCount4: Int = 0
    @AppStorage("dropkickTucSealCount5") var tucSealCount5: Int = 0
    @AppStorage("dropkickTucSealCount6") var tucSealCount6: Int = 0
    @AppStorage("dropkickTucSealCount7") var tucSealCount7: Int = 0
    @AppStorage("dropkickTucSealCountSum") var tucSealCountSum: Int = 0

    func tucSealSumFunc() {
        tucSealCountSum = countSum(
            tucSealCount1,
            tucSealCount2,
            tucSealCount3,
            tucSealCount4,
            tucSealCount5,
            tucSealCount6,
            tucSealCount7,
        )
    }

    func resetTucSeal() {
        tucSealCount1 = 0
        tucSealCount2 = 0
        tucSealCount3 = 0
        tucSealCount4 = 0
        tucSealCount5 = 0
        tucSealCount6 = 0
        tucSealCount7 = 0
        tucSealCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "邪神ちゃんドロップキック"
    @AppStorage("dropkickMinusCheck") var minusCheck: Bool = false
    @AppStorage("dropkickSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetChara()
        resetTucSeal()
    }
}


class DropkickMemory1: ObservableObject {
    // ポイント推定
    @AppStorage("dropkickPtMigisagariMemory1") var ptMigisagari: Int = 0
    @AppStorage("dropkickPtUpperMemory1") var ptUpper: Int = 0
    @AppStorage("dropkickPtMiddleMemory1") var ptMiddle: Int = 0
    @AppStorage("dropkickPtLowerMemory1") var ptLower: Int = 0
    @AppStorage("dropkickPtMigiagariMemory1") var ptMigiagari: Int = 0
    // 初当り
    @AppStorage("dropkickNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("dropkickFirstHitCountBonusMemory1") var firstHitCountBonus: Int = 0
    @AppStorage("dropkickFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    // 終了画面
    @AppStorage("dropkickScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("dropkickScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("dropkickScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("dropkickScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("dropkickScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("dropkickScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("dropkickScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("dropkickScreenCount8Memory1") var screenCount8: Int = 0
    @AppStorage("dropkickScreenCount9Memory1") var screenCount9: Int = 0
    @AppStorage("dropkickScreenCount10Memory1") var screenCount10: Int = 0
    @AppStorage("dropkickScreenCount11Memory1") var screenCount11: Int = 0
    @AppStorage("dropkickScreenCountSumMemory1") var screenCountSum: Int = 0
    // 小悪魔ボーナス キャラ
    @AppStorage("dropkickCharaCount1Memory1") var charaCount1: Int = 0
    @AppStorage("dropkickCharaCount2Memory1") var charaCount2: Int = 0
    @AppStorage("dropkickCharaCount3Memory1") var charaCount3: Int = 0
    @AppStorage("dropkickCharaCount4Memory1") var charaCount4: Int = 0
    @AppStorage("dropkickCharaCount5Memory1") var charaCount5: Int = 0
    @AppStorage("dropkickCharaCount6Memory1") var charaCount6: Int = 0
    @AppStorage("dropkickCharaCount7Memory1") var charaCount7: Int = 0
    @AppStorage("dropkickCharaCount8Memory1") var charaCount8: Int = 0
    @AppStorage("dropkickCharaCount9Memory1") var charaCount9: Int = 0
    @AppStorage("dropkickCharaCount10Memory1") var charaCount10: Int = 0
    @AppStorage("dropkickCharaCount11Memory1") var charaCount11: Int = 0
    @AppStorage("dropkickCharaCount12Memory1") var charaCount12: Int = 0
    @AppStorage("dropkickCharaCountSumMemory1") var charaCountSum: Int = 0
    // とにかくうれしいちゃんす シール
    @AppStorage("dropkickTucSealCount1Memory1") var tucSealCount1: Int = 0
    @AppStorage("dropkickTucSealCount2Memory1") var tucSealCount2: Int = 0
    @AppStorage("dropkickTucSealCount3Memory1") var tucSealCount3: Int = 0
    @AppStorage("dropkickTucSealCount4Memory1") var tucSealCount4: Int = 0
    @AppStorage("dropkickTucSealCount5Memory1") var tucSealCount5: Int = 0
    @AppStorage("dropkickTucSealCount6Memory1") var tucSealCount6: Int = 0
    @AppStorage("dropkickTucSealCount7Memory1") var tucSealCount7: Int = 0
    @AppStorage("dropkickTucSealCountSumMemory1") var tucSealCountSum: Int = 0
    @AppStorage("dropkickMemoMemory1") var memo = ""
    @AppStorage("dropkickDateMemory1") var dateDouble = 0.0
}


class DropkickMemory2: ObservableObject {
    // ポイント推定
    @AppStorage("dropkickPtMigisagariMemory2") var ptMigisagari: Int = 0
    @AppStorage("dropkickPtUpperMemory2") var ptUpper: Int = 0
    @AppStorage("dropkickPtMiddleMemory2") var ptMiddle: Int = 0
    @AppStorage("dropkickPtLowerMemory2") var ptLower: Int = 0
    @AppStorage("dropkickPtMigiagariMemory2") var ptMigiagari: Int = 0
    // 初当り
    @AppStorage("dropkickNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("dropkickFirstHitCountBonusMemory2") var firstHitCountBonus: Int = 0
    @AppStorage("dropkickFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    // 終了画面
    @AppStorage("dropkickScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("dropkickScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("dropkickScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("dropkickScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("dropkickScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("dropkickScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("dropkickScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("dropkickScreenCount8Memory2") var screenCount8: Int = 0
    @AppStorage("dropkickScreenCount9Memory2") var screenCount9: Int = 0
    @AppStorage("dropkickScreenCount10Memory2") var screenCount10: Int = 0
    @AppStorage("dropkickScreenCount11Memory2") var screenCount11: Int = 0
    @AppStorage("dropkickScreenCountSumMemory2") var screenCountSum: Int = 0
    // 小悪魔ボーナス キャラ
    @AppStorage("dropkickCharaCount1Memory2") var charaCount1: Int = 0
    @AppStorage("dropkickCharaCount2Memory2") var charaCount2: Int = 0
    @AppStorage("dropkickCharaCount3Memory2") var charaCount3: Int = 0
    @AppStorage("dropkickCharaCount4Memory2") var charaCount4: Int = 0
    @AppStorage("dropkickCharaCount5Memory2") var charaCount5: Int = 0
    @AppStorage("dropkickCharaCount6Memory2") var charaCount6: Int = 0
    @AppStorage("dropkickCharaCount7Memory2") var charaCount7: Int = 0
    @AppStorage("dropkickCharaCount8Memory2") var charaCount8: Int = 0
    @AppStorage("dropkickCharaCount9Memory2") var charaCount9: Int = 0
    @AppStorage("dropkickCharaCount10Memory2") var charaCount10: Int = 0
    @AppStorage("dropkickCharaCount11Memory2") var charaCount11: Int = 0
    @AppStorage("dropkickCharaCount12Memory2") var charaCount12: Int = 0
    @AppStorage("dropkickCharaCountSumMemory2") var charaCountSum: Int = 0
    // とにかくうれしいちゃんす シール
    @AppStorage("dropkickTucSealCount1Memory2") var tucSealCount1: Int = 0
    @AppStorage("dropkickTucSealCount2Memory2") var tucSealCount2: Int = 0
    @AppStorage("dropkickTucSealCount3Memory2") var tucSealCount3: Int = 0
    @AppStorage("dropkickTucSealCount4Memory2") var tucSealCount4: Int = 0
    @AppStorage("dropkickTucSealCount5Memory2") var tucSealCount5: Int = 0
    @AppStorage("dropkickTucSealCount6Memory2") var tucSealCount6: Int = 0
    @AppStorage("dropkickTucSealCount7Memory2") var tucSealCount7: Int = 0
    @AppStorage("dropkickTucSealCountSumMemory2") var tucSealCountSum: Int = 0
    @AppStorage("dropkickMemoMemory2") var memo = ""
    @AppStorage("dropkickDateMemory2") var dateDouble = 0.0
}


class DropkickMemory3: ObservableObject {
    // ポイント推定
    @AppStorage("dropkickPtMigisagariMemory3") var ptMigisagari: Int = 0
    @AppStorage("dropkickPtUpperMemory3") var ptUpper: Int = 0
    @AppStorage("dropkickPtMiddleMemory3") var ptMiddle: Int = 0
    @AppStorage("dropkickPtLowerMemory3") var ptLower: Int = 0
    @AppStorage("dropkickPtMigiagariMemory3") var ptMigiagari: Int = 0
    // 初当り
    @AppStorage("dropkickNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("dropkickFirstHitCountBonusMemory3") var firstHitCountBonus: Int = 0
    @AppStorage("dropkickFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    // 終了画面
    @AppStorage("dropkickScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("dropkickScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("dropkickScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("dropkickScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("dropkickScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("dropkickScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("dropkickScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("dropkickScreenCount8Memory3") var screenCount8: Int = 0
    @AppStorage("dropkickScreenCount9Memory3") var screenCount9: Int = 0
    @AppStorage("dropkickScreenCount10Memory3") var screenCount10: Int = 0
    @AppStorage("dropkickScreenCount11Memory3") var screenCount11: Int = 0
    @AppStorage("dropkickScreenCountSumMemory3") var screenCountSum: Int = 0
    // 小悪魔ボーナス キャラ
    @AppStorage("dropkickCharaCount1Memory3") var charaCount1: Int = 0
    @AppStorage("dropkickCharaCount2Memory3") var charaCount2: Int = 0
    @AppStorage("dropkickCharaCount3Memory3") var charaCount3: Int = 0
    @AppStorage("dropkickCharaCount4Memory3") var charaCount4: Int = 0
    @AppStorage("dropkickCharaCount5Memory3") var charaCount5: Int = 0
    @AppStorage("dropkickCharaCount6Memory3") var charaCount6: Int = 0
    @AppStorage("dropkickCharaCount7Memory3") var charaCount7: Int = 0
    @AppStorage("dropkickCharaCount8Memory3") var charaCount8: Int = 0
    @AppStorage("dropkickCharaCount9Memory3") var charaCount9: Int = 0
    @AppStorage("dropkickCharaCount10Memory3") var charaCount10: Int = 0
    @AppStorage("dropkickCharaCount11Memory3") var charaCount11: Int = 0
    @AppStorage("dropkickCharaCount12Memory3") var charaCount12: Int = 0
    @AppStorage("dropkickCharaCountSumMemory3") var charaCountSum: Int = 0
    // とにかくうれしいちゃんす シール
    @AppStorage("dropkickTucSealCount1Memory3") var tucSealCount1: Int = 0
    @AppStorage("dropkickTucSealCount2Memory3") var tucSealCount2: Int = 0
    @AppStorage("dropkickTucSealCount3Memory3") var tucSealCount3: Int = 0
    @AppStorage("dropkickTucSealCount4Memory3") var tucSealCount4: Int = 0
    @AppStorage("dropkickTucSealCount5Memory3") var tucSealCount5: Int = 0
    @AppStorage("dropkickTucSealCount6Memory3") var tucSealCount6: Int = 0
    @AppStorage("dropkickTucSealCount7Memory3") var tucSealCount7: Int = 0
    @AppStorage("dropkickTucSealCountSumMemory3") var tucSealCountSum: Int = 0
    @AppStorage("dropkickMemoMemory3") var memo = ""
    @AppStorage("dropkickDateMemory3") var dateDouble = 0.0
}
