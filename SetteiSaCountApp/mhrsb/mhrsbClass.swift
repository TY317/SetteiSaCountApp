//
//  mhrsbClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Mhrsb: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitBz: [Double] = [111.4,108.8,105.6,99.3,97.2,95.8]
    let ratioFirstHitFukubiki: [Double] = [2290.1,2090.4,1821.1,1472.5,1219.3,976.4]
    let ratioFirstHitAt: [Double] = [349.9,337.0,319.8,283.6,264.0,242.3]
    // 猛焔一閃直撃の実質確率（すべての抽選を考慮した数値。参考情報のみ）
    let ratioMouenIssenChokugeki: [Double] = [16281.7,14875.5,12788.0,8702.1,6351.2,4263.1]
    @AppStorage("mhrsbNormalGame") var normalGame: Int = 0
    @AppStorage("mhrsbFirstHitCountBz") var firstHitCountBz: Int = 0
    @AppStorage("mhrsbFirstHitCountFukubiki") var firstHitCountFukubiki: Int = 0
    @AppStorage("mhrsbFirstHitCountAt") var firstHitCountAt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountBz = 0
        firstHitCountFukubiki = 0
        firstHitCountAt = 0
        minusCheck = false
    }

    // --------
    // 終了画面
    // --------
    let ratioScreenNegate2: [Double] = [0.1,0,0.1,0.1,0.1,0.1,]
    let ratioScreenNegate3: [Double] = [0.1,0.1,0,0.1,0.1,0.1,]
    let ratioScreenOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioScreenOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioScreenOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("mhrsbScreenCount1") var screenCount1: Int = 0
    @AppStorage("mhrsbScreenCount2") var screenCount2: Int = 0
    @AppStorage("mhrsbScreenCount3") var screenCount3: Int = 0
    @AppStorage("mhrsbScreenCount4") var screenCount4: Int = 0
    @AppStorage("mhrsbScreenCount5") var screenCount5: Int = 0
    @AppStorage("mhrsbScreenCount6") var screenCount6: Int = 0
    @AppStorage("mhrsbScreenCount7") var screenCount7: Int = 0
    @AppStorage("mhrsbScreenCount8") var screenCount8: Int = 0
    @AppStorage("mhrsbScreenCount9") var screenCount9: Int = 0
    @AppStorage("mhrsbScreenCountSum") var screenCountSum: Int = 0

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
    // エンディング
    // -------
    let ratioEndingOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioEndingOver3: [Double] = [0,0,0.1,0.1,0.1,0.1,]
    let ratioEndingOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioEndingOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioEndingOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("mhrsbEndingCount1") var endingCount1: Int = 0
    @AppStorage("mhrsbEndingCount2") var endingCount2: Int = 0
    @AppStorage("mhrsbEndingCount3") var endingCount3: Int = 0
    @AppStorage("mhrsbEndingCount4") var endingCount4: Int = 0
    @AppStorage("mhrsbEndingCount5") var endingCount5: Int = 0
    @AppStorage("mhrsbEndingCount6") var endingCount6: Int = 0
    @AppStorage("mhrsbEndingCount7") var endingCount7: Int = 0
    @AppStorage("mhrsbEndingCount8") var endingCount8: Int = 0
    @AppStorage("mhrsbEndingCount9") var endingCount9: Int = 0
    @AppStorage("mhrsbEndingCountSum") var endingCountSum: Int = 0

    func endingSumFunc() {
        endingCountSum = countSum(
            endingCount1,
            endingCount2,
            endingCount3,
            endingCount4,
            endingCount5,
            endingCount6,
            endingCount7,
            endingCount8,
            endingCount9,
        )
    }

    func resetEnding() {
        endingCount1 = 0
        endingCount2 = 0
        endingCount3 = 0
        endingCount4 = 0
        endingCount5 = 0
        endingCount6 = 0
        endingCount7 = 0
        endingCount8 = 0
        endingCount9 = 0
        endingCountSum = 0
        minusCheck = false
    }

    // -------
    // BZシナリオ
    // -------
    // シナリオ選択率（％）。並びはシナリオA〜I、各配列は設定1〜6
    let bzScenarioNameList: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
    let ratioBzScenario: [[Double]] = [
        [32.0,31.3,30.5,28.1,25.8,23.4],   // A
        [27.3,25.8,24.2,22.7,21.1,19.5],   // B
        [14.1,14.1,14.1,14.1,14.1,14.1],   // C
        [12.5,12.5,12.5,12.5,12.5,12.5],   // D
        [6.3,7.0,7.8,8.6,9.4,10.2],        // E
        [3.1,3.5,3.9,4.7,5.5,6.3],         // F
        [3.1,3.5,3.9,4.7,5.5,6.3],         // G
        [0.8,1.2,1.6,2.3,3.1,3.9],         // H
        [0.8,1.2,1.6,2.3,3.1,3.9],         // I
    ]
    // シナリオE以上のインデックス（E〜I）
    let bzScenarioOverEIndexList: [Int] = [4, 5, 6, 7, 8]
    // シナリオ別のBZレベル（AT間CZ回数の1回目から）。0＝LOW、1＝MID、2＝HI、3＝SP
    let bzLevelNameList: [String] = ["LOW", "MID", "HI", "SP"]
    let bzScenarioLevelList: [[Int]] = [
        [1,0,0,2,0,0,3],   // A
        [1,0,2,0,0,2,3],   // B
        [1,2,0,2,0,2,3],   // C
        [1,0,0,2,2,2,3],   // D
        [1,0,2,2,2,2,3],   // E
        [1,2,2,2,2,2,3],   // F
        [2,2,2,2,2,2,3],   // G
        [0,0,3],           // H（3回目のCZでAT濃厚）
        [1,1,3],           // I（3回目のCZでAT濃厚）
    ]
    // BZレベル別のアイコンテーブル振分け（％）。並びはテーブル1〜7
    let ratioBzLevelTable: [[Double]] = [
        [84.0,9.8,6.3,0,0,0,0],        // LOW
        [0,50.0,48.4,1.6,0,0,0],       // MID
        [0,0,88.7,7.8,2.7,0.4,0.4],    // HI
        [0,0,0,0,0,0,100],             // SP
    ]
    // テーブルごとの1個目のアイコン（テーブル1〜7）
    let bzTableIconList: [String] = ["QUEST(青)", "QUEST(黄)", "ライゼクス", "セルレギオス", "オロミドロ亜種", "テオ・テスカトル", "AT"]
    let bzMaxCzCount: Int = 7

    // //// 履歴
    // 選択肢
    let bzCzKindList: [String] = ["BZ", "アイルー福引"]
    let bzAtResultList: [String] = ["ハズレ", "当選"]
    // 選択結果
    @AppStorage("mhrsbBzSelectedCzNumber") var bzSelectedCzNumber: Int = 1
    @AppStorage("mhrsbBzSelectedCzKind") var bzSelectedCzKind: String = "BZ"
    @AppStorage("mhrsbBzSelectedIcon") var bzSelectedIcon: String = "QUEST(青)"
    @AppStorage("mhrsbBzSelectedAt") var bzSelectedAt: String = "ハズレ"

    // AT間CZ回数の配列
    let bzCzNumberArrayKey: String = "mhrsbBzCzNumberArrayKey"
    @AppStorage("mhrsbBzCzNumberArrayKey") var bzCzNumberArrayData: Data?
    // CZ種類の配列
    let bzCzKindArrayKey: String = "mhrsbBzCzKindArrayKey"
    @AppStorage("mhrsbBzCzKindArrayKey") var bzCzKindArrayData: Data?
    // アイコンテーブルの配列（1〜7、アイルー福引は0）
    let bzTableArrayKey: String = "mhrsbBzTableArrayKey"
    @AppStorage("mhrsbBzTableArrayKey") var bzTableArrayData: Data?
    // AT当落の配列
    let bzAtArrayKey: String = "mhrsbBzAtArrayKey"
    @AppStorage("mhrsbBzAtArrayKey") var bzAtArrayData: Data?

    // 選択中の1個目のアイコンに対応するテーブル（1〜7）
    var bzSelectedTable: Int {
        (bzTableIconList.firstIndex(of: bzSelectedIcon) ?? 0) + 1
    }

    // データ登録
    func addBzHistory() {
        let table = bzSelectedCzKind == bzCzKindList[0] ? bzSelectedTable : 0
        arrayIntAddData(arrayData: bzCzNumberArrayData, addData: bzSelectedCzNumber, key: bzCzNumberArrayKey)
        arrayStringAddData(arrayData: bzCzKindArrayData, addData: bzSelectedCzKind, key: bzCzKindArrayKey)
        arrayIntAddData(arrayData: bzTableArrayData, addData: table, key: bzTableArrayKey)
        arrayStringAddData(arrayData: bzAtArrayData, addData: bzSelectedAt, key: bzAtArrayKey)
        bzAddRemoveCommon()
    }
    // 1行削除
    func removeLastBzHistory() {
        arrayIntRemoveLast(arrayData: bzCzNumberArrayData, key: bzCzNumberArrayKey)
        arrayStringRemoveLast(arrayData: bzCzKindArrayData, key: bzCzKindArrayKey)
        arrayIntRemoveLast(arrayData: bzTableArrayData, key: bzTableArrayKey)
        arrayStringRemoveLast(arrayData: bzAtArrayData, key: bzAtArrayKey)
        bzAddRemoveCommon()
    }
    func resetBzScenario() {
        arrayIntRemoveAll(arrayData: bzCzNumberArrayData, key: bzCzNumberArrayKey)
        arrayStringRemoveAll(arrayData: bzCzKindArrayData, key: bzCzKindArrayKey)
        arrayIntRemoveAll(arrayData: bzTableArrayData, key: bzTableArrayKey)
        arrayStringRemoveAll(arrayData: bzAtArrayData, key: bzAtArrayKey)
        bzAddRemoveCommon()
        resetQuest()
        minusCheck = false
    }
    // 登録・削除後：次のAT間CZ回数をセットし、AT当落はハズレに戻す
    func bzAddRemoveCommon() {
        bzSelectedCzNumber = bzNextCzNumber
        bzSelectedAt = bzAtResultList[0]
    }

    // 次に登録するAT間CZ回数（AT当選の次は1回目）
    var bzNextCzNumber: Int {
        let numberArray = decodeIntArray(from: bzCzNumberArrayData)
        let atArray = decodeStringArray(from: bzAtArrayData)
        guard let lastNumber = numberArray.last else { return 1 }
        if atArray.last == bzAtResultList[1] {
            return 1
        }
        return min(lastNumber + 1, bzMaxCzCount)
    }

    // 履歴の行ごとに、前の行と別のAT区間か（AT当選の次の行、またはCZ回数が連続しない行）
    var bzIntervalStartFlagList: [Bool] {
        let numberArray = decodeIntArray(from: bzCzNumberArrayData)
        let atArray = decodeStringArray(from: bzAtArrayData)
        return numberArray.indices.map { index in
            if index == 0 { return true }
            if atArray.indices.contains(index - 1) && atArray[index - 1] == bzAtResultList[1] { return true }
            return numberArray[index] != numberArray[index - 1] + 1
        }
    }

    // 履歴をAT区間ごとに分けたもの（古い順）
    var bzAllIntervalList: [MhrsbBzInterval] {
        let numberArray = decodeIntArray(from: bzCzNumberArrayData)
        let tableArray = decodeIntArray(from: bzTableArrayData)
        let startFlagList = bzIntervalStartFlagList
        var list: [MhrsbBzInterval] = []
        for index in numberArray.indices {
            let table = tableArray.indices.contains(index) ? tableArray[index] : 0
            if startFlagList[index] || list.isEmpty {
                list.append(MhrsbBzInterval(start: numberArray[index], entries: [table]))
            } else {
                list[list.count - 1].entries.append(table)
            }
        }
        return list
    }

    // 最後の区間がAT当選で終わっていない（＝現在の区間）か
    var bzIsLastIntervalOpen: Bool {
        let atArray = decodeStringArray(from: bzAtArrayData)
        guard let last = atArray.last else { return false }
        return last != bzAtResultList[1]
    }

    // //// クエスト成功期待度（BZ終了時の獲得アイコン別のAT期待度）
    let questIconList: [String] = [
        "QUEST(青)",
        "QUEST(黄)",
        "ライゼクス",
        "セルレギオス",
        "オロミドロ亜種",
        "テオ・テスカトル",
    ]
    // 獲得アイコン別のAT期待度（％）。questIconList と同じ並び
    let ratioQuestList: [[Double]] = [
        [0.4,0.4,0.8,1.6,2.3,3.1],   // QUEST(青)
        [1.6,2.3,3.1,5.5,6.6,7.8],   // QUEST(黄)
        [30.1,30.9,32.0,35.5,37.5,39.8],   // ライゼクス
        [44.9,45.7,46.9,50.0,52.3,54.7],   // セルレギオス
        [59.8,60.5,61.7,66.4,68.0,69.5],   // オロミドロ亜種
        [75.0,75.8,76.6,78.1,78.9,79.7],   // テオ・テスカトル
    ]
    // 結果表示・参考表の小数点以下の桁数（questIconList と同じ並び）
    let questDecimalList: [Int] = [1, 1, 0, 0, 1, 0]
    @AppStorage("mhrsbQuest1CountMiss") var quest1CountMiss: Int = 0
    @AppStorage("mhrsbQuest1CountHit") var quest1CountHit: Int = 0
    @AppStorage("mhrsbQuest1CountSum") var quest1CountSum: Int = 0
    @AppStorage("mhrsbQuest2CountMiss") var quest2CountMiss: Int = 0
    @AppStorage("mhrsbQuest2CountHit") var quest2CountHit: Int = 0
    @AppStorage("mhrsbQuest2CountSum") var quest2CountSum: Int = 0
    @AppStorage("mhrsbQuest3CountMiss") var quest3CountMiss: Int = 0
    @AppStorage("mhrsbQuest3CountHit") var quest3CountHit: Int = 0
    @AppStorage("mhrsbQuest3CountSum") var quest3CountSum: Int = 0
    @AppStorage("mhrsbQuest4CountMiss") var quest4CountMiss: Int = 0
    @AppStorage("mhrsbQuest4CountHit") var quest4CountHit: Int = 0
    @AppStorage("mhrsbQuest4CountSum") var quest4CountSum: Int = 0
    @AppStorage("mhrsbQuest5CountMiss") var quest5CountMiss: Int = 0
    @AppStorage("mhrsbQuest5CountHit") var quest5CountHit: Int = 0
    @AppStorage("mhrsbQuest5CountSum") var quest5CountSum: Int = 0
    @AppStorage("mhrsbQuest6CountMiss") var quest6CountMiss: Int = 0
    @AppStorage("mhrsbQuest6CountHit") var quest6CountHit: Int = 0
    @AppStorage("mhrsbQuest6CountSum") var quest6CountSum: Int = 0

    func questSumFunc() {
        quest1CountSum = quest1CountHit + quest1CountMiss
        quest2CountSum = quest2CountHit + quest2CountMiss
        quest3CountSum = quest3CountHit + quest3CountMiss
        quest4CountSum = quest4CountHit + quest4CountMiss
        quest5CountSum = quest5CountHit + quest5CountMiss
        quest6CountSum = quest6CountHit + quest6CountMiss
    }

    func resetQuest() {
        quest1CountMiss = 0
        quest1CountHit = 0
        quest1CountSum = 0
        quest2CountMiss = 0
        quest2CountHit = 0
        quest2CountSum = 0
        quest3CountMiss = 0
        quest3CountHit = 0
        quest3CountSum = 0
        quest4CountMiss = 0
        quest4CountHit = 0
        quest4CountSum = 0
        quest5CountMiss = 0
        quest5CountHit = 0
        quest5CountSum = 0
        quest6CountMiss = 0
        quest6CountHit = 0
        quest6CountSum = 0
        minusCheck = false
    }

    // //// 計算
    // 設定ごとのシナリオ選択率（合計で割り戻した割合）
    func bzScenarioPrior(setting: Int) -> [Double] {
        let list = ratioBzScenario.map { $0[setting] }
        let total = list.reduce(0, +)
        return list.map { $0 / total }
    }

    // 全設定平均のシナリオ選択率（シナリオ推測の表示用）
    var bzScenarioPriorAverage: [Double] {
        let settingCount = ratioBzScenario[0].count
        return bzScenarioNameList.indices.map { scenario in
            (0..<settingCount).reduce(0.0) { $0 + bzScenarioPrior(setting: $1)[scenario] } / Double(settingCount)
        }
    }

    // そのシナリオで、区間の記録の並びが起きる確率
    func bzScenarioLikelihood(scenario: Int, interval: MhrsbBzInterval) -> Double {
        let levelList = bzScenarioLevelList[scenario]
        // 記録した最後のCZまで、そのシナリオで到達できるか
        if interval.start - 1 + interval.entries.count > levelList.count {
            return 0
        }
        var likelihood = 1.0
        for (offset, entry) in interval.entries.enumerated() {
            if entry == 0 { continue }   // アイルー福引はCZ回数だけ進める
            let level = levelList[interval.start - 1 + offset]
            likelihood *= ratioBzLevelTable[level][entry - 1] / 100
        }
        return likelihood
    }

    // 設定ごとの、区間の記録の並びが起きる確率
    func bzIntervalProbability(interval: MhrsbBzInterval, setting: Int) -> Double {
        let prior = bzScenarioPrior(setting: setting)
        return prior.indices.reduce(0.0) { $0 + prior[$1] * bzScenarioLikelihood(scenario: $1, interval: interval) }
    }

    // どのシナリオでもあり得る並びか（区切り忘れの検出用）
    func bzIsPossible(interval: MhrsbBzInterval) -> Bool {
        bzScenarioNameList.indices.contains { bzScenarioLikelihood(scenario: $0, interval: interval) > 0 }
    }

    // 区間ごとのシナリオの見込み（全設定平均のシナリオ選択率が前提）
    func bzScenarioPosterior(interval: MhrsbBzInterval) -> [Double] {
        let prior = bzScenarioPriorAverage
        let weightList = prior.indices.map { prior[$0] * bzScenarioLikelihood(scenario: $0, interval: interval) }
        let total = weightList.reduce(0, +)
        guard total > 0 else { return weightList.map { _ in 0 } }
        return weightList.map { $0 / total }
    }

    // 次のCZのBZレベルの見込み。並びは LOW・MID・HI・SP
    func bzNextLevelForecast(interval: MhrsbBzInterval) -> [Double] {
        let posterior = bzScenarioPosterior(interval: interval)
        let nextIndex = interval.start - 1 + interval.entries.count
        var forecast = [0.0, 0.0, 0.0, 0.0]
        var reachable = 0.0
        for scenario in posterior.indices {
            let levelList = bzScenarioLevelList[scenario]
            if nextIndex < levelList.count {
                forecast[levelList[nextIndex]] += posterior[scenario]
                reachable += posterior[scenario]
            }
        }
        guard reachable > 0 else { return forecast }
        return forecast.map { $0 / reachable }
    }

    // 区間がシナリオE以上だった見込み
    func bzOverEProbability(interval: MhrsbBzInterval) -> Double {
        let posterior = bzScenarioPosterior(interval: interval)
        return bzScenarioOverEIndexList.reduce(0.0) { $0 + posterior[$1] }
    }

    // 判別に使える区間（あり得ない並びの区間は除外）
    var bzValidIntervalList: [MhrsbBzInterval] {
        bzAllIntervalList.filter { bzIsPossible(interval: $0) }
    }

    // 推定シナリオE以上の区間数
    var bzEstimatedOverECount: Double {
        bzValidIntervalList.reduce(0.0) { $0 + bzOverEProbability(interval: $1) }
    }

    // CZ◯回目のアイコンテーブル実質出現率（％）。czNumber は 1〜7
    func bzTableRatio(czNumber: Int, setting: Int) -> [Double] {
        let prior = bzScenarioPrior(setting: setting)
        var ratioList = [Double](repeating: 0, count: bzTableIconList.count)
        var reach = 0.0
        for scenario in prior.indices {
            let levelList = bzScenarioLevelList[scenario]
            guard czNumber - 1 < levelList.count else { continue }
            reach += prior[scenario]
            let tableList = ratioBzLevelTable[levelList[czNumber - 1]]
            for table in tableList.indices {
                ratioList[table] += prior[scenario] * tableList[table]
            }
        }
        guard reach > 0 else { return ratioList }
        return ratioList.map { $0 / reach }
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "モンスターハンターライズ：サンブレイク"
    @AppStorage("mhrsbMinusCheck") var minusCheck: Bool = false
    @AppStorage("mhrsbSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetEnding()
        resetBzScenario()
    }
}


