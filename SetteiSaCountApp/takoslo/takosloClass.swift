//
//  takosloClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Takoslo: ObservableObject {
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
    let machineName: String = "タコスロ"
    @AppStorage("takosloMinusCheck") var minusCheck: Bool = false
    @AppStorage("takosloSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class TakosloMemory1: ObservableObject {
    @AppStorage("takosloMemoMemory1") var memo = ""
    @AppStorage("takosloDateMemory1") var dateDouble = 0.0
}


class TakosloMemory2: ObservableObject {
    @AppStorage("takosloMemoMemory2") var memo = ""
    @AppStorage("takosloDateMemory2") var dateDouble = 0.0
}


class TakosloMemory3: ObservableObject {
    @AppStorage("takosloMemoMemory3") var memo = ""
    @AppStorage("takosloDateMemory3") var dateDouble = 0.0
}
