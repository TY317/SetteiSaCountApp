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
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "ダーリン・イン・ザ・フランキス"
    @AppStorage("darlingMinusCheck") var minusCheck: Bool = false
    @AppStorage("darlingSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
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
    @AppStorage("darlingMemoMemory1") var memo = ""
    @AppStorage("darlingDateMemory1") var dateDouble = 0.0
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
    @AppStorage("darlingMemoMemory2") var memo = ""
    @AppStorage("darlingDateMemory2") var dateDouble = 0.0
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
    @AppStorage("darlingMemoMemory3") var memo = ""
    @AppStorage("darlingDateMemory3") var dateDouble = 0.0
}
