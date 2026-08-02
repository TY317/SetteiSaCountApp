//
//  index2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Index2: ObservableObject {
    // -------
    // 通常時
    // -------
    let ratioSuikaKokaku: [Double] = [47.7,48,49.2,50.4,54.7,55.5]
    let ratioSuikaMikotoKokaku: [Double] = [14.3,14.5,14.8,15.2,16.4,16.7]
    @AppStorage("index2SuikaCountKoyaku") var suikaCountKoyaku: Int = 0
    @AppStorage("index2SuikaCountKokaku") var suikaCountKokaku: Int = 0
    @AppStorage("index2SuikaCountMikoto") var suikaCountMikoto: Int = 0

    func resetNormal() {
        suikaCountKoyaku = 0
        suikaCountKokaku = 0
        suikaCountMikoto = 0
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [235.6,233.4,230.8,222.3,215.8,207.2]
    let ratioFirstHitAt: [Double] = [398.8,394.5,389.6,369.5,358,338.4]
    let ratioDirectAt: [Double] = [8000,-1,-1,-1,-1,4000]
    @AppStorage("index2NormalGame") var normalGame: Int = 0
    @AppStorage("index2FirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("index2FirstHitCountAt") var firstHitCountAt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountAt = 0
        minusCheck = false
    }

    // --------
    // 終了画面
    // --------
    @AppStorage("index2ScreenCount1") var screenCount1: Int = 0
    @AppStorage("index2ScreenCount2") var screenCount2: Int = 0
    @AppStorage("index2ScreenCount3") var screenCount3: Int = 0
    @AppStorage("index2ScreenCount4") var screenCount4: Int = 0
    @AppStorage("index2ScreenCount5") var screenCount5: Int = 0
    @AppStorage("index2ScreenCount6") var screenCount6: Int = 0
    @AppStorage("index2ScreenCount7") var screenCount7: Int = 0
    @AppStorage("index2ScreenCount8") var screenCount8: Int = 0
    @AppStorage("index2ScreenCount9") var screenCount9: Int = 0
    @AppStorage("index2ScreenCount10") var screenCount10: Int = 0
    @AppStorage("index2ScreenCount11") var screenCount11: Int = 0
    @AppStorage("index2ScreenCountSum") var screenCountSum: Int = 0

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

    // -----------
    // 共通
    // -----------
    let machineName: String = "とある魔術の禁書目録2"
    @AppStorage("index2MinusCheck") var minusCheck: Bool = false
    @AppStorage("index2SelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
    }
}


class Index2Memory1: ObservableObject {
    @AppStorage("index2MemoMemory1") var memo = ""
    @AppStorage("index2DateMemory1") var dateDouble = 0.0
}


class Index2Memory2: ObservableObject {
    @AppStorage("index2MemoMemory2") var memo = ""
    @AppStorage("index2DateMemory2") var dateDouble = 0.0
}


class Index2Memory3: ObservableObject {
    @AppStorage("index2MemoMemory3") var memo = ""
    @AppStorage("index2DateMemory3") var dateDouble = 0.0
}
