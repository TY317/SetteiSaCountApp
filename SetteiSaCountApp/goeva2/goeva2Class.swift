//
//  goeva2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Goeva2: ObservableObject {
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
    let machineName: String = "ゴジラ対エヴァンゲリオン2"
    @AppStorage("goeva2MinusCheck") var minusCheck: Bool = false
    @AppStorage("goeva2SelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class Goeva2Memory1: ObservableObject {
    @AppStorage("goeva2MemoMemory1") var memo = ""
    @AppStorage("goeva2DateMemory1") var dateDouble = 0.0
}


class Goeva2Memory2: ObservableObject {
    @AppStorage("goeva2MemoMemory2") var memo = ""
    @AppStorage("goeva2DateMemory2") var dateDouble = 0.0
}


class Goeva2Memory3: ObservableObject {
    @AppStorage("goeva2MemoMemory3") var memo = ""
    @AppStorage("goeva2DateMemory3") var dateDouble = 0.0
}
