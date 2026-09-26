//
//  kanokariClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Kanokari: ObservableObject {
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
    let machineName: String = "彼女、お借りします"
    @AppStorage("kanokariMinusCheck") var minusCheck: Bool = false
    @AppStorage("kanokariSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class KanokariMemory1: ObservableObject {
    @AppStorage("kanokariMemoMemory1") var memo = ""
    @AppStorage("kanokariDateMemory1") var dateDouble = 0.0
}


class KanokariMemory2: ObservableObject {
    @AppStorage("kanokariMemoMemory2") var memo = ""
    @AppStorage("kanokariDateMemory2") var dateDouble = 0.0
}


class KanokariMemory3: ObservableObject {
    @AppStorage("kanokariMemoMemory3") var memo = ""
    @AppStorage("kanokariDateMemory3") var dateDouble = 0.0
}
