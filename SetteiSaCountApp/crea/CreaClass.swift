//
//  CreaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/24.
//

import Foundation
import SwiftUI

class Crea: ObservableObject {
    // /////////////
    // 通常時
    // /////////////
    let ratioKoyakuBell: [Double] = [6.0,-1,-1,-1,-1,-1]
    let ratioKoyakuCherry: [Double] = [91.0,-1,-1,-1,-1,-1]
    let ratioKoyakuSuika: [Double] = [73.6,-1,-1,-1,-1,-1]
    let ratioKoyakuChance: [Double] = [46.5,-1,-1,-1,-1,-1]
    let ratioChofukuBell: [Double] = [0.1,-1,-1,-1,-1,-1]
    let ratioChofukuCherry: [Double] = [7.1,-1,-1,-1,-1,-1]
    let ratioChofukuSuika: [Double] = [0.9,-1,-1,-1,-1,-1]
    let ratioChofukuChance: [Double] = [20.0,-1,-1,-1,-1,-1]
    @AppStorage("creaKoyakuCountBell") var koyakuCountBell: Int = 0
    @AppStorage("creaKoyakuCountCherry") var koyakuCountCherry: Int = 0
    @AppStorage("creaKoyakuCountSuika") var koyakuCountSuika: Int = 0
    @AppStorage("creaKoyakuCountChance") var koyakuCountChance: Int = 0
    @AppStorage("creaChofukuCountBell") var chofukuCountBell: Int = 0
    @AppStorage("creaChofukuCountCherry") var chofukuCountCherry: Int = 0
    @AppStorage("creaChofukuCountSuika") var chofukuCountSuika: Int = 0
    @AppStorage("creaChofukuCountChance") var chofukuCountChance: Int = 0
    @AppStorage("creaGameNumberStart") var gameNumberStart: Int = 0
    @AppStorage("creaGameNumberCurrent") var gameNumberCurrent: Int = 0
    @AppStorage("creaGameNumberPlay") var gameNumberPlay: Int = 0
    func resetNormal() {
        koyakuCountBell = 0
        koyakuCountCherry = 0
        koyakuCountSuika = 0
        koyakuCountChance = 0
        chofukuCountBell = 0
        chofukuCountCherry = 0
        chofukuCountSuika = 0
        chofukuCountChance = 0
        minusCheck = false
        gameNumberStart = 0
        gameNumberCurrent = 0
        gameNumberPlay = 0
    }
    
    // ////////////
    // 初当り
    // ////////////
    let ratioBonusBig: [Double] = [299.3,293.9,284.9,274.2,262.1,240.1]
    let ratioBonusReg: [Double] = [383.3,376.6,358.1,334.4,299.3,247.3]
    @AppStorage("creaBonusCountBig") var bonusCountBig: Int = 0
    @AppStorage("creaBonusCountReg") var bonusCountReg: Int = 0
    @AppStorage("creaBonusCountSum") var bonusCountSum: Int = 0
    
    func bonusCountSumFunc() {
        bonusCountSum = bonusCountBig + bonusCountReg
    }
    
    func resetBonus() {
        bonusCountBig = 0
        bonusCountReg = 0
        bonusCountSum = 0
        minusCheck = false
    }
    
    // ///////////////
    // REG中のカード
    // ///////////////
    @AppStorage("creaRegCardCountDefault") var regCardCountDefault: Int = 0
    @AppStorage("creaRegCardCountHighJaku") var regCardCountHighJaku: Int = 0
    @AppStorage("creaRegCardCountHighKyo") var regCardCountHighKyo: Int = 0
    @AppStorage("creaRegCardCountOver4") var regCardCountOver4: Int = 0
    @AppStorage("creaRegCardCountOver6") var regCardCountOver6: Int = 0
    @AppStorage("creaRegCardCountSum") var regCardCountSum: Int = 0
    
    func regCardCountSumFunc() {
        regCardCountSum = countSum(
            regCardCountDefault,
            regCardCountHighJaku,
            regCardCountHighKyo,
            regCardCountOver4,
            regCardCountOver6,
        )
    }
    
    func resetRegCard() {
        regCardCountDefault = 0
        regCardCountHighJaku = 0
        regCardCountHighKyo = 0
        regCardCountOver4 = 0
        regCardCountOver6 = 0
        regCardCountSum = 0
        minusCheck = false
    }
    
    // ////////////////
    // BIG終了時のスタンプ
    // ////////////////
    @AppStorage("creaStampCountDefault") var stampCountDefault: Int = 0
    @AppStorage("creaStampCountGusu") var stampCountGusu: Int = 0
    @AppStorage("creaStampCountHighJaku") var stampCountHighJaku: Int = 0
    @AppStorage("creaStampCountHighKyo") var stampCountHighKyo: Int = 0
    @AppStorage("creaStampCountSum") var stampCountSum: Int = 0
    
