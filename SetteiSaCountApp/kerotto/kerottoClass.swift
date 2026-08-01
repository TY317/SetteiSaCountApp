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
    let ratioHeikoOrange: [Double] = [91.4,90.5,89.5,87.7,86.8,84.9]
    let ratioNanameOrange: [Double] = [187.3,184.1,181.0,177.1,171.1,163]
    let ratioChofukuHeikoOrange: [Double] = [16.2,16.4,16.5,17.5,17.6,18.9]
    let ratioChofukuNanameOrange: [Double] = [40.0,40.2,40.6,41.1,42.3,44.3]
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
        
        koyakuCountBell = 0
        koyakuCountCherry = 0
        koyakuCountKakuteiyaku = 0
        chofukuCountBell = 0
        chofukuCountCherry = 0
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
    
    // -----------
    // ver4.2.1
    // -----------
    let ratioBell: [Double] = [7,6.9,6.9,6.8,6.6,6.5]
    let ratioCherry: [Double] = [24.2,23.9,22.8,22.2,21.6,21]
    let ratioKakuteiyaku: [Double] = [1524.1,1524.1,1489.5,1310.7,1191.6,993]
    let ratioChofukuCherry: [Double] = [1.3,1.3,1.3,1.3,1.2,1.2]
    @AppStorage("kerottoKoyakuCountBell") var koyakuCountBell: Int = 0
    @AppStorage("kerottoKoyakuCountCherry") var koyakuCountCherry: Int = 0
    @AppStorage("kerottoKoyakuCountKakuteiyaku") var koyakuCountKakuteiyaku: Int = 0
    @AppStorage("kerottoChofukuCountBell") var chofukuCountBell: Int = 0
    @AppStorage("kerottoChofukuCountCherry") var chofukuCountCherry: Int = 0
}


