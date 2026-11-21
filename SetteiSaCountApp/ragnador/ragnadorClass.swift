//
//  ragnadorClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Ragnador: ObservableObject {
    // -------
    // 通常時
    // -------

    // 弱チェリーの状態昇格率
    let ratioWeakCherryUpNone: [Double] = [40.6,37.5,34.4,25.0,19.5,17.2]
    let ratioWeakCherryUpHigh: [Double] = [50.0,51.6,53.1,58.6,62.5,64.1]
    let ratioWeakCherryUpSuperHigh: [Double] = [9.4,10.9,12.5,16.4,18.0,18.8]
    @AppStorage("ragnadorWeakCherryCount") var weakCherryCount: Int = 0
    @AppStorage("ragnadorWeakCherryUpCountHigh") var weakCherryUpCountHigh: Int = 0
    @AppStorage("ragnadorWeakCherryUpCountSuperHigh") var weakCherryUpCountSuperHigh: Int = 0

    // レア役からのCZ・AT当選率（設定差のあるものだけカウント）
    // 通常状態
    let ratioRareCzNormalChance: [Double] = [19.9,21.1,22.3,23.4,23.4,23.4]
    let ratioRareCzNormalKyo: [Double] = [32.8,35.2,37.5,43.0,43.0,43.0]
    let ratioRareAtNormalSuika: [Double] = [0.4,0.4,0.4,0.8,1.2,1.2]
    let ratioRareAtNormalChance: [Double] = [0.4,0.4,0.4,0.8,1.2,1.2]
    let ratioRareAtNormalKyo: [Double] = [0.4,0.4,0.8,1.6,2.0,2.3]
    let ratioRareAtNormalGoku: [Double] = [0.4,0.4,0.4,0.8,1.2,1.2]
    // 高確
    let ratioRareCzHighChance: [Double] = [39.8,41.4,43.0,54.7,54.7,54.7]
    let ratioRareCzHighKyo: [Double] = [65.6,66.4,68.8,73.4,75.0,76.6]
    let ratioRareAtHighSuika: [Double] = [0.4,0.4,0.4,0.8,1.2,1.2]
    let ratioRareAtHighChance: [Double] = [0.4,0.4,0.4,0.8,1.2,1.2]
    let ratioRareAtHighKyo: [Double] = [0.4,0.4,0.8,1.6,2.0,2.3]
    @AppStorage("ragnadorRareCountNormalSuika") var rareCountNormalSuika: Int = 0
    @AppStorage("ragnadorRareAtCountNormalSuika") var rareAtCountNormalSuika: Int = 0
    @AppStorage("ragnadorRareCountNormalChance") var rareCountNormalChance: Int = 0
    @AppStorage("ragnadorRareCzCountNormalChance") var rareCzCountNormalChance: Int = 0
    @AppStorage("ragnadorRareAtCountNormalChance") var rareAtCountNormalChance: Int = 0
    @AppStorage("ragnadorRareCountNormalKyo") var rareCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareCzCountNormalKyo") var rareCzCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareAtCountNormalKyo") var rareAtCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareCountNormalGoku") var rareCountNormalGoku: Int = 0
    @AppStorage("ragnadorRareAtCountNormalGoku") var rareAtCountNormalGoku: Int = 0
    @AppStorage("ragnadorRareCountHighSuika") var rareCountHighSuika: Int = 0
    @AppStorage("ragnadorRareAtCountHighSuika") var rareAtCountHighSuika: Int = 0
    @AppStorage("ragnadorRareCountHighChance") var rareCountHighChance: Int = 0
    @AppStorage("ragnadorRareCzCountHighChance") var rareCzCountHighChance: Int = 0
    @AppStorage("ragnadorRareAtCountHighChance") var rareAtCountHighChance: Int = 0
    @AppStorage("ragnadorRareCountHighKyo") var rareCountHighKyo: Int = 0
    @AppStorage("ragnadorRareCzCountHighKyo") var rareCzCountHighKyo: Int = 0
    @AppStorage("ragnadorRareAtCountHighKyo") var rareAtCountHighKyo: Int = 0

    func resetNormal() {
        weakCherryCount = 0
        weakCherryUpCountHigh = 0
        weakCherryUpCountSuperHigh = 0
        rareCountNormalSuika = 0
        rareAtCountNormalSuika = 0
        rareCountNormalChance = 0
        rareCzCountNormalChance = 0
        rareAtCountNormalChance = 0
        rareCountNormalKyo = 0
        rareCzCountNormalKyo = 0
        rareAtCountNormalKyo = 0
        rareCountNormalGoku = 0
        rareAtCountNormalGoku = 0
        rareCountHighSuika = 0
        rareAtCountHighSuika = 0
        rareCountHighChance = 0
        rareCzCountHighChance = 0
        rareAtCountHighChance = 0
        rareCountHighKyo = 0
        rareCzCountHighKyo = 0
        rareAtCountHighKyo = 0
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [172.8,167.2,161.8,145.0,143.0,142.4]
    let ratioFirstHitAt: [Double] = [326.4,317.2,307.7,271.2,260.8,258.3]
    // 選択肢
    let entryKindList: [String] = ["CZ", "直撃", "天井", "その他"]
    let enemyList: [String] = ["青龍", "白虎", "玄武", "朱雀"]
    let atResultList: [String] = ["ハズレ", "当選"]   // AT当否
    // 選択結果
    @AppStorage("ragnadorInputGame") var inputGame: Int = 0
    @AppStorage("ragnadorSelectedEntryKind") var selectedEntryKind: String = "CZ"
    @AppStorage("ragnadorSelectedEnemy") var selectedEnemy: String = "青龍"
    @AppStorage("ragnadorSelectedAtResult") var selectedAtResult: String = "ハズレ"
    // 最初のAT区間（最初のAT当選まで）を敵選択テーブルの計算に含めるか
    // ONならAT後の区間（テーブル6〜10）として扱い、OFFなら計算に使わない
    @AppStorage("ragnadorEnemyIncludeFirstInterval") var enemyIncludeFirstInterval: Bool = false

    // 履歴（1行＝1回の初当り）
    // CZの行：ゲーム数／CZ／敵／AT当否
    // 直撃・天井・その他の行：ゲーム数／種類／空欄／AT当否（直撃は当選固定）
    let gameArrayKey: String = "ragnadorGameArrayKey"
    @AppStorage("ragnadorGameArrayKey") var gameArrayData: Data?
    let entryKindArrayKey: String = "ragnadorEntryKindArrayKey"
    @AppStorage("ragnadorEntryKindArrayKey") var entryKindArrayData: Data?
    let enemyArrayKey: String = "ragnadorEnemyArrayKey"
    @AppStorage("ragnadorEnemyArrayKey") var enemyArrayData: Data?
    let resultArrayKey: String = "ragnadorResultArrayKey"
    @AppStorage("ragnadorResultArrayKey") var resultArrayData: Data?

    // 履歴からの自動算出結果
    @AppStorage("ragnadorPlayGameSum") var playGameSum: Int = 0
    @AppStorage("ragnadorFirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("ragnadorFirstHitCountAt") var firstHitCountAt: Int = 0

    // 入力方式（履歴入力／カウント入力）
    let firstHitInputModeList: [String] = ["履歴入力", "カウント入力"]
    @AppStorage("ragnadorFirstHitInputMode") var firstHitInputMode: String = "履歴入力"
    // カウント入力用
    @AppStorage("ragnadorManualNormalGame") var manualNormalGame: Int = 0
    @AppStorage("ragnadorManualFirstHitCountCz") var manualFirstHitCountCz: Int = 0
    @AppStorage("ragnadorManualFirstHitCountAt") var manualFirstHitCountAt: Int = 0
    // 確率算出・95Ci・設定期待値に使う値（選択中の入力方式の値を返す）
    var isHistoryInputMode: Bool {
        firstHitInputMode == firstHitInputModeList[0]
    }
    var isCzEntry: Bool {
        selectedEntryKind == entryKindList[0]
    }
    var isDirectEntry: Bool {
        selectedEntryKind == entryKindList[1]
    }
    var activeNormalGame: Int {
        get { isHistoryInputMode ? playGameSum : manualNormalGame }
        set { }
    }
    var activeFirstHitCountCz: Int {
        get { isHistoryInputMode ? firstHitCountCz : manualFirstHitCountCz }
        set { }
    }
    var activeFirstHitCountAt: Int {
        get { isHistoryInputMode ? firstHitCountAt : manualFirstHitCountAt }
        set { }
    }

    // データ登録
    func addHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: entryKindArrayData, addData: selectedEntryKind, key: entryKindArrayKey)
        // 敵はCZのときだけ
        arrayStringAddData(arrayData: enemyArrayData, addData: isCzEntry ? selectedEnemy : "", key: enemyArrayKey)
        // 直撃はAT当選固定
        arrayStringAddData(arrayData: resultArrayData, addData: isDirectEntry ? atResultList[1] : selectedAtResult, key: resultArrayKey)
        addRemoveCommon()
    }
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: entryKindArrayData, key: entryKindArrayKey)
        arrayStringRemoveLast(arrayData: enemyArrayData, key: enemyArrayKey)
        arrayStringRemoveLast(arrayData: resultArrayData, key: resultArrayKey)
        addRemoveCommon()
    }
    func resetFirstHit() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: entryKindArrayData, key: entryKindArrayKey)
        arrayStringRemoveAll(arrayData: enemyArrayData, key: enemyArrayKey)
        arrayStringRemoveAll(arrayData: resultArrayData, key: resultArrayKey)
        addRemoveCommon()
        inputGame = 0
        manualNormalGame = 0
        manualFirstHitCountCz = 0
        manualFirstHitCountAt = 0
        minusCheck = false
    }
    func addRemoveCommon() {
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        firstHitCountCz = arrayStringDataCount(arrayData: entryKindArrayData, countString: entryKindList[0])
        firstHitCountAt = arrayStringDataCount(arrayData: resultArrayData, countString: atResultList[1])
    }

    // ある行がAT当選か
    func isAtResult(_ result: String) -> Bool {
        result == atResultList[1]
    }

    // AT区間の区切り（その行でATに当選したか）
    var historyAtFlagList: [Bool] {
        decodeStringArray(from: resultArrayData).map { isAtResult($0) }
    }

    // --------
    // 敵選択テーブル
    // --------
    // 敵種別テーブル（CZごとに、どの振り分けで敵を決めるか）
    // 0:通常 1:白虎以上 2:玄武以上 3:朱雀 4:チャンス
    let enemyTypeNameList: [String] = ["通常", "白虎以上", "玄武以上", "朱雀", "チャンス"]
    // 敵の振り分け（％）。並びは enemyList（青龍・白虎・玄武・朱雀）
    // 通常は設定差あり（青龍・玄武）。設定ごとの値は enemyTypeRatio で組み立てる
    let ratioEnemyNormalGenbu: [Double] = [1.6,2.0,2.3,4.7,5.5,6.3]
    let ratioEnemyTypeFixed: [[Double]] = [
        [0, 0, 0, 0],            // 通常（設定ごとに組み立てるので未使用）
        [0, 87.1, 12.5, 0.4],    // 白虎以上
        [0, 0, 87.5, 12.5],      // 玄武以上
        [0, 0, 0, 100],          // 朱雀
        [64.5, 5.1, 18.0, 12.5], // チャンス
    ]
    // 敵選択テーブル。CZ回数ごとの敵種別テーブル（最後の要素以降はその値を使い続ける）
    // 設定変更後：テーブル1〜5
    let enemyTableChangeList: [[Int]] = [
        [0, 1, 3],   // テーブル1
        [1, 0, 3],   // テーブル2
        [0, 2, 3],   // テーブル3
        [2, 0, 3],   // テーブル4
        [3, 3, 3],   // テーブル5
    ]
    let ratioEnemyTableChange: [Double] = [47.3, 4.7, 1.6, 46.1, 0.4]
    // AT後：テーブル6〜10
    let enemyTableAtList: [[Int]] = [
        [4, 0, 1, 0, 1, 3],   // テーブル6
        [4, 3, 0, 1, 0, 3],   // テーブル7
        [3, 0, 1, 0, 2, 3],   // テーブル8
        [4, 0, 0, 2, 0, 3],   // テーブル9
        [3, 3, 3, 3, 3, 3],   // テーブル10
    ]
    // テーブル7（設定差あり）。テーブル6は「テーブル6＋7の合計 52.0%」からテーブル7を引いた値
    let ratioEnemyTable7: [Double] = [4.7,5.5,6.3,7.8,8.6,9.4]
    let ratioEnemyTable67Sum: Double = 52.0
    let ratioEnemyTable8: Double = 1.6
    let ratioEnemyTable9: Double = 46.1
    let ratioEnemyTable10: Double = 0.4

    // 敵種別テーブルの振り分け（0〜1）。setting は 0〜5
    func enemyTypeRatio(type: Int, setting: Int) -> [Double] {
        if type == 0 {
            let genbu = ratioEnemyNormalGenbu[setting]
            return [100 - 12.5 - genbu - 0.4, 12.5, genbu, 0.4].map { $0 / 100 }
        }
        return ratioEnemyTypeFixed[type].map { $0 / 100 }
    }

    // テーブル7の選択率 table7（0〜1）を前提にした、AT後テーブル6〜10の選択率（0〜1）
    func enemyTableAtPrior(table7: Double) -> [Double] {
        [
            ratioEnemyTable67Sum / 100 - table7,
            table7,
            ratioEnemyTable8 / 100,
            ratioEnemyTable9 / 100,
            ratioEnemyTable10 / 100,
        ]
    }

    // そのテーブルで、区間の敵の並びが起きる確率
    func enemyTableLikelihood(typeList: [Int], interval: RagnadorEnemyInterval, setting: Int) -> Double {
        var likelihood = 1.0
        for (offset, enemy) in interval.enemies.enumerated() {
            let type = typeList[min(offset, typeList.count - 1)]
            likelihood *= enemyTypeRatio(type: type, setting: setting)[enemy]
        }
        return likelihood
    }

    // 設定ごとの、区間の敵の並びが起きる確率（設定期待値で使う）
    func enemyIntervalProbability(interval: RagnadorEnemyInterval, setting: Int) -> Double {
        if interval.isAfterAt {
            let prior = enemyTableAtPrior(table7: ratioEnemyTable7[setting] / 100)
            return enemyTableAtList.indices.reduce(0.0) {
                $0 + prior[$1] * enemyTableLikelihood(typeList: enemyTableAtList[$1], interval: interval, setting: setting)
            }
        } else {
            let total = ratioEnemyTableChange.reduce(0, +)
            return enemyTableChangeList.indices.reduce(0.0) {
                $0 + ratioEnemyTableChange[$1] / total * enemyTableLikelihood(typeList: enemyTableChangeList[$1], interval: interval, setting: setting)
            }
        }
    }

    // 履歴をテーブル区間ごとに分けたもの（古い順）。最初のAT区間は、含める設定のときだけ入れる
    var enemyAllIntervalList: [RagnadorEnemyInterval] {
        enemyBuildIntervalList(includeOpenEmpty: false)
    }
    // テーブル推測の表示用。AT当選直後でCZがまだ無い現在の区間も含める
    var enemyDisplayIntervalList: [RagnadorEnemyInterval] {
        enemyBuildIntervalList(includeOpenEmpty: true)
    }
    func enemyBuildIntervalList(includeOpenEmpty: Bool) -> [RagnadorEnemyInterval] {
        let kindArray = decodeStringArray(from: entryKindArrayData)
        let enemyArray = decodeStringArray(from: enemyArrayData)
        let resultArray = decodeStringArray(from: resultArrayData)
        var list: [RagnadorEnemyInterval] = []
        // 0:設定変更後 1:AT後 2:不明
        var startIndex = enemyIncludeFirstInterval ? 1 : 2
        var enemies: [Int] = []
        func close(isOpen: Bool) {
            // 含めない設定の最初の区間と、CZが1回も無い区間は使わない（表示用の現在の区間は除く）
            if startIndex != 2 && (!enemies.isEmpty || (isOpen && includeOpenEmpty)) {
                list.append(RagnadorEnemyInterval(isAfterAt: startIndex == 1, enemies: enemies, isOpen: isOpen))
            }
            enemies = []
        }
        for index in kindArray.indices {
            if kindArray[index] == entryKindList[0],
               enemyArray.indices.contains(index),
               let enemy = enemyList.firstIndex(of: enemyArray[index]) {
                enemies.append(enemy)
            }
            if resultArray.indices.contains(index) && isAtResult(resultArray[index]) {
                close(isOpen: false)
                startIndex = 1   // 以降はAT後
            }
        }
        close(isOpen: true)
        return list
    }

    // どのテーブルでもあり得る並びか（朝一稼働の設定間違いなどの検出用）
    func enemyIsPossible(interval: RagnadorEnemyInterval) -> Bool {
        enemyIntervalProbability(interval: interval, setting: 0) > 0
    }

    // 判別に使える区間（あり得ない並びの区間は除外）
    var enemyValidIntervalList: [RagnadorEnemyInterval] {
        enemyAllIntervalList.filter { enemyIsPossible(interval: $0) }
    }

    // あり得ない並びで除外した区間があるか
    var enemyHasInvalidInterval: Bool {
        enemyAllIntervalList.count != enemyValidIntervalList.count
    }

    // //// 推定テーブル7選択率（計測区間数に応じた補正つき）
    // 打ち始めは「一般的なホールの設定配分」でのテーブル7選択率を、補正用の区間として数区間分持たせ、
    // 区間の記録が増えるほど、その台の記録から見た値に近づける。
    // テーブル7かどうか絞り込めない区間（AT後1回目のCZだけの区間など）は、推定値をどちらにも動かさない。
    // 一般的なホールの設定配分（設定期待値ページの事前配分「デフォルト」と同じ）
    let enemyGeneralSettingWeightList: [Double] = [72, 21, 2, 3, 1, 1]
    // 補正用に持たせる区間数
    let enemyPriorIntervalCount: Double = 3

    // 一般的なホールの設定配分で平均したテーブル7選択率（0〜1）
    var enemyTable7General: Double {
        let total = enemyGeneralSettingWeightList.reduce(0, +)
        return enemyGeneralSettingWeightList.indices.reduce(0.0) {
            $0 + enemyGeneralSettingWeightList[$1] / total * ratioEnemyTable7[$1] / 100
        }
    }

    // 区間がテーブル7だった見込み（テーブル7選択率 table7 が前提）
    // 敵の振り分けは一般的なホールの設定配分で平均した通常テーブルを使う
    private func enemyTable7Probability(interval: RagnadorEnemyInterval, table7: Double) -> Double {
        let prior = enemyTableAtPrior(table7: table7)
        let weightList = enemyTableAtList.indices.map { table in
            prior[table] * enemyGeneralLikelihood(typeList: enemyTableAtList[table], interval: interval)
        }
        let total = weightList.reduce(0, +)
        guard total > 0 else { return table7 }
        return weightList[1] / total
    }

    // 一般的なホールの設定配分で平均した、テーブルの敵の並びが起きる確率
    private func enemyGeneralLikelihood(typeList: [Int], interval: RagnadorEnemyInterval) -> Double {
        let total = enemyGeneralSettingWeightList.reduce(0, +)
        return enemyGeneralSettingWeightList.indices.reduce(0.0) {
            $0 + enemyGeneralSettingWeightList[$1] / total * enemyTableLikelihood(typeList: typeList, interval: interval, setting: $1)
        }
    }

    // 推定に使うAT後の区間
    var enemyAtIntervalList: [RagnadorEnemyInterval] {
        enemyValidIntervalList.filter { $0.isAfterAt }
    }

    // 推定テーブル7選択率（0〜1）
    // 「補正用の区間＋各区間のテーブル7の見込み」の平均を、値が落ち着くまで繰り返し求める
    var enemyEstimatedTable7Ratio: Double {
        let general = enemyTable7General
        let intervalList = enemyAtIntervalList
        var table7 = general
        for _ in 0..<200 {
            let sum = intervalList.reduce(0.0) { $0 + enemyTable7Probability(interval: $1, table7: table7) }
            let next = (enemyPriorIntervalCount * general + sum) / (enemyPriorIntervalCount + Double(intervalList.count))
            if abs(next - table7) < 1e-7 {
                table7 = next
                break
            }
            table7 = next
        }
        return table7
    }

    // 推定テーブル7の区間数
    var enemyEstimatedTable7Count: Double {
        let table7 = enemyEstimatedTable7Ratio
        return enemyAtIntervalList.reduce(0.0) { $0 + enemyTable7Probability(interval: $1, table7: table7) }
    }

    // //// テーブル推測（区間ごと）
    // 区間のテーブル名（設定変更後はテーブル1〜5、AT後はテーブル6〜10）
    func enemyTableNameList(interval: RagnadorEnemyInterval) -> [String] {
        (0..<5).map { "テーブル\(interval.isAfterAt ? $0 + 6 : $0 + 1)" }
    }
    // 区間のテーブルの並び
    private func enemyTableTypeList(interval: RagnadorEnemyInterval) -> [[Int]] {
        interval.isAfterAt ? enemyTableAtList : enemyTableChangeList
    }
    // 区間ごとのテーブルの見込み（0〜1。AT後は推定テーブル7選択率が前提）
    func enemyTablePosterior(interval: RagnadorEnemyInterval) -> [Double] {
        var prior: [Double]
        if interval.isAfterAt {
            prior = enemyTableAtPrior(table7: enemyEstimatedTable7Ratio)
        } else {
            let total = ratioEnemyTableChange.reduce(0, +)
            prior = ratioEnemyTableChange.map { $0 / total }
        }
        let typeListList = enemyTableTypeList(interval: interval)
        let weightList = prior.indices.map { prior[$0] * enemyGeneralLikelihood(typeList: typeListList[$0], interval: interval) }
        let total = weightList.reduce(0, +)
        guard total > 0 else { return weightList.map { _ in 0 } }
        return weightList.map { $0 / total }
    }
    // CZ回数別の敵の実質出現率（％）。czNumber は 1〜。並びは enemyList
    func enemyEffectiveRatio(isAfterAt: Bool, czNumber: Int, setting: Int) -> [Double] {
        let prior: [Double]
        if isAfterAt {
            prior = enemyTableAtPrior(table7: ratioEnemyTable7[setting] / 100)
        } else {
            let total = ratioEnemyTableChange.reduce(0, +)
            prior = ratioEnemyTableChange.map { $0 / total }
        }
        let typeListList = isAfterAt ? enemyTableAtList : enemyTableChangeList
        var ratioList = [0.0, 0.0, 0.0, 0.0]
        for table in prior.indices {
            let typeList = typeListList[table]
            let type = typeList[min(czNumber - 1, typeList.count - 1)]
            let ratio = enemyTypeRatio(type: type, setting: setting)
            for enemy in ratioList.indices {
                ratioList[enemy] += prior[table] * ratio[enemy] * 100
            }
        }
        return ratioList
    }

    // 次のCZの敵の見込み（0〜1）。並びは enemyList（青龍・白虎・玄武・朱雀）
    func enemyNextForecast(interval: RagnadorEnemyInterval) -> [Double] {
        let posterior = enemyTablePosterior(interval: interval)
        let typeListList = enemyTableTypeList(interval: interval)
        let nextIndex = interval.enemies.count
        let weightTotal = enemyGeneralSettingWeightList.reduce(0, +)
        var forecast = [0.0, 0.0, 0.0, 0.0]
        for table in posterior.indices {
            let typeList = typeListList[table]
            let type = typeList[min(nextIndex, typeList.count - 1)]
            for setting in enemyGeneralSettingWeightList.indices {
                let ratio = enemyTypeRatio(type: type, setting: setting)
                let weight = posterior[table] * enemyGeneralSettingWeightList[setting] / weightTotal
                for enemy in forecast.indices {
                    forecast[enemy] += weight * ratio[enemy]
                }
            }
        }
        return forecast
    }

    // -------
    // ボイス選択
    // -------
    let ratioVoiceOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioVoiceOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioVoiceOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioVoiceOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("ragnadorVoiceCount1") var voiceCount1: Int = 0
    @AppStorage("ragnadorVoiceCount2") var voiceCount2: Int = 0
    @AppStorage("ragnadorVoiceCount3") var voiceCount3: Int = 0
    @AppStorage("ragnadorVoiceCount4") var voiceCount4: Int = 0
    @AppStorage("ragnadorVoiceCount5") var voiceCount5: Int = 0
    @AppStorage("ragnadorVoiceCount6") var voiceCount6: Int = 0
    @AppStorage("ragnadorVoiceCount7") var voiceCount7: Int = 0
    @AppStorage("ragnadorVoiceCount8") var voiceCount8: Int = 0
    @AppStorage("ragnadorVoiceCountSum") var voiceCountSum: Int = 0

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

    // -------
    // CZ,AT終了時のボイス
    // -------
    // ボイスは9種類あるが、カウントは示唆の分類ごと（1:デフォルト 2:テーブル示唆 3:高設定示唆）にまとめる
    @AppStorage("ragnadorEndVoiceCount1") var endVoiceCount1: Int = 0
    @AppStorage("ragnadorEndVoiceCount2") var endVoiceCount2: Int = 0
    @AppStorage("ragnadorEndVoiceCount3") var endVoiceCount3: Int = 0
    @AppStorage("ragnadorEndVoiceCountSum") var endVoiceCountSum: Int = 0

    func endVoiceSumFunc() {
        endVoiceCountSum = countSum(
            endVoiceCount1,
            endVoiceCount2,
            endVoiceCount3,
        )
    }

    func resetEndVoice() {
        endVoiceCount1 = 0
        endVoiceCount2 = 0
        endVoiceCount3 = 0
        endVoiceCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "ラグナドール"
    @AppStorage("ragnadorMinusCheck") var minusCheck: Bool = false
    @AppStorage("ragnadorSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetVoice()
        resetEndVoice()
    }
}


