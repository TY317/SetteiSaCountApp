//
//  dropkickClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Dropkick: ObservableObject {
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
    let machineName: String = "邪神ちゃんドロップキック"
    @AppStorage("dropkickMinusCheck") var minusCheck: Bool = false
    @AppStorage("dropkickSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class DropkickMemory1: ObservableObject {
    @AppStorage("dropkickMemoMemory1") var memo = ""
    @AppStorage("dropkickDateMemory1") var dateDouble = 0.0
}


class DropkickMemory2: ObservableObject {
    @AppStorage("dropkickMemoMemory2") var memo = ""
    @AppStorage("dropkickDateMemory2") var dateDouble = 0.0
}


class DropkickMemory3: ObservableObject {
    @AppStorage("dropkickMemoMemory3") var memo = ""
    @AppStorage("dropkickDateMemory3") var dateDouble = 0.0
}