class KerottoMemory1: ObservableObject {
    @AppStorage("kerottoKoyakuCountHeikoOrangeMemory1") var koyakuCountHeikoOrange: Int = 0
    @AppStorage("kerottoKoyakuCountNanameOrangeMemory1") var koyakuCountNanameOrange: Int = 0
    @AppStorage("kerottoChofukuCountHeikoOrangeMemory1") var chofukuCountHeikoOrange: Int = 0
    @AppStorage("kerottoChofukuCountNanameOrangeMemory1") var chofukuCountNanameOrange: Int = 0
    @AppStorage("kerottoGameNumberStartMemory1") var gameNumberStart: Int = 0
    @AppStorage("kerottoGameNumberCurrentMemory1") var gameNumberCurrent: Int = 0
    @AppStorage("kerottoGameNumberPlayMemory1") var gameNumberPlay: Int = 0
    @AppStorage("kerottoFirstHitCountWSBBMemory1") var firstHitCountWSBB: Int = 0
    @AppStorage("kerottoFirstHitCountRSBBMemory1") var firstHitCountRSBB: Int = 0
    @AppStorage("kerottoFirstHitCountWBBMemory1") var firstHitCountWBB: Int = 0
    @AppStorage("kerottoFirstHitCountRBBMemory1") var firstHitCountRBB: Int = 0
    @AppStorage("kerottoFirstHitCountWREGMemory1") var firstHitCountWREG: Int = 0
    @AppStorage("kerottoFirstHitCountRREGMemory1") var firstHitCountRREG: Int = 0
    @AppStorage("kerottoFirstHitCountAllSumMemory1") var firstHitCountAllSum: Int = 0
    @AppStorage("kerottoFirstHitCountWSumMemory1") var firstHitCountWSum: Int = 0
    @AppStorage("kerottoFirstHitCountRSumMemory1") var firstHitCountRSum: Int = 0
    @AppStorage("kerottoFirstHitCountSBBSumMemory1") var firstHitCountSBBSum: Int = 0
    @AppStorage("kerottoFirstHitCountBBSumMemory1") var firstHitCountBBSum: Int = 0
    @AppStorage("kerottoFirstHitCountREGSumMemory1") var firstHitCountREGSum: Int = 0
    @AppStorage("kerottoScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("kerottoScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("kerottoScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("kerottoScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("kerottoScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("kerottoScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("kerottoScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("kerottoScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("kerottoBonusScreenCount1Memory1") var bonusScreenCount1: Int = 0
    @AppStorage("kerottoBonusScreenCount2Memory1") var bonusScreenCount2: Int = 0
    @AppStorage("kerottoBonusScreenCount3Memory1") var bonusScreenCount3: Int = 0
    @AppStorage("kerottoBonusScreenCountSumMemory1") var bonusScreenCountSum: Int = 0
    @AppStorage("kerottoCutinCount1Memory1") var cutinCount1: Int = 0
    @AppStorage("kerottoCutinCount2Memory1") var cutinCount2: Int = 0
    @AppStorage("kerottoCutinCount3Memory1") var cutinCount3: Int = 0
    @AppStorage("kerottoCutinCount4Memory1") var cutinCount4: Int = 0
    @AppStorage("kerottoCutinCount5Memory1") var cutinCount5: Int = 0
    @AppStorage("kerottoCutinCountSumMemory1") var cutinCountSum: Int = 0
    @AppStorage("kerottoKoyakuCountBellMemory1") var koyakuCountBell: Int = 0
    @AppStorage("kerottoKoyakuCountCherryMemory1") var koyakuCountCherry: Int = 0
    @AppStorage("kerottoKoyakuCountKakuteiyakuMemory1") var koyakuCountKakuteiyaku: Int = 0
    @AppStorage("kerottoChofukuCountBellMemory1") var chofukuCountBell: Int = 0
    @AppStorage("kerottoChofukuCountCherryMemory1") var chofukuCountCherry: Int = 0
    @AppStorage("kerottoMemoMemory1") var memo = ""
    @AppStorage("kerottoDateMemory1") var dateDouble = 0.0
}


class KerottoMemory2: ObservableObject {
    @AppStorage("kerottoKoyakuCountHeikoOrangeMemory2") var koyakuCountHeikoOrange: Int = 0
    @AppStorage("kerottoKoyakuCountNanameOrangeMemory2") var koyakuCountNanameOrange: Int = 0
    @AppStorage("kerottoChofukuCountHeikoOrangeMemory2") var chofukuCountHeikoOrange: Int = 0
    @AppStorage("kerottoChofukuCountNanameOrangeMemory2") var chofukuCountNanameOrange: Int = 0
    @AppStorage("kerottoGameNumberStartMemory2") var gameNumberStart: Int = 0
    @AppStorage("kerottoGameNumberCurrentMemory2") var gameNumberCurrent: Int = 0
    @AppStorage("kerottoGameNumberPlayMemory2") var gameNumberPlay: Int = 0
    @AppStorage("kerottoFirstHitCountWSBBMemory2") var firstHitCountWSBB: Int = 0
    @AppStorage("kerottoFirstHitCountRSBBMemory2") var firstHitCountRSBB: Int = 0
    @AppStorage("kerottoFirstHitCountWBBMemory2") var firstHitCountWBB: Int = 0
    @AppStorage("kerottoFirstHitCountRBBMemory2") var firstHitCountRBB: Int = 0
    @AppStorage("kerottoFirstHitCountWREGMemory2") var firstHitCountWREG: Int = 0
    @AppStorage("kerottoFirstHitCountRREGMemory2") var firstHitCountRREG: Int = 0
    @AppStorage("kerottoFirstHitCountAllSumMemory2") var firstHitCountAllSum: Int = 0
    @AppStorage("kerottoFirstHitCountWSumMemory2") var firstHitCountWSum: Int = 0
    @AppStorage("kerottoFirstHitCountRSumMemory2") var firstHitCountRSum: Int = 0
    @AppStorage("kerottoFirstHitCountSBBSumMemory2") var firstHitCountSBBSum: Int = 0
    @AppStorage("kerottoFirstHitCountBBSumMemory2") var firstHitCountBBSum: Int = 0
    @AppStorage("kerottoFirstHitCountREGSumMemory2") var firstHitCountREGSum: Int = 0
    @AppStorage("kerottoScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("kerottoScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("kerottoScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("kerottoScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("kerottoScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("kerottoScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("kerottoScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("kerottoScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("kerottoBonusScreenCount1Memory2") var bonusScreenCount1: Int = 0
    @AppStorage("kerottoBonusScreenCount2Memory2") var bonusScreenCount2: Int = 0
    @AppStorage("kerottoBonusScreenCount3Memory2") var bonusScreenCount3: Int = 0
    @AppStorage("kerottoBonusScreenCountSumMemory2") var bonusScreenCountSum: Int = 0
    @AppStorage("kerottoCutinCount1Memory2") var cutinCount1: Int = 0
    @AppStorage("kerottoCutinCount2Memory2") var cutinCount2: Int = 0
    @AppStorage("kerottoCutinCount3Memory2") var cutinCount3: Int = 0
    @AppStorage("kerottoCutinCount4Memory2") var cutinCount4: Int = 0
    @AppStorage("kerottoCutinCount5Memory2") var cutinCount5: Int = 0
    @AppStorage("kerottoCutinCountSumMemory2") var cutinCountSum: Int = 0
    @AppStorage("kerottoKoyakuCountBellMemory2") var koyakuCountBell: Int = 0
    @AppStorage("kerottoKoyakuCountCherryMemory2") var koyakuCountCherry: Int = 0
    @AppStorage("kerottoKoyakuCountKakuteiyakuMemory2") var koyakuCountKakuteiyaku: Int = 0
    @AppStorage("kerottoChofukuCountBellMemory2") var chofukuCountBell: Int = 0
    @AppStorage("kerottoChofukuCountCherryMemory2") var chofukuCountCherry: Int = 0
    @AppStorage("kerottoMemoMemory2") var memo = ""
    @AppStorage("kerottoDateMemory2") var dateDouble = 0.0
}


class KerottoMemory3: ObservableObject {
    @AppStorage("kerottoKoyakuCountHeikoOrangeMemory3") var koyakuCountHeikoOrange: Int = 0
    @AppStorage("kerottoKoyakuCountNanameOrangeMemory3") var koyakuCountNanameOrange: Int = 0
    @AppStorage("kerottoChofukuCountHeikoOrangeMemory3") var chofukuCountHeikoOrange: Int = 0
    @AppStorage("kerottoChofukuCountNanameOrangeMemory3") var chofukuCountNanameOrange: Int = 0
    @AppStorage("kerottoGameNumberStartMemory3") var gameNumberStart: Int = 0
    @AppStorage("kerottoGameNumberCurrentMemory3") var gameNumberCurrent: Int = 0
    @AppStorage("kerottoGameNumberPlayMemory3") var gameNumberPlay: Int = 0
    @AppStorage("kerottoFirstHitCountWSBBMemory3") var firstHitCountWSBB: Int = 0
    @AppStorage("kerottoFirstHitCountRSBBMemory3") var firstHitCountRSBB: Int = 0
    @AppStorage("kerottoFirstHitCountWBBMemory3") var firstHitCountWBB: Int = 0
    @AppStorage("kerottoFirstHitCountRBBMemory3") var firstHitCountRBB: Int = 0
    @AppStorage("kerottoFirstHitCountWREGMemory3") var firstHitCountWREG: Int = 0
    @AppStorage("kerottoFirstHitCountRREGMemory3") var firstHitCountRREG: Int = 0
    @AppStorage("kerottoFirstHitCountAllSumMemory3") var firstHitCountAllSum: Int = 0
    @AppStorage("kerottoFirstHitCountWSumMemory3") var firstHitCountWSum: Int = 0
    @AppStorage("kerottoFirstHitCountRSumMemory3") var firstHitCountRSum: Int = 0
    @AppStorage("kerottoFirstHitCountSBBSumMemory3") var firstHitCountSBBSum: Int = 0
    @AppStorage("kerottoFirstHitCountBBSumMemory3") var firstHitCountBBSum: Int = 0
    @AppStorage("kerottoFirstHitCountREGSumMemory3") var firstHitCountREGSum: Int = 0
    @AppStorage("kerottoScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("kerottoScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("kerottoScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("kerottoScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("kerottoScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("kerottoScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("kerottoScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("kerottoScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("kerottoBonusScreenCount1Memory3") var bonusScreenCount1: Int = 0
    @AppStorage("kerottoBonusScreenCount2Memory3") var bonusScreenCount2: Int = 0
    @AppStorage("kerottoBonusScreenCount3Memory3") var bonusScreenCount3: Int = 0
    @AppStorage("kerottoBonusScreenCountSumMemory3") var bonusScreenCountSum: Int = 0
    @AppStorage("kerottoCutinCount1Memory3") var cutinCount1: Int = 0
    @AppStorage("kerottoCutinCount2Memory3") var cutinCount2: Int = 0
    @AppStorage("kerottoCutinCount3Memory3") var cutinCount3: Int = 0
    @AppStorage("kerottoCutinCount4Memory3") var cutinCount4: Int = 0
    @AppStorage("kerottoCutinCount5Memory3") var cutinCount5: Int = 0
    @AppStorage("kerottoCutinCountSumMemory3") var cutinCountSum: Int = 0
    @AppStorage("kerottoKoyakuCountBellMemory3") var koyakuCountBell: Int = 0
    @AppStorage("kerottoKoyakuCountCherryMemory3") var koyakuCountCherry: Int = 0
    @AppStorage("kerottoKoyakuCountKakuteiyakuMemory3") var koyakuCountKakuteiyaku: Int = 0
    @AppStorage("kerottoChofukuCountBellMemory3") var chofukuCountBell: Int = 0
    @AppStorage("kerottoChofukuCountCherryMemory3") var chofukuCountCherry: Int = 0
    @AppStorage("kerottoMemoMemory3") var memo = ""
    @AppStorage("kerottoDateMemory3") var dateDouble = 0.0
}
