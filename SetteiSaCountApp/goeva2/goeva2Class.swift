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
    let bonusKindList: [String] = ["エヴァンゲリオン", "ゴジラ", "AT直撃", "その他"]
    let bonusKindShortList: [String] = ["エヴァ", "ゴジラ", "AT直撃", "その他"]   // 履歴表示用
    let atResultList: [String] = ["ハズレ", "当選"]
    // 選択結果
    @AppStorage("goeva2InputGame") var inputGame: Int = 0
    @AppStorage("goeva2SelectedBonusKind") var selectedBonusKind: String = "エヴァンゲリオン"
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

    // 入力方式（履歴入力／カウント入力）
    let firstHitInputModeList: [String] = ["履歴入力", "カウント入力"]
    @AppStorage("goeva2FirstHitInputMode") var firstHitInputMode: String = "履歴入力"
    // カウント入力用
    @AppStorage("goeva2ManualNormalGame") var manualNormalGame: Int = 0
    @AppStorage("goeva2ManualFirstHitCountEva") var manualFirstHitCountEva: Int = 0
    @AppStorage("goeva2ManualFirstHitCountGodzilla") var manualFirstHitCountGodzilla: Int = 0
    @AppStorage("goeva2ManualFirstHitCountAt") var manualFirstHitCountAt: Int = 0
    // カウント入力のボーナス合算（エヴァンゲリオンボーナス＋ゴジラボーナス）
    var manualFirstHitCountBonus: Int {
        get { manualFirstHitCountEva + manualFirstHitCountGodzilla }
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
    var activeFirstHitCountAt: Int {
        get { isHistoryInputMode ? firstHitCountAt : manualFirstHitCountAt }
        set { }
    }

    // 月蝕変異の発生率（通常ゲーム数は入力方式ごとの値を流用し、回数も入力方式ごとに別管理）
    let ratioGesshoku: [Double] = [5333,4367,3734,3156,2720,2399]
    @AppStorage("goeva2GesshokuCount") var gesshokuCount: Int = 0
    @AppStorage("goeva2ManualGesshokuCount") var manualGesshokuCount: Int = 0
    var activeGesshokuCount: Int {
        get { isHistoryInputMode ? gesshokuCount : manualGesshokuCount }
        set { }
    }

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
        manualNormalGame = 0
        manualFirstHitCountEva = 0
        manualFirstHitCountGodzilla = 0
        manualFirstHitCountAt = 0
        gesshokuCount = 0
        manualGesshokuCount = 0
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
    let ratioScreenNegate13: [Double] = [0,0.1,0,0.1,0.1,0.1,]
    let ratioScreenNegate24: [Double] = [0.1,0,0.1,0,0.1,0.1,]
    let ratioScreenOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioScreenOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioScreenOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioScreenOver6: [Double] = [0,0,0,0,0,0.1,]
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

    // -------
    // ボイス
    // -------
    let ratioVoiceOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioVoiceOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioVoiceOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioVoiceOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("goeva2VoiceCount1") var voiceCount1: Int = 0
    @AppStorage("goeva2VoiceCount2") var voiceCount2: Int = 0
    @AppStorage("goeva2VoiceCount3") var voiceCount3: Int = 0
    @AppStorage("goeva2VoiceCount4") var voiceCount4: Int = 0
    @AppStorage("goeva2VoiceCount5") var voiceCount5: Int = 0
    @AppStorage("goeva2VoiceCount6") var voiceCount6: Int = 0
    @AppStorage("goeva2VoiceCount7") var voiceCount7: Int = 0
    @AppStorage("goeva2VoiceCount8") var voiceCount8: Int = 0
    @AppStorage("goeva2VoiceCountSum") var voiceCountSum: Int = 0

    func voiceSumFunc() {
        voiceCountSum = countSum(
            voiceCount1,
            voiceCount2,
            voiceCount3,
            voiceCount4,
            voiceCount5,
            voiceCount6,
            voiceCount7,
            voiceCount8,
        )
    }

    func resetVoice() {
        voiceCount1 = 0
        voiceCount2 = 0
        voiceCount3 = 0
        voiceCount4 = 0
        voiceCount5 = 0
        voiceCount6 = 0
        voiceCount7 = 0
        voiceCount8 = 0
        voiceCountSum = 0
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
        resetVoice()
    }
}


