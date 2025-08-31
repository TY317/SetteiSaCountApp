//
//  DarlingClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/27.
//

import Foundation
import SwiftUI

class Darling: ObservableObject {
    // //////////
    // 初当り
    // //////////
    let ratioCz: [Double] = [125.1, 125.3, 123.4, 124.1, 118.4, 115.9]
    let ratioBonus: [Double] = [343.0, 334.1, 320.1, 298.9, 270.3, 252.3]
    let ratioKokaku: [Double] = [343.0, 334.1, 320.1, 298.9, 270.3, 252.3]
    // 選択肢の設定
    let selectListFirstKind: [String] = ["CZ(コネクト)","CZ(ココロ)", "ボーナス直撃"]
    let selectListBonusKind: [String] = ["ハズレ", "ﾀﾞｰﾘﾝ・ｲﾝ・ｻﾞ・ﾎﾞｰﾅｽ", "REG", "エピソード"]
    let selectListKokakuHit: [String] = ["ハズレ", "当選"]
    
    // 選択結果
    @AppStorage("darlingSelectedFirstKind") var selectedFirstKind: String = "CZ(コネクト)"
    @AppStorage("darlingSelectedBonusKind") var selectedBonusKind: String = "ハズレ"
    @AppStorage("darlingSelectedKokakuHit") var selectedKokakuHit: String = "ハズレ"
    @AppStorage("darlingInputGame") var inputGame: Int = 0
    
    
    // ゲーム数配列
    let gameArrayKey: String = "darlingGameArrayKey"
    @AppStorage("darlingGameArrayKey") var gameArrayData: Data?
    // 種類配列
    let firstKindArrayKey: String = "darlingFirstKindArrayKey"
    @AppStorage("darlingFirstKindArrayKey") var firstKindArrayData: Data?
    // 当選契機配列
    let bonusKindArrayKey: String = "darlingBonusKindArrayKey"
    @AppStorage("darlingBonusKindArrayKey") var bonusKindArrayData: Data?
    // ST結果配列
    let kokakuHitArrayKey: String = "darlingKokakuHitArrayKey"
    @AppStorage("darlingKokakuHitArrayKey") var kokakuHitArrayData: Data?
    
    // 算出結果
    @AppStorage("darlingNormalGame") var normalGame: Int = 0
    @AppStorage("darlingCzCount") var czCount: Int = 0
    @AppStorage("darlingBonusCount") var bonusCount: Int = 0
    @AppStorage("darlingKokakuCount") var kokakuCount: Int = 0
    
