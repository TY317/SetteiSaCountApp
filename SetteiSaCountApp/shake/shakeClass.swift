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
    
    // --------
    // REG
    // --------
    @AppStorage("shakeVoiceCountDefault") var voiceCountDefault: Int = 0
    @AppStorage("shakeVoiceCountHighJaku") var voiceCountHighJaku: Int = 0
    @AppStorage("shakeVoiceCountHighChu") var voiceCountHighChu: Int = 0
    @AppStorage("shakeVoiceCountHighKyo") var voiceCountHighKyo: Int = 0
    @AppStorage("shakeVoiceCountOver5") var voiceCountOver5: Int = 0
    @AppStorage("shakeVoiceCountSum") var voiceCountSum: Int = 0
    
    func voiceSumFunc() {
        voiceCountSum = countSum(
            voiceCountDefault,
            voiceCountHighJaku,
            voiceCountHighChu,
            voiceCountHighKyo,
            voiceCountOver5,
        )
    }
    
    func resetReg() {
        voiceCountDefault = 0
        voiceCountHighJaku = 0
        voiceCountHighChu = 0
        voiceCountHighKyo = 0
        voiceCountOver5 = 0
        voiceCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // BT
    // -----------
    let ratioJackEnd: [Double] = [50,57,45,60]
    let ratioJackContinue: [Double] = [47.5,40.5,52.5,37.5]
    let ratioJackSpecial: [Double] = [2.5,2.5,2.5,2.5]
    @AppStorage("shakeJacCountEnd") var jacCountEnd: Int = 0
    @AppStorage("shakeJacCountContinue") var jacCountContinue: Int = 0
    @AppStorage("shakeJacCountSpecial") var jacCountSpecial: Int = 0
    @AppStorage("shakeJacCountSum") var jacCountSum: Int = 0
    
    func jackSumFunc() {
        jacCountSum = jacCountEnd + jacCountContinue + jacCountSpecial
    }
    
    func resetBt() {
        jacCountEnd = 0
        jacCountContinue = 0
        jacCountSpecial = 0
        jacCountSum = 0
        minusCheck = false
    }
    
    // ----------
    // BIG終了画面
    // ----------
    @AppStorage("shakeScreenCountDefault") var screenCountDefault: Int = 0
    @AppStorage("shakeScreenCountHighJaku") var screenCountHighJaku: Int = 0
    @AppStorage("shakeScreenCountHighChu") var screenCountHighChu: Int = 0
    @AppStorage("shakeScreenCountHighKyo") var screenCountHighKyo: Int = 0
    @AppStorage("shakeScreenCountOver6") var screenCountOver6: Int = 0
    @AppStorage("shakeScreenCountOver1000") var screenCountOver1000: Int = 0
    @AppStorage("shakeScreenCountOver1500") var screenCountOver1500: Int = 0
    @AppStorage("shakeScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCountDefault,
            screenCountHighJaku,
            screenCountHighChu,
            screenCountHighKyo,
            screenCountOver6,
            screenCountOver1000,
            screenCountOver1500,
        )
    }
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountHighJaku = 0
        screenCountHighChu = 0
        screenCountHighKyo = 0
        screenCountOver6 = 0
        screenCountOver1000 = 0
        screenCountOver1500 = 0
        screenCountSum = 0
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
        resetReg()
        resetBt()
        resetScreen()
    }
}
