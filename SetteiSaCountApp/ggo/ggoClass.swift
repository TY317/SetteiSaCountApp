//
//  ggoClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Ggo: ObservableObject {
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
    let machineName: String = "ソードアート・オンライン オルタナティブ ガンゲイル・オンライン"
    @AppStorage("ggoMinusCheck") var minusCheck: Bool = false
    @AppStorage("ggoSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class GgoMemory1: ObservableObject {
    @AppStorage("ggoMemoMemory1") var memo = ""
    @AppStorage("ggoDateMemory1") var dateDouble = 0.0
}


class GgoMemory2: ObservableObject {
    @AppStorage("ggoMemoMemory2") var memo = ""
    @AppStorage("ggoDateMemory2") var dateDouble = 0.0
}


class GgoMemory3: ObservableObject {
    @AppStorage("ggoMemoMemory3") var memo = ""
    @AppStorage("ggoDateMemory3") var dateDouble = 0.0
}
