//
//  goeva2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Goeva2: ObservableObject {
    // -------
    // 通常時
    // -------
    // スイカ成立時のCZ当選率
    let ratioSuikaCz: [Double] = [21.9,23.4,25.0,28.1,29.7,31.3]
    @AppStorage("goeva2SuikaCount") var suikaCount: Int = 0
    @AppStorage("goeva2SuikaCzCount") var suikaCzCount: Int = 0

    // レア役からのボーナス当選率（設定1のみ判明）
    let ratioBonusNormalWeak: [Double] = [0.1,-1,-1,-1,-1,-1]
    let ratioBonusNormalStrong1: [Double] = [18.7,-1,-1,-1,-1,-1]
    let ratioBonusNormalStrong2: [Double] = [23.7,-1,-1,-1,-1,-1]
    let ratioBonusHighWeak: [Double] = [0.4,-1,-1,-1,-1,-1]
    let ratioBonusHighStrong1: [Double] = [38.2,-1,-1,-1,-1,-1]
    let ratioBonusHighStrong2: [Double] = [44.9,-1,-1,-1,-1,-1]
    let ratioBonusSuperWeak: [Double] = [14.1,-1,-1,-1,-1,-1]
    @AppStorage("goeva2BonusNormalWeakCount") var bonusNormalWeakCount: Int = 0
    @AppStorage("goeva2BonusNormalWeakCountHit") var bonusNormalWeakCountHit: Int = 0
    @AppStorage("goeva2BonusNormalStrong1Count") var bonusNormalStrong1Count: Int = 0
    @AppStorage("goeva2BonusNormalStrong1CountHit") var bonusNormalStrong1CountHit: Int = 0
    @AppStorage("goeva2BonusNormalStrong2Count") var bonusNormalStrong2Count: Int = 0
    @AppStorage("goeva2BonusNormalStrong2CountHit") var bonusNormalStrong2CountHit: Int = 0
    @AppStorage("goeva2BonusHighWeakCount") var bonusHighWeakCount: Int = 0
    @AppStorage("goeva2BonusHighWeakCountHit") var bonusHighWeakCountHit: Int = 0
    @AppStorage("goeva2BonusHighStrong1Count") var bonusHighStrong1Count: Int = 0
    @AppStorage("goeva2BonusHighStrong1CountHit") var bonusHighStrong1CountHit: Int = 0
    @AppStorage("goeva2BonusHighStrong2Count") var bonusHighStrong2Count: Int = 0
    @AppStorage("goeva2BonusHighStrong2CountHit") var bonusHighStrong2CountHit: Int = 0
    @AppStorage("goeva2BonusSuperWeakCount") var bonusSuperWeakCount: Int = 0
    @AppStorage("goeva2BonusSuperWeakCountHit") var bonusSuperWeakCountHit: Int = 0

    func resetNormal() {
        suikaCount = 0
        suikaCzCount = 0
        bonusNormalWeakCount = 0
        bonusNormalWeakCountHit = 0
        bonusNormalStrong1Count = 0
        bonusNormalStrong1CountHit = 0
        bonusNormalStrong2Count = 0
        bonusNormalStrong2CountHit = 0
        bonusHighWeakCount = 0
        bonusHighWeakCountHit = 0
        bonusHighStrong1Count = 0
        bonusHighStrong1CountHit = 0
        bonusHighStrong2Count = 0
        bonusHighStrong2CountHit = 0
        bonusSuperWeakCount = 0
        bonusSuperWeakCountHit = 0
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitBonus: [Double] = [234.2,229.0,221.8,207.0,201.5,195.0]
    let ratioFirstHitAt: [Double] = [460.5,446.5,425.5,390.4,374.2,355.5]
    // 選択肢
    let bonusKindList: [String] = ["エヴァンゲリオンボーナス", "ゴジラボーナス", "AT直撃"]
    let bonusKindShortList: [String] = ["エヴァ", "ゴジラ", "AT直撃"]   // 履歴表示用
    let atResultList: [String] = ["ハズレ", "当選"]
    // 選択結果
    @AppStorage("goeva2InputGame") var inputGame: Int = 0
    @AppStorage("goeva2SelectedBonusKind") var selectedBonusKind: String = "エヴァンゲリオンボーナス"
    @AppStorage("goeva2SelectedAtResult") var selectedAtResult: String = "ハズレ"

    // ゲーム数配列
    let gameArrayKey: String = "goeva2GameArrayKey"
    @AppStorage("goeva2GameArrayKey") var gameArrayData: Data?
    // ボーナス種類配列
    let bonusKindArrayKey: String = "goeva2BonusKindArrayKey"
    @AppStorage("goeva2BonusKindArrayKey") var bonusKindArrayData: Data?
    // AT当否配列
    let atResultArrayKey: String = "goeva2AtResultArrayKey"
    @AppStorage("goeva2AtResultArrayKey") var atResultArrayData: Data?

    // 履歴からの自動算出結果
    @AppStorage("goeva2PlayGameSum") var playGameSum: Int = 0
    @AppStorage("goeva2FirstHitCountBonus") var firstHitCountBonus: Int = 0
    @AppStorage("goeva2FirstHitCountAt") var firstHitCountAt: Int = 0

    // データ登録
    func addHistory() {
        // AT直撃は当選1択なのでピッカーの選択状態によらず当選で登録
        let atResult = selectedBonusKind == bonusKindList[2] ? atResultList[1] : selectedAtResult
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusKindArrayData, addData: selectedBonusKind, key: bonusKindArrayKey)
        arrayStringAddData(arrayData: atResultArrayData, addData: atResult, key: atResultArrayKey)
        addRemoveCommon()
    }
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: bonusKindArrayData, key: bonusKindArrayKey)
        arrayStringRemoveLast(arrayData: atResultArrayData, key: atResultArrayKey)
        addRemoveCommon()
    }
    func resetFirstHit() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: bonusKindArrayData, key: bonusKindArrayKey)
        arrayStringRemoveAll(arrayData: atResultArrayData, key: atResultArrayKey)
        addRemoveCommon()
        inputGame = 0
        minusCheck = false
    }
    func addRemoveCommon() {
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        // ボーナスはエヴァンゲリオンボーナスとゴジラボーナスの合算
        firstHitCountBonus = countSum(
            arrayStringDataCount(arrayData: bonusKindArrayData, countString: bonusKindList[0]),
            arrayStringDataCount(arrayData: bonusKindArrayData, countString: bonusKindList[1]),
        )
        firstHitCountAt = arrayStringDataCount(arrayData: atResultArrayData, countString: atResultList[1])
    }

    // 履歴表示用のボーナス種類名
    func bonusKindShortName(_ kind: String) -> String {
        guard let index = bonusKindList.firstIndex(of: kind) else { return kind }
        return bonusKindShortList[index]
    }

    // AT区間の先頭行かどうか（先頭行、または1つ前がAT当選）
    var atIntervalStartFlagList: [Bool] {
        let atArray = decodeStringArray(from: atResultArrayData)
        return atArray.indices.map { index in
            if index == 0 { return true }
            return atArray[index - 1] == atResultList[1]
        }
    }

    // --------
    // 終了画面
    // --------
    @AppStorage("goeva2ScreenCount1") var screenCount1: Int = 0
    @AppStorage("goeva2ScreenCount2") var screenCount2: Int = 0
    @AppStorage("goeva2ScreenCount3") var screenCount3: Int = 0
    @AppStorage("goeva2ScreenCount4") var screenCount4: Int = 0
    @AppStorage("goeva2ScreenCount5") var screenCount5: Int = 0
    @AppStorage("goeva2ScreenCount6") var screenCount6: Int = 0
    @AppStorage("goeva2ScreenCount7") var screenCount7: Int = 0
    @AppStorage("goeva2ScreenCount8") var screenCount8: Int = 0
    @AppStorage("goeva2ScreenCount9") var screenCount9: Int = 0
    @AppStorage("goeva2ScreenCount10") var screenCount10: Int = 0
    @AppStorage("goeva2ScreenCountSum") var screenCountSum: Int = 0

    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
            screenCount4,
            screenCount5,
            screenCount6,
            screenCount7,
            screenCount8,
            screenCount9,
            screenCount10,
        )
    }

    func resetScreen() {
        screenCount1 = 0
        screenCount2 = 0
        screenCount3 = 0
        screenCount4 = 0
        screenCount5 = 0
        screenCount6 = 0
        screenCount7 = 0
        screenCount8 = 0
        screenCount9 = 0
        screenCount10 = 0
        screenCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "ゴジラ対エヴァンゲリオン2"
    @AppStorage("goeva2MinusCheck") var minusCheck: Bool = false
    @AppStorage("goeva2SelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
    }
}


class Goeva2Memory1: ObservableObject {
    @AppStorage("goeva2MemoMemory1") var memo = ""
    @AppStorage("goeva2DateMemory1") var dateDouble = 0.0
}


class Goeva2Memory2: ObservableObject {
    @AppStorage("goeva2MemoMemory2") var memo = ""
    @AppStorage("goeva2DateMemory2") var dateDouble = 0.0
}


class Goeva2Memory3: ObservableObject {
    @AppStorage("goeva2MemoMemory3") var memo = ""
    @AppStorage("goeva2DateMemory3") var dateDouble = 0.0
}
