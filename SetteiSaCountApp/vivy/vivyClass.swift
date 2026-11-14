//
//  vivyClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Vivy: ObservableObject {
    // -------
    // 通常時
    // -------

    // アクセスチャンス昇格 継続回数
    // 突入時に昇格までの継続回数（1〜5回）を抽選。[回数][設定]
    let ratioAccelDistribution: [[Double]] = [
        [3.5,5.9,6.3,7.8,9.0,10.2],
        [1.6,10.2,1.6,10.2,5.1,10.5],
        [19.9,10.9,19.9,12.9,19.9,20.3],
        [25.0,25.0,25.0,25.0,25.0,25.0],
        [50.0,48.0,47.3,44.1,41.0,34.0],
    ]
    // その回まで昇格しなかった場合に、その回で昇格する確率（独自算出）。[回数][設定]
    // 5回目は全設定100%なので対象外
    var ratioAccelPromote: [[Double]] {
        (0..<4).map { step in
            (0..<6).map { setting in
                let remain = ratioAccelDistribution[step...].reduce(0.0) { $0 + $1[setting] }
                return remain > 0 ? ratioAccelDistribution[step][setting] / remain * 100 : 0
            }
        }
    }
    @AppStorage("vivyAccelPromoteCountMiss1") var accelPromoteCountMiss1: Int = 0
    @AppStorage("vivyAccelPromoteCountHit1") var accelPromoteCountHit1: Int = 0
    @AppStorage("vivyAccelPromoteCountSum1") var accelPromoteCountSum1: Int = 0
    @AppStorage("vivyAccelPromoteCountMiss2") var accelPromoteCountMiss2: Int = 0
    @AppStorage("vivyAccelPromoteCountHit2") var accelPromoteCountHit2: Int = 0
    @AppStorage("vivyAccelPromoteCountSum2") var accelPromoteCountSum2: Int = 0
    @AppStorage("vivyAccelPromoteCountMiss3") var accelPromoteCountMiss3: Int = 0
    @AppStorage("vivyAccelPromoteCountHit3") var accelPromoteCountHit3: Int = 0
    @AppStorage("vivyAccelPromoteCountSum3") var accelPromoteCountSum3: Int = 0
    @AppStorage("vivyAccelPromoteCountMiss4") var accelPromoteCountMiss4: Int = 0
    @AppStorage("vivyAccelPromoteCountHit4") var accelPromoteCountHit4: Int = 0
    @AppStorage("vivyAccelPromoteCountSum4") var accelPromoteCountSum4: Int = 0

    // 弱チェリー確率（状態別）。ゲーム数はその状態で消化したゲーム数を直接入力
    let ratioWeakCherryNormal: [Double] = [72.8,-1,-1,-1,-1,62.4]   // 通常時
    let ratioWeakCherryHigh2: [Double] = [23.6,-1,-1,-1,-1,22.4]   // 変換高確Lv2
    let ratioWeakCherryHigh3: [Double] = [13.9,-1,-1,-1,-1,13.5]   // 変換高確Lv3
    @AppStorage("vivyWeakCherryGameNormal") var weakCherryGameNormal: Int = 0
    @AppStorage("vivyWeakCherryCountNormal") var weakCherryCountNormal: Int = 0
    @AppStorage("vivyWeakCherryGameHigh2") var weakCherryGameHigh2: Int = 0
    @AppStorage("vivyWeakCherryCountHigh2") var weakCherryCountHigh2: Int = 0
    @AppStorage("vivyWeakCherryGameHigh3") var weakCherryGameHigh3: Int = 0
    @AppStorage("vivyWeakCherryCountHigh3") var weakCherryCountHigh3: Int = 0

    func accelPromoteSumFunc() {
        accelPromoteCountSum1 = accelPromoteCountHit1 + accelPromoteCountMiss1
        accelPromoteCountSum2 = accelPromoteCountHit2 + accelPromoteCountMiss2
        accelPromoteCountSum3 = accelPromoteCountHit3 + accelPromoteCountMiss3
        accelPromoteCountSum4 = accelPromoteCountHit4 + accelPromoteCountMiss4
    }

    func resetNormal() {
        weakCherryGameNormal = 0
        weakCherryCountNormal = 0
        weakCherryGameHigh2 = 0
        weakCherryCountHigh2 = 0
        weakCherryGameHigh3 = 0
        weakCherryCountHigh3 = 0
        accelPromoteCountMiss1 = 0
        accelPromoteCountHit1 = 0
        accelPromoteCountSum1 = 0
        accelPromoteCountMiss2 = 0
        accelPromoteCountHit2 = 0
        accelPromoteCountSum2 = 0
        accelPromoteCountMiss3 = 0
        accelPromoteCountHit3 = 0
        accelPromoteCountSum3 = 0
        accelPromoteCountMiss4 = 0
        accelPromoteCountHit4 = 0
        accelPromoteCountSum4 = 0
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitAt: [Double] = [276.5,251.7,272.1,222.8,235.9,210.3]
    // 登録の種類（周期到達とAT当選を同じ履歴に並べる）
    let entryKindList: [String] = ["周期到達", "AT当選"]
    @AppStorage("vivySelectedEntryKind") var selectedEntryKind: String = "周期到達"
    // 選択肢
    let cycleList: [String] = ["1周期", "2周期", "3周期", "4周期", "5周期", "6周期"]
    let pointList: [String] = ["111pt", "222pt", "333pt", "444pt", "555pt"]
    let triggerList: [String] = ["CZ", "直撃", "周期天井", "ゲーム数天井", "その他"]
    let atLabel: String = "AT"
    // 選択結果
    @AppStorage("vivyInputGame") var inputGame: Int = 0
    @AppStorage("vivySelectedCycle") var selectedCycle: String = "1周期"
    @AppStorage("vivySelectedPoint") var selectedPoint: String = "111pt"
    @AppStorage("vivySelectedTrigger") var selectedTrigger: String = "CZ"

    // 履歴（1行ごとに種類・ゲーム数・中央列・右列を持つ）
    // 周期到達の行：ゲーム数 0（表示は空欄）／中央＝周期数／右＝規定ポイント
    // AT当選の行：ゲーム数／中央＝AT／右＝当選契機
    let entryKindArrayKey: String = "vivyEntryKindArrayKey"
    @AppStorage("vivyEntryKindArrayKey") var entryKindArrayData: Data?
    let gameArrayKey: String = "vivyGameArrayKey"
    @AppStorage("vivyGameArrayKey") var gameArrayData: Data?
    let centerArrayKey: String = "vivyCenterArrayKey"
    @AppStorage("vivyCenterArrayKey") var centerArrayData: Data?
    let rightArrayKey: String = "vivyRightArrayKey"
    @AppStorage("vivyRightArrayKey") var rightArrayData: Data?

    // 履歴からの自動算出結果
    @AppStorage("vivyPlayGameSum") var playGameSum: Int = 0
    @AppStorage("vivyFirstHitCountAt") var firstHitCountAt: Int = 0

    // 入力方式（履歴入力／カウント入力）
    let firstHitInputModeList: [String] = ["履歴入力", "カウント入力"]
    @AppStorage("vivyFirstHitInputMode") var firstHitInputMode: String = "履歴入力"
    // カウント入力用
    @AppStorage("vivyManualNormalGame") var manualNormalGame: Int = 0
    @AppStorage("vivyManualFirstHitCountAt") var manualFirstHitCountAt: Int = 0
    // 確率算出・95Ci・設定期待値に使う値（選択中の入力方式の値を返す）
    var isHistoryInputMode: Bool {
        firstHitInputMode == firstHitInputModeList[0]
    }
    var isCycleEntry: Bool {
        selectedEntryKind == entryKindList[0]
    }
    var activeNormalGame: Int {
        get { isHistoryInputMode ? playGameSum : manualNormalGame }
        set { }
    }
    var activeFirstHitCountAt: Int {
        get { isHistoryInputMode ? firstHitCountAt : manualFirstHitCountAt }
        set { }
    }

    // データ登録
    func addHistory() {
        if isCycleEntry {
            arrayStringAddData(arrayData: entryKindArrayData, addData: entryKindList[0], key: entryKindArrayKey)
            arrayIntAddData(arrayData: gameArrayData, addData: 0, key: gameArrayKey)
            arrayStringAddData(arrayData: centerArrayData, addData: selectedCycle, key: centerArrayKey)
            arrayStringAddData(arrayData: rightArrayData, addData: selectedPoint, key: rightArrayKey)
        } else {
            arrayStringAddData(arrayData: entryKindArrayData, addData: entryKindList[1], key: entryKindArrayKey)
            arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
            arrayStringAddData(arrayData: centerArrayData, addData: atLabel, key: centerArrayKey)
            arrayStringAddData(arrayData: rightArrayData, addData: selectedTrigger, key: rightArrayKey)
        }
        addRemoveCommon()
    }
    // 1行削除
    func removeLastHistory() {
        arrayStringRemoveLast(arrayData: entryKindArrayData, key: entryKindArrayKey)
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: centerArrayData, key: centerArrayKey)
        arrayStringRemoveLast(arrayData: rightArrayData, key: rightArrayKey)
        addRemoveCommon()
    }
    func resetFirstHit() {
        arrayStringRemoveAll(arrayData: entryKindArrayData, key: entryKindArrayKey)
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: centerArrayData, key: centerArrayKey)
        arrayStringRemoveAll(arrayData: rightArrayData, key: rightArrayKey)
        addRemoveCommon()
        inputGame = 0
        manualNormalGame = 0
        manualFirstHitCountAt = 0
        minusCheck = false
    }
    func addRemoveCommon() {
        // ゲーム数はAT当選ごとにリセットされるので単純合計（周期到達の行は0）
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        firstHitCountAt = arrayStringDataCount(arrayData: entryKindArrayData, countString: entryKindList[1])
    }

    // AT区間の先頭行かどうか（先頭行、または1つ前がAT当選）
    var atIntervalStartFlagList: [Bool] {
        let kindArray = decodeStringArray(from: entryKindArrayData)
        return kindArray.indices.map { index in
            if index == 0 { return true }
            return kindArray[index - 1] == entryKindList[1]
        }
    }

    // --------
    // 終了画面
    // --------
    @AppStorage("vivyScreenCount1") var screenCount1: Int = 0
    @AppStorage("vivyScreenCount2") var screenCount2: Int = 0
    @AppStorage("vivyScreenCount3") var screenCount3: Int = 0
    @AppStorage("vivyScreenCount4") var screenCount4: Int = 0
    @AppStorage("vivyScreenCount5") var screenCount5: Int = 0
    @AppStorage("vivyScreenCount6") var screenCount6: Int = 0
    @AppStorage("vivyScreenCount7") var screenCount7: Int = 0
    @AppStorage("vivyScreenCount8") var screenCount8: Int = 0
    @AppStorage("vivyScreenCount9") var screenCount9: Int = 0
    @AppStorage("vivyScreenCountSum") var screenCountSum: Int = 0

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
        screenCountSum = 0
        minusCheck = false
    }

    // -------
    // ミニキャラ選択
    // -------
    let ratioChara1: [Double] = [16.7,16.6,16.5,16.5,16.5,16.5]   // ヴィヴィ
    let ratioChara2: [Double] = [16.7,24.8,14.5,14.4,14.4,14.4]   // エリザベス
    let ratioChara3: [Double] = [16.7,14.5,24.8,14.8,14.4,14.4]   // エステラ
    let ratioChara4: [Double] = [16.7,14.5,14.5,24.7,14.4,14.4]   // グレイス
    let ratioChara5: [Double] = [16.7,14.5,14.5,14.4,24.7,14.4]   // オフィーリア
    let ratioChara6: [Double] = [16.7,14.5,14.5,14.0,14.4,24.7]   // マツモト
    // 設定期待値用：設定ごとの合計が100%になるよう正規化した振分け（元の表は丸めで98.8〜100.2%）
    var ratioCharaNormalizedList: [[Double]] {
        let rawList = [ratioChara1, ratioChara2, ratioChara3, ratioChara4, ratioChara5, ratioChara6]
        return rawList.map { ratio in
            ratio.indices.map { setting in
                let total = rawList.reduce(0.0) { $0 + $1[setting] }
                return total > 0 ? ratio[setting] / total * 100 : 0
            }
        }
    }
    @AppStorage("vivyCharaCount1") var charaCount1: Int = 0
    @AppStorage("vivyCharaCount2") var charaCount2: Int = 0
    @AppStorage("vivyCharaCount3") var charaCount3: Int = 0
    @AppStorage("vivyCharaCount4") var charaCount4: Int = 0
    @AppStorage("vivyCharaCount5") var charaCount5: Int = 0
    @AppStorage("vivyCharaCount6") var charaCount6: Int = 0
    @AppStorage("vivyCharaCountSum") var charaCountSum: Int = 0

    func charaSumFunc() {
        charaCountSum = countSum(
            charaCount1,
            charaCount2,
            charaCount3,
            charaCount4,
            charaCount5,
            charaCount6,
        )
    }

    func resetChara() {
        charaCount1 = 0
        charaCount2 = 0
        charaCount3 = 0
        charaCount4 = 0
        charaCount5 = 0
        charaCount6 = 0
        charaCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "Vivy"
    @AppStorage("vivyMinusCheck") var minusCheck: Bool = false
    @AppStorage("vivySelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetChara()
    }
}


