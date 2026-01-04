//
//  mushotenClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/03.
//

import Foundation
import SwiftUI

class Mushoten: ObservableObject {
    // ---------
    // 通常時
    // ---------
    let ratioHitogamiHit: [Double] = [31.8,32.2,32.7,34.7,36.6,41]
    @AppStorage("mushotenHitogamiCountMove") var hitogamiCountMove: Int = 0
    @AppStorage("mushotenHitogamiCountHit") var hitogamiCountHit: Int = 0
    
    func resetNormal() {
        hitogamiCountMove = 0
        hitogamiCountHit = 0
        minusCheck = false
    }
    
    // ----------
    // CZ
    // ----------
    let ratioCz: [Double] = [170,168,166,161,156,147]
    @AppStorage("mushotenGameNumberStart") var gameNumberStart: Int = 0
    @AppStorage("mushotenGameNumberCurrent") var gameNumberCurrent: Int = 0
    @AppStorage("mushotenGameNumberPlay") var gameNumberPlay: Int = 0
    @AppStorage("mushotenCzCount") var czCount: Int = 0
    func resetCz() {
        gameNumberStart = 0
        gameNumberCurrent = 0
        gameNumberPlay = 0
        czCount = 0
        minusCheck = false
    }
    
    // --------
    // 初当り
    // --------
    let ratioFirstHitBonusSum: [Double] = [170,168,166,161,156,147]
    let ratioFirstHitAt: [Double] = [416,406,394,361,327,292]
    @AppStorage("mushotenNormalGame") var normalGame: Int = 0
    @AppStorage("mushotenFirstHitCountBig") var firstHitCountBig: Int = 0
    @AppStorage("mushotenFirstHitCountReg") var firstHitCountReg: Int = 0
    @AppStorage("mushotenFirstHitCountBonusSum") var firstHitCountBonusSum: Int = 0
    @AppStorage("mushotenFirstHitCountAt") var firstHitCountAt: Int = 0
    
    func bonusSumFunc() {
        firstHitCountBonusSum = firstHitCountBig + firstHitCountReg
    }
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountBig = 0
        firstHitCountReg = 0
        firstHitCountBonusSum = 0
        firstHitCountAt = 0
        minusCheck = false
    }
    
    // ---------
    // 魔術ボーナス
    // ---------
    @AppStorage("mushotenStoryCountDefault") var storyCountDefault: Int = 0
    @AppStorage("mushotenStoryCountHighJaku") var storyCountHighJaku: Int = 0
    @AppStorage("mushotenStoryCountHighKyo") var storyCountHighKyo: Int = 0
    @AppStorage("mushotenStoryCountOver2") var storyCountOver2: Int = 0
    @AppStorage("mushotenStoryCountOver4") var storyCountOver4: Int = 0
    @AppStorage("mushotenStoryCountOver6") var storyCountOver6: Int = 0
    @AppStorage("mushotenStoryCountSum") var storyCountSum: Int = 0
    
    func storySumFunc() {
        storyCountSum = countSum(
            storyCountDefault,
            storyCountHighJaku,
            storyCountHighKyo,
            storyCountOver2,
            storyCountOver4,
            storyCountOver6,
        )
    }
    
    func resetReg() {
        storyCountDefault = 0
        storyCountHighJaku = 0
        storyCountHighKyo = 0
        storyCountOver2 = 0
        storyCountOver4 = 0
        storyCountOver6 = 0
        storyCountSum = 0
        minusCheck = false
    }
    
    // -------
    // 終了画面
    // -------
    @AppStorage("mushotenScreenCountDefault") var screenCountDefault: Int = 0
    @AppStorage("mushotenScreenCountGusu") var screenCountGusu: Int = 0
    @AppStorage("mushotenScreenCountHighJaku") var screenCountHighJaku: Int = 0
    @AppStorage("mushotenScreenCountHighKyo") var screenCountHighKyo: Int = 0
    @AppStorage("mushotenScreenCountOver2") var screenCountOver2: Int = 0
    @AppStorage("mushotenScreenCountOver4") var screenCountOver4: Int = 0
    @AppStorage("mushotenScreenCountOver6") var screenCountOver6: Int = 0
    @AppStorage("mushotenScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCountDefault,
            screenCountGusu,
            screenCountHighJaku,
            screenCountHighKyo,
            screenCountOver2,
            screenCountOver4,
            screenCountOver6,
        )
    }
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountGusu = 0
        screenCountHighJaku = 0
        screenCountHighKyo = 0
        screenCountOver2 = 0
        screenCountOver4 = 0
        screenCountOver6 = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "無職転生"
    @AppStorage("mushotenMinusCheck") var minusCheck: Bool = false
    @AppStorage("mushotenSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetCz()
        resetFirstHit()
        resetReg()
        resetScreen()
    }
}