class RagnadorMemory1: ObservableObject {
    @AppStorage("ragnadorWeakCherryCountMemory1") var weakCherryCount: Int = 0
    @AppStorage("ragnadorWeakCherryUpCountHighMemory1") var weakCherryUpCountHigh: Int = 0
    @AppStorage("ragnadorWeakCherryUpCountSuperHighMemory1") var weakCherryUpCountSuperHigh: Int = 0
    @AppStorage("ragnadorRareCountNormalSuikaMemory1") var rareCountNormalSuika: Int = 0
    @AppStorage("ragnadorRareAtCountNormalSuikaMemory1") var rareAtCountNormalSuika: Int = 0
    @AppStorage("ragnadorRareCountNormalChanceMemory1") var rareCountNormalChance: Int = 0
    @AppStorage("ragnadorRareCzCountNormalChanceMemory1") var rareCzCountNormalChance: Int = 0
    @AppStorage("ragnadorRareAtCountNormalChanceMemory1") var rareAtCountNormalChance: Int = 0
    @AppStorage("ragnadorRareCountNormalKyoMemory1") var rareCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareCzCountNormalKyoMemory1") var rareCzCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareAtCountNormalKyoMemory1") var rareAtCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareCountNormalGokuMemory1") var rareCountNormalGoku: Int = 0
    @AppStorage("ragnadorRareAtCountNormalGokuMemory1") var rareAtCountNormalGoku: Int = 0
    @AppStorage("ragnadorRareCountHighSuikaMemory1") var rareCountHighSuika: Int = 0
    @AppStorage("ragnadorRareAtCountHighSuikaMemory1") var rareAtCountHighSuika: Int = 0
    @AppStorage("ragnadorRareCountHighChanceMemory1") var rareCountHighChance: Int = 0
    @AppStorage("ragnadorRareCzCountHighChanceMemory1") var rareCzCountHighChance: Int = 0
    @AppStorage("ragnadorRareAtCountHighChanceMemory1") var rareAtCountHighChance: Int = 0
    @AppStorage("ragnadorRareCountHighKyoMemory1") var rareCountHighKyo: Int = 0
    @AppStorage("ragnadorRareCzCountHighKyoMemory1") var rareCzCountHighKyo: Int = 0
    @AppStorage("ragnadorRareAtCountHighKyoMemory1") var rareAtCountHighKyo: Int = 0
    @AppStorage("ragnadorEnemyIncludeFirstIntervalMemory1") var enemyIncludeFirstInterval: Bool = false
    @AppStorage("ragnadorGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("ragnadorEntryKindArrayKeyMemory1") var entryKindArrayData: Data?
    @AppStorage("ragnadorEnemyArrayKeyMemory1") var enemyArrayData: Data?
    @AppStorage("ragnadorResultArrayKeyMemory1") var resultArrayData: Data?
    @AppStorage("ragnadorPlayGameSumMemory1") var playGameSum: Int = 0
    @AppStorage("ragnadorFirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("ragnadorFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("ragnadorFirstHitInputModeMemory1") var firstHitInputMode: String = "履歴入力"
    @AppStorage("ragnadorManualNormalGameMemory1") var manualNormalGame: Int = 0
    @AppStorage("ragnadorManualFirstHitCountCzMemory1") var manualFirstHitCountCz: Int = 0
    @AppStorage("ragnadorManualFirstHitCountAtMemory1") var manualFirstHitCountAt: Int = 0
    @AppStorage("ragnadorVoiceCount1Memory1") var voiceCount1: Int = 0
    @AppStorage("ragnadorVoiceCount2Memory1") var voiceCount2: Int = 0
    @AppStorage("ragnadorVoiceCount3Memory1") var voiceCount3: Int = 0
    @AppStorage("ragnadorVoiceCount4Memory1") var voiceCount4: Int = 0
    @AppStorage("ragnadorVoiceCount5Memory1") var voiceCount5: Int = 0
    @AppStorage("ragnadorVoiceCount6Memory1") var voiceCount6: Int = 0
    @AppStorage("ragnadorVoiceCount7Memory1") var voiceCount7: Int = 0
    @AppStorage("ragnadorVoiceCount8Memory1") var voiceCount8: Int = 0
    @AppStorage("ragnadorVoiceCountSumMemory1") var voiceCountSum: Int = 0
    @AppStorage("ragnadorEndVoiceCount1Memory1") var endVoiceCount1: Int = 0
    @AppStorage("ragnadorEndVoiceCount2Memory1") var endVoiceCount2: Int = 0
    @AppStorage("ragnadorEndVoiceCount3Memory1") var endVoiceCount3: Int = 0
    @AppStorage("ragnadorEndVoiceCountSumMemory1") var endVoiceCountSum: Int = 0
    @AppStorage("ragnadorMemoMemory1") var memo = ""
    @AppStorage("ragnadorDateMemory1") var dateDouble = 0.0
}


class RagnadorMemory2: ObservableObject {
    @AppStorage("ragnadorWeakCherryCountMemory2") var weakCherryCount: Int = 0
    @AppStorage("ragnadorWeakCherryUpCountHighMemory2") var weakCherryUpCountHigh: Int = 0
    @AppStorage("ragnadorWeakCherryUpCountSuperHighMemory2") var weakCherryUpCountSuperHigh: Int = 0
    @AppStorage("ragnadorRareCountNormalSuikaMemory2") var rareCountNormalSuika: Int = 0
    @AppStorage("ragnadorRareAtCountNormalSuikaMemory2") var rareAtCountNormalSuika: Int = 0
    @AppStorage("ragnadorRareCountNormalChanceMemory2") var rareCountNormalChance: Int = 0
    @AppStorage("ragnadorRareCzCountNormalChanceMemory2") var rareCzCountNormalChance: Int = 0
    @AppStorage("ragnadorRareAtCountNormalChanceMemory2") var rareAtCountNormalChance: Int = 0
    @AppStorage("ragnadorRareCountNormalKyoMemory2") var rareCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareCzCountNormalKyoMemory2") var rareCzCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareAtCountNormalKyoMemory2") var rareAtCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareCountNormalGokuMemory2") var rareCountNormalGoku: Int = 0
    @AppStorage("ragnadorRareAtCountNormalGokuMemory2") var rareAtCountNormalGoku: Int = 0
    @AppStorage("ragnadorRareCountHighSuikaMemory2") var rareCountHighSuika: Int = 0
    @AppStorage("ragnadorRareAtCountHighSuikaMemory2") var rareAtCountHighSuika: Int = 0
    @AppStorage("ragnadorRareCountHighChanceMemory2") var rareCountHighChance: Int = 0
    @AppStorage("ragnadorRareCzCountHighChanceMemory2") var rareCzCountHighChance: Int = 0
    @AppStorage("ragnadorRareAtCountHighChanceMemory2") var rareAtCountHighChance: Int = 0
    @AppStorage("ragnadorRareCountHighKyoMemory2") var rareCountHighKyo: Int = 0
    @AppStorage("ragnadorRareCzCountHighKyoMemory2") var rareCzCountHighKyo: Int = 0
    @AppStorage("ragnadorRareAtCountHighKyoMemory2") var rareAtCountHighKyo: Int = 0
    @AppStorage("ragnadorEnemyIncludeFirstIntervalMemory2") var enemyIncludeFirstInterval: Bool = false
    @AppStorage("ragnadorGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("ragnadorEntryKindArrayKeyMemory2") var entryKindArrayData: Data?
    @AppStorage("ragnadorEnemyArrayKeyMemory2") var enemyArrayData: Data?
    @AppStorage("ragnadorResultArrayKeyMemory2") var resultArrayData: Data?
    @AppStorage("ragnadorPlayGameSumMemory2") var playGameSum: Int = 0
    @AppStorage("ragnadorFirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("ragnadorFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("ragnadorFirstHitInputModeMemory2") var firstHitInputMode: String = "履歴入力"
    @AppStorage("ragnadorManualNormalGameMemory2") var manualNormalGame: Int = 0
    @AppStorage("ragnadorManualFirstHitCountCzMemory2") var manualFirstHitCountCz: Int = 0
    @AppStorage("ragnadorManualFirstHitCountAtMemory2") var manualFirstHitCountAt: Int = 0
    @AppStorage("ragnadorVoiceCount1Memory2") var voiceCount1: Int = 0
    @AppStorage("ragnadorVoiceCount2Memory2") var voiceCount2: Int = 0
    @AppStorage("ragnadorVoiceCount3Memory2") var voiceCount3: Int = 0
    @AppStorage("ragnadorVoiceCount4Memory2") var voiceCount4: Int = 0
    @AppStorage("ragnadorVoiceCount5Memory2") var voiceCount5: Int = 0
    @AppStorage("ragnadorVoiceCount6Memory2") var voiceCount6: Int = 0
    @AppStorage("ragnadorVoiceCount7Memory2") var voiceCount7: Int = 0
    @AppStorage("ragnadorVoiceCount8Memory2") var voiceCount8: Int = 0
    @AppStorage("ragnadorVoiceCountSumMemory2") var voiceCountSum: Int = 0
    @AppStorage("ragnadorEndVoiceCount1Memory2") var endVoiceCount1: Int = 0
    @AppStorage("ragnadorEndVoiceCount2Memory2") var endVoiceCount2: Int = 0
    @AppStorage("ragnadorEndVoiceCount3Memory2") var endVoiceCount3: Int = 0
    @AppStorage("ragnadorEndVoiceCountSumMemory2") var endVoiceCountSum: Int = 0
    @AppStorage("ragnadorMemoMemory2") var memo = ""
    @AppStorage("ragnadorDateMemory2") var dateDouble = 0.0
}


class RagnadorMemory3: ObservableObject {
    @AppStorage("ragnadorWeakCherryCountMemory3") var weakCherryCount: Int = 0
    @AppStorage("ragnadorWeakCherryUpCountHighMemory3") var weakCherryUpCountHigh: Int = 0
    @AppStorage("ragnadorWeakCherryUpCountSuperHighMemory3") var weakCherryUpCountSuperHigh: Int = 0
    @AppStorage("ragnadorRareCountNormalSuikaMemory3") var rareCountNormalSuika: Int = 0
    @AppStorage("ragnadorRareAtCountNormalSuikaMemory3") var rareAtCountNormalSuika: Int = 0
    @AppStorage("ragnadorRareCountNormalChanceMemory3") var rareCountNormalChance: Int = 0
    @AppStorage("ragnadorRareCzCountNormalChanceMemory3") var rareCzCountNormalChance: Int = 0
    @AppStorage("ragnadorRareAtCountNormalChanceMemory3") var rareAtCountNormalChance: Int = 0
    @AppStorage("ragnadorRareCountNormalKyoMemory3") var rareCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareCzCountNormalKyoMemory3") var rareCzCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareAtCountNormalKyoMemory3") var rareAtCountNormalKyo: Int = 0
    @AppStorage("ragnadorRareCountNormalGokuMemory3") var rareCountNormalGoku: Int = 0
    @AppStorage("ragnadorRareAtCountNormalGokuMemory3") var rareAtCountNormalGoku: Int = 0
    @AppStorage("ragnadorRareCountHighSuikaMemory3") var rareCountHighSuika: Int = 0
    @AppStorage("ragnadorRareAtCountHighSuikaMemory3") var rareAtCountHighSuika: Int = 0
    @AppStorage("ragnadorRareCountHighChanceMemory3") var rareCountHighChance: Int = 0
    @AppStorage("ragnadorRareCzCountHighChanceMemory3") var rareCzCountHighChance: Int = 0
    @AppStorage("ragnadorRareAtCountHighChanceMemory3") var rareAtCountHighChance: Int = 0
    @AppStorage("ragnadorRareCountHighKyoMemory3") var rareCountHighKyo: Int = 0
    @AppStorage("ragnadorRareCzCountHighKyoMemory3") var rareCzCountHighKyo: Int = 0
    @AppStorage("ragnadorRareAtCountHighKyoMemory3") var rareAtCountHighKyo: Int = 0
    @AppStorage("ragnadorEnemyIncludeFirstIntervalMemory3") var enemyIncludeFirstInterval: Bool = false
    @AppStorage("ragnadorGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("ragnadorEntryKindArrayKeyMemory3") var entryKindArrayData: Data?
    @AppStorage("ragnadorEnemyArrayKeyMemory3") var enemyArrayData: Data?
    @AppStorage("ragnadorResultArrayKeyMemory3") var resultArrayData: Data?
    @AppStorage("ragnadorPlayGameSumMemory3") var playGameSum: Int = 0
    @AppStorage("ragnadorFirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("ragnadorFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("ragnadorFirstHitInputModeMemory3") var firstHitInputMode: String = "履歴入力"
    @AppStorage("ragnadorManualNormalGameMemory3") var manualNormalGame: Int = 0
    @AppStorage("ragnadorManualFirstHitCountCzMemory3") var manualFirstHitCountCz: Int = 0
    @AppStorage("ragnadorManualFirstHitCountAtMemory3") var manualFirstHitCountAt: Int = 0
    @AppStorage("ragnadorVoiceCount1Memory3") var voiceCount1: Int = 0
    @AppStorage("ragnadorVoiceCount2Memory3") var voiceCount2: Int = 0
    @AppStorage("ragnadorVoiceCount3Memory3") var voiceCount3: Int = 0
    @AppStorage("ragnadorVoiceCount4Memory3") var voiceCount4: Int = 0
    @AppStorage("ragnadorVoiceCount5Memory3") var voiceCount5: Int = 0
    @AppStorage("ragnadorVoiceCount6Memory3") var voiceCount6: Int = 0
    @AppStorage("ragnadorVoiceCount7Memory3") var voiceCount7: Int = 0
    @AppStorage("ragnadorVoiceCount8Memory3") var voiceCount8: Int = 0
    @AppStorage("ragnadorVoiceCountSumMemory3") var voiceCountSum: Int = 0
    @AppStorage("ragnadorEndVoiceCount1Memory3") var endVoiceCount1: Int = 0
    @AppStorage("ragnadorEndVoiceCount2Memory3") var endVoiceCount2: Int = 0
    @AppStorage("ragnadorEndVoiceCount3Memory3") var endVoiceCount3: Int = 0
    @AppStorage("ragnadorEndVoiceCountSumMemory3") var endVoiceCountSum: Int = 0
    @AppStorage("ragnadorMemoMemory3") var memo = ""
    @AppStorage("ragnadorDateMemory3") var dateDouble = 0.0
}


// 敵選択テーブルの区間（設定変更後またはAT後から、次のAT当選まで）
struct RagnadorEnemyInterval {
    var isAfterAt: Bool   // true＝AT後（テーブル6〜10）、false＝設定変更後（テーブル1〜5）
    var enemies: [Int]    // CZごとの敵（enemyList の番号。古い順）
    var isOpen: Bool = false   // まだAT当選していない現在の区間か
}
