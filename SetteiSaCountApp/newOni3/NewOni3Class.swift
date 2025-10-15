//
//  NewOni3Class.swift
//  SetteiSaCountApp
//
//  newOni3ted by 横田徹 on 2025/10/05.
//

import Foundation
import SwiftUI

class NewOni3: ObservableObject {
    // ///////////
    // 通常時
    // ///////////
    let ratioKokaku: [Double] = [38.3,-1,-1,-1,-1,-1]
    @AppStorage("newOni3KokakuCountJakuCherry") var kokakuCountJakuCherry: Int = 0
    @AppStorage("newOni3KokakuCountJakuSuika") var kokakuCountJakuSuika: Int = 0
    @AppStorage("newOni3KokakuCountJakuSum") var kokakuCountJakuSum: Int = 0
    @AppStorage("newOni3KokakuCountIkou") var kokakuCountIkou: Int = 0
    
    func kokakuCountJakuSumCalc() {
        kokakuCountJakuSum = kokakuCountJakuCherry + kokakuCountJakuSuika
    }
    
    func resetNormal() {
        kokakuCountJakuCherry = 0
        kokakuCountJakuSuika = 0
        kokakuCountJakuSum = 0
        kokakuCountIkou = 0
        minusCheck = false
    }
    
    // //////////////
    // 初当り
    // //////////////
    let ratioFirstHitAt: [Double] = [379.7,372.7,352.8,306.5,297.9,293]
    @AppStorage("newOni3NormalGame") var normalGame: Int = 0
    @AppStorage("newOni3FirstHitCountAt") var firstHitCountAt: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        minusCheck = false
    }
    
    // //////////////
    // AT終了画面
    // //////////////
    @AppStorage("newOni3ScreenCountDefault") var screenCountDefault: Int = 0
    @AppStorage("newOni3ScreenCountKisu") var screenCountKisu: Int = 0
    @AppStorage("newOni3ScreenCountGusu") var screenCountGusu: Int = 0
    @AppStorage("newOni3ScreenCountHigh") var screenCountHigh: Int = 0
    @AppStorage("newOni3ScreenCountOver2") var screenCountOver2: Int = 0
    @AppStorage("newOni3ScreenCountOver3") var screenCountOver3: Int = 0
    @AppStorage("newOni3ScreenCountOver4") var screenCountOver4: Int = 0
    @AppStorage("newOni3ScreenCountOver5") var screenCountOver5: Int = 0
    @AppStorage("newOni3ScreenCountOver6") var screenCountOver6: Int = 0
    @AppStorage("newOni3ScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = screenCountDefault + screenCountKisu + screenCountGusu + screenCountHigh + screenCountOver2 + screenCountOver3 + screenCountOver4 + screenCountOver5 + screenCountOver6
    }
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountKisu = 0
        screenCountGusu = 0
        screenCountHigh = 0
        screenCountOver2 = 0
        screenCountOver3 = 0
        screenCountOver4 = 0
        screenCountOver5 = 0
        screenCountOver6 = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // ////////////
    // 鬼ボーナス
    // ////////////
    @AppStorage("newOni3PersonSenarioCountMikata") var personSenarioCountMikata: Int = 0
    @AppStorage("newOni3PersonSenarioCountTeki") var personSenarioCountTeki: Int = 0
    @AppStorage("newOni3PersonSenarioCountSum") var personSenarioCountSum: Int = 0
    
    // 最終キャラ
    @AppStorage("newOni3PersonFinalCountDefault") var personFinalCountDefault: Int = 0
    @AppStorage("newOni3PersonFinalCountHigh") var personFinalCountHigh: Int = 0
    @AppStorage("newOni3PersonFinalCountOver2") var personFinalCountOver2: Int = 0
    @AppStorage("newOni3PersonFinalCountOver3") var personFinalCountOver3: Int = 0
    @AppStorage("newOni3PersonFinalCountOver4") var personFinalCountOver4: Int = 0
    @AppStorage("newOni3PersonFinalCountOver5") var personFinalCountOver5: Int = 0
    @AppStorage("newOni3PersonFinalCountOver6") var personFinalCountOver6: Int = 0
    @AppStorage("newOni3PersonFinalCountSum") var personFinalCountSum: Int = 0
    
    func oniBonusSumFunc() {
        personSenarioCountSum = personSenarioCountMikata + personSenarioCountTeki
        personFinalCountSum = countSum(
            personFinalCountDefault,
            personFinalCountHigh,
            personFinalCountOver2,
            personFinalCountOver3,
            personFinalCountOver4,
            personFinalCountOver5,
            personFinalCountOver6,
        )
    }
    
    func resetOniBonus() {
        personSenarioCountMikata = 0
        personSenarioCountTeki = 0
        personSenarioCountSum = 0
        personFinalCountDefault = 0
        personFinalCountHigh = 0
        personFinalCountOver2 = 0
        personFinalCountOver3 = 0
        personFinalCountOver4 = 0
        personFinalCountOver5 = 0
        personFinalCountOver6 = 0
        personFinalCountSum = 0
        minusCheck = false
    }
    
    // ///////////////
    // エンディング
    // ///////////////
    @AppStorage("newOni3EndingCountDefault") var endingCountDefault: Int = 0
    @AppStorage("newOni3EndingCountKisuJaku") var endingCountKisuJaku: Int = 0
    @AppStorage("newOni3EndingCountGusuJaku") var endingCountGusuJaku: Int = 0
    @AppStorage("newOni3EndingCountKisuKyo") var endingCountKisuKyo: Int = 0
    @AppStorage("newOni3EndingCountGusuKyo") var endingCountGusuKyo: Int = 0
    @AppStorage("newOni3EndingCountNegate2") var endingCountNegate2: Int = 0
    @AppStorage("newOni3EndingCountNegate3") var endingCountNegate3: Int = 0
    @AppStorage("newOni3EndingCountNegate4") var endingCountNegate4: Int = 0
    @AppStorage("newOni3EndingCountOver2") var endingCountOver2: Int = 0
    @AppStorage("newOni3EndingCountOver3") var endingCountOver3: Int = 0
    @AppStorage("newOni3EndingCountOver4") var endingCountOver4: Int = 0
    @AppStorage("newOni3EndingCountOver5") var endingCountOver5: Int = 0
    @AppStorage("newOni3EndingCountOver6") var endingCountOver6: Int = 0
    @AppStorage("newOni3EndingCountSum") var endingCountSum: Int = 0
    
    func endingSumFunc() {
        endingCountSum = countSum(
            endingCountDefault,
            endingCountKisuJaku,
            endingCountGusuJaku,
            endingCountKisuKyo,
            endingCountGusuKyo,
            endingCountNegate2,
            endingCountNegate3,
            endingCountNegate4,
            endingCountOver2,
            endingCountOver3,
            endingCountOver4,
            endingCountOver5,
            endingCountOver6,
        )
    }
    
    func resetEnding() {
        endingCountDefault = 0
        endingCountKisuJaku = 0
        endingCountGusuJaku = 0
        endingCountKisuKyo = 0
        endingCountGusuKyo = 0
        endingCountNegate2 = 0
        endingCountNegate3 = 0
        endingCountNegate4 = 0
        endingCountOver2 = 0
        endingCountOver3 = 0
        endingCountOver4 = 0
        endingCountOver5 = 0
        endingCountOver6 = 0
        endingCountSum = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "新鬼武者3"
    @AppStorage("newOni3MinusCheck") var minusCheck: Bool = false
    @AppStorage("newOni3SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetOniBonus()
        resetEnding()
    }
}


