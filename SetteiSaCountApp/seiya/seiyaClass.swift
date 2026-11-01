//
//  seiyaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Seiya: ObservableObject {
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
    let machineName: String = "聖闘士星矢 黄金十二宮"
    @AppStorage("seiyaMinusCheck") var minusCheck: Bool = false
    @AppStorage("seiyaSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class SeiyaMemory1: ObservableObject {
    @AppStorage("seiyaMemoMemory1") var memo = ""
    @AppStorage("seiyaDateMemory1") var dateDouble = 0.0
}


class SeiyaMemory2: ObservableObject {
    @AppStorage("seiyaMemoMemory2") var memo = ""
    @AppStorage("seiyaDateMemory2") var dateDouble = 0.0
}


class SeiyaMemory3: ObservableObject {
    @AppStorage("seiyaMemoMemory3") var memo = ""
    @AppStorage("seiyaDateMemory3") var dateDouble = 0.0
}
