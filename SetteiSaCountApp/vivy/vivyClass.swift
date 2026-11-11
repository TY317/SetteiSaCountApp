//
//  vivyClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Vivy: ObservableObject {
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
    let machineName: String = "Vivy"
    @AppStorage("vivyMinusCheck") var minusCheck: Bool = false
    @AppStorage("vivySelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class VivyMemory1: ObservableObject {
    @AppStorage("vivyMemoMemory1") var memo = ""
    @AppStorage("vivyDateMemory1") var dateDouble = 0.0
}


class VivyMemory2: ObservableObject {
    @AppStorage("vivyMemoMemory2") var memo = ""
    @AppStorage("vivyDateMemory2") var dateDouble = 0.0
}


class VivyMemory3: ObservableObject {
    @AppStorage("vivyMemoMemory3") var memo = ""
    @AppStorage("vivyDateMemory3") var dateDouble = 0.0
}
