//
//  kanokariClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Kanokari: ObservableObject {
    // -------
    // 通常時
    // -------
    // ---- かのかりBONUS後（1Gレンチャンス終了後も同様）のモード振分け（％）
    let ratioModeA: [Double] = [74.6,72.3,68.4,55.1,53.5,51.6]
    let ratioModeB: [Double] = [21.5,23.0,26.2,35.5,36.3,37.5]
    let ratioModeC: [Double] = [3.9,4.7,5.5,9.4,10.2,10.9]
    // モードごとのゾーンでのCZ当選率（％）。並びはモードA・B・C
    let ratioModeZone100: [Double] = [10.2,30.1,100]
    let ratioModeZone300: [Double] = [10.2,40.2,30.1]
    // ゾーン到達時のCZ当選率（独自算出）
    // モード振分け × モードごとの当選率から算出。300Gは100Gの結果でモードの見込みを更新してから算出する
    // 3つの割合の積は「1回のBONUS後の結果」の確率と一致するため、3つとも数えても二重計上にならない
    var ratioZone100: [Double] { zoneRatio(after100: nil) }
    var ratioZone300Atari: [Double] { zoneRatio(after100: true) }
    var ratioZone300Through: [Double] { zoneRatio(after100: false) }
    @AppStorage("kanokariZone100CountMiss") var zone100CountMiss: Int = 0
    @AppStorage("kanokariZone100CountHit") var zone100CountHit: Int = 0
    @AppStorage("kanokariZone100CountSum") var zone100CountSum: Int = 0
    @AppStorage("kanokariZone300AtariCountMiss") var zone300AtariCountMiss: Int = 0
    @AppStorage("kanokariZone300AtariCountHit") var zone300AtariCountHit: Int = 0
    @AppStorage("kanokariZone300AtariCountSum") var zone300AtariCountSum: Int = 0
    @AppStorage("kanokariZone300ThroughCountMiss") var zone300ThroughCountMiss: Int = 0
    @AppStorage("kanokariZone300ThroughCountHit") var zone300ThroughCountHit: Int = 0
    @AppStorage("kanokariZone300ThroughCountSum") var zone300ThroughCountSum: Int = 0

    func zone100SumFunc() {
        zone100CountSum = zone100CountHit + zone100CountMiss
    }

    func zone300AtariSumFunc() {
        zone300AtariCountSum = zone300AtariCountHit + zone300AtariCountMiss
    }

    func zone300ThroughSumFunc() {
        zone300ThroughCountSum = zone300ThroughCountHit + zone300ThroughCountMiss
    }

    // after100：nil＝100G到達時、true＝100G当選後の300G、false＝100Gスルー後の300G
    private func zoneRatio(after100: Bool?) -> [Double] {
        let modeLists = [ratioModeA, ratioModeB, ratioModeC]
        return ratioModeA.indices.map { setting in
            let total = modeLists.reduce(0.0) { $0 + $1[setting] }
            // 各モードの重み（100Gの結果があればその結果になる確率を掛けて更新）
            let weights: [Double] = modeLists.indices.map { mode in
                let share = modeLists[mode][setting] / total
                let hit100 = ratioModeZone100[mode] / 100
                switch after100 {
                case .none: return share
                case .some(true): return share * hit100
                case .some(false): return share * (1 - hit100)
                }
            }
            let weightSum = weights.reduce(0, +)
            guard weightSum > 0 else { return 0 }
            let zoneList = after100 == nil ? ratioModeZone100 : ratioModeZone300
            return zip(weights, zoneList).reduce(0.0) { $0 + $1.0 * $1.1 } / weightSum
        }
    }

    func resetNormal() {
        zone100CountMiss = 0
        zone100CountHit = 0
        zone100CountSum = 0
        zone300AtariCountMiss = 0
        zone300AtariCountHit = 0
        zone300AtariCountSum = 0
        zone300ThroughCountMiss = 0
        zone300ThroughCountHit = 0
        zone300ThroughCountSum = 0
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [172,169,164,154,151,149]
    let ratioFirstHitBonus: [Double] = [269,263,254,235,231,226]
    @AppStorage("kanokariNormalGame") var normalGame: Int = 0
    @AppStorage("kanokariFirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("kanokariFirstHitCountBonus") var firstHitCountBonus: Int = 0
    // ---- REG連続天井（振分け％：3〜6回）
    let ratioRegTenjo3: [Double] = [1.6,2.0,2.3,2.7,3.1,3.5]
    let ratioRegTenjo4: [Double] = [12.5,13.3,14.1,15.6,16.0,16.4]
    let ratioRegTenjo5: [Double] = [35.9,37.1,38.3,40.2,41.0,41.8]
    let ratioRegTenjo6: [Double] = [50.0,47.7,45.3,41.4,39.8,38.3]
    // 段階ごとの天井率（その回数まで天井が来ずに到達したときに、その回数で天井となる割合）
    // 振分けは1回の抽選だが、段階ごとの割合の積は振分けの確率と一致するため、段階ごとに数えても二重計上にならない
    var ratioRegTenjoStage3: [Double] { regTenjoStageRatio(stage: 0) }
    var ratioRegTenjoStage4: [Double] { regTenjoStageRatio(stage: 1) }
    var ratioRegTenjoStage5: [Double] { regTenjoStageRatio(stage: 2) }
    @AppStorage("kanokariRegTenjo3CountMiss") var regTenjo3CountMiss: Int = 0
    @AppStorage("kanokariRegTenjo3CountHit") var regTenjo3CountHit: Int = 0
    @AppStorage("kanokariRegTenjo3CountSum") var regTenjo3CountSum: Int = 0
    @AppStorage("kanokariRegTenjo4CountMiss") var regTenjo4CountMiss: Int = 0
    @AppStorage("kanokariRegTenjo4CountHit") var regTenjo4CountHit: Int = 0
    @AppStorage("kanokariRegTenjo4CountSum") var regTenjo4CountSum: Int = 0
    @AppStorage("kanokariRegTenjo5CountMiss") var regTenjo5CountMiss: Int = 0
    @AppStorage("kanokariRegTenjo5CountHit") var regTenjo5CountHit: Int = 0
    @AppStorage("kanokariRegTenjo5CountSum") var regTenjo5CountSum: Int = 0

    func regTenjo3SumFunc() {
        regTenjo3CountSum = regTenjo3CountHit + regTenjo3CountMiss
    }

    func regTenjo4SumFunc() {
        regTenjo4CountSum = regTenjo4CountHit + regTenjo4CountMiss
    }

    func regTenjo5SumFunc() {
        regTenjo5CountSum = regTenjo5CountHit + regTenjo5CountMiss
    }

    // 振分けから段階ごとの天井率（％）を求める。stage は 0＝3回目、1＝4回目、2＝5回目
    private func regTenjoStageRatio(stage: Int) -> [Double] {
        let lists = [ratioRegTenjo3, ratioRegTenjo4, ratioRegTenjo5, ratioRegTenjo6]
        return lists[0].indices.map { setting in
            // 表の合計が丸めで100からずれるため、合計で割り戻す
            let total = lists.reduce(0.0) { $0 + $1[setting] }
            let passed = (0..<stage).reduce(0.0) { $0 + lists[$1][setting] }
            let remain = total - passed
            return remain > 0 ? lists[stage][setting] / remain * 100 : 0
        }
    }

    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountBonus = 0
        regTenjo3CountMiss = 0
        regTenjo3CountHit = 0
        regTenjo3CountSum = 0
        regTenjo4CountMiss = 0
        regTenjo4CountHit = 0
        regTenjo4CountSum = 0
        regTenjo5CountMiss = 0
        regTenjo5CountHit = 0
        regTenjo5CountSum = 0
        minusCheck = false
    }

    // -------
    // 画面選択
    // -------
    // 振分け（%）。screenCount1〜7 と同じ並び
    let ratioScreen1: [Double] = [82.5,80.9,75.9,75.2,66.9,66.1]   // 枠なし
    let ratioScreen2: [Double] = [15.0,15.0,17.5,17.5,20.0,20.0]   // 白枠 BBQ
    let ratioScreen3: [Double] = [2.5,2.5,5.0,5.0,10.0,10.0]       // 白枠 浜辺
    let ratioScreen4: [Double] = [0,1.6,1.6,1.6,1.6,1.6]           // 赤枠
    let ratioScreen5: [Double] = [0,0,0,0.8,0.8,0.8]               // 紫枠
    let ratioScreen6: [Double] = [0,0,0,0,0.8,0.8]                 // 銀枠
    let ratioScreen7: [Double] = [0,0,0,0,0,0.8]                   // 金枠
    @AppStorage("kanokariScreenCount1") var screenCount1: Int = 0
    @AppStorage("kanokariScreenCount2") var screenCount2: Int = 0
    @AppStorage("kanokariScreenCount3") var screenCount3: Int = 0
    @AppStorage("kanokariScreenCount4") var screenCount4: Int = 0
    @AppStorage("kanokariScreenCount5") var screenCount5: Int = 0
    @AppStorage("kanokariScreenCount6") var screenCount6: Int = 0
    @AppStorage("kanokariScreenCount7") var screenCount7: Int = 0
    @AppStorage("kanokariScreenCountSum") var screenCountSum: Int = 0

    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
            screenCount4,
            screenCount5,
            screenCount6,
            screenCount7,
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
        screenCountSum = 0
        minusCheck = false
    }

    // -------
    // RB中 キャラ紹介シナリオ
    // -------
    // 振分け（%）。カウントと同じ並び（シナリオ番号は右のコメント）
    let ratioRbCharaDefault: [Double] = [43.8,41.4,35.9,34.8,27.7,25.0]   // ①
    let ratioRbCharaKisu: [Double] = [15.6,12.5,15.6,12.5,15.6,12.5]   // ②
    let ratioRbCharaGusu: [Double] = [12.5,15.6,12.5,15.6,12.5,15.6]   // ③
    let ratioRbCharaHighJaku: [Double] = [12.5,13.3,14.1,14.8,15.6,16.4]   // ④
    let ratioRbCharaHighKyo: [Double] = [3.1,3.1,6.3,6.3,12.5,12.5]   // ⑤
    let ratioRbCharaNegate1: [Double] = [0,6.3,1.6,1.6,1.6,1.6]   // ⑦
    let ratioRbCharaNegate2: [Double] = [3.1,0,6.3,1.6,1.6,1.6]   // ⑧
    let ratioRbCharaNegate3: [Double] = [3.1,1.6,0,6.3,1.6,1.6]   // ⑨
    let ratioRbCharaNegate4: [Double] = [3.1,1.6,1.6,0,6.3,1.6]   // ⑩
    let ratioRbCharaNegate5: [Double] = [3.1,1.6,1.6,1.6,0,6.3]   // ⑪
    let ratioRbCharaOver2: [Double] = [0,3.1,3.1,3.1,3.1,3.1]   // ⑫
    let ratioRbCharaOver3: [Double] = [0,0,1.6,1.6,1.6,1.6]   // ⑬
    let ratioRbCharaOver4: [Double] = [0,0,0,0.4,0.2,0.2]   // ⑭
    let ratioRbCharaOver5: [Double] = [0,0,0,0,0.2,0.2]   // ⑮
    let ratioRbCharaOver6: [Double] = [0,0,0,0,0,0.4]   // ⑥
    @AppStorage("kanokariRbCharaCountDefault") var rbCharaCountDefault: Int = 0
    @AppStorage("kanokariRbCharaCountKisu") var rbCharaCountKisu: Int = 0
    @AppStorage("kanokariRbCharaCountGusu") var rbCharaCountGusu: Int = 0
    @AppStorage("kanokariRbCharaCountHighJaku") var rbCharaCountHighJaku: Int = 0
    @AppStorage("kanokariRbCharaCountHighKyo") var rbCharaCountHighKyo: Int = 0
    @AppStorage("kanokariRbCharaCountNegate1") var rbCharaCountNegate1: Int = 0
    @AppStorage("kanokariRbCharaCountNegate2") var rbCharaCountNegate2: Int = 0
    @AppStorage("kanokariRbCharaCountNegate3") var rbCharaCountNegate3: Int = 0
    @AppStorage("kanokariRbCharaCountNegate4") var rbCharaCountNegate4: Int = 0
    @AppStorage("kanokariRbCharaCountNegate5") var rbCharaCountNegate5: Int = 0
    @AppStorage("kanokariRbCharaCountOver2") var rbCharaCountOver2: Int = 0
    @AppStorage("kanokariRbCharaCountOver3") var rbCharaCountOver3: Int = 0
    @AppStorage("kanokariRbCharaCountOver4") var rbCharaCountOver4: Int = 0
    @AppStorage("kanokariRbCharaCountOver5") var rbCharaCountOver5: Int = 0
    @AppStorage("kanokariRbCharaCountOver6") var rbCharaCountOver6: Int = 0
    @AppStorage("kanokariRbCharaCountSum") var rbCharaCountSum: Int = 0

    func rbCharaSumFunc() {
        rbCharaCountSum = countSum(
            rbCharaCountDefault,
            rbCharaCountKisu,
            rbCharaCountGusu,
            rbCharaCountHighJaku,
            rbCharaCountHighKyo,
            rbCharaCountNegate1,
            rbCharaCountNegate2,
            rbCharaCountNegate3,
            rbCharaCountNegate4,
            rbCharaCountNegate5,
            rbCharaCountOver2,
            rbCharaCountOver3,
            rbCharaCountOver4,
            rbCharaCountOver5,
            rbCharaCountOver6,
        )
    }

    func resetRbChara() {
        rbCharaCountDefault = 0
        rbCharaCountKisu = 0
        rbCharaCountGusu = 0
        rbCharaCountHighJaku = 0
        rbCharaCountHighKyo = 0
        rbCharaCountNegate1 = 0
        rbCharaCountNegate2 = 0
        rbCharaCountNegate3 = 0
        rbCharaCountNegate4 = 0
        rbCharaCountNegate5 = 0
        rbCharaCountOver2 = 0
        rbCharaCountOver3 = 0
        rbCharaCountOver4 = 0
        rbCharaCountOver5 = 0
        rbCharaCountOver6 = 0
        rbCharaCountSum = 0
        minusCheck = false
    }

    // -------
    // キャラ選択（1Gレンチャンス）
    // -------
    // 振分け（%）。シナリオ①〜④（①③＝偶数示唆、②④＝奇数示唆）
    let ratioKoryakuChara1: [Double] = [22.5,27.5,22.5,27.5,22.5,27.5]   // ① 麻美→瑠夏→墨→千鶴
    let ratioKoryakuChara2: [Double] = [27.5,22.5,27.5,22.5,27.5,22.5]   // ② 瑠夏→墨→千鶴→麻美
    let ratioKoryakuChara3: [Double] = [22.5,27.5,22.5,27.5,22.5,27.5]   // ③ 墨→千鶴→麻美→瑠夏
    let ratioKoryakuChara4: [Double] = [27.5,22.5,27.5,22.5,27.5,22.5]   // ④ 千鶴→麻美→瑠夏→墨
    // 示唆ごとの合算（koryakuCharaCount1／2 と対応）
    let ratioKoryakuCharaGusu: [Double] = [45,55,45,55,45,55]   // 偶数示唆（①＋③）
    let ratioKoryakuCharaKisu: [Double] = [55,45,55,45,55,45]   // 奇数示唆（②＋④）
    @AppStorage("kanokariKoryakuCharaCount1") var koryakuCharaCount1: Int = 0   // 偶数設定示唆
    @AppStorage("kanokariKoryakuCharaCount2") var koryakuCharaCount2: Int = 0   // 奇数設定示唆
    @AppStorage("kanokariKoryakuCharaCountSum") var koryakuCharaCountSum: Int = 0

    func koryakuCharaSumFunc() {
        koryakuCharaCountSum = countSum(
            koryakuCharaCount1,
            koryakuCharaCount2,
        )
    }

    func resetKoryakuChara() {
        koryakuCharaCount1 = 0
        koryakuCharaCount2 = 0
        koryakuCharaCountSum = 0
        minusCheck = false
    }

    // -------
    // ボイス選択（エンディング）
    // -------
    // 強チャンス目時のボイス振分け（%）。参考情報のみ（設定期待値には未使用）
    let ratioEndingVoiceKyoChanceDefault: [Double] = [16.4,12.6,11.2,9.1,7.3,5.6]
    let ratioEndingVoiceKyoChanceHighJaku: [Double] = [25.0,25.4,26.2,27.0,27.7,28.5]
    let ratioEndingVoiceKyoChanceHighChu: [Double] = [6.3,7.0,8.6,10.2,11.7,13.3]
    let ratioEndingVoiceKyoChanceHighKyo: [Double] = [3.1,4.7,7.8,10.9,14.1,17.2]
    let ratioEndingVoiceKyoChanceOver2: [Double] = [0,12.5,12.5,12.5,12.5,12.5]
    let ratioEndingVoiceKyoChanceOver4: [Double] = [0,0,0,3.1,3.1,3.1]
    let ratioEndingVoiceKyoChanceOver5: [Double] = [0,0,0,0,1.6,1.6]
    let ratioEndingVoiceKyoChanceOver6: [Double] = [0,0,0,0,0,1.6]
    let ratioEndingVoiceOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioEndingVoiceOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioEndingVoiceOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioEndingVoiceOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("kanokariEndingVoiceCount1") var endingVoiceCount1: Int = 0   // デフォルト
    @AppStorage("kanokariEndingVoiceCount2") var endingVoiceCount2: Int = 0   // 高設定示唆 弱
    @AppStorage("kanokariEndingVoiceCount3") var endingVoiceCount3: Int = 0   // 高設定示唆 中
    @AppStorage("kanokariEndingVoiceCount4") var endingVoiceCount4: Int = 0   // 高設定示唆 強
    @AppStorage("kanokariEndingVoiceCount5") var endingVoiceCount5: Int = 0   // 設定2 以上濃厚
    @AppStorage("kanokariEndingVoiceCount6") var endingVoiceCount6: Int = 0   // 設定4 以上濃厚
    @AppStorage("kanokariEndingVoiceCount7") var endingVoiceCount7: Int = 0   // 設定5 以上濃厚
    @AppStorage("kanokariEndingVoiceCount8") var endingVoiceCount8: Int = 0   // 設定6 濃厚
    @AppStorage("kanokariEndingVoiceCountSum") var endingVoiceCountSum: Int = 0

    func endingVoiceSumFunc() {
        endingVoiceCountSum = countSum(
            endingVoiceCount1,
            endingVoiceCount2,
            endingVoiceCount3,
            endingVoiceCount4,
            endingVoiceCount5,
            endingVoiceCount6,
            endingVoiceCount7,
            endingVoiceCount8,
        )
    }

    func resetEndingVoice() {
        endingVoiceCount1 = 0
        endingVoiceCount2 = 0
        endingVoiceCount3 = 0
        endingVoiceCount4 = 0
        endingVoiceCount5 = 0
        endingVoiceCount6 = 0
        endingVoiceCount7 = 0
        endingVoiceCount8 = 0
        endingVoiceCountSum = 0
        minusCheck = false
    }

    // -------
    // 引き戻し
    // -------
    // 引き戻し期待度（非ユメカノモードは全設定共通、ユメカノモードに設定差）
    let ratioComebackNormal: [Double] = [24.7,24.7,24.7,24.7,24.7,24.7]
    let ratioComebackYumekano: [Double] = [58.0,58.2,58.3,58.7,60.0,63.8]
    @AppStorage("kanokariComebackYumekanoCountMiss") var comebackYumekanoCountMiss: Int = 0
    @AppStorage("kanokariComebackYumekanoCountHit") var comebackYumekanoCountHit: Int = 0
    @AppStorage("kanokariComebackYumekanoCountSum") var comebackYumekanoCountSum: Int = 0

    func comebackYumekanoSumFunc() {
        comebackYumekanoCountSum = comebackYumekanoCountHit + comebackYumekanoCountMiss
    }

    // 引き戻し当選時のななかりDREAM当選率
    let ratioDreamNormal: [Double] = [2.8,3.1,3.6,3.8,4.3,4.6]
    let ratioDreamYumekano: [Double] = [19.2,20.5,23.6,28.3,31.5,36.4]
    @AppStorage("kanokariDreamNormalCountMiss") var dreamNormalCountMiss: Int = 0
    @AppStorage("kanokariDreamNormalCountHit") var dreamNormalCountHit: Int = 0
    @AppStorage("kanokariDreamNormalCountSum") var dreamNormalCountSum: Int = 0
    @AppStorage("kanokariDreamYumekanoCountMiss") var dreamYumekanoCountMiss: Int = 0
    @AppStorage("kanokariDreamYumekanoCountHit") var dreamYumekanoCountHit: Int = 0
    @AppStorage("kanokariDreamYumekanoCountSum") var dreamYumekanoCountSum: Int = 0

    func dreamNormalSumFunc() {
        dreamNormalCountSum = dreamNormalCountHit + dreamNormalCountMiss
    }

    func dreamYumekanoSumFunc() {
        dreamYumekanoCountSum = dreamYumekanoCountHit + dreamYumekanoCountMiss
    }

    func resetComeback() {
        comebackYumekanoCountMiss = 0
        comebackYumekanoCountHit = 0
        comebackYumekanoCountSum = 0
        dreamNormalCountMiss = 0
        dreamNormalCountHit = 0
        dreamNormalCountSum = 0
        dreamYumekanoCountMiss = 0
        dreamYumekanoCountHit = 0
        dreamYumekanoCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "彼女、お借りします"
    @AppStorage("kanokariMinusCheck") var minusCheck: Bool = false
    @AppStorage("kanokariSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetRbChara()
        resetKoryakuChara()
        resetEndingVoice()
        resetComeback()
    }
}


