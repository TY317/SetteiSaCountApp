//
//  mhrsbClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Mhrsb: ObservableObject {
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
    let machineName: String = "モンスターハンターライズ：サンブレイク"
    @AppStorage("mhrsbMinusCheck") var minusCheck: Bool = false
    @AppStorage("mhrsbSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class MhrsbMemory1: ObservableObject {
    @AppStorage("mhrsbMemoMemory1") var memo = ""
    @AppStorage("mhrsbDateMemory1") var dateDouble = 0.0
}


class MhrsbMemory2: ObservableObject {
    @AppStorage("mhrsbMemoMemory2") var memo = ""
    @AppStorage("mhrsbDateMemory2") var dateDouble = 0.0
}


class MhrsbMemory3: ObservableObject {
    @AppStorage("mhrsbMemoMemory3") var memo = ""
    @AppStorage("mhrsbDateMemory3") var dateDouble = 0.0
}
