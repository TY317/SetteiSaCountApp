//
//  sbjClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/06.
//

import Foundation
import SwiftUI

class Sbj: ObservableObject {
    // ////////////////////////
    // 通常時
    // ////////////////////////
    @AppStorage("sbjKokakuCount") var kokakuCount: Int = 0
    @AppStorage("sbjNextInputSumCount") var nextInputSumCount: Int = 0 {
        didSet {
            normalGame = nextInputSumCount * nextInputSumDenominate
        }
    }
    @AppStorage("sbjNextInputSumDenominate") var nextInputSumDenominate: Int = 0 {
        didSet {
            normalGame = nextInputSumCount * nextInputSumDenominate
        }
    }
    @AppStorage("sbjNextInputRbCount") var nextInputRbCount: Int = 0 {
        didSet {
            bonusSum = countSum(nextInputRbCount, nextInputRedBbCount, nextInputBlueBbCount)
        }
    }
        @AppStorage("sbjNextInputRedBbCount") var nextInputRedBbCount: Int = 0 {
            didSet {
                bonusSum = countSum(nextInputRbCount, nextInputRedBbCount, nextInputBlueBbCount)
                rioChanceCount = countSum(nextInputRedBbCount, nextInputBlueBbCount)
            }
        }
            @AppStorage("sbjNextInputBlueBbCount") var nextInputBlueBbCount: Int = 0 {
                didSet {
                    bonusSum = countSum(nextInputRbCount, nextInputRedBbCount, nextInputBlueBbCount)
                    rioChanceCount = countSum(nextInputRedBbCount, nextInputBlueBbCount)
                }
            }
    @AppStorage("sbjNormalGame") var normalGame: Int = 0
    @AppStorage("sbjBonusSum") var bonusSum: Int = 0
    @AppStorage("sbjRioChanceCount") var rioChanceCount: Int = 0
    
    func resetNormal() {
        kokakuCount = 0
        nextInputSumCount = 0
        nextInputSumDenominate = 0
        nextInputRbCount = 0
        nextInputRedBbCount = 0
        nextInputBlueBbCount = 0
        minusCheck = false
        normalChanceCount = 0
        normalChanceKokakuCount = 0
        normalChanceChokugekiCount = 0
    }
    
    // ////////////////////////
    // ダイスチェック
    // ////////////////////////
    // 選択肢の設定
    let selectListDice: [String] = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6"
    ]
    let stAddString: String = "ストックタイム"
    
    @AppStorage("sbjSelectedDiceLeft") var selectedDiceLeft: String = "1"
    @AppStorage("sbjSelectedDiceRight") var selectedDiceRight: String = "1"
    @AppStorage("sbjnextInputSuikaCount") var nextInputSuikaCount: Int = 0
    
    // ダイス1配列
    let diceLeftArrayKey = "sbjDiceLeftArrayKey"
    @AppStorage("sbjDiceLeftArrayKey") var diceLeftArrayData: Data?
    // ダイス2配列
    let diceRightArrayKey = "sbjDiceRightArrayKey"
    @AppStorage("sbjDiceRightArrayKey") var diceRightArrayData: Data?
    // スイカ回数配列
    let suikaArrayKey = "sbjSuikaArrayKey"
    @AppStorage("sbjSuikaArrayKey") var suikaArrayData: Data?
    
    // データ追加
    func addDataHistory() {
        arrayStringAddData(arrayData: diceLeftArrayData, addData: selectedDiceLeft, key: diceLeftArrayKey)
        arrayStringAddData(arrayData: diceRightArrayData, addData: selectedDiceRight, key: diceRightArrayKey)
        arrayIntAddData(arrayData: suikaArrayData, addData: nextInputSuikaCount, key: suikaArrayKey)
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayStringRemoveLast(arrayData: diceLeftArrayData, key: diceLeftArrayKey)
        arrayStringRemoveLast(arrayData: diceRightArrayData, key: diceRightArrayKey)
        arrayIntRemoveLast(arrayData: suikaArrayData, key: suikaArrayKey)
    }
    
    // ストックタイムの登録
    func stAddHistory() {
        arrayStringAddData(arrayData: diceLeftArrayData, addData: stAddString, key: diceLeftArrayKey)
        arrayStringAddData(arrayData: diceRightArrayData, addData: stAddString, key: diceRightArrayKey)
        arrayIntAddData(arrayData: suikaArrayData, addData: nextInputSuikaCount, key: suikaArrayKey)
    }
    
    func resetDiceCheck() {
        arrayStringRemoveAll(arrayData: diceLeftArrayData, key: diceLeftArrayKey)
        arrayStringRemoveAll(arrayData: diceRightArrayData, key: diceRightArrayKey)
        arrayIntRemoveAll(arrayData: suikaArrayData, key: suikaArrayKey)
        nextInputSuikaCount = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("sbjMinusCheck") var minusCheck: Bool = false
    @AppStorage("sbjSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetDiceCheck()
    }
    
    // /////////////////////////
    // ver220で追加、通常チャンス目関連
    // /////////////////////////
    @AppStorage("sbjNormalChanceCount") var normalChanceCount = 0
    @AppStorage("sbjNormalChanceKokakuCount") var normalChanceKokakuCount = 0
    @AppStorage("sbjNormalChanceChokugekiCount") var normalChanceChokugekiCount = 0
}


