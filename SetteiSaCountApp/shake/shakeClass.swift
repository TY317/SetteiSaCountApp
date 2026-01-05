//
//  shakeClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import Foundation
import SwiftUI
import Combine

class Shake: ObservableObject {
    // ----------
    // 通常時
    // ----------
    let ratioKoyakuBell: [Double] = [10.3,-1,-1,-1,]
    let ratioKoyakuCherry: [Double] = [36.9,-1,-1,-1,]
    let ratioKoyakuSuika: [Double] = [65.5,-1,-1,-1,]
    @AppStorage("shakeGameNumberStart") var gameNumberStart: Int = 0
    @AppStorage("shakeGameNumberCurrent") var gameNumberCurrent: Int = 0
    @AppStorage("shakeGameNumberPlay") var gameNumberPlay: Int = 0
    @AppStorage("shakeKoyakuCountBell") var koyakuCountBell: Int = 0
    @AppStorage("shakeKoyakuCountCherry") var koyakuCountCherry: Int = 0
    @AppStorage("shakeKoyakuCountSuika") var koyakuCountSuika: Int = 0
    
    func resetNormal() {
        minusCheck = false
        gameNumberStart = 0
        gameNumberCurrent = 0
        gameNumberPlay = 0
        koyakuCountBell = 0
        koyakuCountCherry = 0
        koyakuCountSuika = 0
    }
    
    // ---------
    // 初当り
    // ---------
    let ratioBonusBig: [Double] = [350.5,327.7,341.3,297.9]
    let ratioBonusReg: [Double] = [425.6,332.7,409.6,297.9]
    let ratioBonusSum: [Double] = [192.2,165.1,186.2,148.9]
    @AppStorage("shakeNormalGame") var normalGame: Int = 0
    @AppStorage("shakeBonusCountBig") var bonusCountBig: Int = 0
    @AppStorage("shakeBonusCountReg") var bonusCountReg: Int = 0
    @AppStorage("shakeBonusCountSum") var bonusCountSum: Int = 0
    
    // 特定契機
    let ratioIdenBonusSuika: [Double] = [16384,16384,8192,5451.3]
    let ratioIdenBonusBell: [Double] = [8192,6553.6,8192,5041.2]
    let ratioIdenBonusSpecialI: [Double] = [3276.8,2259.9,3120.8,1872.5]
    let ratioIdenBonusSum: [Double] = [2048,1524.1,1771.3,1091.9]
    @AppStorage("shakeIdenBonusCountSuika") var idenBonusCountSuika: Int = 0
    @AppStorage("shakeIdenBonusCountBell") var idenBonusCountBell: Int = 0
    @AppStorage("shakeIdenBonusCountSpecialI") var idenBonusCountSpecialI: Int = 0
    @AppStorage("shakeIdenBonusCountSum") var idenBonusCountSum: Int = 0
    
    func bonusSumFunc() {
        bonusCountSum = bonusCountBig + bonusCountReg
    }
    
    func idenBonusSumFunc() {
        idenBonusCountSum = idenBonusCountSuika + idenBonusCountBell + idenBonusCountSpecialI
    }
    
    func resetFirstHit() {
        normalGame = 0
        bonusCountBig = 0
        bonusCountReg = 0
        bonusCountSum = 0
        idenBonusCountSuika = 0
        idenBonusCountBell = 0
        idenBonusCountSpecialI = 0
        idenBonusCountSum = 0
        gameNumberStart = 0
        gameNumberCurrent = 0
        gameNumberPlay = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "シェイクBT"
    @AppStorage("shakeMinusCheck") var minusCheck: Bool = false
    @AppStorage("shakeSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}