    func stampCountSumFunc() {
        stampCountSum = countSum(
            stampCountDefault,
            stampCountGusu,
            stampCountHighJaku,
            stampCountHighKyo,
        )
    }
    
    func resetStamp() {
        stampCountDefault = 0
        stampCountGusu = 0
        stampCountHighJaku = 0
        stampCountHighKyo = 0
        stampCountSum = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "クレアの秘宝伝BT"
    @AppStorage("creaMinusCheck") var minusCheck: Bool = false
    @AppStorage("creaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetBonus()
        resetRegCard()
        resetStamp()
        resetBt()
    }
    
    // //////////////
    // ver3.11.0で追加
    // //////////////
    let ratioBtHazure: [Double] = [420.1,420.1,420.1,30.0,30.0,30.0,]
    @AppStorage("creaBtGame") var btGame: Int = 0
    @AppStorage("creaBtHazure") var btHazure: Int = 0
    
    func resetBt() {
        btGame = 0
        btHazure = 0
        minusCheck = false
    }
}

// メモリー1
class CreaMemory1: ObservableObject {
    @AppStorage("creaKoyakuCountBellMemory1") var koyakuCountBell: Int = 0
    @AppStorage("creaKoyakuCountCherryMemory1") var koyakuCountCherry: Int = 0
    @AppStorage("creaKoyakuCountSuikaMemory1") var koyakuCountSuika: Int = 0
    @AppStorage("creaKoyakuCountChanceMemory1") var koyakuCountChance: Int = 0
    @AppStorage("creaChofukuCountBellMemory1") var chofukuCountBell: Int = 0
    @AppStorage("creaChofukuCountCherryMemory1") var chofukuCountCherry: Int = 0
    @AppStorage("creaChofukuCountSuikaMemory1") var chofukuCountSuika: Int = 0
    @AppStorage("creaChofukuCountChanceMemory1") var chofukuCountChance: Int = 0
    @AppStorage("creaGameNumberStartMemory1") var gameNumberStart: Int = 0
    @AppStorage("creaGameNumberCurrentMemory1") var gameNumberCurrent: Int = 0
    @AppStorage("creaGameNumberPlayMemory1") var gameNumberPlay: Int = 0
    @AppStorage("creaBonusCountBigMemory1") var bonusCountBig: Int = 0
    @AppStorage("creaBonusCountRegMemory1") var bonusCountReg: Int = 0
    @AppStorage("creaBonusCountSumMemory1") var bonusCountSum: Int = 0
    @AppStorage("creaRegCardCountDefaultMemory1") var regCardCountDefault: Int = 0
    @AppStorage("creaRegCardCountHighJakuMemory1") var regCardCountHighJaku: Int = 0
    @AppStorage("creaRegCardCountHighKyoMemory1") var regCardCountHighKyo: Int = 0
    @AppStorage("creaRegCardCountOver4Memory1") var regCardCountOver4: Int = 0
    @AppStorage("creaRegCardCountOver6Memory1") var regCardCountOver6: Int = 0
    @AppStorage("creaRegCardCountSumMemory1") var regCardCountSum: Int = 0
    @AppStorage("creaStampCountDefaultMemory1") var stampCountDefault: Int = 0
    @AppStorage("creaStampCountGusuMemory1") var stampCountGusu: Int = 0
    @AppStorage("creaStampCountHighJakuMemory1") var stampCountHighJaku: Int = 0
    @AppStorage("creaStampCountHighKyoMemory1") var stampCountHighKyo: Int = 0
    @AppStorage("creaStampCountSumMemory1") var stampCountSum: Int = 0
    @AppStorage("creaMemoMemory1") var memo = ""
    @AppStorage("creaDateMemory1") var dateDouble = 0.0
    
