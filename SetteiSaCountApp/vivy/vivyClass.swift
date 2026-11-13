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

    // アクセルチャンス昇格 継続回数
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

    func resetFirstHit() {
        minusCheck = false
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
    @AppStorage("vivyMemoMemory1") var memo = ""
    @AppStorage("vivyDateMemory1") var dateDouble = 0.0
}


class VivyMemory2: ObservableObject {
    @AppStorage("vivyMemoMemory2") var memo = ""
    @AppStorage("vivyDateMemory2") var dateDouble = 0.0
}


class VivyMemory3: ObservableObject {
    @AppStorage("vivyMemoMemory3") var memo = ""
    @AppStorage("vivyDateMemory3") var dateDouble = 0.0
}