    // データ登録
    func addHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: firstKindArrayData, addData: selectedFirstKind, key: firstKindArrayKey)
        arrayStringAddData(arrayData: bonusKindArrayData, addData: selectedBonusKind, key: bonusKindArrayKey)
        arrayStringAddData(arrayData: kokakuHitArrayData, addData: selectedKokakuHit, key: kokakuHitArrayKey)
        addRemoveCommon()
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: firstKindArrayData, key: firstKindArrayKey)
        arrayStringRemoveLast(arrayData: bonusKindArrayData, key: bonusKindArrayKey)
        arrayStringRemoveLast(arrayData: kokakuHitArrayData, key: kokakuHitArrayKey)
        addRemoveCommon()
    }
    
    func resetFirstHit() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: firstKindArrayData, key: firstKindArrayKey)
        arrayStringRemoveAll(arrayData: bonusKindArrayData, key: bonusKindArrayKey)
        arrayStringRemoveAll(arrayData: kokakuHitArrayData, key: kokakuHitArrayKey)
        addRemoveCommon()
        inputGame = 0
        minusCheck = false
    }
    
    func addRemoveCommon() {
        // 通常ゲーム数の算出
        normalGame = arraySumGameNotResetWordOne(
            gameArrayData: gameArrayData,
            bonusArrayData: bonusKindArrayData,
            notResetWord: selectListBonusKind[0]
        )
        // CZ回数算出
        let firstKindAllData = arrayStringAllDataCount(arrayData: firstKindArrayData)
        let firstKindChokugekiData = arrayStringDataCount(arrayData: firstKindArrayData, countString: selectListFirstKind[2])
        czCount = firstKindAllData - firstKindChokugekiData
        // ボーナス回数算出
        let bonusKindAllData = arrayStringAllDataCount(arrayData: bonusKindArrayData)
        let bonusKindHazureData = arrayStringDataCount(arrayData: bonusKindArrayData, countString: selectListBonusKind[0])
        bonusCount = bonusKindAllData - bonusKindHazureData
        // ボーナス高確率回数算出
        kokakuCount = arrayStringDataCount(arrayData: kokakuHitArrayData, countString: selectListKokakuHit[1])
    }
    
    // //////////////
    // エンディング
    // //////////////
    @AppStorage("darlingEndingCountDefault") var endingCountDefault: Int = 0
    @AppStorage("darlingEndingCount13sisa") var endingCount13sisa: Int = 0
    @AppStorage("darlingEndingCount245sisa") var endingCount245sisa: Int = 0
    @AppStorage("darlingEndingCount5sisa") var endingCount5sisa: Int = 0
    @AppStorage("darlingEndingCountOver2") var endingCountOver2: Int = 0
    @AppStorage("darlingEndingCountOver6") var endingCountOver6: Int = 0
    @AppStorage("darlingEndingCountSum") var endingCountSum: Int = 0
    
    func eindingSumFunc() {
        endingCountSum = countSum(
            endingCountDefault,
            endingCount13sisa,
            endingCount245sisa,
            endingCount5sisa,
            endingCountOver2,
            endingCountOver6,
        )
    }
    
    func resetEnding() {
        endingCountDefault = 0
        endingCount13sisa = 0
        endingCount245sisa = 0
        endingCount5sisa = 0
        endingCountOver2 = 0
        endingCountOver6 = 0
        endingCountSum = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "ダーリン・イン・ザ・フランキス"
    @AppStorage("darlingMinusCheck") var minusCheck: Bool = false
    @AppStorage("darlingSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
        resetEnding()
        resetNormal()
        resetCz()
    }
    
    // ///////////
    // ver3.8.0で追加
    // ///////////
    // 高確移行率
    let ratioKokakuCherry: [Double] = [16.4,16.4,17.2,17.2,19.3,20.3]
    let ratioKokakuChance: [Double] = [40.6,40.7,42.1,42.1,45.8,47.6]
    @AppStorage("darlingKokakuCountCherryMiss") var kokakuCountCherryMiss: Int = 0
    @AppStorage("darlingKokakuCountCherryHit") var kokakuCountCherryHit: Int = 0
    @AppStorage("darlingKokakuCountCherrySum") var kokakuCountCherrySum: Int = 0
    @AppStorage("darlingKokakuCountChanceMiss") var kokakuCountChanceMiss: Int = 0
    @AppStorage("darlingKokakuCountChanceHit") var kokakuCountChanceHit: Int = 0
    @AppStorage("darlingKokakuCountChanceSum") var kokakuCountChanceSum: Int = 0
    
    func kokakuCountSumFunc() {
        kokakuCountCherrySum = countSum(
            kokakuCountCherryMiss,
            kokakuCountCherryHit,
        )
        kokakuCountChanceSum = countSum(
            kokakuCountChanceMiss,
            kokakuCountChanceHit,
        )
    }
    
    func resetNormal() {
        kokakuCountCherryMiss = 0
        kokakuCountCherryHit = 0
        kokakuCountCherrySum = 0
        kokakuCountChanceMiss = 0
        kokakuCountChanceHit = 0
        kokakuCountChanceSum = 0
        minusCheck = false
    }
    
    // CZ 開始時の初期レベル
    let ratioCzLevelWhite: [Double] = [69.1,69.1,69.1,67.4,65.8,63]
    let ratioCzLevelBlue: [Double] = [25,25,25,25.2,25.4,25.7]
    let ratioCzLevelYellow: [Double] = [4.7,4.7,4.7,5.6,6.3,7.8]
    let ratioCzLevelGreen: [Double] = [0.8,0.8,0.8,1.2,1.5,2.2]
    let ratioCzLevelRed: [Double] = [0.4,0.4,0.4,0.7,0.9,1.4]
    @AppStorage("darlingCzLevelCountWhite") var czLevelCountWhite: Int = 0
    @AppStorage("darlingCzLevelCountBlue") var czLevelCountBlue: Int = 0
    @AppStorage("darlingCzLevelCountYellow") var czLevelCountYellow: Int = 0
    @AppStorage("darlingCzLevelCountGreen") var czLevelCountGreen: Int = 0
    @AppStorage("darlingCzLevelCountRed") var czLevelCountRed: Int = 0
    @AppStorage("darlingCzLevelCountSum") var czLevelCountSum: Int = 0
    
    func czLevelCountSumFunc() {
        czLevelCountSum = countSum(
            czLevelCountWhite,
            czLevelCountBlue,
            czLevelCountYellow,
            czLevelCountGreen,
            czLevelCountRed,
        )
    }
    
    func resetCz() {
        czLevelCountWhite = 0
        czLevelCountBlue = 0
        czLevelCountYellow = 0
        czLevelCountGreen = 0
        czLevelCountRed = 0
        czLevelCountSum = 0
        minusCheck = false
    }
}


