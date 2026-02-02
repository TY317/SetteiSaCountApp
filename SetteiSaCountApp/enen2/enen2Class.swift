//
//  enen2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/11.
//

import Foundation
import SwiftUI

class Enen2: ObservableObject {
    // ----------
    // 初当り
    // ----------
    let ratioFirstHitBonus: [Double] = [272,269,257,242,236,227]
    let ratioFirstHitLoop: [Double] = [684,662,617,546,518,486]
    @AppStorage("enen2NormalGame") var normalGame: Int = 0
    @AppStorage("enen2FirstHitCountBonus") var firstHitCountBonus: Int = 0
    @AppStorage("enen2FirstHitCountLoop") var firstHitCountLoop: Int = 0
    
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountBonus = 0
        firstHitCountLoop = 0
        minusCheck = false
    }
    
    // ---------
    // 終了画面
    // ---------
    @AppStorage("enen2ScreenCount1") var screenCount1: Int = 0
    @AppStorage("enen2ScreenCount2") var screenCount2: Int = 0
    @AppStorage("enen2ScreenCount3") var screenCount3: Int = 0
    @AppStorage("enen2ScreenCount4") var screenCount4: Int = 0
    @AppStorage("enen2ScreenCount5") var screenCount5: Int = 0
    @AppStorage("enen2ScreenCount6") var screenCount6: Int = 0
    @AppStorage("enen2ScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
            screenCount4,
            screenCount5,
            screenCount6,
        )
    }
    
    func resetScreen() {
        screenCount1 = 0
        screenCount2 = 0
        screenCount3 = 0
        screenCount4 = 0
        screenCount5 = 0
        screenCount6 = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // ----------
    // 伝道者の罠
    // ----------
    @AppStorage("enen2WanaCountMiss") var wanaCountMiss: Int = 0
    @AppStorage("enen2WanaCountHit") var wanaCountHit: Int = 0
    @AppStorage("enen2WanaCountSum") var wanaCountSum: Int = 0
    
    func wanaSumFunc() {
        wanaCountSum = wanaCountMiss + wanaCountHit
    }
    
    func resetWana() {
        wanaCountMiss = 0
        wanaCountHit = 0
        wanaCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "炎炎ノ消防隊2"
    @AppStorage("enen2MinusCheck") var minusCheck: Bool = false
    @AppStorage("enen2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
        resetWana()
    }
}


class Enen2Memory1: ObservableObject {
    @AppStorage("enen2NormalGameMemory1") var normalGame: Int = 0
    @AppStorage("enen2FirstHitCountBonusMemory1") var firstHitCountBonus: Int = 0
    @AppStorage("enen2FirstHitCountLoopMemory1") var firstHitCountLoop: Int = 0
    @AppStorage("enen2ScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("enen2ScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("enen2ScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("enen2ScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("enen2ScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("enen2ScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("enen2ScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("enen2WanaCountMissMemory1") var wanaCountMiss: Int = 0
    @AppStorage("enen2WanaCountHitMemory1") var wanaCountHit: Int = 0
    @AppStorage("enen2WanaCountSumMemory1") var wanaCountSum: Int = 0
    @AppStorage("enen2MemoMemory1") var memo = ""
    @AppStorage("enen2DateMemory1") var dateDouble = 0.0
}

class Enen2Memory2: ObservableObject {
    @AppStorage("enen2NormalGameMemory2") var normalGame: Int = 0
    @AppStorage("enen2FirstHitCountBonusMemory2") var firstHitCountBonus: Int = 0
    @AppStorage("enen2FirstHitCountLoopMemory2") var firstHitCountLoop: Int = 0
    @AppStorage("enen2ScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("enen2ScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("enen2ScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("enen2ScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("enen2ScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("enen2ScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("enen2ScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("enen2WanaCountMissMemory2") var wanaCountMiss: Int = 0
    @AppStorage("enen2WanaCountHitMemory2") var wanaCountHit: Int = 0
    @AppStorage("enen2WanaCountSumMemory2") var wanaCountSum: Int = 0
    @AppStorage("enen2MemoMemory2") var memo = ""
    @AppStorage("enen2DateMemory2") var dateDouble = 0.0
}

class Enen2Memory3: ObservableObject {
    @AppStorage("enen2NormalGameMemory3") var normalGame: Int = 0
    @AppStorage("enen2FirstHitCountBonusMemory3") var firstHitCountBonus: Int = 0
    @AppStorage("enen2FirstHitCountLoopMemory3") var firstHitCountLoop: Int = 0
    @AppStorage("enen2ScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("enen2ScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("enen2ScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("enen2ScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("enen2ScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("enen2ScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("enen2ScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("enen2WanaCountMissMemory3") var wanaCountMiss: Int = 0
    @AppStorage("enen2WanaCountHitMemory3") var wanaCountHit: Int = 0
    @AppStorage("enen2WanaCountSumMemory3") var wanaCountSum: Int = 0
    @AppStorage("enen2MemoMemory3") var memo = ""
    @AppStorage("enen2DateMemory3") var dateDouble = 0.0
}