class Goeva2Memory1: ObservableObject {
    @AppStorage("goeva2SuikaCountMemory1") var suikaCount: Int = 0
    @AppStorage("goeva2SuikaCzCountMemory1") var suikaCzCount: Int = 0
    @AppStorage("goeva2BonusNormalWeakCountMemory1") var bonusNormalWeakCount: Int = 0
    @AppStorage("goeva2BonusNormalWeakCountHitMemory1") var bonusNormalWeakCountHit: Int = 0
    @AppStorage("goeva2BonusNormalStrong1CountMemory1") var bonusNormalStrong1Count: Int = 0
    @AppStorage("goeva2BonusNormalStrong1CountHitMemory1") var bonusNormalStrong1CountHit: Int = 0
    @AppStorage("goeva2BonusNormalStrong2CountMemory1") var bonusNormalStrong2Count: Int = 0
    @AppStorage("goeva2BonusNormalStrong2CountHitMemory1") var bonusNormalStrong2CountHit: Int = 0
    @AppStorage("goeva2BonusHighWeakCountMemory1") var bonusHighWeakCount: Int = 0
    @AppStorage("goeva2BonusHighWeakCountHitMemory1") var bonusHighWeakCountHit: Int = 0
    @AppStorage("goeva2BonusHighStrong1CountMemory1") var bonusHighStrong1Count: Int = 0
    @AppStorage("goeva2BonusHighStrong1CountHitMemory1") var bonusHighStrong1CountHit: Int = 0
    @AppStorage("goeva2BonusHighStrong2CountMemory1") var bonusHighStrong2Count: Int = 0
    @AppStorage("goeva2BonusHighStrong2CountHitMemory1") var bonusHighStrong2CountHit: Int = 0
    @AppStorage("goeva2BonusSuperWeakCountMemory1") var bonusSuperWeakCount: Int = 0
    @AppStorage("goeva2BonusSuperWeakCountHitMemory1") var bonusSuperWeakCountHit: Int = 0
    @AppStorage("goeva2GameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("goeva2BonusKindArrayKeyMemory1") var bonusKindArrayData: Data?
    @AppStorage("goeva2AtResultArrayKeyMemory1") var atResultArrayData: Data?
    @AppStorage("goeva2PlayGameSumMemory1") var playGameSum: Int = 0
    @AppStorage("goeva2FirstHitCountBonusMemory1") var firstHitCountBonus: Int = 0
    @AppStorage("goeva2FirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("goeva2ScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("goeva2ScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("goeva2ScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("goeva2ScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("goeva2ScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("goeva2ScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("goeva2ScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("goeva2ScreenCount8Memory1") var screenCount8: Int = 0
    @AppStorage("goeva2ScreenCount9Memory1") var screenCount9: Int = 0
    @AppStorage("goeva2ScreenCount10Memory1") var screenCount10: Int = 0
    @AppStorage("goeva2ScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("goeva2FirstHitInputModeMemory1") var firstHitInputMode: String = "履歴入力"
    @AppStorage("goeva2ManualNormalGameMemory1") var manualNormalGame: Int = 0
    @AppStorage("goeva2ManualFirstHitCountEvaMemory1") var manualFirstHitCountEva: Int = 0
    @AppStorage("goeva2ManualFirstHitCountGodzillaMemory1") var manualFirstHitCountGodzilla: Int = 0
    @AppStorage("goeva2ManualFirstHitCountAtMemory1") var manualFirstHitCountAt: Int = 0
    @AppStorage("goeva2VoiceCount1Memory1") var voiceCount1: Int = 0
    @AppStorage("goeva2VoiceCount2Memory1") var voiceCount2: Int = 0
    @AppStorage("goeva2VoiceCount3Memory1") var voiceCount3: Int = 0
    @AppStorage("goeva2VoiceCount4Memory1") var voiceCount4: Int = 0
    @AppStorage("goeva2VoiceCount5Memory1") var voiceCount5: Int = 0
    @AppStorage("goeva2VoiceCount6Memory1") var voiceCount6: Int = 0
    @AppStorage("goeva2VoiceCount7Memory1") var voiceCount7: Int = 0
    @AppStorage("goeva2VoiceCount8Memory1") var voiceCount8: Int = 0
    @AppStorage("goeva2VoiceCountSumMemory1") var voiceCountSum: Int = 0
    @AppStorage("goeva2GesshokuCountMemory1") var gesshokuCount: Int = 0
    @AppStorage("goeva2ManualGesshokuCountMemory1") var manualGesshokuCount: Int = 0
    @AppStorage("goeva2MemoMemory1") var memo = ""
    @AppStorage("goeva2DateMemory1") var dateDouble = 0.0
}


class Goeva2Memory2: ObservableObject {
    @AppStorage("goeva2SuikaCountMemory2") var suikaCount: Int = 0
    @AppStorage("goeva2SuikaCzCountMemory2") var suikaCzCount: Int = 0
    @AppStorage("goeva2BonusNormalWeakCountMemory2") var bonusNormalWeakCount: Int = 0
    @AppStorage("goeva2BonusNormalWeakCountHitMemory2") var bonusNormalWeakCountHit: Int = 0
    @AppStorage("goeva2BonusNormalStrong1CountMemory2") var bonusNormalStrong1Count: Int = 0
    @AppStorage("goeva2BonusNormalStrong1CountHitMemory2") var bonusNormalStrong1CountHit: Int = 0
    @AppStorage("goeva2BonusNormalStrong2CountMemory2") var bonusNormalStrong2Count: Int = 0
    @AppStorage("goeva2BonusNormalStrong2CountHitMemory2") var bonusNormalStrong2CountHit: Int = 0
    @AppStorage("goeva2BonusHighWeakCountMemory2") var bonusHighWeakCount: Int = 0
    @AppStorage("goeva2BonusHighWeakCountHitMemory2") var bonusHighWeakCountHit: Int = 0
    @AppStorage("goeva2BonusHighStrong1CountMemory2") var bonusHighStrong1Count: Int = 0
    @AppStorage("goeva2BonusHighStrong1CountHitMemory2") var bonusHighStrong1CountHit: Int = 0
    @AppStorage("goeva2BonusHighStrong2CountMemory2") var bonusHighStrong2Count: Int = 0
    @AppStorage("goeva2BonusHighStrong2CountHitMemory2") var bonusHighStrong2CountHit: Int = 0
    @AppStorage("goeva2BonusSuperWeakCountMemory2") var bonusSuperWeakCount: Int = 0
    @AppStorage("goeva2BonusSuperWeakCountHitMemory2") var bonusSuperWeakCountHit: Int = 0
    @AppStorage("goeva2GameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("goeva2BonusKindArrayKeyMemory2") var bonusKindArrayData: Data?
    @AppStorage("goeva2AtResultArrayKeyMemory2") var atResultArrayData: Data?
    @AppStorage("goeva2PlayGameSumMemory2") var playGameSum: Int = 0
    @AppStorage("goeva2FirstHitCountBonusMemory2") var firstHitCountBonus: Int = 0
    @AppStorage("goeva2FirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("goeva2ScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("goeva2ScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("goeva2ScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("goeva2ScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("goeva2ScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("goeva2ScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("goeva2ScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("goeva2ScreenCount8Memory2") var screenCount8: Int = 0
    @AppStorage("goeva2ScreenCount9Memory2") var screenCount9: Int = 0
    @AppStorage("goeva2ScreenCount10Memory2") var screenCount10: Int = 0
    @AppStorage("goeva2ScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("goeva2FirstHitInputModeMemory2") var firstHitInputMode: String = "履歴入力"
    @AppStorage("goeva2ManualNormalGameMemory2") var manualNormalGame: Int = 0
    @AppStorage("goeva2ManualFirstHitCountEvaMemory2") var manualFirstHitCountEva: Int = 0
    @AppStorage("goeva2ManualFirstHitCountGodzillaMemory2") var manualFirstHitCountGodzilla: Int = 0
    @AppStorage("goeva2ManualFirstHitCountAtMemory2") var manualFirstHitCountAt: Int = 0
    @AppStorage("goeva2VoiceCount1Memory2") var voiceCount1: Int = 0
    @AppStorage("goeva2VoiceCount2Memory2") var voiceCount2: Int = 0
    @AppStorage("goeva2VoiceCount3Memory2") var voiceCount3: Int = 0
    @AppStorage("goeva2VoiceCount4Memory2") var voiceCount4: Int = 0
    @AppStorage("goeva2VoiceCount5Memory2") var voiceCount5: Int = 0
    @AppStorage("goeva2VoiceCount6Memory2") var voiceCount6: Int = 0
    @AppStorage("goeva2VoiceCount7Memory2") var voiceCount7: Int = 0
    @AppStorage("goeva2VoiceCount8Memory2") var voiceCount8: Int = 0
    @AppStorage("goeva2VoiceCountSumMemory2") var voiceCountSum: Int = 0
    @AppStorage("goeva2GesshokuCountMemory2") var gesshokuCount: Int = 0
    @AppStorage("goeva2ManualGesshokuCountMemory2") var manualGesshokuCount: Int = 0
    @AppStorage("goeva2MemoMemory2") var memo = ""
    @AppStorage("goeva2DateMemory2") var dateDouble = 0.0
}


class Goeva2Memory3: ObservableObject {
    @AppStorage("goeva2SuikaCountMemory3") var suikaCount: Int = 0
    @AppStorage("goeva2SuikaCzCountMemory3") var suikaCzCount: Int = 0
    @AppStorage("goeva2BonusNormalWeakCountMemory3") var bonusNormalWeakCount: Int = 0
    @AppStorage("goeva2BonusNormalWeakCountHitMemory3") var bonusNormalWeakCountHit: Int = 0
    @AppStorage("goeva2BonusNormalStrong1CountMemory3") var bonusNormalStrong1Count: Int = 0
    @AppStorage("goeva2BonusNormalStrong1CountHitMemory3") var bonusNormalStrong1CountHit: Int = 0
    @AppStorage("goeva2BonusNormalStrong2CountMemory3") var bonusNormalStrong2Count: Int = 0
    @AppStorage("goeva2BonusNormalStrong2CountHitMemory3") var bonusNormalStrong2CountHit: Int = 0
    @AppStorage("goeva2BonusHighWeakCountMemory3") var bonusHighWeakCount: Int = 0
    @AppStorage("goeva2BonusHighWeakCountHitMemory3") var bonusHighWeakCountHit: Int = 0
    @AppStorage("goeva2BonusHighStrong1CountMemory3") var bonusHighStrong1Count: Int = 0
    @AppStorage("goeva2BonusHighStrong1CountHitMemory3") var bonusHighStrong1CountHit: Int = 0
    @AppStorage("goeva2BonusHighStrong2CountMemory3") var bonusHighStrong2Count: Int = 0
    @AppStorage("goeva2BonusHighStrong2CountHitMemory3") var bonusHighStrong2CountHit: Int = 0
    @AppStorage("goeva2BonusSuperWeakCountMemory3") var bonusSuperWeakCount: Int = 0
    @AppStorage("goeva2BonusSuperWeakCountHitMemory3") var bonusSuperWeakCountHit: Int = 0
    @AppStorage("goeva2GameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("goeva2BonusKindArrayKeyMemory3") var bonusKindArrayData: Data?
    @AppStorage("goeva2AtResultArrayKeyMemory3") var atResultArrayData: Data?
    @AppStorage("goeva2PlayGameSumMemory3") var playGameSum: Int = 0
    @AppStorage("goeva2FirstHitCountBonusMemory3") var firstHitCountBonus: Int = 0
    @AppStorage("goeva2FirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("goeva2ScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("goeva2ScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("goeva2ScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("goeva2ScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("goeva2ScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("goeva2ScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("goeva2ScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("goeva2ScreenCount8Memory3") var screenCount8: Int = 0
    @AppStorage("goeva2ScreenCount9Memory3") var screenCount9: Int = 0
    @AppStorage("goeva2ScreenCount10Memory3") var screenCount10: Int = 0
    @AppStorage("goeva2ScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("goeva2FirstHitInputModeMemory3") var firstHitInputMode: String = "履歴入力"
    @AppStorage("goeva2ManualNormalGameMemory3") var manualNormalGame: Int = 0
    @AppStorage("goeva2ManualFirstHitCountEvaMemory3") var manualFirstHitCountEva: Int = 0
    @AppStorage("goeva2ManualFirstHitCountGodzillaMemory3") var manualFirstHitCountGodzilla: Int = 0
    @AppStorage("goeva2ManualFirstHitCountAtMemory3") var manualFirstHitCountAt: Int = 0
    @AppStorage("goeva2VoiceCount1Memory3") var voiceCount1: Int = 0
    @AppStorage("goeva2VoiceCount2Memory3") var voiceCount2: Int = 0
    @AppStorage("goeva2VoiceCount3Memory3") var voiceCount3: Int = 0
    @AppStorage("goeva2VoiceCount4Memory3") var voiceCount4: Int = 0
    @AppStorage("goeva2VoiceCount5Memory3") var voiceCount5: Int = 0
    @AppStorage("goeva2VoiceCount6Memory3") var voiceCount6: Int = 0
    @AppStorage("goeva2VoiceCount7Memory3") var voiceCount7: Int = 0
    @AppStorage("goeva2VoiceCount8Memory3") var voiceCount8: Int = 0
    @AppStorage("goeva2VoiceCountSumMemory3") var voiceCountSum: Int = 0
    @AppStorage("goeva2GesshokuCountMemory3") var gesshokuCount: Int = 0
    @AppStorage("goeva2ManualGesshokuCountMemory3") var manualGesshokuCount: Int = 0
    @AppStorage("goeva2MemoMemory3") var memo = ""
    @AppStorage("goeva2DateMemory3") var dateDouble = 0.0
}
