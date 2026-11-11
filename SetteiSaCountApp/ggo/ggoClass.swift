//
//  ggoClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Ggo: ObservableObject {
    // -------
    // 通常時
    // -------
    // 天国選択率
    let ratioModeHeaven: [Double] = [21.9,23.0,24.6,28.1,31.3,31.6]
    @AppStorage("ggoModeHeavenCountMiss") var modeHeavenCountMiss: Int = 0
    @AppStorage("ggoModeHeavenCountHit") var modeHeavenCountHit: Int = 0
    @AppStorage("ggoModeHeavenCountSum") var modeHeavenCountSum: Int = 0

    func modeHeavenSumFunc() {
        modeHeavenCountSum = modeHeavenCountHit + modeHeavenCountMiss
    }

    func resetNormal() {
        modeHeavenCountMiss = 0
        modeHeavenCountHit = 0
        modeHeavenCountSum = 0
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitBonus: [Double] = [192.0,189.2,180.9,168.6,155.4,153.9]
    let ratioFirstHitSt: [Double] = [521.7,510.4,486.6,445.3,405.0,392.6]
    // 選択肢
    let bonusKindList: [String] = ["BIG", "REG", "エピソード", "直撃", "その他"]
    let stResultList: [String] = ["ハズレ", "当選"]
    // 選択結果
    @AppStorage("ggoInputGame") var inputGame: Int = 0
    @AppStorage("ggoSelectedBonusKind") var selectedBonusKind: String = "BIG"
    @AppStorage("ggoSelectedStResult") var selectedStResult: String = "ハズレ"

    // ゲーム数配列
    let gameArrayKey: String = "ggoGameArrayKey"
    @AppStorage("ggoGameArrayKey") var gameArrayData: Data?
    // ボーナス種類配列
    let bonusKindArrayKey: String = "ggoBonusKindArrayKey"
    @AppStorage("ggoBonusKindArrayKey") var bonusKindArrayData: Data?
    // ST当否配列
    let stResultArrayKey: String = "ggoStResultArrayKey"
    @AppStorage("ggoStResultArrayKey") var stResultArrayData: Data?

    // 履歴からの自動算出結果
    @AppStorage("ggoPlayGameSum") var playGameSum: Int = 0
    @AppStorage("ggoFirstHitCountBonus") var firstHitCountBonus: Int = 0
    @AppStorage("ggoFirstHitCountSt") var firstHitCountSt: Int = 0

    // 入力方式（履歴入力／カウント入力）
    let firstHitInputModeList: [String] = ["履歴入力", "カウント入力"]
    @AppStorage("ggoFirstHitInputMode") var firstHitInputMode: String = "履歴入力"
    // カウント入力用
    @AppStorage("ggoManualNormalGame") var manualNormalGame: Int = 0
    @AppStorage("ggoManualFirstHitCountBig") var manualFirstHitCountBig: Int = 0
    @AppStorage("ggoManualFirstHitCountReg") var manualFirstHitCountReg: Int = 0
    @AppStorage("ggoManualFirstHitCountEpisode") var manualFirstHitCountEpisode: Int = 0
    @AppStorage("ggoManualFirstHitCountSt") var manualFirstHitCountSt: Int = 0
    // カウント入力のボーナス合算（BIG＋REG＋エピソード）
    var manualFirstHitCountBonus: Int {
        get { manualFirstHitCountBig + manualFirstHitCountReg + manualFirstHitCountEpisode }
        set { }
    }
    // 確率算出・95Ci・設定期待値に使う値（選択中の入力方式の値を返す）
    var isHistoryInputMode: Bool {
        firstHitInputMode == firstHitInputModeList[0]
    }
    var activeNormalGame: Int {
        get { isHistoryInputMode ? playGameSum : manualNormalGame }
        set { }
    }
    var activeFirstHitCountBonus: Int {
        get { isHistoryInputMode ? firstHitCountBonus : manualFirstHitCountBonus }
        set { }
    }
    var activeFirstHitCountSt: Int {
        get { isHistoryInputMode ? firstHitCountSt : manualFirstHitCountSt }
        set { }
    }

    // データ登録
    func addHistory() {
        // 直撃は当選1択なのでピッカーの選択状態によらず当選で登録
        let stResult = selectedBonusKind == bonusKindList[3] ? stResultList[1] : selectedStResult
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusKindArrayData, addData: selectedBonusKind, key: bonusKindArrayKey)
        arrayStringAddData(arrayData: stResultArrayData, addData: stResult, key: stResultArrayKey)
        addRemoveCommon()
    }
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: bonusKindArrayData, key: bonusKindArrayKey)
        arrayStringRemoveLast(arrayData: stResultArrayData, key: stResultArrayKey)
        addRemoveCommon()
    }
    func resetFirstHit() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: bonusKindArrayData, key: bonusKindArrayKey)
        arrayStringRemoveAll(arrayData: stResultArrayData, key: stResultArrayKey)
        addRemoveCommon()
        inputGame = 0
        manualNormalGame = 0
        manualFirstHitCountBig = 0
        manualFirstHitCountReg = 0
        manualFirstHitCountEpisode = 0
        manualFirstHitCountSt = 0
        minusCheck = false
    }
    func addRemoveCommon() {
        // ゲーム数は初当りごとにリセットされるので単純合計
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        // ボーナスはBIG＋REG＋エピソードの合算
        firstHitCountBonus = countSum(
            arrayStringDataCount(arrayData: bonusKindArrayData, countString: bonusKindList[0]),
            arrayStringDataCount(arrayData: bonusKindArrayData, countString: bonusKindList[1]),
            arrayStringDataCount(arrayData: bonusKindArrayData, countString: bonusKindList[2]),
        )
        firstHitCountSt = arrayStringDataCount(arrayData: stResultArrayData, countString: stResultList[1])
    }

    // ST区間の先頭行かどうか（先頭行、または1つ前がST当選）
    var stIntervalStartFlagList: [Bool] {
        let stArray = decodeStringArray(from: stResultArrayData)
        return stArray.indices.map { index in
            if index == 0 { return true }
            return stArray[index - 1] == stResultList[1]
        }
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "ソードアート・オンライン オルタナティブ ガンゲイル・オンライン"
    @AppStorage("ggoMinusCheck") var minusCheck: Bool = false
    @AppStorage("ggoSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class GgoMemory1: ObservableObject {
    @AppStorage("ggoModeHeavenCountMissMemory1") var modeHeavenCountMiss: Int = 0
    @AppStorage("ggoModeHeavenCountHitMemory1") var modeHeavenCountHit: Int = 0
    @AppStorage("ggoModeHeavenCountSumMemory1") var modeHeavenCountSum: Int = 0
    @AppStorage("ggoPlayGameSumMemory1") var playGameSum: Int = 0
    @AppStorage("ggoFirstHitCountBonusMemory1") var firstHitCountBonus: Int = 0
    @AppStorage("ggoFirstHitCountStMemory1") var firstHitCountSt: Int = 0
    @AppStorage("ggoFirstHitInputModeMemory1") var firstHitInputMode: String = "履歴入力"
    @AppStorage("ggoManualNormalGameMemory1") var manualNormalGame: Int = 0
    @AppStorage("ggoManualFirstHitCountBigMemory1") var manualFirstHitCountBig: Int = 0
    @AppStorage("ggoManualFirstHitCountRegMemory1") var manualFirstHitCountReg: Int = 0
    @AppStorage("ggoManualFirstHitCountEpisodeMemory1") var manualFirstHitCountEpisode: Int = 0
    @AppStorage("ggoManualFirstHitCountStMemory1") var manualFirstHitCountSt: Int = 0
    @AppStorage("ggoGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("ggoBonusKindArrayKeyMemory1") var bonusKindArrayData: Data?
    @AppStorage("ggoStResultArrayKeyMemory1") var stResultArrayData: Data?
    @AppStorage("ggoMemoMemory1") var memo = ""
    @AppStorage("ggoDateMemory1") var dateDouble = 0.0
}


class GgoMemory2: ObservableObject {
    @AppStorage("ggoModeHeavenCountMissMemory2") var modeHeavenCountMiss: Int = 0
    @AppStorage("ggoModeHeavenCountHitMemory2") var modeHeavenCountHit: Int = 0
    @AppStorage("ggoModeHeavenCountSumMemory2") var modeHeavenCountSum: Int = 0
    @AppStorage("ggoPlayGameSumMemory2") var playGameSum: Int = 0
    @AppStorage("ggoFirstHitCountBonusMemory2") var firstHitCountBonus: Int = 0
    @AppStorage("ggoFirstHitCountStMemory2") var firstHitCountSt: Int = 0
    @AppStorage("ggoFirstHitInputModeMemory2") var firstHitInputMode: String = "履歴入力"
    @AppStorage("ggoManualNormalGameMemory2") var manualNormalGame: Int = 0
    @AppStorage("ggoManualFirstHitCountBigMemory2") var manualFirstHitCountBig: Int = 0
    @AppStorage("ggoManualFirstHitCountRegMemory2") var manualFirstHitCountReg: Int = 0
    @AppStorage("ggoManualFirstHitCountEpisodeMemory2") var manualFirstHitCountEpisode: Int = 0
    @AppStorage("ggoManualFirstHitCountStMemory2") var manualFirstHitCountSt: Int = 0
    @AppStorage("ggoGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("ggoBonusKindArrayKeyMemory2") var bonusKindArrayData: Data?
    @AppStorage("ggoStResultArrayKeyMemory2") var stResultArrayData: Data?
    @AppStorage("ggoMemoMemory2") var memo = ""
    @AppStorage("ggoDateMemory2") var dateDouble = 0.0
}


class GgoMemory3: ObservableObject {
    @AppStorage("ggoModeHeavenCountMissMemory3") var modeHeavenCountMiss: Int = 0
    @AppStorage("ggoModeHeavenCountHitMemory3") var modeHeavenCountHit: Int = 0
    @AppStorage("ggoModeHeavenCountSumMemory3") var modeHeavenCountSum: Int = 0
    @AppStorage("ggoPlayGameSumMemory3") var playGameSum: Int = 0
    @AppStorage("ggoFirstHitCountBonusMemory3") var firstHitCountBonus: Int = 0
    @AppStorage("ggoFirstHitCountStMemory3") var firstHitCountSt: Int = 0
    @AppStorage("ggoFirstHitInputModeMemory3") var firstHitInputMode: String = "履歴入力"
    @AppStorage("ggoManualNormalGameMemory3") var manualNormalGame: Int = 0
    @AppStorage("ggoManualFirstHitCountBigMemory3") var manualFirstHitCountBig: Int = 0
    @AppStorage("ggoManualFirstHitCountRegMemory3") var manualFirstHitCountReg: Int = 0
    @AppStorage("ggoManualFirstHitCountEpisodeMemory3") var manualFirstHitCountEpisode: Int = 0
    @AppStorage("ggoManualFirstHitCountStMemory3") var manualFirstHitCountSt: Int = 0
    @AppStorage("ggoGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("ggoBonusKindArrayKeyMemory3") var bonusKindArrayData: Data?
    @AppStorage("ggoStResultArrayKeyMemory3") var stResultArrayData: Data?
    @AppStorage("ggoMemoMemory3") var memo = ""
    @AppStorage("ggoDateMemory3") var dateDouble = 0.0
}
