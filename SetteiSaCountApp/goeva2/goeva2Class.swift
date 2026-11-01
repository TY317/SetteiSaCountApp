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

    func resetFirstHit() {
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
