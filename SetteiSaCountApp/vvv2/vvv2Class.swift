//
//  vvv2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/16.
//

import Foundation
import SwiftUI

class Vvv2: ObservableObject {
    // ///////////
    // 初当り
    // ///////////
    @AppStorage("vvv2BonusCountKakumei") var bonusCountKakumei: Int = 0
    @AppStorage("vvv2BonusCountKessen") var bonusCountKessen: Int = 0
    @AppStorage("vvv2BonusCountSum") var bonusCountSum: Int = 0
    
    func resetFirstHit() {
        bonusCountKakumei = 0
        bonusCountKessen = 0
        bonusCountSum = 0
        minusCheck = false
    }
    
    // /////////////
    // 終了画面
    // /////////////
    @AppStorage("vvv2ScreenCountDefault") var screenCountDefault: Int = 0
    @AppStorage("vvv2ScreenCountBlue1") var screenCountBlue1: Int = 0
    @AppStorage("vvv2ScreenCountBlue2") var screenCountBlue2: Int = 0
    @AppStorage("vvv2ScreenCountRed1") var screenCountRed1: Int = 0
    @AppStorage("vvv2ScreenCountRed2") var screenCountRed2: Int = 0
    @AppStorage("vvv2ScreenCountPurple") var screenCountPurple: Int = 0
    @AppStorage("vvv2ScreenCountSilver") var screenCountSilver: Int = 0
    @AppStorage("vvv2ScreenCountGold") var screenCountGold: Int = 0
    @AppStorage("vvv2ScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCountDefault,
            screenCountBlue1,
            screenCountBlue2,
            screenCountRed1,
            screenCountRed2,
            screenCountPurple,
            screenCountSilver,
            screenCountGold,
        )
    }
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountBlue1 = 0
        screenCountBlue2 = 0
        screenCountRed1 = 0
        screenCountRed2 = 0
        screenCountPurple = 0
        screenCountSilver = 0
        screenCountGold = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // /////////
    // ドライブ発生率
    // /////////
    let ratioDrive: [Double] = [16,16,7,7,7]
    @AppStorage("vvv2RoundCount10") var roundCount10: Int = 0
    @AppStorage("vvv2RoundCount20") var roundCount20: Int = 0
    @AppStorage("vvv2RoundCountDrive") var roundCountDrive: Int = 0
    @AppStorage("vvv2RoundCountSum") var roundCountSum: Int = 0
    
    func roundSumFunc() {
        roundCountSum = countSum(
            roundCount10,
            roundCount20,
            roundCountDrive,
        )
    }
    
    func resetRush() {
        roundCount10 = 0
        roundCount20 = 0
        roundCountDrive = 0
        roundCountSum = 0
        minusCheck = false
    }
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "革命機ヴァルヴレイヴ2"
    @AppStorage("vvv2MinusCheck") var minusCheck: Bool = false
    @AppStorage("vvv2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
        resetScreen()
        resetRush()
    }
    
    // ---------------
    // ver3.13.0で追加
    // ---------------
    let ratioKakumeiRatio: [Double] = [55,-1,-1,-1,60]
    let ratioKessenRatio: [Double] = [45,-1,-1,-1,40]
}