class MhrsbMemory1: ObservableObject {
    @AppStorage("mhrsbNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("mhrsbFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("mhrsbScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("mhrsbScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("mhrsbScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("mhrsbScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("mhrsbScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("mhrsbScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("mhrsbScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("mhrsbScreenCount8Memory1") var screenCount8: Int = 0
    @AppStorage("mhrsbScreenCount9Memory1") var screenCount9: Int = 0
    @AppStorage("mhrsbScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("mhrsbEndingCount1Memory1") var endingCount1: Int = 0
    @AppStorage("mhrsbEndingCount2Memory1") var endingCount2: Int = 0
    @AppStorage("mhrsbEndingCount3Memory1") var endingCount3: Int = 0
    @AppStorage("mhrsbEndingCount4Memory1") var endingCount4: Int = 0
    @AppStorage("mhrsbEndingCount5Memory1") var endingCount5: Int = 0
    @AppStorage("mhrsbEndingCount6Memory1") var endingCount6: Int = 0
    @AppStorage("mhrsbEndingCount7Memory1") var endingCount7: Int = 0
    @AppStorage("mhrsbEndingCount8Memory1") var endingCount8: Int = 0
    @AppStorage("mhrsbEndingCount9Memory1") var endingCount9: Int = 0
    @AppStorage("mhrsbEndingCountSumMemory1") var endingCountSum: Int = 0
    @AppStorage("mhrsbFirstHitCountBzMemory1") var firstHitCountBz: Int = 0
    @AppStorage("mhrsbFirstHitCountFukubikiMemory1") var firstHitCountFukubiki: Int = 0
    @AppStorage("mhrsbBzCzNumberArrayKeyMemory1") var bzCzNumberArrayData: Data?
    @AppStorage("mhrsbBzCzKindArrayKeyMemory1") var bzCzKindArrayData: Data?
    @AppStorage("mhrsbBzTableArrayKeyMemory1") var bzTableArrayData: Data?
    @AppStorage("mhrsbBzAtArrayKeyMemory1") var bzAtArrayData: Data?
    @AppStorage("mhrsbQuest1CountMissMemory1") var quest1CountMiss: Int = 0
    @AppStorage("mhrsbQuest1CountHitMemory1") var quest1CountHit: Int = 0
    @AppStorage("mhrsbQuest1CountSumMemory1") var quest1CountSum: Int = 0
    @AppStorage("mhrsbQuest2CountMissMemory1") var quest2CountMiss: Int = 0
    @AppStorage("mhrsbQuest2CountHitMemory1") var quest2CountHit: Int = 0
    @AppStorage("mhrsbQuest2CountSumMemory1") var quest2CountSum: Int = 0
    @AppStorage("mhrsbQuest3CountMissMemory1") var quest3CountMiss: Int = 0
    @AppStorage("mhrsbQuest3CountHitMemory1") var quest3CountHit: Int = 0
    @AppStorage("mhrsbQuest3CountSumMemory1") var quest3CountSum: Int = 0
    @AppStorage("mhrsbQuest4CountMissMemory1") var quest4CountMiss: Int = 0
    @AppStorage("mhrsbQuest4CountHitMemory1") var quest4CountHit: Int = 0
    @AppStorage("mhrsbQuest4CountSumMemory1") var quest4CountSum: Int = 0
    @AppStorage("mhrsbQuest5CountMissMemory1") var quest5CountMiss: Int = 0
    @AppStorage("mhrsbQuest5CountHitMemory1") var quest5CountHit: Int = 0
    @AppStorage("mhrsbQuest5CountSumMemory1") var quest5CountSum: Int = 0
    @AppStorage("mhrsbQuest6CountMissMemory1") var quest6CountMiss: Int = 0
    @AppStorage("mhrsbQuest6CountHitMemory1") var quest6CountHit: Int = 0
    @AppStorage("mhrsbQuest6CountSumMemory1") var quest6CountSum: Int = 0
    @AppStorage("mhrsbMemoMemory1") var memo = ""
    @AppStorage("mhrsbDateMemory1") var dateDouble = 0.0
}


class MhrsbMemory2: ObservableObject {
    @AppStorage("mhrsbNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("mhrsbFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("mhrsbScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("mhrsbScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("mhrsbScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("mhrsbScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("mhrsbScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("mhrsbScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("mhrsbScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("mhrsbScreenCount8Memory2") var screenCount8: Int = 0
    @AppStorage("mhrsbScreenCount9Memory2") var screenCount9: Int = 0
    @AppStorage("mhrsbScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("mhrsbEndingCount1Memory2") var endingCount1: Int = 0
    @AppStorage("mhrsbEndingCount2Memory2") var endingCount2: Int = 0
    @AppStorage("mhrsbEndingCount3Memory2") var endingCount3: Int = 0
    @AppStorage("mhrsbEndingCount4Memory2") var endingCount4: Int = 0
    @AppStorage("mhrsbEndingCount5Memory2") var endingCount5: Int = 0
    @AppStorage("mhrsbEndingCount6Memory2") var endingCount6: Int = 0
    @AppStorage("mhrsbEndingCount7Memory2") var endingCount7: Int = 0
    @AppStorage("mhrsbEndingCount8Memory2") var endingCount8: Int = 0
    @AppStorage("mhrsbEndingCount9Memory2") var endingCount9: Int = 0
    @AppStorage("mhrsbEndingCountSumMemory2") var endingCountSum: Int = 0
    @AppStorage("mhrsbFirstHitCountBzMemory2") var firstHitCountBz: Int = 0
    @AppStorage("mhrsbFirstHitCountFukubikiMemory2") var firstHitCountFukubiki: Int = 0
    @AppStorage("mhrsbBzCzNumberArrayKeyMemory2") var bzCzNumberArrayData: Data?
    @AppStorage("mhrsbBzCzKindArrayKeyMemory2") var bzCzKindArrayData: Data?
    @AppStorage("mhrsbBzTableArrayKeyMemory2") var bzTableArrayData: Data?
    @AppStorage("mhrsbBzAtArrayKeyMemory2") var bzAtArrayData: Data?
    @AppStorage("mhrsbQuest1CountMissMemory2") var quest1CountMiss: Int = 0
    @AppStorage("mhrsbQuest1CountHitMemory2") var quest1CountHit: Int = 0
    @AppStorage("mhrsbQuest1CountSumMemory2") var quest1CountSum: Int = 0
    @AppStorage("mhrsbQuest2CountMissMemory2") var quest2CountMiss: Int = 0
    @AppStorage("mhrsbQuest2CountHitMemory2") var quest2CountHit: Int = 0
    @AppStorage("mhrsbQuest2CountSumMemory2") var quest2CountSum: Int = 0
    @AppStorage("mhrsbQuest3CountMissMemory2") var quest3CountMiss: Int = 0
    @AppStorage("mhrsbQuest3CountHitMemory2") var quest3CountHit: Int = 0
    @AppStorage("mhrsbQuest3CountSumMemory2") var quest3CountSum: Int = 0
    @AppStorage("mhrsbQuest4CountMissMemory2") var quest4CountMiss: Int = 0
    @AppStorage("mhrsbQuest4CountHitMemory2") var quest4CountHit: Int = 0
    @AppStorage("mhrsbQuest4CountSumMemory2") var quest4CountSum: Int = 0
    @AppStorage("mhrsbQuest5CountMissMemory2") var quest5CountMiss: Int = 0
    @AppStorage("mhrsbQuest5CountHitMemory2") var quest5CountHit: Int = 0
    @AppStorage("mhrsbQuest5CountSumMemory2") var quest5CountSum: Int = 0
    @AppStorage("mhrsbQuest6CountMissMemory2") var quest6CountMiss: Int = 0
    @AppStorage("mhrsbQuest6CountHitMemory2") var quest6CountHit: Int = 0
    @AppStorage("mhrsbQuest6CountSumMemory2") var quest6CountSum: Int = 0
    @AppStorage("mhrsbMemoMemory2") var memo = ""
    @AppStorage("mhrsbDateMemory2") var dateDouble = 0.0
}


class MhrsbMemory3: ObservableObject {
    @AppStorage("mhrsbNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("mhrsbFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("mhrsbScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("mhrsbScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("mhrsbScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("mhrsbScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("mhrsbScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("mhrsbScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("mhrsbScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("mhrsbScreenCount8Memory3") var screenCount8: Int = 0
    @AppStorage("mhrsbScreenCount9Memory3") var screenCount9: Int = 0
    @AppStorage("mhrsbScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("mhrsbEndingCount1Memory3") var endingCount1: Int = 0
    @AppStorage("mhrsbEndingCount2Memory3") var endingCount2: Int = 0
    @AppStorage("mhrsbEndingCount3Memory3") var endingCount3: Int = 0
    @AppStorage("mhrsbEndingCount4Memory3") var endingCount4: Int = 0
    @AppStorage("mhrsbEndingCount5Memory3") var endingCount5: Int = 0
    @AppStorage("mhrsbEndingCount6Memory3") var endingCount6: Int = 0
    @AppStorage("mhrsbEndingCount7Memory3") var endingCount7: Int = 0
    @AppStorage("mhrsbEndingCount8Memory3") var endingCount8: Int = 0
    @AppStorage("mhrsbEndingCount9Memory3") var endingCount9: Int = 0
    @AppStorage("mhrsbEndingCountSumMemory3") var endingCountSum: Int = 0
    @AppStorage("mhrsbFirstHitCountBzMemory3") var firstHitCountBz: Int = 0
    @AppStorage("mhrsbFirstHitCountFukubikiMemory3") var firstHitCountFukubiki: Int = 0
    @AppStorage("mhrsbBzCzNumberArrayKeyMemory3") var bzCzNumberArrayData: Data?
    @AppStorage("mhrsbBzCzKindArrayKeyMemory3") var bzCzKindArrayData: Data?
    @AppStorage("mhrsbBzTableArrayKeyMemory3") var bzTableArrayData: Data?
    @AppStorage("mhrsbBzAtArrayKeyMemory3") var bzAtArrayData: Data?
    @AppStorage("mhrsbQuest1CountMissMemory3") var quest1CountMiss: Int = 0
    @AppStorage("mhrsbQuest1CountHitMemory3") var quest1CountHit: Int = 0
    @AppStorage("mhrsbQuest1CountSumMemory3") var quest1CountSum: Int = 0
    @AppStorage("mhrsbQuest2CountMissMemory3") var quest2CountMiss: Int = 0
    @AppStorage("mhrsbQuest2CountHitMemory3") var quest2CountHit: Int = 0
    @AppStorage("mhrsbQuest2CountSumMemory3") var quest2CountSum: Int = 0
    @AppStorage("mhrsbQuest3CountMissMemory3") var quest3CountMiss: Int = 0
    @AppStorage("mhrsbQuest3CountHitMemory3") var quest3CountHit: Int = 0
    @AppStorage("mhrsbQuest3CountSumMemory3") var quest3CountSum: Int = 0
    @AppStorage("mhrsbQuest4CountMissMemory3") var quest4CountMiss: Int = 0
    @AppStorage("mhrsbQuest4CountHitMemory3") var quest4CountHit: Int = 0
    @AppStorage("mhrsbQuest4CountSumMemory3") var quest4CountSum: Int = 0
    @AppStorage("mhrsbQuest5CountMissMemory3") var quest5CountMiss: Int = 0
    @AppStorage("mhrsbQuest5CountHitMemory3") var quest5CountHit: Int = 0
    @AppStorage("mhrsbQuest5CountSumMemory3") var quest5CountSum: Int = 0
    @AppStorage("mhrsbQuest6CountMissMemory3") var quest6CountMiss: Int = 0
    @AppStorage("mhrsbQuest6CountHitMemory3") var quest6CountHit: Int = 0
    @AppStorage("mhrsbQuest6CountSumMemory3") var quest6CountSum: Int = 0
    @AppStorage("mhrsbMemoMemory3") var memo = ""
    @AppStorage("mhrsbDateMemory3") var dateDouble = 0.0
}

// BZシナリオの1区間（AT〜AT）の記録
struct MhrsbBzInterval {
    var start: Int   // 記録開始のCZ回数（1〜7）
    var entries: [Int]   // 1〜7＝アイコンテーブル、0＝アイルー福引
}
