//
//  tonskillClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Tonskill: ObservableObject {
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
    let machineName: String = "とんでもスキルで異世界放浪メシ"
    @AppStorage("tonskillMinusCheck") var minusCheck: Bool = false
    @AppStorage("tonskillSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class TonskillMemory1: ObservableObject {
    @AppStorage("tonskillMemoMemory1") var memo = ""
    @AppStorage("tonskillDateMemory1") var dateDouble = 0.0
}


class TonskillMemory2: ObservableObject {
    @AppStorage("tonskillMemoMemory2") var memo = ""
    @AppStorage("tonskillDateMemory2") var dateDouble = 0.0
}


class TonskillMemory3: ObservableObject {
    @AppStorage("tonskillMemoMemory3") var memo = ""
    @AppStorage("tonskillDateMemory3") var dateDouble = 0.0
}
