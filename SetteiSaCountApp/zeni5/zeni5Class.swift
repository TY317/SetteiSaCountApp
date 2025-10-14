//
//  zeni5Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/14.
//

import Foundation
import SwiftUI

class Zeni5: ObservableObject {
    // ///////////
    // 初当り
    // ///////////
    let ratioFirstHit: [Double] = [424.5,416.4,388.1,375.9,300.5]
    @AppStorage("zeni5NormalGame") var normalGame: Int = 0
    @AppStorage("zeni5FirstHitCount") var firstHitCount: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCount = 0
        minusCheck = false
    }
    
    // ///////////
    // ボーナス終了画面
    // ///////////
    @AppStorage("zeni5ScreenCountDefault") var screenCountDefault: Int = 0
    @AppStorage("zeni5ScreenCountZeni1") var screenCountZeni1: Int = 0
    @AppStorage("zeni5ScreenCountZeni2") var screenCountZeni2: Int = 0
    @AppStorage("zeni5ScreenCountOver3") var screenCountOver3: Int = 0
    @AppStorage("zeni5ScreenCountOver4") var screenCountOver4: Int = 0
    @AppStorage("zeni5ScreenCountOver5") var screenCountOver5: Int = 0
    @AppStorage("zeni5ScreenCountOver6") var screenCountOver6: Int = 0
    @AppStorage("zeni5ScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCountDefault,
            screenCountZeni1,
            screenCountZeni2,
            screenCountOver3,
            screenCountOver4,
            screenCountOver5,
            screenCountOver6,
            screenCountSum,
        )
    }
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountZeni1 = 0
        screenCountZeni2 = 0
        screenCountOver3 = 0
        screenCountOver4 = 0
        screenCountOver5 = 0
        screenCountOver6 = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // ///////////
    // エンディング
    // ///////////
    @AppStorage("zeni5EndingCountDefault") var endingCountDefault: Int = 0
    @AppStorage("zeni5EndingCount2") var endingCount2: Int = 0
    @AppStorage("zeni5EndingCount3") var endingCount3: Int = 0
    @AppStorage("zeni5EndingCount4") var endingCount4: Int = 0
    @AppStorage("zeni5EndingCount5") var endingCount5: Int = 0
    @AppStorage("zeni5EndingCount6") var endingCount6: Int = 0
    @AppStorage("zeni5EndingCount7") var endingCount7: Int = 0
    @AppStorage("zeni5EndingCountSum") var endingCountSum: Int = 0
    
    func endingSumFunc() {
        endingCountSum = countSum(
            endingCountDefault,
            endingCount2,
            endingCount3,
            endingCount4,
            endingCount5,
            endingCount6,
            endingCount7,
        )
    }
    
    func resetEnding() {
        endingCountDefault = 0
        endingCount2 = 0
        endingCount3 = 0
        endingCount4 = 0
        endingCount5 = 0
        endingCount6 = 0
        endingCount7 = 0
        endingCountSum = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "主役は銭形5"
    @AppStorage("zeni5MinusCheck") var minusCheck: Bool = false
    @AppStorage("zeni5SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
        resetScreen()
        resetEnding()
    }
}

