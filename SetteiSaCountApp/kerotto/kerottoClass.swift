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

    func resetAll() {
        resetNormal()
        resetFirstHit()
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
