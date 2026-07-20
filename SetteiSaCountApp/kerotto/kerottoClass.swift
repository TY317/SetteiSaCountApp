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

    func resetNormal() {
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

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
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