class Zeni5Memory1: ObservableObject {
    @AppStorage("zeni5NormalGameMemory1") var normalGame: Int = 0
    @AppStorage("zeni5FirstHitCountMemory1") var firstHitCount: Int = 0
    @AppStorage("zeni5ScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("zeni5ScreenCountZeni1Memory1") var screenCountZeni1: Int = 0
    @AppStorage("zeni5ScreenCountZeni2Memory1") var screenCountZeni2: Int = 0
    @AppStorage("zeni5ScreenCountOver3Memory1") var screenCountOver3: Int = 0
    @AppStorage("zeni5ScreenCountOver4Memory1") var screenCountOver4: Int = 0
    @AppStorage("zeni5ScreenCountOver5Memory1") var screenCountOver5: Int = 0
    @AppStorage("zeni5ScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("zeni5ScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("zeni5EndingCountDefaultMemory1") var endingCountDefault: Int = 0
    @AppStorage("zeni5EndingCount2Memory1") var endingCount2: Int = 0
    @AppStorage("zeni5EndingCount3Memory1") var endingCount3: Int = 0
    @AppStorage("zeni5EndingCount4Memory1") var endingCount4: Int = 0
    @AppStorage("zeni5EndingCount5Memory1") var endingCount5: Int = 0
    @AppStorage("zeni5EndingCount6Memory1") var endingCount6: Int = 0
    @AppStorage("zeni5EndingCount7Memory1") var endingCount7: Int = 0
    @AppStorage("zeni5EndingCountSumMemory1") var endingCountSum: Int = 0
    @AppStorage("zeni5MemoMemory1") var memo = ""
    @AppStorage("zeni5DateMemory1") var dateDouble = 0.0
}

class Zeni5Memory2: ObservableObject {
    @AppStorage("zeni5NormalGameMemory2") var normalGame: Int = 0
    @AppStorage("zeni5FirstHitCountMemory2") var firstHitCount: Int = 0
    @AppStorage("zeni5ScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("zeni5ScreenCountZeni1Memory2") var screenCountZeni1: Int = 0
    @AppStorage("zeni5ScreenCountZeni2Memory2") var screenCountZeni2: Int = 0
    @AppStorage("zeni5ScreenCountOver3Memory2") var screenCountOver3: Int = 0
    @AppStorage("zeni5ScreenCountOver4Memory2") var screenCountOver4: Int = 0
    @AppStorage("zeni5ScreenCountOver5Memory2") var screenCountOver5: Int = 0
    @AppStorage("zeni5ScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("zeni5ScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("zeni5EndingCountDefaultMemory2") var endingCountDefault: Int = 0
    @AppStorage("zeni5EndingCount2Memory2") var endingCount2: Int = 0
    @AppStorage("zeni5EndingCount3Memory2") var endingCount3: Int = 0
    @AppStorage("zeni5EndingCount4Memory2") var endingCount4: Int = 0
    @AppStorage("zeni5EndingCount5Memory2") var endingCount5: Int = 0
    @AppStorage("zeni5EndingCount6Memory2") var endingCount6: Int = 0
    @AppStorage("zeni5EndingCount7Memory2") var endingCount7: Int = 0
    @AppStorage("zeni5EndingCountSumMemory2") var endingCountSum: Int = 0
    @AppStorage("zeni5MemoMemory2") var memo = ""
    @AppStorage("zeni5DateMemory2") var dateDouble = 0.0
}

class Zeni5Memory3: ObservableObject {
    @AppStorage("zeni5NormalGameMemory3") var normalGame: Int = 0
    @AppStorage("zeni5FirstHitCountMemory3") var firstHitCount: Int = 0
    @AppStorage("zeni5ScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("zeni5ScreenCountZeni1Memory3") var screenCountZeni1: Int = 0
    @AppStorage("zeni5ScreenCountZeni2Memory3") var screenCountZeni2: Int = 0
    @AppStorage("zeni5ScreenCountOver3Memory3") var screenCountOver3: Int = 0
    @AppStorage("zeni5ScreenCountOver4Memory3") var screenCountOver4: Int = 0
    @AppStorage("zeni5ScreenCountOver5Memory3") var screenCountOver5: Int = 0
    @AppStorage("zeni5ScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("zeni5ScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("zeni5EndingCountDefaultMemory3") var endingCountDefault: Int = 0
    @AppStorage("zeni5EndingCount2Memory3") var endingCount2: Int = 0
    @AppStorage("zeni5EndingCount3Memory3") var endingCount3: Int = 0
    @AppStorage("zeni5EndingCount4Memory3") var endingCount4: Int = 0
    @AppStorage("zeni5EndingCount5Memory3") var endingCount5: Int = 0
    @AppStorage("zeni5EndingCount6Memory3") var endingCount6: Int = 0
    @AppStorage("zeni5EndingCount7Memory3") var endingCount7: Int = 0
    @AppStorage("zeni5EndingCountSumMemory3") var endingCountSum: Int = 0
    @AppStorage("zeni5MemoMemory3") var memo = ""
    @AppStorage("zeni5DateMemory3") var dateDouble = 0.0
}