class KanokariMemory1: ObservableObject {
    @AppStorage("kanokariNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("kanokariFirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("kanokariFirstHitCountBonusMemory1") var firstHitCountBonus: Int = 0
    @AppStorage("kanokariScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("kanokariScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("kanokariScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("kanokariScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("kanokariScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("kanokariScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("kanokariScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("kanokariScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("kanokariRbCharaCountDefaultMemory1") var rbCharaCountDefault: Int = 0
    @AppStorage("kanokariRbCharaCountKisuMemory1") var rbCharaCountKisu: Int = 0
    @AppStorage("kanokariRbCharaCountGusuMemory1") var rbCharaCountGusu: Int = 0
    @AppStorage("kanokariRbCharaCountHighJakuMemory1") var rbCharaCountHighJaku: Int = 0
    @AppStorage("kanokariRbCharaCountHighKyoMemory1") var rbCharaCountHighKyo: Int = 0
    @AppStorage("kanokariRbCharaCountNegate1Memory1") var rbCharaCountNegate1: Int = 0
    @AppStorage("kanokariRbCharaCountNegate2Memory1") var rbCharaCountNegate2: Int = 0
    @AppStorage("kanokariRbCharaCountNegate3Memory1") var rbCharaCountNegate3: Int = 0
    @AppStorage("kanokariRbCharaCountNegate4Memory1") var rbCharaCountNegate4: Int = 0
    @AppStorage("kanokariRbCharaCountNegate5Memory1") var rbCharaCountNegate5: Int = 0
    @AppStorage("kanokariRbCharaCountOver2Memory1") var rbCharaCountOver2: Int = 0
    @AppStorage("kanokariRbCharaCountOver3Memory1") var rbCharaCountOver3: Int = 0
    @AppStorage("kanokariRbCharaCountOver4Memory1") var rbCharaCountOver4: Int = 0
    @AppStorage("kanokariRbCharaCountOver5Memory1") var rbCharaCountOver5: Int = 0
    @AppStorage("kanokariRbCharaCountOver6Memory1") var rbCharaCountOver6: Int = 0
    @AppStorage("kanokariRbCharaCountSumMemory1") var rbCharaCountSum: Int = 0
    @AppStorage("kanokariKoryakuCharaCount1Memory1") var koryakuCharaCount1: Int = 0
    @AppStorage("kanokariKoryakuCharaCount2Memory1") var koryakuCharaCount2: Int = 0
    @AppStorage("kanokariKoryakuCharaCountSumMemory1") var koryakuCharaCountSum: Int = 0
    @AppStorage("kanokariEndingVoiceCount1Memory1") var endingVoiceCount1: Int = 0
    @AppStorage("kanokariEndingVoiceCount2Memory1") var endingVoiceCount2: Int = 0
    @AppStorage("kanokariEndingVoiceCount3Memory1") var endingVoiceCount3: Int = 0
    @AppStorage("kanokariEndingVoiceCount4Memory1") var endingVoiceCount4: Int = 0
    @AppStorage("kanokariEndingVoiceCount5Memory1") var endingVoiceCount5: Int = 0
    @AppStorage("kanokariEndingVoiceCount6Memory1") var endingVoiceCount6: Int = 0
    @AppStorage("kanokariEndingVoiceCount7Memory1") var endingVoiceCount7: Int = 0
    @AppStorage("kanokariEndingVoiceCount8Memory1") var endingVoiceCount8: Int = 0
    @AppStorage("kanokariEndingVoiceCountSumMemory1") var endingVoiceCountSum: Int = 0
    @AppStorage("kanokariComebackYumekanoCountMissMemory1") var comebackYumekanoCountMiss: Int = 0
    @AppStorage("kanokariComebackYumekanoCountHitMemory1") var comebackYumekanoCountHit: Int = 0
    @AppStorage("kanokariComebackYumekanoCountSumMemory1") var comebackYumekanoCountSum: Int = 0
    @AppStorage("kanokariDreamNormalCountMissMemory1") var dreamNormalCountMiss: Int = 0
    @AppStorage("kanokariDreamNormalCountHitMemory1") var dreamNormalCountHit: Int = 0
    @AppStorage("kanokariDreamNormalCountSumMemory1") var dreamNormalCountSum: Int = 0
    @AppStorage("kanokariDreamYumekanoCountMissMemory1") var dreamYumekanoCountMiss: Int = 0
    @AppStorage("kanokariDreamYumekanoCountHitMemory1") var dreamYumekanoCountHit: Int = 0
    @AppStorage("kanokariDreamYumekanoCountSumMemory1") var dreamYumekanoCountSum: Int = 0
    @AppStorage("kanokariRegTenjo3CountMissMemory1") var regTenjo3CountMiss: Int = 0
    @AppStorage("kanokariRegTenjo3CountHitMemory1") var regTenjo3CountHit: Int = 0
    @AppStorage("kanokariRegTenjo3CountSumMemory1") var regTenjo3CountSum: Int = 0
    @AppStorage("kanokariRegTenjo4CountMissMemory1") var regTenjo4CountMiss: Int = 0
    @AppStorage("kanokariRegTenjo4CountHitMemory1") var regTenjo4CountHit: Int = 0
    @AppStorage("kanokariRegTenjo4CountSumMemory1") var regTenjo4CountSum: Int = 0
    @AppStorage("kanokariRegTenjo5CountMissMemory1") var regTenjo5CountMiss: Int = 0
    @AppStorage("kanokariRegTenjo5CountHitMemory1") var regTenjo5CountHit: Int = 0
    @AppStorage("kanokariRegTenjo5CountSumMemory1") var regTenjo5CountSum: Int = 0
    @AppStorage("kanokariZone100CountMissMemory1") var zone100CountMiss: Int = 0
    @AppStorage("kanokariZone100CountHitMemory1") var zone100CountHit: Int = 0
    @AppStorage("kanokariZone100CountSumMemory1") var zone100CountSum: Int = 0
    @AppStorage("kanokariZone300AtariCountMissMemory1") var zone300AtariCountMiss: Int = 0
    @AppStorage("kanokariZone300AtariCountHitMemory1") var zone300AtariCountHit: Int = 0
    @AppStorage("kanokariZone300AtariCountSumMemory1") var zone300AtariCountSum: Int = 0
    @AppStorage("kanokariZone300ThroughCountMissMemory1") var zone300ThroughCountMiss: Int = 0
    @AppStorage("kanokariZone300ThroughCountHitMemory1") var zone300ThroughCountHit: Int = 0
    @AppStorage("kanokariZone300ThroughCountSumMemory1") var zone300ThroughCountSum: Int = 0
    @AppStorage("kanokariMemoMemory1") var memo = ""
    @AppStorage("kanokariDateMemory1") var dateDouble = 0.0
}


class KanokariMemory2: ObservableObject {
    @AppStorage("kanokariNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("kanokariFirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("kanokariFirstHitCountBonusMemory2") var firstHitCountBonus: Int = 0
    @AppStorage("kanokariScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("kanokariScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("kanokariScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("kanokariScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("kanokariScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("kanokariScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("kanokariScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("kanokariScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("kanokariRbCharaCountDefaultMemory2") var rbCharaCountDefault: Int = 0
    @AppStorage("kanokariRbCharaCountKisuMemory2") var rbCharaCountKisu: Int = 0
    @AppStorage("kanokariRbCharaCountGusuMemory2") var rbCharaCountGusu: Int = 0
    @AppStorage("kanokariRbCharaCountHighJakuMemory2") var rbCharaCountHighJaku: Int = 0
    @AppStorage("kanokariRbCharaCountHighKyoMemory2") var rbCharaCountHighKyo: Int = 0
    @AppStorage("kanokariRbCharaCountNegate1Memory2") var rbCharaCountNegate1: Int = 0
    @AppStorage("kanokariRbCharaCountNegate2Memory2") var rbCharaCountNegate2: Int = 0
    @AppStorage("kanokariRbCharaCountNegate3Memory2") var rbCharaCountNegate3: Int = 0
    @AppStorage("kanokariRbCharaCountNegate4Memory2") var rbCharaCountNegate4: Int = 0
    @AppStorage("kanokariRbCharaCountNegate5Memory2") var rbCharaCountNegate5: Int = 0
    @AppStorage("kanokariRbCharaCountOver2Memory2") var rbCharaCountOver2: Int = 0
    @AppStorage("kanokariRbCharaCountOver3Memory2") var rbCharaCountOver3: Int = 0
    @AppStorage("kanokariRbCharaCountOver4Memory2") var rbCharaCountOver4: Int = 0
    @AppStorage("kanokariRbCharaCountOver5Memory2") var rbCharaCountOver5: Int = 0
    @AppStorage("kanokariRbCharaCountOver6Memory2") var rbCharaCountOver6: Int = 0
    @AppStorage("kanokariRbCharaCountSumMemory2") var rbCharaCountSum: Int = 0
    @AppStorage("kanokariKoryakuCharaCount1Memory2") var koryakuCharaCount1: Int = 0
    @AppStorage("kanokariKoryakuCharaCount2Memory2") var koryakuCharaCount2: Int = 0
    @AppStorage("kanokariKoryakuCharaCountSumMemory2") var koryakuCharaCountSum: Int = 0
    @AppStorage("kanokariEndingVoiceCount1Memory2") var endingVoiceCount1: Int = 0
    @AppStorage("kanokariEndingVoiceCount2Memory2") var endingVoiceCount2: Int = 0
    @AppStorage("kanokariEndingVoiceCount3Memory2") var endingVoiceCount3: Int = 0
    @AppStorage("kanokariEndingVoiceCount4Memory2") var endingVoiceCount4: Int = 0
    @AppStorage("kanokariEndingVoiceCount5Memory2") var endingVoiceCount5: Int = 0
    @AppStorage("kanokariEndingVoiceCount6Memory2") var endingVoiceCount6: Int = 0
    @AppStorage("kanokariEndingVoiceCount7Memory2") var endingVoiceCount7: Int = 0
    @AppStorage("kanokariEndingVoiceCount8Memory2") var endingVoiceCount8: Int = 0
    @AppStorage("kanokariEndingVoiceCountSumMemory2") var endingVoiceCountSum: Int = 0
    @AppStorage("kanokariComebackYumekanoCountMissMemory2") var comebackYumekanoCountMiss: Int = 0
    @AppStorage("kanokariComebackYumekanoCountHitMemory2") var comebackYumekanoCountHit: Int = 0
    @AppStorage("kanokariComebackYumekanoCountSumMemory2") var comebackYumekanoCountSum: Int = 0
    @AppStorage("kanokariDreamNormalCountMissMemory2") var dreamNormalCountMiss: Int = 0
    @AppStorage("kanokariDreamNormalCountHitMemory2") var dreamNormalCountHit: Int = 0
    @AppStorage("kanokariDreamNormalCountSumMemory2") var dreamNormalCountSum: Int = 0
    @AppStorage("kanokariDreamYumekanoCountMissMemory2") var dreamYumekanoCountMiss: Int = 0
    @AppStorage("kanokariDreamYumekanoCountHitMemory2") var dreamYumekanoCountHit: Int = 0
    @AppStorage("kanokariDreamYumekanoCountSumMemory2") var dreamYumekanoCountSum: Int = 0
    @AppStorage("kanokariRegTenjo3CountMissMemory2") var regTenjo3CountMiss: Int = 0
    @AppStorage("kanokariRegTenjo3CountHitMemory2") var regTenjo3CountHit: Int = 0
    @AppStorage("kanokariRegTenjo3CountSumMemory2") var regTenjo3CountSum: Int = 0
    @AppStorage("kanokariRegTenjo4CountMissMemory2") var regTenjo4CountMiss: Int = 0
    @AppStorage("kanokariRegTenjo4CountHitMemory2") var regTenjo4CountHit: Int = 0
    @AppStorage("kanokariRegTenjo4CountSumMemory2") var regTenjo4CountSum: Int = 0
    @AppStorage("kanokariRegTenjo5CountMissMemory2") var regTenjo5CountMiss: Int = 0
    @AppStorage("kanokariRegTenjo5CountHitMemory2") var regTenjo5CountHit: Int = 0
    @AppStorage("kanokariRegTenjo5CountSumMemory2") var regTenjo5CountSum: Int = 0
    @AppStorage("kanokariZone100CountMissMemory2") var zone100CountMiss: Int = 0
    @AppStorage("kanokariZone100CountHitMemory2") var zone100CountHit: Int = 0
    @AppStorage("kanokariZone100CountSumMemory2") var zone100CountSum: Int = 0
    @AppStorage("kanokariZone300AtariCountMissMemory2") var zone300AtariCountMiss: Int = 0
    @AppStorage("kanokariZone300AtariCountHitMemory2") var zone300AtariCountHit: Int = 0
    @AppStorage("kanokariZone300AtariCountSumMemory2") var zone300AtariCountSum: Int = 0
    @AppStorage("kanokariZone300ThroughCountMissMemory2") var zone300ThroughCountMiss: Int = 0
    @AppStorage("kanokariZone300ThroughCountHitMemory2") var zone300ThroughCountHit: Int = 0
    @AppStorage("kanokariZone300ThroughCountSumMemory2") var zone300ThroughCountSum: Int = 0
    @AppStorage("kanokariMemoMemory2") var memo = ""
    @AppStorage("kanokariDateMemory2") var dateDouble = 0.0
}


class KanokariMemory3: ObservableObject {
    @AppStorage("kanokariNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("kanokariFirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("kanokariFirstHitCountBonusMemory3") var firstHitCountBonus: Int = 0
    @AppStorage("kanokariScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("kanokariScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("kanokariScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("kanokariScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("kanokariScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("kanokariScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("kanokariScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("kanokariScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("kanokariRbCharaCountDefaultMemory3") var rbCharaCountDefault: Int = 0
    @AppStorage("kanokariRbCharaCountKisuMemory3") var rbCharaCountKisu: Int = 0
    @AppStorage("kanokariRbCharaCountGusuMemory3") var rbCharaCountGusu: Int = 0
    @AppStorage("kanokariRbCharaCountHighJakuMemory3") var rbCharaCountHighJaku: Int = 0
    @AppStorage("kanokariRbCharaCountHighKyoMemory3") var rbCharaCountHighKyo: Int = 0
    @AppStorage("kanokariRbCharaCountNegate1Memory3") var rbCharaCountNegate1: Int = 0
    @AppStorage("kanokariRbCharaCountNegate2Memory3") var rbCharaCountNegate2: Int = 0
    @AppStorage("kanokariRbCharaCountNegate3Memory3") var rbCharaCountNegate3: Int = 0
    @AppStorage("kanokariRbCharaCountNegate4Memory3") var rbCharaCountNegate4: Int = 0
    @AppStorage("kanokariRbCharaCountNegate5Memory3") var rbCharaCountNegate5: Int = 0
    @AppStorage("kanokariRbCharaCountOver2Memory3") var rbCharaCountOver2: Int = 0
    @AppStorage("kanokariRbCharaCountOver3Memory3") var rbCharaCountOver3: Int = 0
    @AppStorage("kanokariRbCharaCountOver4Memory3") var rbCharaCountOver4: Int = 0
    @AppStorage("kanokariRbCharaCountOver5Memory3") var rbCharaCountOver5: Int = 0
    @AppStorage("kanokariRbCharaCountOver6Memory3") var rbCharaCountOver6: Int = 0
    @AppStorage("kanokariRbCharaCountSumMemory3") var rbCharaCountSum: Int = 0
    @AppStorage("kanokariKoryakuCharaCount1Memory3") var koryakuCharaCount1: Int = 0
    @AppStorage("kanokariKoryakuCharaCount2Memory3") var koryakuCharaCount2: Int = 0
    @AppStorage("kanokariKoryakuCharaCountSumMemory3") var koryakuCharaCountSum: Int = 0
    @AppStorage("kanokariEndingVoiceCount1Memory3") var endingVoiceCount1: Int = 0
    @AppStorage("kanokariEndingVoiceCount2Memory3") var endingVoiceCount2: Int = 0
    @AppStorage("kanokariEndingVoiceCount3Memory3") var endingVoiceCount3: Int = 0
    @AppStorage("kanokariEndingVoiceCount4Memory3") var endingVoiceCount4: Int = 0
    @AppStorage("kanokariEndingVoiceCount5Memory3") var endingVoiceCount5: Int = 0
    @AppStorage("kanokariEndingVoiceCount6Memory3") var endingVoiceCount6: Int = 0
    @AppStorage("kanokariEndingVoiceCount7Memory3") var endingVoiceCount7: Int = 0
    @AppStorage("kanokariEndingVoiceCount8Memory3") var endingVoiceCount8: Int = 0
    @AppStorage("kanokariEndingVoiceCountSumMemory3") var endingVoiceCountSum: Int = 0
    @AppStorage("kanokariComebackYumekanoCountMissMemory3") var comebackYumekanoCountMiss: Int = 0
    @AppStorage("kanokariComebackYumekanoCountHitMemory3") var comebackYumekanoCountHit: Int = 0
    @AppStorage("kanokariComebackYumekanoCountSumMemory3") var comebackYumekanoCountSum: Int = 0
    @AppStorage("kanokariDreamNormalCountMissMemory3") var dreamNormalCountMiss: Int = 0
    @AppStorage("kanokariDreamNormalCountHitMemory3") var dreamNormalCountHit: Int = 0
    @AppStorage("kanokariDreamNormalCountSumMemory3") var dreamNormalCountSum: Int = 0
    @AppStorage("kanokariDreamYumekanoCountMissMemory3") var dreamYumekanoCountMiss: Int = 0
    @AppStorage("kanokariDreamYumekanoCountHitMemory3") var dreamYumekanoCountHit: Int = 0
    @AppStorage("kanokariDreamYumekanoCountSumMemory3") var dreamYumekanoCountSum: Int = 0
    @AppStorage("kanokariRegTenjo3CountMissMemory3") var regTenjo3CountMiss: Int = 0
    @AppStorage("kanokariRegTenjo3CountHitMemory3") var regTenjo3CountHit: Int = 0
    @AppStorage("kanokariRegTenjo3CountSumMemory3") var regTenjo3CountSum: Int = 0
    @AppStorage("kanokariRegTenjo4CountMissMemory3") var regTenjo4CountMiss: Int = 0
    @AppStorage("kanokariRegTenjo4CountHitMemory3") var regTenjo4CountHit: Int = 0
    @AppStorage("kanokariRegTenjo4CountSumMemory3") var regTenjo4CountSum: Int = 0
    @AppStorage("kanokariRegTenjo5CountMissMemory3") var regTenjo5CountMiss: Int = 0
    @AppStorage("kanokariRegTenjo5CountHitMemory3") var regTenjo5CountHit: Int = 0
    @AppStorage("kanokariRegTenjo5CountSumMemory3") var regTenjo5CountSum: Int = 0
    @AppStorage("kanokariZone100CountMissMemory3") var zone100CountMiss: Int = 0
    @AppStorage("kanokariZone100CountHitMemory3") var zone100CountHit: Int = 0
    @AppStorage("kanokariZone100CountSumMemory3") var zone100CountSum: Int = 0
    @AppStorage("kanokariZone300AtariCountMissMemory3") var zone300AtariCountMiss: Int = 0
    @AppStorage("kanokariZone300AtariCountHitMemory3") var zone300AtariCountHit: Int = 0
    @AppStorage("kanokariZone300AtariCountSumMemory3") var zone300AtariCountSum: Int = 0
    @AppStorage("kanokariZone300ThroughCountMissMemory3") var zone300ThroughCountMiss: Int = 0
    @AppStorage("kanokariZone300ThroughCountHitMemory3") var zone300ThroughCountHit: Int = 0
    @AppStorage("kanokariZone300ThroughCountSumMemory3") var zone300ThroughCountSum: Int = 0
    @AppStorage("kanokariMemoMemory3") var memo = ""
    @AppStorage("kanokariDateMemory3") var dateDouble = 0.0
}