// //// メモリー1
class DarlingMemory1: ObservableObject {
    @AppStorage("darlingGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("darlingFirstKindArrayKeyMemory1") var firstKindArrayData: Data?
    @AppStorage("darlingBonusKindArrayKeyMemory1") var bonusKindArrayData: Data?
    @AppStorage("darlingKokakuHitArrayKeyMemory1") var kokakuHitArrayData: Data?
    @AppStorage("darlingNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("darlingCzCountMemory1") var czCount: Int = 0
    @AppStorage("darlingBonusCountMemory1") var bonusCount: Int = 0
    @AppStorage("darlingKokakuCountMemory1") var kokakuCount: Int = 0
    @AppStorage("darlingEndingCountDefaultMemory1") var endingCountDefault: Int = 0
    @AppStorage("darlingEndingCount13sisaMemory1") var endingCount13sisa: Int = 0
    @AppStorage("darlingEndingCount245sisaMemory1") var endingCount245sisa: Int = 0
    @AppStorage("darlingEndingCount5sisaMemory1") var endingCount5sisa: Int = 0
    @AppStorage("darlingEndingCountOver2Memory1") var endingCountOver2: Int = 0
    @AppStorage("darlingEndingCountOver6Memory1") var endingCountOver6: Int = 0
    @AppStorage("darlingEndingCountSumMemory1") var endingCountSum: Int = 0
    @AppStorage("darlingMemoMemory1") var memo = ""
    @AppStorage("darlingDateMemory1") var dateDouble = 0.0
    
    // ///////////
    // ver3.8.0で追加
    // ///////////
    @AppStorage("darlingKokakuCountCherryMissMemory1") var kokakuCountCherryMiss: Int = 0
    @AppStorage("darlingKokakuCountCherryHitMemory1") var kokakuCountCherryHit: Int = 0
    @AppStorage("darlingKokakuCountCherrySumMemory1") var kokakuCountCherrySum: Int = 0
    @AppStorage("darlingKokakuCountChanceMissMemory1") var kokakuCountChanceMiss: Int = 0
    @AppStorage("darlingKokakuCountChanceHitMemory1") var kokakuCountChanceHit: Int = 0
    @AppStorage("darlingKokakuCountChanceSumMemory1") var kokakuCountChanceSum: Int = 0
    @AppStorage("darlingCzLevelCountWhiteMemory1") var czLevelCountWhite: Int = 0
    @AppStorage("darlingCzLevelCountBlueMemory1") var czLevelCountBlue: Int = 0
    @AppStorage("darlingCzLevelCountYellowMemory1") var czLevelCountYellow: Int = 0
    @AppStorage("darlingCzLevelCountGreenMemory1") var czLevelCountGreen: Int = 0
    @AppStorage("darlingCzLevelCountRedMemory1") var czLevelCountRed: Int = 0
    @AppStorage("darlingCzLevelCountSumMemory1") var czLevelCountSum: Int = 0
}

// //// メモリー2
class DarlingMemory2: ObservableObject {
    @AppStorage("darlingGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("darlingFirstKindArrayKeyMemory2") var firstKindArrayData: Data?
    @AppStorage("darlingBonusKindArrayKeyMemory2") var bonusKindArrayData: Data?
    @AppStorage("darlingKokakuHitArrayKeyMemory2") var kokakuHitArrayData: Data?
    @AppStorage("darlingNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("darlingCzCountMemory2") var czCount: Int = 0
    @AppStorage("darlingBonusCountMemory2") var bonusCount: Int = 0
    @AppStorage("darlingKokakuCountMemory2") var kokakuCount: Int = 0
    @AppStorage("darlingEndingCountDefaultMemory2") var endingCountDefault: Int = 0
    @AppStorage("darlingEndingCount13sisaMemory2") var endingCount13sisa: Int = 0
    @AppStorage("darlingEndingCount245sisaMemory2") var endingCount245sisa: Int = 0
    @AppStorage("darlingEndingCount5sisaMemory2") var endingCount5sisa: Int = 0
    @AppStorage("darlingEndingCountOver2Memory2") var endingCountOver2: Int = 0
    @AppStorage("darlingEndingCountOver6Memory2") var endingCountOver6: Int = 0
    @AppStorage("darlingEndingCountSumMemory2") var endingCountSum: Int = 0
    @AppStorage("darlingMemoMemory2") var memo = ""
    @AppStorage("darlingDateMemory2") var dateDouble = 0.0
    
    // ///////////
    // ver3.8.0で追加
    // ///////////
    @AppStorage("darlingKokakuCountCherryMissMemory2") var kokakuCountCherryMiss: Int = 0
    @AppStorage("darlingKokakuCountCherryHitMemory2") var kokakuCountCherryHit: Int = 0
    @AppStorage("darlingKokakuCountCherrySumMemory2") var kokakuCountCherrySum: Int = 0
    @AppStorage("darlingKokakuCountChanceMissMemory2") var kokakuCountChanceMiss: Int = 0
    @AppStorage("darlingKokakuCountChanceHitMemory2") var kokakuCountChanceHit: Int = 0
    @AppStorage("darlingKokakuCountChanceSumMemory2") var kokakuCountChanceSum: Int = 0
    @AppStorage("darlingCzLevelCountWhiteMemory2") var czLevelCountWhite: Int = 0
    @AppStorage("darlingCzLevelCountBlueMemory2") var czLevelCountBlue: Int = 0
    @AppStorage("darlingCzLevelCountYellowMemory2") var czLevelCountYellow: Int = 0
    @AppStorage("darlingCzLevelCountGreenMemory2") var czLevelCountGreen: Int = 0
    @AppStorage("darlingCzLevelCountRedMemory2") var czLevelCountRed: Int = 0
    @AppStorage("darlingCzLevelCountSumMemory2") var czLevelCountSum: Int = 0
}

// //// メモリー3
class DarlingMemory3: ObservableObject {
    @AppStorage("darlingGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("darlingFirstKindArrayKeyMemory3") var firstKindArrayData: Data?
    @AppStorage("darlingBonusKindArrayKeyMemory3") var bonusKindArrayData: Data?
    @AppStorage("darlingKokakuHitArrayKeyMemory3") var kokakuHitArrayData: Data?
    @AppStorage("darlingNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("darlingCzCountMemory3") var czCount: Int = 0
    @AppStorage("darlingBonusCountMemory3") var bonusCount: Int = 0
    @AppStorage("darlingKokakuCountMemory3") var kokakuCount: Int = 0
    @AppStorage("darlingEndingCountDefaultMemory3") var endingCountDefault: Int = 0
    @AppStorage("darlingEndingCount13sisaMemory3") var endingCount13sisa: Int = 0
    @AppStorage("darlingEndingCount245sisaMemory3") var endingCount245sisa: Int = 0
    @AppStorage("darlingEndingCount5sisaMemory3") var endingCount5sisa: Int = 0
    @AppStorage("darlingEndingCountOver2Memory3") var endingCountOver2: Int = 0
    @AppStorage("darlingEndingCountOver6Memory3") var endingCountOver6: Int = 0
    @AppStorage("darlingEndingCountSumMemory3") var endingCountSum: Int = 0
    @AppStorage("darlingMemoMemory3") var memo = ""
    @AppStorage("darlingDateMemory3") var dateDouble = 0.0
    
    // ///////////
    // ver3.8.0で追加
    // ///////////
    @AppStorage("darlingKokakuCountCherryMissMemory3") var kokakuCountCherryMiss: Int = 0
    @AppStorage("darlingKokakuCountCherryHitMemory3") var kokakuCountCherryHit: Int = 0
    @AppStorage("darlingKokakuCountCherrySumMemory3") var kokakuCountCherrySum: Int = 0
    @AppStorage("darlingKokakuCountChanceMissMemory3") var kokakuCountChanceMiss: Int = 0
    @AppStorage("darlingKokakuCountChanceHitMemory3") var kokakuCountChanceHit: Int = 0
    @AppStorage("darlingKokakuCountChanceSumMemory3") var kokakuCountChanceSum: Int = 0
    @AppStorage("darlingCzLevelCountWhiteMemory3") var czLevelCountWhite: Int = 0
    @AppStorage("darlingCzLevelCountBlueMemory3") var czLevelCountBlue: Int = 0
    @AppStorage("darlingCzLevelCountYellowMemory3") var czLevelCountYellow: Int = 0
    @AppStorage("darlingCzLevelCountGreenMemory3") var czLevelCountGreen: Int = 0
    @AppStorage("darlingCzLevelCountRedMemory3") var czLevelCountRed: Int = 0
    @AppStorage("darlingCzLevelCountSumMemory3") var czLevelCountSum: Int = 0
}
