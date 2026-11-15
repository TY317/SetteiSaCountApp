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
    let machineName: String = "ラグナドール"
    @AppStorage("ragnadorMinusCheck") var minusCheck: Bool = false
    @AppStorage("ragnadorSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class RagnadorMemory1: ObservableObject {
    @AppStorage("ragnadorMemoMemory1") var memo = ""
    @AppStorage("ragnadorDateMemory1") var dateDouble = 0.0
}


class RagnadorMemory2: ObservableObject {
    @AppStorage("ragnadorMemoMemory2") var memo = ""
    @AppStorage("ragnadorDateMemory2") var dateDouble = 0.0
}


class RagnadorMemory3: ObservableObject {
    @AppStorage("ragnadorMemoMemory3") var memo = ""
    @AppStorage("ragnadorDateMemory3") var dateDouble = 0.0
}