class Vvv2Memory1: ObservableObject {
    @AppStorage("vvv2BonusCountKakumeiMemory1") var bonusCountKakumei: Int = 0
    @AppStorage("vvv2BonusCountKessenMemory1") var bonusCountKessen: Int = 0
    @AppStorage("vvv2BonusCountSumMemory1") var bonusCountSum: Int = 0
    @AppStorage("vvv2ScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("vvv2ScreenCountBlue1Memory1") var screenCountBlue1: Int = 0
    @AppStorage("vvv2ScreenCountBlue2Memory1") var screenCountBlue2: Int = 0
    @AppStorage("vvv2ScreenCountRed1Memory1") var screenCountRed1: Int = 0
    @AppStorage("vvv2ScreenCountRed2Memory1") var screenCountRed2: Int = 0
    @AppStorage("vvv2ScreenCountPurpleMemory1") var screenCountPurple: Int = 0
    @AppStorage("vvv2ScreenCountSilverMemory1") var screenCountSilver: Int = 0
    @AppStorage("vvv2ScreenCountGoldMemory1") var screenCountGold: Int = 0
    @AppStorage("vvv2ScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("vvv2RoundCount10Memory1") var roundCount10: Int = 0
    @AppStorage("vvv2RoundCount20Memory1") var roundCount20: Int = 0
    @AppStorage("vvv2RoundCountDriveMemory1") var roundCountDrive: Int = 0
    @AppStorage("vvv2RoundCountSumMemory1") var roundCountSum: Int = 0
    @AppStorage("vvv2MemoMemory1") var memo = ""
    @AppStorage("vvv2DateMemory1") var dateDouble = 0.0
}


class Vvv2Memory2: ObservableObject {
    @AppStorage("vvv2BonusCountKakumeiMemory2") var bonusCountKakumei: Int = 0
    @AppStorage("vvv2BonusCountKessenMemory2") var bonusCountKessen: Int = 0
    @AppStorage("vvv2BonusCountSumMemory2") var bonusCountSum: Int = 0
    @AppStorage("vvv2ScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("vvv2ScreenCountBlue1Memory2") var screenCountBlue1: Int = 0
    @AppStorage("vvv2ScreenCountBlue2Memory2") var screenCountBlue2: Int = 0
    @AppStorage("vvv2ScreenCountRed1Memory2") var screenCountRed1: Int = 0
    @AppStorage("vvv2ScreenCountRed2Memory2") var screenCountRed2: Int = 0
    @AppStorage("vvv2ScreenCountPurpleMemory2") var screenCountPurple: Int = 0
    @AppStorage("vvv2ScreenCountSilverMemory2") var screenCountSilver: Int = 0
    @AppStorage("vvv2ScreenCountGoldMemory2") var screenCountGold: Int = 0
    @AppStorage("vvv2ScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("vvv2RoundCount10Memory2") var roundCount10: Int = 0
    @AppStorage("vvv2RoundCount20Memory2") var roundCount20: Int = 0
    @AppStorage("vvv2RoundCountDriveMemory2") var roundCountDrive: Int = 0
    @AppStorage("vvv2RoundCountSumMemory2") var roundCountSum: Int = 0
    @AppStorage("vvv2MemoMemory2") var memo = ""
    @AppStorage("vvv2DateMemory2") var dateDouble = 0.0
}


class Vvv2Memory3: ObservableObject {
    @AppStorage("vvv2BonusCountKakumeiMemory3") var bonusCountKakumei: Int = 0
    @AppStorage("vvv2BonusCountKessenMemory3") var bonusCountKessen: Int = 0
    @AppStorage("vvv2BonusCountSumMemory3") var bonusCountSum: Int = 0
    @AppStorage("vvv2ScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("vvv2ScreenCountBlue1Memory3") var screenCountBlue1: Int = 0
    @AppStorage("vvv2ScreenCountBlue2Memory3") var screenCountBlue2: Int = 0
    @AppStorage("vvv2ScreenCountRed1Memory3") var screenCountRed1: Int = 0
    @AppStorage("vvv2ScreenCountRed2Memory3") var screenCountRed2: Int = 0
    @AppStorage("vvv2ScreenCountPurpleMemory3") var screenCountPurple: Int = 0
    @AppStorage("vvv2ScreenCountSilverMemory3") var screenCountSilver: Int = 0
    @AppStorage("vvv2ScreenCountGoldMemory3") var screenCountGold: Int = 0
    @AppStorage("vvv2ScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("vvv2RoundCount10Memory3") var roundCount10: Int = 0
    @AppStorage("vvv2RoundCount20Memory3") var roundCount20: Int = 0
    @AppStorage("vvv2RoundCountDriveMemory3") var roundCountDrive: Int = 0
    @AppStorage("vvv2RoundCountSumMemory3") var roundCountSum: Int = 0
    @AppStorage("vvv2MemoMemory3") var memo = ""
    @AppStorage("vvv2DateMemory3") var dateDouble = 0.0
}
