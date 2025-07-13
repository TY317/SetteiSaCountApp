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
        resetNormal()
    }
    
    // ///////////////
    // ver3.5.1で追加
    // 小役
    // ///////////////
    let ratioBell: [Double] = [8,-1,-1,-1,-1,-1]
    let ratioCherry: [Double] = [60,-1,-1,-1,-1,-1]
    let ratioSuikaSum: [Double] = [66.6,-1,-1,-1,-1,-1]
    let ratioReachMeYaku: [Double] = [528.5,-1,-1,-1,-1,-1]
    let ratioBosoReplay: [Double] = [5957.8,-1,-1,-1,-1,-1]
    @AppStorage("evaYakusokuKoyakuCountBell") var koyakuCountBell: Int = 0
    @AppStorage("evaYakusokuKoyakuCountCherry") var koyakuCountCherry: Int = 0
    @AppStorage("evaYakusokuKoyakuCountSuikaSum") var koyakuCountSuikaSum: Int = 0
    @AppStorage("evaYakusokuKoyakuCountReach") var koyakuCountReach: Int = 0
    @AppStorage("evaYakusokuKoyakuCountBoso") var koyakuCountBoso: Int = 0
    @AppStorage("evaYakusokuKoyakuCountAllSum") var koyakuCountAllSum: Int = 0
    
    func koyakuSumFunc() {
        koyakuCountAllSum = countSum(
            koyakuCountBell,
            koyakuCountCherry,
            koyakuCountSuikaSum,
            koyakuCountReach,
            koyakuCountBoso,
        )
    }
    
    func resetNormal() {
        koyakuCountBell = 0
        koyakuCountCherry = 0
        koyakuCountSuikaSum = 0
        koyakuCountReach = 0
        koyakuCountBoso = 0
        koyakuCountAllSum = 0
        gameNumberStart = 0
        gameNumberCurrent = 0
        gameNumberPlay = 0
        minusCheck = false
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
    
    // ///////////////
    // ver3.5.1で追加
    // 小役
    // ///////////////
    @AppStorage("evaYakusokuKoyakuCountBellMemory1") var koyakuCountBell: Int = 0
    @AppStorage("evaYakusokuKoyakuCountCherryMemory1") var koyakuCountCherry: Int = 0
    @AppStorage("evaYakusokuKoyakuCountSuikaSumMemory1") var koyakuCountSuikaSum: Int = 0
    @AppStorage("evaYakusokuKoyakuCountReachMemory1") var koyakuCountReach: Int = 0
    @AppStorage("evaYakusokuKoyakuCountBosoMemory1") var koyakuCountBoso: Int = 0
    @AppStorage("evaYakusokuKoyakuCountAllSumMemory1") var koyakuCountAllSum: Int = 0
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
    
    // ///////////////
    // ver3.5.1で追加
    // 小役
    // ///////////////
    @AppStorage("evaYakusokuKoyakuCountBellMemory2") var koyakuCountBell: Int = 0
    @AppStorage("evaYakusokuKoyakuCountCherryMemory2") var koyakuCountCherry: Int = 0
    @AppStorage("evaYakusokuKoyakuCountSuikaSumMemory2") var koyakuCountSuikaSum: Int = 0
    @AppStorage("evaYakusokuKoyakuCountReachMemory2") var koyakuCountReach: Int = 0
    @AppStorage("evaYakusokuKoyakuCountBosoMemory2") var koyakuCountBoso: Int = 0
    @AppStorage("evaYakusokuKoyakuCountAllSumMemory2") var koyakuCountAllSum: Int = 0
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
    
    // ///////////////
    // ver3.5.1で追加
    // 小役
    // ///////////////
    @AppStorage("evaYakusokuKoyakuCountBellMemory3") var koyakuCountBell: Int = 0
    @AppStorage("evaYakusokuKoyakuCountCherryMemory3") var koyakuCountCherry: Int = 0
    @AppStorage("evaYakusokuKoyakuCountSuikaSumMemory3") var koyakuCountSuikaSum: Int = 0
    @AppStorage("evaYakusokuKoyakuCountReachMemory3") var koyakuCountReach: Int = 0
    @AppStorage("evaYakusokuKoyakuCountBosoMemory3") var koyakuCountBoso: Int = 0
    @AppStorage("evaYakusokuKoyakuCountAllSumMemory3") var koyakuCountAllSum: Int = 0
}
