//
//  kerottoClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Kerotto: ObservableObject {
    // -------
    // 通常時
    // -------
    let ratioHeikoOrange: [Double] = [91.4,-1,-1,-1,-1,-1]
    let ratioNanameOrange: [Double] = [187.3,-1,-1,-1,-1,-1]
    let ratioChofukuHeikoOrange: [Double] = [16.2,-1,-1,-1,-1,-1]
    let ratioChofukuNanameOrange: [Double] = [40.0,-1,-1,-1,-1,-1]
    @AppStorage("kerottoKoyakuCountHeikoOrange") var koyakuCountHeikoOrange: Int = 0
    @AppStorage("kerottoKoyakuCountNanameOrange") var koyakuCountNanameOrange: Int = 0
    @AppStorage("kerottoChofukuCountHeikoOrange") var chofukuCountHeikoOrange: Int = 0
    @AppStorage("kerottoChofukuCountNanameOrange") var chofukuCountNanameOrange: Int = 0

    func resetNormal() {
        koyakuCountHeikoOrange = 0
        koyakuCountNanameOrange = 0
        chofukuCountHeikoOrange = 0
        chofukuCountNanameOrange = 0
        gameNumberStart = 0
        gameNumberCurrent = 0
        gameNumberPlay = 0
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitSbb: [Double] = [464.8,461.5,458.3,436.9,431.2,409.6,]
    let ratioFirstHitBb: [Double] = [464.8,461.5,458.3,436.9,431.2,409.6,]
    let ratioFirstHitReg: [Double] = [350.5,341.3,324.4,299.3,274.2,239.2,]
    let ratioFirstHitWhite: [Double] = [55,45.4,54.9,45.3,54.9,45.1,]
    let ratioFirstHitRed: [Double] = [45,54.6,45.1,54.7,45.1,54.9]
    @AppStorage("kerottoGameNumberStart") var gameNumberStart: Int = 0
    @AppStorage("kerottoGameNumberCurrent") var gameNumberCurrent: Int = 0
    @AppStorage("kerottoGameNumberPlay") var gameNumberPlay: Int = 0
    @AppStorage("kerottoFirstHitCountWSBB") var firstHitCountWSBB: Int = 0
    @AppStorage("kerottoFirstHitCountRSBB") var firstHitCountRSBB: Int = 0
    @AppStorage("kerottoFirstHitCountWBB") var firstHitCountWBB: Int = 0
    @AppStorage("kerottoFirstHitCountRBB") var firstHitCountRBB: Int = 0
    @AppStorage("kerottoFirstHitCountWREG") var firstHitCountWREG: Int = 0
    @AppStorage("kerottoFirstHitCountRREG") var firstHitCountRREG: Int = 0
    @AppStorage("kerottoFirstHitCountAllSum") var firstHitCountAllSum: Int = 0
    @AppStorage("kerottoFirstHitCountWSum") var firstHitCountWSum: Int = 0
    @AppStorage("kerottoFirstHitCountRSum") var firstHitCountRSum: Int = 0
    @AppStorage("kerottoFirstHitCountSBBSum") var firstHitCountSBBSum: Int = 0
    @AppStorage("kerottoFirstHitCountBBSum") var firstHitCountBBSum: Int = 0
    @AppStorage("kerottoFirstHitCountREGSum") var firstHitCountREGSum: Int = 0
    
    func firstHitSumFunc() {
        firstHitCountAllSum = countSum(
            firstHitCountWSBB,
            firstHitCountRSBB,
            firstHitCountWBB,
            firstHitCountRBB,
            firstHitCountWREG,
            firstHitCountRREG,
        )
        
        firstHitCountWSum = countSum(
            firstHitCountWSBB,
            firstHitCountWBB,
            firstHitCountWREG,
        )
        
        firstHitCountRSum = countSum(
            firstHitCountRSBB,
            firstHitCountRBB,
            firstHitCountRREG,
        )
        
        firstHitCountSBBSum = firstHitCountWSBB + firstHitCountRSBB
        firstHitCountBBSum = firstHitCountWBB + firstHitCountRBB
        firstHitCountREGSum = firstHitCountWREG + firstHitCountRREG
    }

    func resetFirstHit() {
        gameNumberStart = 0
        gameNumberCurrent = 0
        gameNumberPlay = 0
        firstHitCountWSBB = 0
        firstHitCountRSBB = 0
        firstHitCountWBB = 0
        firstHitCountRBB = 0
        firstHitCountWREG = 0
        firstHitCountRREG = 0
        firstHitCountAllSum = 0
        firstHitCountWSum = 0
        firstHitCountRSum = 0
        firstHitCountSBBSum = 0
        firstHitCountBBSum = 0
        firstHitCountREGSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "ケロット5 BT"
    @AppStorage("kerottoMinusCheck") var minusCheck: Bool = false
    @AppStorage("kerottoSelectedMemory") var selectedMemory = "メモリー1"

    // -------
    // 画面選択
    // -------
    let ratioScreenOver2: [Double] = [0,1,1,1,1,1]
    let ratioScreenOver4: [Double] = [0,0,0,1,1,1]
    let ratioScreenOver5: [Double] = [0,0,0,0,1,1]
    @AppStorage("kerottoScreenCount1") var screenCount1: Int = 0
    @AppStorage("kerottoScreenCount2") var screenCount2: Int = 0
    @AppStorage("kerottoScreenCount3") var screenCount3: Int = 0
    @AppStorage("kerottoScreenCount4") var screenCount4: Int = 0
    @AppStorage("kerottoScreenCount5") var screenCount5: Int = 0
    @AppStorage("kerottoScreenCount6") var screenCount6: Int = 0
    @AppStorage("kerottoScreenCount7") var screenCount7: Int = 0
    @AppStorage("kerottoScreenCountSum") var screenCountSum: Int = 0

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

    // --------
    // ボーナス確定画面
    // --------
    @AppStorage("kerottoBonusScreenCount1") var bonusScreenCount1: Int = 0
    @AppStorage("kerottoBonusScreenCount2") var bonusScreenCount2: Int = 0
    @AppStorage("kerottoBonusScreenCount3") var bonusScreenCount3: Int = 0
    @AppStorage("kerottoBonusScreenCountSum") var bonusScreenCountSum: Int = 0

    func bonusScreenSumFunc() {
        bonusScreenCountSum = countSum(
            bonusScreenCount1,
            bonusScreenCount2,
            bonusScreenCount3,
        )
    }

    func resetBonusScreen() {
        bonusScreenCount1 = 0
        bonusScreenCount2 = 0
        bonusScreenCount3 = 0
        bonusScreenCountSum = 0
        minusCheck = false
    }

    // -------
    // カットイン選択
    // -------
    let ratioCutinOver2: [Double] = [0,1,1,1,1,1]
    let ratioCutinOver4: [Double] = [0,0,0,1,1,1]
    let ratioCutinOver5: [Double] = [0,0,0,0,1,1]
    @AppStorage("kerottoCutinCount1") var cutinCount1: Int = 0
    @AppStorage("kerottoCutinCount2") var cutinCount2: Int = 0
    @AppStorage("kerottoCutinCount3") var cutinCount3: Int = 0
    @AppStorage("kerottoCutinCount4") var cutinCount4: Int = 0
    @AppStorage("kerottoCutinCount5") var cutinCount5: Int = 0
    @AppStorage("kerottoCutinCountSum") var cutinCountSum: Int = 0

    func cutinSumFunc() {
        cutinCountSum = countSum(
            cutinCount1,
            cutinCount2,
            cutinCount3,
            cutinCount4,
            cutinCount5,
        )
    }

    func resetCutin() {
        cutinCount1 = 0
        cutinCount2 = 0
        cutinCount3 = 0
        cutinCount4 = 0
        cutinCount5 = 0
        cutinCountSum = 0
        minusCheck = false
    }

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetBonusScreen()
        resetCutin()
    }
}


class KerottoMemory1: ObservableObject {
    @AppStorage("kerottoMemoMemory1") var memo = ""
    @AppStorage("kerottoDateMemory1") var dateDouble = 0.0
}


class KerottoMemory2: ObservableObject {
    @AppStorage("kerottoMemoMemory2") var memo = ""
    @AppStorage("kerottoDateMemory2") var dateDouble = 0.0
}


class KerottoMemory3: ObservableObject {
    @AppStorage("kerottoMemoMemory3") var memo = ""
    @AppStorage("kerottoDateMemory3") var dateDouble = 0.0
}