class MushotenMemory1: ObservableObject {
    @AppStorage("mushotenHitogamiCountMoveMemory1") var hitogamiCountMove: Int = 0
    @AppStorage("mushotenHitogamiCountHitMemory1") var hitogamiCountHit: Int = 0
    @AppStorage("mushotenGameNumberStartMemory1") var gameNumberStart: Int = 0
    @AppStorage("mushotenGameNumberCurrentMemory1") var gameNumberCurrent: Int = 0
    @AppStorage("mushotenGameNumberPlayMemory1") var gameNumberPlay: Int = 0
    @AppStorage("mushotenCzCountMemory1") var czCount: Int = 0
    @AppStorage("mushotenNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("mushotenFirstHitCountBigMemory1") var firstHitCountBig: Int = 0
    @AppStorage("mushotenFirstHitCountRegMemory1") var firstHitCountReg: Int = 0
    @AppStorage("mushotenFirstHitCountBonusSumMemory1") var firstHitCountBonusSum: Int = 0
    @AppStorage("mushotenFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("mushotenStoryCountDefaultMemory1") var storyCountDefault: Int = 0
    @AppStorage("mushotenStoryCountHighJakuMemory1") var storyCountHighJaku: Int = 0
    @AppStorage("mushotenStoryCountHighKyoMemory1") var storyCountHighKyo: Int = 0
    @AppStorage("mushotenStoryCountOver2Memory1") var storyCountOver2: Int = 0
    @AppStorage("mushotenStoryCountOver4Memory1") var storyCountOver4: Int = 0
    @AppStorage("mushotenStoryCountOver6Memory1") var storyCountOver6: Int = 0
    @AppStorage("mushotenStoryCountSumMemory1") var storyCountSum: Int = 0
    @AppStorage("mushotenScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("mushotenScreenCountGusuMemory1") var screenCountGusu: Int = 0
    @AppStorage("mushotenScreenCountHighJakuMemory1") var screenCountHighJaku: Int = 0
    @AppStorage("mushotenScreenCountHighKyoMemory1") var screenCountHighKyo: Int = 0
    @AppStorage("mushotenScreenCountOver2Memory1") var screenCountOver2: Int = 0
    @AppStorage("mushotenScreenCountOver4Memory1") var screenCountOver4: Int = 0
    @AppStorage("mushotenScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("mushotenScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("mushotenMemoMemory1") var memo = ""
    @AppStorage("mushotenDateMemory1") var dateDouble = 0.0
}


class MushotenMemory2: ObservableObject {
    @AppStorage("mushotenHitogamiCountMoveMemory2") var hitogamiCountMove: Int = 0
    @AppStorage("mushotenHitogamiCountHitMemory2") var hitogamiCountHit: Int = 0
    @AppStorage("mushotenGameNumberStartMemory2") var gameNumberStart: Int = 0
    @AppStorage("mushotenGameNumberCurrentMemory2") var gameNumberCurrent: Int = 0
    @AppStorage("mushotenGameNumberPlayMemory2") var gameNumberPlay: Int = 0
    @AppStorage("mushotenCzCountMemory2") var czCount: Int = 0
    @AppStorage("mushotenNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("mushotenFirstHitCountBigMemory2") var firstHitCountBig: Int = 0
    @AppStorage("mushotenFirstHitCountRegMemory2") var firstHitCountReg: Int = 0
    @AppStorage("mushotenFirstHitCountBonusSumMemory2") var firstHitCountBonusSum: Int = 0
    @AppStorage("mushotenFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("mushotenStoryCountDefaultMemory2") var storyCountDefault: Int = 0
    @AppStorage("mushotenStoryCountHighJakuMemory2") var storyCountHighJaku: Int = 0
    @AppStorage("mushotenStoryCountHighKyoMemory2") var storyCountHighKyo: Int = 0
    @AppStorage("mushotenStoryCountOver2Memory2") var storyCountOver2: Int = 0
    @AppStorage("mushotenStoryCountOver4Memory2") var storyCountOver4: Int = 0
    @AppStorage("mushotenStoryCountOver6Memory2") var storyCountOver6: Int = 0
    @AppStorage("mushotenStoryCountSumMemory2") var storyCountSum: Int = 0
    @AppStorage("mushotenScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("mushotenScreenCountGusuMemory2") var screenCountGusu: Int = 0
    @AppStorage("mushotenScreenCountHighJakuMemory2") var screenCountHighJaku: Int = 0
    @AppStorage("mushotenScreenCountHighKyoMemory2") var screenCountHighKyo: Int = 0
    @AppStorage("mushotenScreenCountOver2Memory2") var screenCountOver2: Int = 0
    @AppStorage("mushotenScreenCountOver4Memory2") var screenCountOver4: Int = 0
    @AppStorage("mushotenScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("mushotenScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("mushotenMemoMemory2") var memo = ""
    @AppStorage("mushotenDateMemory2") var dateDouble = 0.0
}


class MushotenMemory3: ObservableObject {
    @AppStorage("mushotenHitogamiCountMoveMemory3") var hitogamiCountMove: Int = 0
    @AppStorage("mushotenHitogamiCountHitMemory3") var hitogamiCountHit: Int = 0
    @AppStorage("mushotenGameNumberStartMemory3") var gameNumberStart: Int = 0
    @AppStorage("mushotenGameNumberCurrentMemory3") var gameNumberCurrent: Int = 0
    @AppStorage("mushotenGameNumberPlayMemory3") var gameNumberPlay: Int = 0
    @AppStorage("mushotenCzCountMemory3") var czCount: Int = 0
    @AppStorage("mushotenNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("mushotenFirstHitCountBigMemory3") var firstHitCountBig: Int = 0
    @AppStorage("mushotenFirstHitCountRegMemory3") var firstHitCountReg: Int = 0
    @AppStorage("mushotenFirstHitCountBonusSumMemory3") var firstHitCountBonusSum: Int = 0
    @AppStorage("mushotenFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("mushotenStoryCountDefaultMemory3") var storyCountDefault: Int = 0
    @AppStorage("mushotenStoryCountHighJakuMemory3") var storyCountHighJaku: Int = 0
    @AppStorage("mushotenStoryCountHighKyoMemory3") var storyCountHighKyo: Int = 0
    @AppStorage("mushotenStoryCountOver2Memory3") var storyCountOver2: Int = 0
    @AppStorage("mushotenStoryCountOver4Memory3") var storyCountOver4: Int = 0
    @AppStorage("mushotenStoryCountOver6Memory3") var storyCountOver6: Int = 0
    @AppStorage("mushotenStoryCountSumMemory3") var storyCountSum: Int = 0
    @AppStorage("mushotenScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("mushotenScreenCountGusuMemory3") var screenCountGusu: Int = 0
    @AppStorage("mushotenScreenCountHighJakuMemory3") var screenCountHighJaku: Int = 0
    @AppStorage("mushotenScreenCountHighKyoMemory3") var screenCountHighKyo: Int = 0
    @AppStorage("mushotenScreenCountOver2Memory3") var screenCountOver2: Int = 0
    @AppStorage("mushotenScreenCountOver4Memory3") var screenCountOver4: Int = 0
    @AppStorage("mushotenScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("mushotenScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("mushotenMemoMemory3") var memo = ""
    @AppStorage("mushotenDateMemory3") var dateDouble = 0.0
}
