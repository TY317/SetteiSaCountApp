//
//  worldDaiStarClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class WorldDaiStar: ObservableObject {
    // -------
    // 通常時
    // -------
    // ST終了時のラッキーモード移行率（参考情報）
    let ratioLuckyModeOther: [Double] = [20.3,20.7,21.1,21.5,21.9,22.3]        // 右記以外
    let ratioLuckyModeStThrough: [Double] = [33.2,34,34.8,36.3,37.1,37.9]      // ST駆け抜け時
    let ratioLuckyModeAfterHighSt: [Double] = [50,50.8,53.1,58.2,59.4,62.1]    // 上位ST後

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [180.6, 173.8, 168.3, 164.9, 163, 156]
    let ratioFirstHitAt: [Double] = [306.5, 297.1, 284.1, 262.1, 257.1, 246.6]
    @AppStorage("worldDaiStarNormalGame") var normalGame: Int = 0
    @AppStorage("worldDaiStarFirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("worldDaiStarFirstHitCountAt") var firstHitCountAt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountAt = 0
        minusCheck = false
    }

    // --------
    // 終了画面
    // --------
    @AppStorage("worldDaiStarScreenCount1") var screenCount1: Int = 0
    @AppStorage("worldDaiStarScreenCount2") var screenCount2: Int = 0
    @AppStorage("worldDaiStarScreenCount3") var screenCount3: Int = 0
    @AppStorage("worldDaiStarScreenCountSum") var screenCountSum: Int = 0

    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
        )
    }

    func resetScreen() {
        screenCount1 = 0
        screenCount2 = 0
        screenCount3 = 0
        screenCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "ワールドダイスター"
    @AppStorage("worldDaiStarMinusCheck") var minusCheck: Bool = false
    @AppStorage("worldDaiStarSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetComeBack()
    }
    
    // -----------
    // ver4.5.0
    // -----------
    let ratioComeBack: [Double] = [12.5,12.5,16,16,22.5,25.5]
    @AppStorage("worldDaiStarComeBackCountMiss") var comeBackCountMiss: Int = 0
    @AppStorage("worldDaiStarComeBackCountHit") var comeBackCountHit: Int = 0
    @AppStorage("worldDaiStarComeBackCountSum") var comeBackCountSum: Int = 0
    
    func comeBackSumFunc() {
        comeBackCountSum = countSum(
            comeBackCountMiss,
            comeBackCountHit,
        )
    }
    
    func resetComeBack() {
        comeBackCountMiss = 0
        comeBackCountHit = 0
        comeBackCountSum = 0
        minusCheck = false
    }
}


class WorldDaiStarMemory1: ObservableObject {
    @AppStorage("worldDaiStarNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("worldDaiStarFirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("worldDaiStarFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("worldDaiStarScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("worldDaiStarScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("worldDaiStarScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("worldDaiStarScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("worldDaiStarComeBackCountMissMemory1") var comeBackCountMiss: Int = 0
    @AppStorage("worldDaiStarComeBackCountHitMemory1") var comeBackCountHit: Int = 0
    @AppStorage("worldDaiStarComeBackCountSumMemory1") var comeBackCountSum: Int = 0
    @AppStorage("worldDaiStarMemoMemory1") var memo = ""
    @AppStorage("worldDaiStarDateMemory1") var dateDouble = 0.0
}


class WorldDaiStarMemory2: ObservableObject {
    @AppStorage("worldDaiStarNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("worldDaiStarFirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("worldDaiStarFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("worldDaiStarScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("worldDaiStarScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("worldDaiStarScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("worldDaiStarScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("worldDaiStarComeBackCountMissMemory2") var comeBackCountMiss: Int = 0
    @AppStorage("worldDaiStarComeBackCountHitMemory2") var comeBackCountHit: Int = 0
    @AppStorage("worldDaiStarComeBackCountSumMemory2") var comeBackCountSum: Int = 0
    @AppStorage("worldDaiStarMemoMemory2") var memo = ""
    @AppStorage("worldDaiStarDateMemory2") var dateDouble = 0.0
}


class WorldDaiStarMemory3: ObservableObject {
    @AppStorage("worldDaiStarNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("worldDaiStarFirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("worldDaiStarFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("worldDaiStarScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("worldDaiStarScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("worldDaiStarScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("worldDaiStarScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("worldDaiStarComeBackCountMissMemory3") var comeBackCountMiss: Int = 0
    @AppStorage("worldDaiStarComeBackCountHitMemory3") var comeBackCountHit: Int = 0
    @AppStorage("worldDaiStarComeBackCountSumMemory3") var comeBackCountSum: Int = 0
    @AppStorage("worldDaiStarMemoMemory3") var memo = ""
    @AppStorage("worldDaiStarDateMemory3") var dateDouble = 0.0
}