// メモリー1
class NewOni3Memory1: ObservableObject {
    @AppStorage("newOni3KokakuCountJakuCherryMemory1") var kokakuCountJakuCherry: Int = 0
    @AppStorage("newOni3KokakuCountJakuSuikaMemory1") var kokakuCountJakuSuika: Int = 0
    @AppStorage("newOni3KokakuCountJakuSumMemory1") var kokakuCountJakuSum: Int = 0
    @AppStorage("newOni3KokakuCountIkouMemory1") var kokakuCountIkou: Int = 0
    @AppStorage("newOni3NormalGameMemory1") var normalGame: Int = 0
    @AppStorage("newOni3FirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("newOni3ScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("newOni3ScreenCountKisuMemory1") var screenCountKisu: Int = 0
    @AppStorage("newOni3ScreenCountGusuMemory1") var screenCountGusu: Int = 0
    @AppStorage("newOni3ScreenCountHighMemory1") var screenCountHigh: Int = 0
    @AppStorage("newOni3ScreenCountOver2Memory1") var screenCountOver2: Int = 0
    @AppStorage("newOni3ScreenCountOver3Memory1") var screenCountOver3: Int = 0
    @AppStorage("newOni3ScreenCountOver4Memory1") var screenCountOver4: Int = 0
    @AppStorage("newOni3ScreenCountOver5Memory1") var screenCountOver5: Int = 0
    @AppStorage("newOni3ScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("newOni3ScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("newOni3PersonSenarioCountMikataMemory1") var personSenarioCountMikata: Int = 0
    @AppStorage("newOni3PersonSenarioCountTekiMemory1") var personSenarioCountTeki: Int = 0
    @AppStorage("newOni3PersonSenarioCountSumMemory1") var personSenarioCountSum: Int = 0
    @AppStorage("newOni3PersonFinalCountDefaultMemory1") var personFinalCountDefault: Int = 0
    @AppStorage("newOni3PersonFinalCountHighMemory1") var personFinalCountHigh: Int = 0
    @AppStorage("newOni3PersonFinalCountOver2Memory1") var personFinalCountOver2: Int = 0
    @AppStorage("newOni3PersonFinalCountOver3Memory1") var personFinalCountOver3: Int = 0
    @AppStorage("newOni3PersonFinalCountOver4Memory1") var personFinalCountOver4: Int = 0
    @AppStorage("newOni3PersonFinalCountOver5Memory1") var personFinalCountOver5: Int = 0
    @AppStorage("newOni3PersonFinalCountOver6Memory1") var personFinalCountOver6: Int = 0
    @AppStorage("newOni3PersonFinalCountSumMemory1") var personFinalCountSum: Int = 0
    @AppStorage("newOni3EndingCountDefaultMemory1") var endingCountDefault: Int = 0
    @AppStorage("newOni3EndingCountKisuJakuMemory1") var endingCountKisuJaku: Int = 0
    @AppStorage("newOni3EndingCountGusuJakuMemory1") var endingCountGusuJaku: Int = 0
    @AppStorage("newOni3EndingCountKisuKyoMemory1") var endingCountKisuKyo: Int = 0
    @AppStorage("newOni3EndingCountGusuKyoMemory1") var endingCountGusuKyo: Int = 0
    @AppStorage("newOni3EndingCountNegate2Memory1") var endingCountNegate2: Int = 0
    @AppStorage("newOni3EndingCountNegate3Memory1") var endingCountNegate3: Int = 0
    @AppStorage("newOni3EndingCountNegate4Memory1") var endingCountNegate4: Int = 0
    @AppStorage("newOni3EndingCountOver2Memory1") var endingCountOver2: Int = 0
    @AppStorage("newOni3EndingCountOver3Memory1") var endingCountOver3: Int = 0
    @AppStorage("newOni3EndingCountOver4Memory1") var endingCountOver4: Int = 0
    @AppStorage("newOni3EndingCountOver5Memory1") var endingCountOver5: Int = 0
    @AppStorage("newOni3EndingCountOver6Memory1") var endingCountOver6: Int = 0
    @AppStorage("newOni3EndingCountSumMemory1") var endingCountSum: Int = 0
    @AppStorage("newOni3MinusCheckMemory1") var minusCheck: Bool = false
    @AppStorage("newOni3SelectedMemoryMemory1") var selectedMemory = "メモリー1"
    @AppStorage("newOni3MemoMemory1") var memo = ""
    @AppStorage("newOni3DateMemory1") var dateDouble = 0.0
}

// メモリー2
class NewOni3Memory2: ObservableObject {
    @AppStorage("newOni3KokakuCountJakuCherryMemory2") var kokakuCountJakuCherry: Int = 0
    @AppStorage("newOni3KokakuCountJakuSuikaMemory2") var kokakuCountJakuSuika: Int = 0
    @AppStorage("newOni3KokakuCountJakuSumMemory2") var kokakuCountJakuSum: Int = 0
    @AppStorage("newOni3KokakuCountIkouMemory2") var kokakuCountIkou: Int = 0
    @AppStorage("newOni3NormalGameMemory2") var normalGame: Int = 0
    @AppStorage("newOni3FirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("newOni3ScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("newOni3ScreenCountKisuMemory2") var screenCountKisu: Int = 0
    @AppStorage("newOni3ScreenCountGusuMemory2") var screenCountGusu: Int = 0
    @AppStorage("newOni3ScreenCountHighMemory2") var screenCountHigh: Int = 0
    @AppStorage("newOni3ScreenCountOver2Memory2") var screenCountOver2: Int = 0
    @AppStorage("newOni3ScreenCountOver3Memory2") var screenCountOver3: Int = 0
    @AppStorage("newOni3ScreenCountOver4Memory2") var screenCountOver4: Int = 0
    @AppStorage("newOni3ScreenCountOver5Memory2") var screenCountOver5: Int = 0
    @AppStorage("newOni3ScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("newOni3ScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("newOni3PersonSenarioCountMikataMemory2") var personSenarioCountMikata: Int = 0
    @AppStorage("newOni3PersonSenarioCountTekiMemory2") var personSenarioCountTeki: Int = 0
    @AppStorage("newOni3PersonSenarioCountSumMemory2") var personSenarioCountSum: Int = 0
    @AppStorage("newOni3PersonFinalCountDefaultMemory2") var personFinalCountDefault: Int = 0
    @AppStorage("newOni3PersonFinalCountHighMemory2") var personFinalCountHigh: Int = 0
    @AppStorage("newOni3PersonFinalCountOver2Memory2") var personFinalCountOver2: Int = 0
    @AppStorage("newOni3PersonFinalCountOver3Memory2") var personFinalCountOver3: Int = 0
    @AppStorage("newOni3PersonFinalCountOver4Memory2") var personFinalCountOver4: Int = 0
    @AppStorage("newOni3PersonFinalCountOver5Memory2") var personFinalCountOver5: Int = 0
    @AppStorage("newOni3PersonFinalCountOver6Memory2") var personFinalCountOver6: Int = 0
    @AppStorage("newOni3PersonFinalCountSumMemory2") var personFinalCountSum: Int = 0
    @AppStorage("newOni3EndingCountDefaultMemory2") var endingCountDefault: Int = 0
    @AppStorage("newOni3EndingCountKisuJakuMemory2") var endingCountKisuJaku: Int = 0
    @AppStorage("newOni3EndingCountGusuJakuMemory2") var endingCountGusuJaku: Int = 0
    @AppStorage("newOni3EndingCountKisuKyoMemory2") var endingCountKisuKyo: Int = 0
    @AppStorage("newOni3EndingCountGusuKyoMemory2") var endingCountGusuKyo: Int = 0
    @AppStorage("newOni3EndingCountNegate2Memory2") var endingCountNegate2: Int = 0
    @AppStorage("newOni3EndingCountNegate3Memory2") var endingCountNegate3: Int = 0
    @AppStorage("newOni3EndingCountNegate4Memory2") var endingCountNegate4: Int = 0
    @AppStorage("newOni3EndingCountOver2Memory2") var endingCountOver2: Int = 0
    @AppStorage("newOni3EndingCountOver3Memory2") var endingCountOver3: Int = 0
    @AppStorage("newOni3EndingCountOver4Memory2") var endingCountOver4: Int = 0
    @AppStorage("newOni3EndingCountOver5Memory2") var endingCountOver5: Int = 0
    @AppStorage("newOni3EndingCountOver6Memory2") var endingCountOver6: Int = 0
    @AppStorage("newOni3EndingCountSumMemory2") var endingCountSum: Int = 0
    @AppStorage("newOni3MinusCheckMemory2") var minusCheck: Bool = false
    @AppStorage("newOni3SelectedMemoryMemory2") var selectedMemory = "メモリー1"
    @AppStorage("newOni3MemoMemory2") var memo = ""
    @AppStorage("newOni3DateMemory2") var dateDouble = 0.0
}

// メモリー3
class NewOni3Memory3: ObservableObject {
    @AppStorage("newOni3KokakuCountJakuCherryMemory3") var kokakuCountJakuCherry: Int = 0
    @AppStorage("newOni3KokakuCountJakuSuikaMemory3") var kokakuCountJakuSuika: Int = 0
    @AppStorage("newOni3KokakuCountJakuSumMemory3") var kokakuCountJakuSum: Int = 0
    @AppStorage("newOni3KokakuCountIkouMemory3") var kokakuCountIkou: Int = 0
    @AppStorage("newOni3NormalGameMemory3") var normalGame: Int = 0
    @AppStorage("newOni3FirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("newOni3ScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("newOni3ScreenCountKisuMemory3") var screenCountKisu: Int = 0
    @AppStorage("newOni3ScreenCountGusuMemory3") var screenCountGusu: Int = 0
    @AppStorage("newOni3ScreenCountHighMemory3") var screenCountHigh: Int = 0
    @AppStorage("newOni3ScreenCountOver2Memory3") var screenCountOver2: Int = 0
    @AppStorage("newOni3ScreenCountOver3Memory3") var screenCountOver3: Int = 0
    @AppStorage("newOni3ScreenCountOver4Memory3") var screenCountOver4: Int = 0
    @AppStorage("newOni3ScreenCountOver5Memory3") var screenCountOver5: Int = 0
    @AppStorage("newOni3ScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("newOni3ScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("newOni3PersonSenarioCountMikataMemory3") var personSenarioCountMikata: Int = 0
    @AppStorage("newOni3PersonSenarioCountTekiMemory3") var personSenarioCountTeki: Int = 0
    @AppStorage("newOni3PersonSenarioCountSumMemory3") var personSenarioCountSum: Int = 0
    @AppStorage("newOni3PersonFinalCountDefaultMemory3") var personFinalCountDefault: Int = 0
    @AppStorage("newOni3PersonFinalCountHighMemory3") var personFinalCountHigh: Int = 0
    @AppStorage("newOni3PersonFinalCountOver2Memory3") var personFinalCountOver2: Int = 0
    @AppStorage("newOni3PersonFinalCountOver3Memory3") var personFinalCountOver3: Int = 0
    @AppStorage("newOni3PersonFinalCountOver4Memory3") var personFinalCountOver4: Int = 0
    @AppStorage("newOni3PersonFinalCountOver5Memory3") var personFinalCountOver5: Int = 0
    @AppStorage("newOni3PersonFinalCountOver6Memory3") var personFinalCountOver6: Int = 0
    @AppStorage("newOni3PersonFinalCountSumMemory3") var personFinalCountSum: Int = 0
    @AppStorage("newOni3EndingCountDefaultMemory3") var endingCountDefault: Int = 0
    @AppStorage("newOni3EndingCountKisuJakuMemory3") var endingCountKisuJaku: Int = 0
    @AppStorage("newOni3EndingCountGusuJakuMemory3") var endingCountGusuJaku: Int = 0
    @AppStorage("newOni3EndingCountKisuKyoMemory3") var endingCountKisuKyo: Int = 0
    @AppStorage("newOni3EndingCountGusuKyoMemory3") var endingCountGusuKyo: Int = 0
    @AppStorage("newOni3EndingCountNegate2Memory3") var endingCountNegate2: Int = 0
    @AppStorage("newOni3EndingCountNegate3Memory3") var endingCountNegate3: Int = 0
    @AppStorage("newOni3EndingCountNegate4Memory3") var endingCountNegate4: Int = 0
    @AppStorage("newOni3EndingCountOver2Memory3") var endingCountOver2: Int = 0
    @AppStorage("newOni3EndingCountOver3Memory3") var endingCountOver3: Int = 0
    @AppStorage("newOni3EndingCountOver4Memory3") var endingCountOver4: Int = 0
    @AppStorage("newOni3EndingCountOver5Memory3") var endingCountOver5: Int = 0
    @AppStorage("newOni3EndingCountOver6Memory3") var endingCountOver6: Int = 0
    @AppStorage("newOni3EndingCountSumMemory3") var endingCountSum: Int = 0
    @AppStorage("newOni3MinusCheckMemory3") var minusCheck: Bool = false
    @AppStorage("newOni3SelectedMemoryMemory3") var selectedMemory = "メモリー1"
    @AppStorage("newOni3MemoMemory3") var memo = ""
    @AppStorage("newOni3DateMemory3") var dateDouble = 0.0
}
