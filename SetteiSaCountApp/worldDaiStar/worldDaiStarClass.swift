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

    func resetNormal() {
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
    }
}


class WorldDaiStarMemory1: ObservableObject {
    @AppStorage("worldDaiStarMemoMemory1") var memo = ""
    @AppStorage("worldDaiStarDateMemory1") var dateDouble = 0.0
}


class WorldDaiStarMemory2: ObservableObject {
    @AppStorage("worldDaiStarMemoMemory2") var memo = ""
    @AppStorage("worldDaiStarDateMemory2") var dateDouble = 0.0
}


class WorldDaiStarMemory3: ObservableObject {
    @AppStorage("worldDaiStarMemoMemory3") var memo = ""
    @AppStorage("worldDaiStarDateMemory3") var dateDouble = 0.0
}