    // //////////////
    // ver3.11.0で追加
    // //////////////
    @AppStorage("creaBtGameMemory1") var btGame: Int = 0
    @AppStorage("creaBtHazureMemory1") var btHazure: Int = 0
}

// メモリー2
class CreaMemory2: ObservableObject {
    @AppStorage("creaKoyakuCountBellMemory2") var koyakuCountBell: Int = 0
    @AppStorage("creaKoyakuCountCherryMemory2") var koyakuCountCherry: Int = 0
    @AppStorage("creaKoyakuCountSuikaMemory2") var koyakuCountSuika: Int = 0
    @AppStorage("creaKoyakuCountChanceMemory2") var koyakuCountChance: Int = 0
    @AppStorage("creaChofukuCountBellMemory2") var chofukuCountBell: Int = 0
    @AppStorage("creaChofukuCountCherryMemory2") var chofukuCountCherry: Int = 0
    @AppStorage("creaChofukuCountSuikaMemory2") var chofukuCountSuika: Int = 0
    @AppStorage("creaChofukuCountChanceMemory2") var chofukuCountChance: Int = 0
    @AppStorage("creaGameNumberStartMemory2") var gameNumberStart: Int = 0
    @AppStorage("creaGameNumberCurrentMemory2") var gameNumberCurrent: Int = 0
    @AppStorage("creaGameNumberPlayMemory2") var gameNumberPlay: Int = 0
    @AppStorage("creaBonusCountBigMemory2") var bonusCountBig: Int = 0
    @AppStorage("creaBonusCountRegMemory2") var bonusCountReg: Int = 0
    @AppStorage("creaBonusCountSumMemory2") var bonusCountSum: Int = 0
    @AppStorage("creaRegCardCountDefaultMemory2") var regCardCountDefault: Int = 0
    @AppStorage("creaRegCardCountHighJakuMemory2") var regCardCountHighJaku: Int = 0
    @AppStorage("creaRegCardCountHighKyoMemory2") var regCardCountHighKyo: Int = 0
    @AppStorage("creaRegCardCountOver4Memory2") var regCardCountOver4: Int = 0
    @AppStorage("creaRegCardCountOver6Memory2") var regCardCountOver6: Int = 0
    @AppStorage("creaRegCardCountSumMemory2") var regCardCountSum: Int = 0
    @AppStorage("creaStampCountDefaultMemory2") var stampCountDefault: Int = 0
    @AppStorage("creaStampCountGusuMemory2") var stampCountGusu: Int = 0
    @AppStorage("creaStampCountHighJakuMemory2") var stampCountHighJaku: Int = 0
    @AppStorage("creaStampCountHighKyoMemory2") var stampCountHighKyo: Int = 0
    @AppStorage("creaStampCountSumMemory2") var stampCountSum: Int = 0
    @AppStorage("creaMemoMemory2") var memo = ""
    @AppStorage("creaDateMemory2") var dateDouble = 0.0
    
    // //////////////
    // ver3.11.0で追加
    // //////////////
    @AppStorage("creaBtGameMemory2") var btGame: Int = 0
    @AppStorage("creaBtHazureMemory2") var btHazure: Int = 0
}

// メモリー3
class CreaMemory3: ObservableObject {
    @AppStorage("creaKoyakuCountBellMemory3") var koyakuCountBell: Int = 0
    @AppStorage("creaKoyakuCountCherryMemory3") var koyakuCountCherry: Int = 0
    @AppStorage("creaKoyakuCountSuikaMemory3") var koyakuCountSuika: Int = 0
    @AppStorage("creaKoyakuCountChanceMemory3") var koyakuCountChance: Int = 0
    @AppStorage("creaChofukuCountBellMemory3") var chofukuCountBell: Int = 0
    @AppStorage("creaChofukuCountCherryMemory3") var chofukuCountCherry: Int = 0
    @AppStorage("creaChofukuCountSuikaMemory3") var chofukuCountSuika: Int = 0
    @AppStorage("creaChofukuCountChanceMemory3") var chofukuCountChance: Int = 0
    @AppStorage("creaGameNumberStartMemory3") var gameNumberStart: Int = 0
    @AppStorage("creaGameNumberCurrentMemory3") var gameNumberCurrent: Int = 0
    @AppStorage("creaGameNumberPlayMemory3") var gameNumberPlay: Int = 0
    @AppStorage("creaBonusCountBigMemory3") var bonusCountBig: Int = 0
    @AppStorage("creaBonusCountRegMemory3") var bonusCountReg: Int = 0
    @AppStorage("creaBonusCountSumMemory3") var bonusCountSum: Int = 0
    @AppStorage("creaRegCardCountDefaultMemory3") var regCardCountDefault: Int = 0
    @AppStorage("creaRegCardCountHighJakuMemory3") var regCardCountHighJaku: Int = 0
    @AppStorage("creaRegCardCountHighKyoMemory3") var regCardCountHighKyo: Int = 0
    @AppStorage("creaRegCardCountOver4Memory3") var regCardCountOver4: Int = 0
    @AppStorage("creaRegCardCountOver6Memory3") var regCardCountOver6: Int = 0
    @AppStorage("creaRegCardCountSumMemory3") var regCardCountSum: Int = 0
    @AppStorage("creaStampCountDefaultMemory3") var stampCountDefault: Int = 0
    @AppStorage("creaStampCountGusuMemory3") var stampCountGusu: Int = 0
    @AppStorage("creaStampCountHighJakuMemory3") var stampCountHighJaku: Int = 0
    @AppStorage("creaStampCountHighKyoMemory3") var stampCountHighKyo: Int = 0
    @AppStorage("creaStampCountSumMemory3") var stampCountSum: Int = 0
    @AppStorage("creaMemoMemory3") var memo = ""
    @AppStorage("creaDateMemory3") var dateDouble = 0.0
    
    // //////////////
    // ver3.11.0で追加
    // //////////////
    @AppStorage("creaBtGameMemory3") var btGame: Int = 0
    @AppStorage("creaBtHazureMemory3") var btHazure: Int = 0
}
