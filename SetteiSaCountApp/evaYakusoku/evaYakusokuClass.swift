//
//  evaYakusokuClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/14.
//

import Foundation
import SwiftUI

class EvaYakusoku: ObservableObject {
    // //////////////
    // 初当り
    // //////////////
    let ratioBigSum: [Double] = [300.6,290,281.3,266.4,254,240.9]
    let ratioReg: [Double] = [569.9,546.1,508.0,474.9,442.8,404.5]
    let ratioBonusSum: [Double] = [196.8,189.4,181.0,170.7,161.4,151.0]
    @AppStorage("evaYakusokuBonusCountSBig") var bonusCountSBig: Int = 0
    @AppStorage("evaYakusokuBonusCountBig") var bonusCountBig: Int = 0
    @AppStorage("evaYakusokuBonusCountBigSum") var bonusCountBigSum: Int = 0
    @AppStorage("evaYakusokuBonusCountReg") var bonusCountReg: Int = 0
    @AppStorage("evaYakusokuBonusCountAllSum") var bonusCountAllSum: Int = 0
    @AppStorage("evaYakusokuGameNumberStart") var gameNumberStart: Int = 0
    @AppStorage("evaYakusokuGameNumberCurrent") var gameNumberCurrent: Int = 0
    @AppStorage("evaYakusokuGameNumberPlay") var gameNumberPlay: Int = 0
    
    func bonusSumFunc() {
        bonusCountBigSum = countSum(
            bonusCountSBig,
            bonusCountBig,
        )
        
        bonusCountAllSum = countSum(
            bonusCountSBig,
            bonusCountBig,
            bonusCountReg,
        )
    }
    
    func resetFirstHit() {
        bonusCountSBig = 0
        bonusCountBig = 0
        bonusCountBigSum = 0
        bonusCountReg = 0
        bonusCountAllSum = 0
        gameNumberStart = 0
        gameNumberCurrent = 0
        gameNumberPlay = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "ヱヴァンゲリヲン〜約束の扉〜"
    @AppStorage("evaYakusokuMinusCheck") var minusCheck: Bool = false
    @AppStorage("evaYakusokuSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
    }
}


// //// メモリー1
class EvaYakusokuMemory1: ObservableObject {
    @AppStorage("evaYakusokuBonusCountSBigMemory1") var bonusCountSBig: Int = 0
    @AppStorage("evaYakusokuBonusCountBigMemory1") var bonusCountBig: Int = 0
    @AppStorage("evaYakusokuBonusCountBigSumMemory1") var bonusCountBigSum: Int = 0
    @AppStorage("evaYakusokuBonusCountRegMemory1") var bonusCountReg: Int = 0
    @AppStorage("evaYakusokuBonusCountAllSumMemory1") var bonusCountAllSum: Int = 0
    @AppStorage("evaYakusokuGameNumberStartMemory1") var gameNumberStart: Int = 0
    @AppStorage("evaYakusokuGameNumberCurrentMemory1") var gameNumberCurrent: Int = 0
    @AppStorage("evaYakusokuGameNumberPlayMemory1") var gameNumberPlay: Int = 0
    @AppStorage("evaYakusokuMemoMemory1") var memo = ""
    @AppStorage("evaYakusokuDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class EvaYakusokuMemory2: ObservableObject {
    @AppStorage("evaYakusokuBonusCountSBigMemory2") var bonusCountSBig: Int = 0
    @AppStorage("evaYakusokuBonusCountBigMemory2") var bonusCountBig: Int = 0
    @AppStorage("evaYakusokuBonusCountBigSumMemory2") var bonusCountBigSum: Int = 0
    @AppStorage("evaYakusokuBonusCountRegMemory2") var bonusCountReg: Int = 0
    @AppStorage("evaYakusokuBonusCountAllSumMemory2") var bonusCountAllSum: Int = 0
    @AppStorage("evaYakusokuGameNumberStartMemory2") var gameNumberStart: Int = 0
    @AppStorage("evaYakusokuGameNumberCurrentMemory2") var gameNumberCurrent: Int = 0
    @AppStorage("evaYakusokuGameNumberPlayMemory2") var gameNumberPlay: Int = 0
    @AppStorage("evaYakusokuMemoMemory2") var memo = ""
    @AppStorage("evaYakusokuDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class EvaYakusokuMemory3: ObservableObject {
    @AppStorage("evaYakusokuBonusCountSBigMemory3") var bonusCountSBig: Int = 0
    @AppStorage("evaYakusokuBonusCountBigMemory3") var bonusCountBig: Int = 0
    @AppStorage("evaYakusokuBonusCountBigSumMemory3") var bonusCountBigSum: Int = 0
    @AppStorage("evaYakusokuBonusCountRegMemory3") var bonusCountReg: Int = 0
    @AppStorage("evaYakusokuBonusCountAllSumMemory3") var bonusCountAllSum: Int = 0
    @AppStorage("evaYakusokuGameNumberStartMemory3") var gameNumberStart: Int = 0
    @AppStorage("evaYakusokuGameNumberCurrentMemory3") var gameNumberCurrent: Int = 0
    @AppStorage("evaYakusokuGameNumberPlayMemory3") var gameNumberPlay: Int = 0
    @AppStorage("evaYakusokuMemoMemory3") var memo = ""
    @AppStorage("evaYakusokuDateMemory3") var dateDouble = 0.0
}
