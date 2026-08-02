//
//  index2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Index2: ObservableObject {
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
    let machineName: String = "とある魔術の禁書目録2"
    @AppStorage("index2MinusCheck") var minusCheck: Bool = false
    @AppStorage("index2SelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class Index2Memory1: ObservableObject {
    @AppStorage("index2MemoMemory1") var memo = ""
    @AppStorage("index2DateMemory1") var dateDouble = 0.0
}


class Index2Memory2: ObservableObject {
    @AppStorage("index2MemoMemory2") var memo = ""
    @AppStorage("index2DateMemory2") var dateDouble = 0.0
}


class Index2Memory3: ObservableObject {
    @AppStorage("index2MemoMemory3") var memo = ""
    @AppStorage("index2DateMemory3") var dateDouble = 0.0
}
