//
//  dmc5Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/01.
//

import Foundation
import SwiftUI

class Dmc5: ObservableObject {
    // ////////////
    // 初当り
    // ////////////
    let ratioFirstHitBonus: [Double] = [257,254.1,251.5,222.6,217.3,204.1]
    let ratioFirstHitSt: [Double] = [445.4,436.5,411.2,359.6,329.5,303.9]
    @AppStorage("dmc5NormalGame") var normalGame: Int = 0
    @AppStorage("dmc5BonusCount") var bonusCount: Int = 0
    @AppStorage("dmc5StCount") var stCount: Int = 0
    
//    func resetFirstHit() {
//        normalGame = 0
//        bonusCount = 0
//        stCount = 0
//        minusCheck = false
//    }
    
    // ///////////////
    // 終了画面
    // ///////////////
    @AppStorage("dmc5ScreenCountDefault") var screenCountDefault: Int = 0
    @AppStorage("dmc5ScreenCountKisu") var screenCountKisu: Int = 0
    @AppStorage("dmc5ScreenCountGusu") var screenCountGusu: Int = 0
    @AppStorage("dmc5ScreenCountHighJaku") var screenCountHighJaku: Int = 0
    @AppStorage("dmc5ScreenCountHighKyo") var screenCountHighKyo: Int = 0
    @AppStorage("dmc5ScreenCountNegate3") var screenCountNegate3: Int = 0
    @AppStorage("dmc5ScreenCountNegate2") var screenCountNegate2: Int = 0
    @AppStorage("dmc5ScreenCountNegate1") var screenCountNegate1: Int = 0
    @AppStorage("dmc5ScreenCountOver4") var screenCountOver4: Int = 0
    @AppStorage("dmc5ScreenCountOver5") var screenCountOver5: Int = 0
    @AppStorage("dmc5ScreenCountOver6") var screenCountOver6: Int = 0
    @AppStorage("dmc5ScreenCountSum") var screenCountSum: Int = 0
    
    func screenCountSumFunc() {
        screenCountSum = countSum(
            screenCountDefault,
            screenCountKisu,
            screenCountGusu,
            screenCountHighJaku,
            screenCountHighKyo,
            screenCountNegate3,
            screenCountNegate2,
            screenCountNegate1,
            screenCountOver4,
            screenCountOver5,
            screenCountOver6
        )
    }
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountKisu = 0
        screenCountGusu = 0
        screenCountHighJaku = 0
        screenCountHighKyo = 0
        screenCountNegate3 = 0
        screenCountNegate2 = 0
        screenCountNegate1 = 0
        screenCountOver4 = 0
        screenCountOver5 = 0
        screenCountOver6 = 0
        screenCountSumFunc()
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "Devil May Cry 5"
    @AppStorage("dmc5MinusCheck") var minusCheck: Bool = false
    @AppStorage("dmc5SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
//        resetFirstHit()
        resetScreen()
        resetHistory()
    }
    
    // //////////////////
    // ver3.4.0で追加
    // 初当り履歴
    // //////////////////
    // 選択肢の設定
    let selectListBonusKind: [String] = ["DMC", "エピソード"]
    let selectListTrigger: [String] = ["CZ", "ゲーム数", "直撃", "天井", "その他"]
    let selectListStHit: [String] = ["当選", "ハズレ"]
    
    // 選択結果
    @AppStorage("dmc5SelectedBonusKind") var selectedBonusKind: String = "DMC"
    @AppStorage("dmc5SelectedTrigger") var selectedTrigger: String = "CZ"
    @AppStorage("dmc5SelectedStHit") var selectedStHit: String = "当選"
    @AppStorage("dmc5InputGame") var inputGame: Int = 0
    
    // ゲーム数配列
    let gameArrayKey: String = "dmc5GameArrayKey"
    @AppStorage("dmc5GameArrayKey") var gameArrayData: Data?
    // 種類配列
    let bonusKindArrayKey: String = "dmc5BonusKindArrayKey"
    @AppStorage("dmc5BonusKindArrayKey") var bonusKindArrayData: Data?
    // 当選契機配列
    let triggerArrayKey: String = "dmc5TriggerArrayKey"
    @AppStorage("dmc5TriggerArrayKey") var triggerArrayData: Data?
    // ST結果配列
    let stHitArrayKey: String = "dmc5StHitArrayKey"
    @AppStorage("dmc5StHitArrayKey") var stHitArrayData: Data?
    
    // データ登録
    func addHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusKindArrayData, addData: selectedBonusKind, key: bonusKindArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedTrigger, key: triggerArrayKey)
        arrayStringAddData(arrayData: stHitArrayData, addData: selectedStHit, key: stHitArrayKey)
        addRemoveCommon()
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: bonusKindArrayData, key: bonusKindArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveLast(arrayData: stHitArrayData, key: stHitArrayKey)
        addRemoveCommon()
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: bonusKindArrayData, key: bonusKindArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveAll(arrayData: stHitArrayData, key: stHitArrayKey)
        addRemoveCommon()
        inputGame = 0
        minusCheck = false
    }
    
    func addRemoveCommon() {
        normalGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: stHitArrayData, resetWord: selectListStHit[0])
        bonusCount = arrayStringAllDataCount(arrayData: bonusKindArrayData)
        stCount = arrayStringDataCount(arrayData: stHitArrayData, countString: selectListStHit[0])
    }
}


