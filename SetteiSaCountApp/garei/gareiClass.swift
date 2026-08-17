//
//  gareiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Garei: ObservableObject {
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
    let machineName: String = "喰霊-零-Re"
    @AppStorage("gareiMinusCheck") var minusCheck: Bool = false
    @AppStorage("gareiSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class GareiMemory1: ObservableObject {
    @AppStorage("gareiMemoMemory1") var memo = ""
    @AppStorage("gareiDateMemory1") var dateDouble = 0.0
}


class GareiMemory2: ObservableObject {
    @AppStorage("gareiMemoMemory2") var memo = ""
    @AppStorage("gareiDateMemory2") var dateDouble = 0.0
}


class GareiMemory3: ObservableObject {
    @AppStorage("gareiMemoMemory3") var memo = ""
    @AppStorage("gareiDateMemory3") var dateDouble = 0.0
}
