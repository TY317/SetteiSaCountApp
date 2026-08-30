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

    func resetFirstHit() {
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
