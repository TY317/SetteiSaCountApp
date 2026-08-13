//
//  streetFighter6Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class StreetFighter6: ObservableObject {
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
    let machineName: String = "ストリートファイター6"
    @AppStorage("streetFighter6MinusCheck") var minusCheck: Bool = false
    @AppStorage("streetFighter6SelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class StreetFighter6Memory1: ObservableObject {
    @AppStorage("streetFighter6MemoMemory1") var memo = ""
    @AppStorage("streetFighter6DateMemory1") var dateDouble = 0.0
}


class StreetFighter6Memory2: ObservableObject {
    @AppStorage("streetFighter6MemoMemory2") var memo = ""
    @AppStorage("streetFighter6DateMemory2") var dateDouble = 0.0
}


class StreetFighter6Memory3: ObservableObject {
    @AppStorage("streetFighter6MemoMemory3") var memo = ""
    @AppStorage("streetFighter6DateMemory3") var dateDouble = 0.0
}
