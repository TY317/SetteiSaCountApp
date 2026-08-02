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

    // -----------
    // 共通
    // -----------
    let machineName: String = "ワールドダイスター"
    @AppStorage("worldDaiStarMinusCheck") var minusCheck: Bool = false
    @AppStorage("worldDaiStarSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
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
