//
//  streetFighter6Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class StreetFighter6: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitFb: [Double] = [278.6,272.1,264.6,258.9,255.3,252.6]
    let ratioFirstHitBonus: [Double] = [487.6,473.3,447.2,425.6,405.9,389.9]
    @AppStorage("streetFighter6NormalGame") var normalGame: Int = 0
    @AppStorage("streetFighter6FirstHitCountFb") var firstHitCountFb: Int = 0
    @AppStorage("streetFighter6FirstHitCountBonus") var firstHitCountBonus: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountFb = 0
        firstHitCountBonus = 0
        fbTenjoCount1Miss = 0
        fbTenjoCount1Hit = 0
        fbTenjoCount1Sum = 0
        fbTenjoCount2Miss = 0
        fbTenjoCount2Hit = 0
        fbTenjoCount2Sum = 0
        fbTenjoCount3Miss = 0
        fbTenjoCount3Hit = 0
        fbTenjoCount3Sum = 0
        fbTenjoCount4Miss = 0
        fbTenjoCount4Hit = 0
        fbTenjoCount4Sum = 0
        fbTenjoCountOver2 = 0
        fbTenjoCountOver3 = 0
        fbTenjoCountOver4 = 0
        fbTenjoCountAllSum = 0
        minusCheck = false
    }
    
    // ---- FBスルー天井
    let ratioFbTenjo1: [Double] = [0.8,0.8,0.8,1.6,2.3,3.1]
    let ratioFbTenjo2: [Double] = [0.8,1.6,3.1,6.3,9.4,12.5]
    let ratioFbTenjo3: [Double] = [25,28.1,31.3,37.5,40.6,43.8]
    let ratioFbTenjo4: [Double] = [73.4,69.5,64.8,54.7,47.7,40.6]
    @AppStorage("streetFighter6FbTenjoCount1Miss") var fbTenjoCount1Miss: Int = 0
    @AppStorage("streetFighter6FbTenjoCount1Hit") var fbTenjoCount1Hit: Int = 0
    @AppStorage("streetFighter6FbTenjoCount1Sum") var fbTenjoCount1Sum: Int = 0
    @AppStorage("streetFighter6FbTenjoCount2Miss") var fbTenjoCount2Miss: Int = 0
    @AppStorage("streetFighter6FbTenjoCount2Hit") var fbTenjoCount2Hit: Int = 0
    @AppStorage("streetFighter6FbTenjoCount2Sum") var fbTenjoCount2Sum: Int = 0
    @AppStorage("streetFighter6FbTenjoCount3Miss") var fbTenjoCount3Miss: Int = 0
    @AppStorage("streetFighter6FbTenjoCount3Hit") var fbTenjoCount3Hit: Int = 0
    @AppStorage("streetFighter6FbTenjoCount3Sum") var fbTenjoCount3Sum: Int = 0
    @AppStorage("streetFighter6FbTenjoCount4Miss") var fbTenjoCount4Miss: Int = 0
    @AppStorage("streetFighter6FbTenjoCount4Hit") var fbTenjoCount4Hit: Int = 0
    @AppStorage("streetFighter6FbTenjoCount4Sum") var fbTenjoCount4Sum: Int = 0
    @AppStorage("streetFighter6FbTenjoCountOver2") var fbTenjoCountOver2: Int = 0
    @AppStorage("streetFighter6FbTenjoCountOver3") var fbTenjoCountOver3: Int = 0
    @AppStorage("streetFighter6FbTenjoCountOver4") var fbTenjoCountOver4: Int = 0
    @AppStorage("streetFighter6FbTenjoCountAllSum") var fbTenjoCountAllSum: Int = 0
    
    func fbTenjoSumFunc () {
        fbTenjoCountAllSum = fbTenjoCount1Hit + fbTenjoCount1Miss
        fbTenjoCountOver2 = fbTenjoCount1Miss
        fbTenjoCountOver3 = fbTenjoCount2Miss + fbTenjoCountOver2
        fbTenjoCountOver4 = fbTenjoCount3Miss + fbTenjoCountOver3
        fbTenjoCount1Sum = fbTenjoCount1Miss + fbTenjoCount1Hit
        fbTenjoCount2Sum = fbTenjoCount2Miss + fbTenjoCount2Hit
        fbTenjoCount3Sum = fbTenjoCount3Miss + fbTenjoCount3Hit
        fbTenjoCount4Sum = fbTenjoCount4Miss + fbTenjoCount4Hit
    }


    // --------
    // 終了画面
    // --------
    let ratioScreenOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioScreenOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioScreenOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("streetFighter6ScreenCount1") var screenCount1: Int = 0
    @AppStorage("streetFighter6ScreenCount2") var screenCount2: Int = 0
    @AppStorage("streetFighter6ScreenCount3") var screenCount3: Int = 0
    @AppStorage("streetFighter6ScreenCount4") var screenCount4: Int = 0
    @AppStorage("streetFighter6ScreenCount5") var screenCount5: Int = 0
    @AppStorage("streetFighter6ScreenCount6") var screenCount6: Int = 0
    @AppStorage("streetFighter6ScreenCount7") var screenCount7: Int = 0
    @AppStorage("streetFighter6ScreenCount8") var screenCount8: Int = 0
    @AppStorage("streetFighter6ScreenCountSum") var screenCountSum: Int = 0

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


    // --------
    // エンディング
    // --------
    let ratioEndingOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    @AppStorage("streetFighter6EndingCount1") var endingCount1: Int = 0
    @AppStorage("streetFighter6EndingCount2") var endingCount2: Int = 0
    @AppStorage("streetFighter6EndingCount3") var endingCount3: Int = 0
    @AppStorage("streetFighter6EndingCount4") var endingCount4: Int = 0
    @AppStorage("streetFighter6EndingCount5") var endingCount5: Int = 0
    @AppStorage("streetFighter6EndingCountSum") var endingCountSum: Int = 0

    func endingSumFunc() {
        endingCountSum = countSum(
            endingCount1,
            endingCount2,
            endingCount3,
            endingCount4,
            endingCount5,
        )
    }

    func resetEnding() {
        endingCount1 = 0
        endingCount2 = 0
        endingCount3 = 0
        endingCount4 = 0
        endingCount5 = 0
        endingCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "ストリートファイター6"
    @AppStorage("streetFighter6MinusCheck") var minusCheck: Bool = false
    @AppStorage("streetFighter6SelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetEnding()
    }
}


class StreetFighter6Memory1: ObservableObject {
    @AppStorage("streetFighter6MemoMemory1") var memo = ""
    @AppStorage("streetFighter6DateMemory1") var dateDouble = 0.0
}


class StreetFighter6Memory2: ObservableObject {
    @AppStorage("streetFighter6MemoMemory2") var memo = ""
    @AppStorage("streetFighter6DateMemory2") var dateDouble = 0.0
}


class StreetFighter6Memory3: ObservableObject {
    @AppStorage("streetFighter6MemoMemory3") var memo = ""
    @AppStorage("streetFighter6DateMemory3") var dateDouble = 0.0
}