class VivyMemory1: ObservableObject {
    @AppStorage("vivyAccelPromoteCountMiss1Memory1") var accelPromoteCountMiss1: Int = 0
    @AppStorage("vivyAccelPromoteCountHit1Memory1") var accelPromoteCountHit1: Int = 0
    @AppStorage("vivyAccelPromoteCountSum1Memory1") var accelPromoteCountSum1: Int = 0
    @AppStorage("vivyAccelPromoteCountMiss2Memory1") var accelPromoteCountMiss2: Int = 0
    @AppStorage("vivyAccelPromoteCountHit2Memory1") var accelPromoteCountHit2: Int = 0
    @AppStorage("vivyAccelPromoteCountSum2Memory1") var accelPromoteCountSum2: Int = 0
    @AppStorage("vivyAccelPromoteCountMiss3Memory1") var accelPromoteCountMiss3: Int = 0
    @AppStorage("vivyAccelPromoteCountHit3Memory1") var accelPromoteCountHit3: Int = 0
    @AppStorage("vivyAccelPromoteCountSum3Memory1") var accelPromoteCountSum3: Int = 0
    @AppStorage("vivyAccelPromoteCountMiss4Memory1") var accelPromoteCountMiss4: Int = 0
    @AppStorage("vivyAccelPromoteCountHit4Memory1") var accelPromoteCountHit4: Int = 0
    @AppStorage("vivyAccelPromoteCountSum4Memory1") var accelPromoteCountSum4: Int = 0
    @AppStorage("vivyWeakCherryGameNormalMemory1") var weakCherryGameNormal: Int = 0
    @AppStorage("vivyWeakCherryCountNormalMemory1") var weakCherryCountNormal: Int = 0
    @AppStorage("vivyWeakCherryGameHigh2Memory1") var weakCherryGameHigh2: Int = 0
    @AppStorage("vivyWeakCherryCountHigh2Memory1") var weakCherryCountHigh2: Int = 0
    @AppStorage("vivyWeakCherryGameHigh3Memory1") var weakCherryGameHigh3: Int = 0
    @AppStorage("vivyWeakCherryCountHigh3Memory1") var weakCherryCountHigh3: Int = 0
    @AppStorage("vivyPlayGameSumMemory1") var playGameSum: Int = 0
    @AppStorage("vivyFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("vivyFirstHitInputModeMemory1") var firstHitInputMode: String = "履歴入力"
    @AppStorage("vivyManualNormalGameMemory1") var manualNormalGame: Int = 0
    @AppStorage("vivyManualFirstHitCountAtMemory1") var manualFirstHitCountAt: Int = 0
    @AppStorage("vivyScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("vivyScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("vivyScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("vivyScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("vivyScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("vivyScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("vivyScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("vivyScreenCount8Memory1") var screenCount8: Int = 0
    @AppStorage("vivyScreenCount9Memory1") var screenCount9: Int = 0
    @AppStorage("vivyScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("vivyCharaCount1Memory1") var charaCount1: Int = 0
    @AppStorage("vivyCharaCount2Memory1") var charaCount2: Int = 0
    @AppStorage("vivyCharaCount3Memory1") var charaCount3: Int = 0
    @AppStorage("vivyCharaCount4Memory1") var charaCount4: Int = 0
    @AppStorage("vivyCharaCount5Memory1") var charaCount5: Int = 0
    @AppStorage("vivyCharaCount6Memory1") var charaCount6: Int = 0
    @AppStorage("vivyCharaCountSumMemory1") var charaCountSum: Int = 0
    @AppStorage("vivyEntryKindArrayKeyMemory1") var entryKindArrayData: Data?
    @AppStorage("vivyGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("vivyCenterArrayKeyMemory1") var centerArrayData: Data?
    @AppStorage("vivyRightArrayKeyMemory1") var rightArrayData: Data?
    @AppStorage("vivyMemoMemory1") var memo = ""
    @AppStorage("vivyDateMemory1") var dateDouble = 0.0
}


class VivyMemory2: ObservableObject {
    @AppStorage("vivyAccelPromoteCountMiss1Memory2") var accelPromoteCountMiss1: Int = 0
    @AppStorage("vivyAccelPromoteCountHit1Memory2") var accelPromoteCountHit1: Int = 0
    @AppStorage("vivyAccelPromoteCountSum1Memory2") var accelPromoteCountSum1: Int = 0
    @AppStorage("vivyAccelPromoteCountMiss2Memory2") var accelPromoteCountMiss2: Int = 0
    @AppStorage("vivyAccelPromoteCountHit2Memory2") var accelPromoteCountHit2: Int = 0
    @AppStorage("vivyAccelPromoteCountSum2Memory2") var accelPromoteCountSum2: Int = 0
    @AppStorage("vivyAccelPromoteCountMiss3Memory2") var accelPromoteCountMiss3: Int = 0
    @AppStorage("vivyAccelPromoteCountHit3Memory2") var accelPromoteCountHit3: Int = 0
    @AppStorage("vivyAccelPromoteCountSum3Memory2") var accelPromoteCountSum3: Int = 0
    @AppStorage("vivyAccelPromoteCountMiss4Memory2") var accelPromoteCountMiss4: Int = 0
    @AppStorage("vivyAccelPromoteCountHit4Memory2") var accelPromoteCountHit4: Int = 0
    @AppStorage("vivyAccelPromoteCountSum4Memory2") var accelPromoteCountSum4: Int = 0
    @AppStorage("vivyWeakCherryGameNormalMemory2") var weakCherryGameNormal: Int = 0
    @AppStorage("vivyWeakCherryCountNormalMemory2") var weakCherryCountNormal: Int = 0
    @AppStorage("vivyWeakCherryGameHigh2Memory2") var weakCherryGameHigh2: Int = 0
    @AppStorage("vivyWeakCherryCountHigh2Memory2") var weakCherryCountHigh2: Int = 0
    @AppStorage("vivyWeakCherryGameHigh3Memory2") var weakCherryGameHigh3: Int = 0
    @AppStorage("vivyWeakCherryCountHigh3Memory2") var weakCherryCountHigh3: Int = 0
    @AppStorage("vivyPlayGameSumMemory2") var playGameSum: Int = 0
    @AppStorage("vivyFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("vivyFirstHitInputModeMemory2") var firstHitInputMode: String = "履歴入力"
    @AppStorage("vivyManualNormalGameMemory2") var manualNormalGame: Int = 0
    @AppStorage("vivyManualFirstHitCountAtMemory2") var manualFirstHitCountAt: Int = 0
    @AppStorage("vivyScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("vivyScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("vivyScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("vivyScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("vivyScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("vivyScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("vivyScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("vivyScreenCount8Memory2") var screenCount8: Int = 0
    @AppStorage("vivyScreenCount9Memory2") var screenCount9: Int = 0
    @AppStorage("vivyScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("vivyCharaCount1Memory2") var charaCount1: Int = 0
    @AppStorage("vivyCharaCount2Memory2") var charaCount2: Int = 0
    @AppStorage("vivyCharaCount3Memory2") var charaCount3: Int = 0
    @AppStorage("vivyCharaCount4Memory2") var charaCount4: Int = 0
    @AppStorage("vivyCharaCount5Memory2") var charaCount5: Int = 0
    @AppStorage("vivyCharaCount6Memory2") var charaCount6: Int = 0
    @AppStorage("vivyCharaCountSumMemory2") var charaCountSum: Int = 0
    @AppStorage("vivyEntryKindArrayKeyMemory2") var entryKindArrayData: Data?
    @AppStorage("vivyGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("vivyCenterArrayKeyMemory2") var centerArrayData: Data?
    @AppStorage("vivyRightArrayKeyMemory2") var rightArrayData: Data?
    @AppStorage("vivyMemoMemory2") var memo = ""
    @AppStorage("vivyDateMemory2") var dateDouble = 0.0
}


class VivyMemory3: ObservableObject {
    @AppStorage("vivyAccelPromoteCountMiss1Memory3") var accelPromoteCountMiss1: Int = 0
    @AppStorage("vivyAccelPromoteCountHit1Memory3") var accelPromoteCountHit1: Int = 0
    @AppStorage("vivyAccelPromoteCountSum1Memory3") var accelPromoteCountSum1: Int = 0
    @AppStorage("vivyAccelPromoteCountMiss2Memory3") var accelPromoteCountMiss2: Int = 0
    @AppStorage("vivyAccelPromoteCountHit2Memory3") var accelPromoteCountHit2: Int = 0
    @AppStorage("vivyAccelPromoteCountSum2Memory3") var accelPromoteCountSum2: Int = 0
    @AppStorage("vivyAccelPromoteCountMiss3Memory3") var accelPromoteCountMiss3: Int = 0
    @AppStorage("vivyAccelPromoteCountHit3Memory3") var accelPromoteCountHit3: Int = 0
    @AppStorage("vivyAccelPromoteCountSum3Memory3") var accelPromoteCountSum3: Int = 0
    @AppStorage("vivyAccelPromoteCountMiss4Memory3") var accelPromoteCountMiss4: Int = 0
    @AppStorage("vivyAccelPromoteCountHit4Memory3") var accelPromoteCountHit4: Int = 0
    @AppStorage("vivyAccelPromoteCountSum4Memory3") var accelPromoteCountSum4: Int = 0
    @AppStorage("vivyWeakCherryGameNormalMemory3") var weakCherryGameNormal: Int = 0
    @AppStorage("vivyWeakCherryCountNormalMemory3") var weakCherryCountNormal: Int = 0
    @AppStorage("vivyWeakCherryGameHigh2Memory3") var weakCherryGameHigh2: Int = 0
    @AppStorage("vivyWeakCherryCountHigh2Memory3") var weakCherryCountHigh2: Int = 0
    @AppStorage("vivyWeakCherryGameHigh3Memory3") var weakCherryGameHigh3: Int = 0
    @AppStorage("vivyWeakCherryCountHigh3Memory3") var weakCherryCountHigh3: Int = 0
    @AppStorage("vivyPlayGameSumMemory3") var playGameSum: Int = 0
    @AppStorage("vivyFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("vivyFirstHitInputModeMemory3") var firstHitInputMode: String = "履歴入力"
    @AppStorage("vivyManualNormalGameMemory3") var manualNormalGame: Int = 0
    @AppStorage("vivyManualFirstHitCountAtMemory3") var manualFirstHitCountAt: Int = 0
    @AppStorage("vivyScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("vivyScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("vivyScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("vivyScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("vivyScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("vivyScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("vivyScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("vivyScreenCount8Memory3") var screenCount8: Int = 0
    @AppStorage("vivyScreenCount9Memory3") var screenCount9: Int = 0
    @AppStorage("vivyScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("vivyCharaCount1Memory3") var charaCount1: Int = 0
    @AppStorage("vivyCharaCount2Memory3") var charaCount2: Int = 0
    @AppStorage("vivyCharaCount3Memory3") var charaCount3: Int = 0
    @AppStorage("vivyCharaCount4Memory3") var charaCount4: Int = 0
    @AppStorage("vivyCharaCount5Memory3") var charaCount5: Int = 0
    @AppStorage("vivyCharaCount6Memory3") var charaCount6: Int = 0
    @AppStorage("vivyCharaCountSumMemory3") var charaCountSum: Int = 0
    @AppStorage("vivyEntryKindArrayKeyMemory3") var entryKindArrayData: Data?
    @AppStorage("vivyGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("vivyCenterArrayKeyMemory3") var centerArrayData: Data?
    @AppStorage("vivyRightArrayKeyMemory3") var rightArrayData: Data?
    @AppStorage("vivyMemoMemory3") var memo = ""
    @AppStorage("vivyDateMemory3") var dateDouble = 0.0
}
