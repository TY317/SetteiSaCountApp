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