// //// メモリー1
class SbjMemory1: ObservableObject {
    @AppStorage("sbjKokakuCountMemory1") var kokakuCount: Int = 0
    @AppStorage("sbjNextInputSumCountMemory1") var nextInputSumCount: Int = 0
    @AppStorage("sbjNextInputSumDenominateMemory1") var nextInputSumDenominate: Int = 0
    @AppStorage("sbjNextInputRbCountMemory1") var nextInputRbCount: Int = 0
    @AppStorage("sbjNextInputRedBbCountMemory1") var nextInputRedBbCount: Int = 0
    @AppStorage("sbjNextInputBlueBbCountMemory1") var nextInputBlueBbCount: Int = 0
    @AppStorage("sbjBonusSumMemory1") var bonusSum: Int = 0
    @AppStorage("sbjRioChanceCountMemory1") var rioChanceCount: Int = 0
    @AppStorage("sbjDiceLeftArrayKeyMemory1") var diceLeftArrayData: Data?
    @AppStorage("sbjDiceRightArrayKeyMemory1") var diceRightArrayData: Data?
    @AppStorage("sbjSuikaArrayKeyMemory1") var suikaArrayData: Data?
    @AppStorage("sbjMemoMemory1") var memo = ""
    @AppStorage("sbjDateMemory1") var dateDouble = 0.0
    // /////////////////////////
    // ver220で追加、通常チャンス目関連
    // /////////////////////////
    @AppStorage("sbjNormalChanceCountMemory1") var normalChanceCount = 0
    @AppStorage("sbjNormalChanceKokakuCountMemory1") var normalChanceKokakuCount = 0
    @AppStorage("sbjNormalChanceChokugekiCountMemory1") var normalChanceChokugekiCount = 0
}

// //// メモリー2
class SbjMemory2: ObservableObject {
    @AppStorage("sbjKokakuCountMemory2") var kokakuCount: Int = 0
    @AppStorage("sbjNextInputSumCountMemory2") var nextInputSumCount: Int = 0
    @AppStorage("sbjNextInputSumDenominateMemory2") var nextInputSumDenominate: Int = 0
    @AppStorage("sbjNextInputRbCountMemory2") var nextInputRbCount: Int = 0
    @AppStorage("sbjNextInputRedBbCountMemory2") var nextInputRedBbCount: Int = 0
    @AppStorage("sbjNextInputBlueBbCountMemory2") var nextInputBlueBbCount: Int = 0
    @AppStorage("sbjBonusSumMemory2") var bonusSum: Int = 0
    @AppStorage("sbjRioChanceCountMemory2") var rioChanceCount: Int = 0
    @AppStorage("sbjDiceLeftArrayKeyMemory2") var diceLeftArrayData: Data?
    @AppStorage("sbjDiceRightArrayKeyMemory2") var diceRightArrayData: Data?
    @AppStorage("sbjSuikaArrayKeyMemory2") var suikaArrayData: Data?
    @AppStorage("sbjMemoMemory2") var memo = ""
    @AppStorage("sbjDateMemory2") var dateDouble = 0.0
    // /////////////////////////
    // ver220で追加、通常チャンス目関連
    // /////////////////////////
    @AppStorage("sbjNormalChanceCountMemory2") var normalChanceCount = 0
    @AppStorage("sbjNormalChanceKokakuCountMemory2") var normalChanceKokakuCount = 0
    @AppStorage("sbjNormalChanceChokugekiCountMemory2") var normalChanceChokugekiCount = 0
}

// //// メモリー3
class SbjMemory3: ObservableObject {
    @AppStorage("sbjKokakuCountMemory3") var kokakuCount: Int = 0
    @AppStorage("sbjNextInputSumCountMemory3") var nextInputSumCount: Int = 0
    @AppStorage("sbjNextInputSumDenominateMemory3") var nextInputSumDenominate: Int = 0
    @AppStorage("sbjNextInputRbCountMemory3") var nextInputRbCount: Int = 0
    @AppStorage("sbjNextInputRedBbCountMemory3") var nextInputRedBbCount: Int = 0
    @AppStorage("sbjNextInputBlueBbCountMemory3") var nextInputBlueBbCount: Int = 0
    @AppStorage("sbjBonusSumMemory3") var bonusSum: Int = 0
    @AppStorage("sbjRioChanceCountMemory3") var rioChanceCount: Int = 0
    @AppStorage("sbjDiceLeftArrayKeyMemory3") var diceLeftArrayData: Data?
    @AppStorage("sbjDiceRightArrayKeyMemory3") var diceRightArrayData: Data?
    @AppStorage("sbjSuikaArrayKeyMemory3") var suikaArrayData: Data?
    @AppStorage("sbjMemoMemory3") var memo = ""
    @AppStorage("sbjDateMemory3") var dateDouble = 0.0
    // /////////////////////////
    // ver220で追加、通常チャンス目関連
    // /////////////////////////
    @AppStorage("sbjNormalChanceCountMemory3") var normalChanceCount = 0
    @AppStorage("sbjNormalChanceKokakuCountMemory3") var normalChanceKokakuCount = 0
    @AppStorage("sbjNormalChanceChokugekiCountMemory3") var normalChanceChokugekiCount = 0
}

