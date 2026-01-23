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
    let ratioKoyakuBell: [Double] = [10.3,10.2,9.9,9.6,]
    let ratioKoyakuCherry: [Double] = [36.9,36.4,35.9,33.6,]
    let ratioKoyakuSuika: [Double] = [65.5,63.6,60,58.4,]
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


class ShakeMemory1: ObservableObject {
    @AppStorage("shakeGameNumberStartMemory1") var gameNumberStart: Int = 0
    @AppStorage("shakeGameNumberCurrentMemory1") var gameNumberCurrent: Int = 0
    @AppStorage("shakeGameNumberPlayMemory1") var gameNumberPlay: Int = 0
    @AppStorage("shakeKoyakuCountBellMemory1") var koyakuCountBell: Int = 0
    @AppStorage("shakeKoyakuCountCherryMemory1") var koyakuCountCherry: Int = 0
    @AppStorage("shakeKoyakuCountSuikaMemory1") var koyakuCountSuika: Int = 0
    @AppStorage("shakeNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("shakeBonusCountBigMemory1") var bonusCountBig: Int = 0
    @AppStorage("shakeBonusCountRegMemory1") var bonusCountReg: Int = 0
    @AppStorage("shakeBonusCountSumMemory1") var bonusCountSum: Int = 0
    @AppStorage("shakeIdenBonusCountSuikaMemory1") var idenBonusCountSuika: Int = 0
    @AppStorage("shakeIdenBonusCountBellMemory1") var idenBonusCountBell: Int = 0
    @AppStorage("shakeIdenBonusCountSpecialIMemory1") var idenBonusCountSpecialI: Int = 0
    @AppStorage("shakeIdenBonusCountSumMemory1") var idenBonusCountSum: Int = 0
    @AppStorage("shakeVoiceCountDefaultMemory1") var voiceCountDefault: Int = 0
    @AppStorage("shakeVoiceCountHighJakuMemory1") var voiceCountHighJaku: Int = 0
    @AppStorage("shakeVoiceCountHighChuMemory1") var voiceCountHighChu: Int = 0
    @AppStorage("shakeVoiceCountHighKyoMemory1") var voiceCountHighKyo: Int = 0
    @AppStorage("shakeVoiceCountOver5Memory1") var voiceCountOver5: Int = 0
    @AppStorage("shakeVoiceCountSumMemory1") var voiceCountSum: Int = 0
    @AppStorage("shakeJacCountEndMemory1") var jacCountEnd: Int = 0
    @AppStorage("shakeJacCountContinueMemory1") var jacCountContinue: Int = 0
    @AppStorage("shakeJacCountSpecialMemory1") var jacCountSpecial: Int = 0
    @AppStorage("shakeJacCountSumMemory1") var jacCountSum: Int = 0
    @AppStorage("shakeScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("shakeScreenCountHighJakuMemory1") var screenCountHighJaku: Int = 0
    @AppStorage("shakeScreenCountHighChuMemory1") var screenCountHighChu: Int = 0
    @AppStorage("shakeScreenCountHighKyoMemory1") var screenCountHighKyo: Int = 0
    @AppStorage("shakeScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("shakeScreenCountOver1000Memory1") var screenCountOver1000: Int = 0
    @AppStorage("shakeScreenCountOver1500Memory1") var screenCountOver1500: Int = 0
    @AppStorage("shakeScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("shakeMemoMemory1") var memo = ""
    @AppStorage("shakeDateMemory1") var dateDouble = 0.0
}


class ShakeMemory2: ObservableObject {
    @AppStorage("shakeGameNumberStartMemory2") var gameNumberStart: Int = 0
    @AppStorage("shakeGameNumberCurrentMemory2") var gameNumberCurrent: Int = 0
    @AppStorage("shakeGameNumberPlayMemory2") var gameNumberPlay: Int = 0
    @AppStorage("shakeKoyakuCountBellMemory2") var koyakuCountBell: Int = 0
    @AppStorage("shakeKoyakuCountCherryMemory2") var koyakuCountCherry: Int = 0
    @AppStorage("shakeKoyakuCountSuikaMemory2") var koyakuCountSuika: Int = 0
    @AppStorage("shakeNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("shakeBonusCountBigMemory2") var bonusCountBig: Int = 0
    @AppStorage("shakeBonusCountRegMemory2") var bonusCountReg: Int = 0
    @AppStorage("shakeBonusCountSumMemory2") var bonusCountSum: Int = 0
    @AppStorage("shakeIdenBonusCountSuikaMemory2") var idenBonusCountSuika: Int = 0
    @AppStorage("shakeIdenBonusCountBellMemory2") var idenBonusCountBell: Int = 0
    @AppStorage("shakeIdenBonusCountSpecialIMemory2") var idenBonusCountSpecialI: Int = 0
    @AppStorage("shakeIdenBonusCountSumMemory2") var idenBonusCountSum: Int = 0
    @AppStorage("shakeVoiceCountDefaultMemory2") var voiceCountDefault: Int = 0
    @AppStorage("shakeVoiceCountHighJakuMemory2") var voiceCountHighJaku: Int = 0
    @AppStorage("shakeVoiceCountHighChuMemory2") var voiceCountHighChu: Int = 0
    @AppStorage("shakeVoiceCountHighKyoMemory2") var voiceCountHighKyo: Int = 0
    @AppStorage("shakeVoiceCountOver5Memory2") var voiceCountOver5: Int = 0
    @AppStorage("shakeVoiceCountSumMemory2") var voiceCountSum: Int = 0
    @AppStorage("shakeJacCountEndMemory2") var jacCountEnd: Int = 0
    @AppStorage("shakeJacCountContinueMemory2") var jacCountContinue: Int = 0
    @AppStorage("shakeJacCountSpecialMemory2") var jacCountSpecial: Int = 0
    @AppStorage("shakeJacCountSumMemory2") var jacCountSum: Int = 0
    @AppStorage("shakeScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("shakeScreenCountHighJakuMemory2") var screenCountHighJaku: Int = 0
    @AppStorage("shakeScreenCountHighChuMemory2") var screenCountHighChu: Int = 0
    @AppStorage("shakeScreenCountHighKyoMemory2") var screenCountHighKyo: Int = 0
    @AppStorage("shakeScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("shakeScreenCountOver1000Memory2") var screenCountOver1000: Int = 0
    @AppStorage("shakeScreenCountOver1500Memory2") var screenCountOver1500: Int = 0
    @AppStorage("shakeScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("shakeMemoMemory2") var memo = ""
    @AppStorage("shakeDateMemory2") var dateDouble = 0.0
}


class ShakeMemory3: ObservableObject {
    @AppStorage("shakeGameNumberStartMemory3") var gameNumberStart: Int = 0
    @AppStorage("shakeGameNumberCurrentMemory3") var gameNumberCurrent: Int = 0
    @AppStorage("shakeGameNumberPlayMemory3") var gameNumberPlay: Int = 0
    @AppStorage("shakeKoyakuCountBellMemory3") var koyakuCountBell: Int = 0
    @AppStorage("shakeKoyakuCountCherryMemory3") var koyakuCountCherry: Int = 0
    @AppStorage("shakeKoyakuCountSuikaMemory3") var koyakuCountSuika: Int = 0
    @AppStorage("shakeNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("shakeBonusCountBigMemory3") var bonusCountBig: Int = 0
    @AppStorage("shakeBonusCountRegMemory3") var bonusCountReg: Int = 0
    @AppStorage("shakeBonusCountSumMemory3") var bonusCountSum: Int = 0
    @AppStorage("shakeIdenBonusCountSuikaMemory3") var idenBonusCountSuika: Int = 0
    @AppStorage("shakeIdenBonusCountBellMemory3") var idenBonusCountBell: Int = 0
    @AppStorage("shakeIdenBonusCountSpecialIMemory3") var idenBonusCountSpecialI: Int = 0
    @AppStorage("shakeIdenBonusCountSumMemory3") var idenBonusCountSum: Int = 0
    @AppStorage("shakeVoiceCountDefaultMemory3") var voiceCountDefault: Int = 0
    @AppStorage("shakeVoiceCountHighJakuMemory3") var voiceCountHighJaku: Int = 0
    @AppStorage("shakeVoiceCountHighChuMemory3") var voiceCountHighChu: Int = 0
    @AppStorage("shakeVoiceCountHighKyoMemory3") var voiceCountHighKyo: Int = 0
    @AppStorage("shakeVoiceCountOver5Memory3") var voiceCountOver5: Int = 0
    @AppStorage("shakeVoiceCountSumMemory3") var voiceCountSum: Int = 0
    @AppStorage("shakeJacCountEndMemory3") var jacCountEnd: Int = 0
    @AppStorage("shakeJacCountContinueMemory3") var jacCountContinue: Int = 0
    @AppStorage("shakeJacCountSpecialMemory3") var jacCountSpecial: Int = 0
    @AppStorage("shakeJacCountSumMemory3") var jacCountSum: Int = 0
    @AppStorage("shakeScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("shakeScreenCountHighJakuMemory3") var screenCountHighJaku: Int = 0
    @AppStorage("shakeScreenCountHighChuMemory3") var screenCountHighChu: Int = 0
    @AppStorage("shakeScreenCountHighKyoMemory3") var screenCountHighKyo: Int = 0
    @AppStorage("shakeScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("shakeScreenCountOver1000Memory3") var screenCountOver1000: Int = 0
    @AppStorage("shakeScreenCountOver1500Memory3") var screenCountOver1500: Int = 0
    @AppStorage("shakeScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("shakeMemoMemory3") var memo = ""
    @AppStorage("shakeDateMemory3") var dateDouble = 0.0
}
