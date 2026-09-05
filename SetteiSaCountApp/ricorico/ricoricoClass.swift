//
//  ricoricoClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Ricorico: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [198.7,196.9,191.3,183.3,175.9,169.4]
    let ratioFirstHitBattleCz: [Double] = [209.2,-1,-1,-1,-1,184.4]
    let ratioFirstHitYoshokiCz: [Double] = [3965,-1,-1,-1,-1,2084.8]
    let ratioFirstHitAt: [Double] = [328.8,323.4,312.1,288.3,271.6,256.7]
    @AppStorage("ricoricoNormalGame") var normalGame: Int = 0
    @AppStorage("ricoricoFirstHitCountBattleCz") var firstHitCountBattleCz: Int = 0
    @AppStorage("ricoricoFirstHitCountYoshokiCz") var firstHitCountYoshokiCz: Int = 0
    @AppStorage("ricoricoFirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("ricoricoFirstHitCountAt") var firstHitCountAt: Int = 0

    func firstHitCzSumFunc() {
        firstHitCountCz = firstHitCountBattleCz + firstHitCountYoshokiCz
    }

    func resetFirstHit() {
        normalGame = 0
        firstHitCountBattleCz = 0
        firstHitCountYoshokiCz = 0
        firstHitCountCz = 0
        firstHitCountAt = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "リコリス・リコイル"
    @AppStorage("ricoricoMinusCheck") var minusCheck: Bool = false
    @AppStorage("ricoricoSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class RicoricoMemory1: ObservableObject {
    @AppStorage("ricoricoMemoMemory1") var memo = ""
    @AppStorage("ricoricoDateMemory1") var dateDouble = 0.0
}


class RicoricoMemory2: ObservableObject {
    @AppStorage("ricoricoMemoMemory2") var memo = ""
    @AppStorage("ricoricoDateMemory2") var dateDouble = 0.0
}


class RicoricoMemory3: ObservableObject {
    @AppStorage("ricoricoMemoMemory3") var memo = ""
    @AppStorage("ricoricoDateMemory3") var dateDouble = 0.0
}
