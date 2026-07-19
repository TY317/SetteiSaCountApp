//
//  kerottoClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Kerotto: ObservableObject {
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
    let machineName: String = "ケロット5 BT"
    @AppStorage("kerottoMinusCheck") var minusCheck: Bool = false
    @AppStorage("kerottoSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class KerottoMemory1: ObservableObject {
    @AppStorage("kerottoMemoMemory1") var memo = ""
    @AppStorage("kerottoDateMemory1") var dateDouble = 0.0
}


class KerottoMemory2: ObservableObject {
    @AppStorage("kerottoMemoMemory2") var memo = ""
    @AppStorage("kerottoDateMemory2") var dateDouble = 0.0
}


class KerottoMemory3: ObservableObject {
    @AppStorage("kerottoMemoMemory3") var memo = ""
    @AppStorage("kerottoDateMemory3") var dateDouble = 0.0
}