// //// メモリー1
class Dmc5Memory1: ObservableObject {
    @AppStorage("dmc5NormalGameMemory1") var normalGame: Int = 0
    @AppStorage("dmc5BonusCountMemory1") var bonusCount: Int = 0
    @AppStorage("dmc5StCountMemory1") var stCount: Int = 0
    @AppStorage("dmc5ScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("dmc5ScreenCountKisuMemory1") var screenCountKisu: Int = 0
    @AppStorage("dmc5ScreenCountGusuMemory1") var screenCountGusu: Int = 0
    @AppStorage("dmc5ScreenCountHighJakuMemory1") var screenCountHighJaku: Int = 0
    @AppStorage("dmc5ScreenCountHighKyoMemory1") var screenCountHighKyo: Int = 0
    @AppStorage("dmc5ScreenCountNegate3Memory1") var screenCountNegate3: Int = 0
    @AppStorage("dmc5ScreenCountNegate2Memory1") var screenCountNegate2: Int = 0
    @AppStorage("dmc5ScreenCountNegate1Memory1") var screenCountNegate1: Int = 0
    @AppStorage("dmc5ScreenCountOver4Memory1") var screenCountOver4: Int = 0
    @AppStorage("dmc5ScreenCountOver5Memory1") var screenCountOver5: Int = 0
    @AppStorage("dmc5ScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("dmc5ScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("dmc5MemoMemory1") var memo = ""
    @AppStorage("dmc5DateMemory1") var dateDouble = 0.0
    
    // //////////////////
    // ver3.4.0で追加
    // 初当り履歴
    // //////////////////
    // 選択肢の設定
    @AppStorage("dmc5GameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("dmc5BonusKindArrayKeyMemory1") var bonusKindArrayData: Data?
    @AppStorage("dmc5TriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("dmc5StHitArrayKeyMemory1") var stHitArrayData: Data?
}


// //// メモリー2
class Dmc5Memory2: ObservableObject {
    @AppStorage("dmc5NormalGameMemory2") var normalGame: Int = 0
    @AppStorage("dmc5BonusCountMemory2") var bonusCount: Int = 0
    @AppStorage("dmc5StCountMemory2") var stCount: Int = 0
    @AppStorage("dmc5ScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("dmc5ScreenCountKisuMemory2") var screenCountKisu: Int = 0
    @AppStorage("dmc5ScreenCountGusuMemory2") var screenCountGusu: Int = 0
    @AppStorage("dmc5ScreenCountHighJakuMemory2") var screenCountHighJaku: Int = 0
    @AppStorage("dmc5ScreenCountHighKyoMemory2") var screenCountHighKyo: Int = 0
    @AppStorage("dmc5ScreenCountNegate3Memory2") var screenCountNegate3: Int = 0
    @AppStorage("dmc5ScreenCountNegate2Memory2") var screenCountNegate2: Int = 0
    @AppStorage("dmc5ScreenCountNegate1Memory2") var screenCountNegate1: Int = 0
    @AppStorage("dmc5ScreenCountOver4Memory2") var screenCountOver4: Int = 0
    @AppStorage("dmc5ScreenCountOver5Memory2") var screenCountOver5: Int = 0
    @AppStorage("dmc5ScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("dmc5ScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("dmc5MemoMemory2") var memo = ""
    @AppStorage("dmc5DateMemory2") var dateDouble = 0.0
    
    // //////////////////
    // ver3.4.0で追加
    // 初当り履歴
    // //////////////////
    // 選択肢の設定
    @AppStorage("dmc5GameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("dmc5BonusKindArrayKeyMemory2") var bonusKindArrayData: Data?
    @AppStorage("dmc5TriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("dmc5StHitArrayKeyMemory2") var stHitArrayData: Data?
}


// //// メモリー3
class Dmc5Memory3: ObservableObject {
    @AppStorage("dmc5NormalGameMemory3") var normalGame: Int = 0
    @AppStorage("dmc5BonusCountMemory3") var bonusCount: Int = 0
    @AppStorage("dmc5StCountMemory3") var stCount: Int = 0
    @AppStorage("dmc5ScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("dmc5ScreenCountKisuMemory3") var screenCountKisu: Int = 0
    @AppStorage("dmc5ScreenCountGusuMemory3") var screenCountGusu: Int = 0
    @AppStorage("dmc5ScreenCountHighJakuMemory3") var screenCountHighJaku: Int = 0
    @AppStorage("dmc5ScreenCountHighKyoMemory3") var screenCountHighKyo: Int = 0
    @AppStorage("dmc5ScreenCountNegate3Memory3") var screenCountNegate3: Int = 0
    @AppStorage("dmc5ScreenCountNegate2Memory3") var screenCountNegate2: Int = 0
    @AppStorage("dmc5ScreenCountNegate1Memory3") var screenCountNegate1: Int = 0
    @AppStorage("dmc5ScreenCountOver4Memory3") var screenCountOver4: Int = 0
    @AppStorage("dmc5ScreenCountOver5Memory3") var screenCountOver5: Int = 0
    @AppStorage("dmc5ScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("dmc5ScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("dmc5MemoMemory3") var memo = ""
    @AppStorage("dmc5DateMemory3") var dateDouble = 0.0
    
    // //////////////////
    // ver3.4.0で追加
    // 初当り履歴
    // //////////////////
    // 選択肢の設定
    @AppStorage("dmc5GameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("dmc5BonusKindArrayKeyMemory3") var bonusKindArrayData: Data?
    @AppStorage("dmc5TriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("dmc5StHitArrayKeyMemory3") var stHitArrayData: Data?
}
