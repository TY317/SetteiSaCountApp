//
//  sencole6Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Sencole6: ObservableObject {
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
    let machineName: String = "戦国コレクション6"
    @AppStorage("sencole6MinusCheck") var minusCheck: Bool = false
    @AppStorage("sencole6SelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class Sencole6Memory1: ObservableObject {
    @AppStorage("sencole6MemoMemory1") var memo = ""
    @AppStorage("sencole6DateMemory1") var dateDouble = 0.0
}


class Sencole6Memory2: ObservableObject {
    @AppStorage("sencole6MemoMemory2") var memo = ""
    @AppStorage("sencole6DateMemory2") var dateDouble = 0.0
}


class Sencole6Memory3: ObservableObject {
    @AppStorage("sencole6MemoMemory3") var memo = ""
    @AppStorage("sencole6DateMemory3") var dateDouble = 0.0
}
