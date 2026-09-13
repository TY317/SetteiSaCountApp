//
//  aobutaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Aobuta: ObservableObject {
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
    let machineName: String = "青春ブタ野郎はバニーガール先輩の夢を見ない"
    @AppStorage("aobutaMinusCheck") var minusCheck: Bool = false
    @AppStorage("aobutaSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class AobutaMemory1: ObservableObject {
    @AppStorage("aobutaMemoMemory1") var memo = ""
    @AppStorage("aobutaDateMemory1") var dateDouble = 0.0
}


class AobutaMemory2: ObservableObject {
    @AppStorage("aobutaMemoMemory2") var memo = ""
    @AppStorage("aobutaDateMemory2") var dateDouble = 0.0
}


class AobutaMemory3: ObservableObject {
    @AppStorage("aobutaMemoMemory3") var memo = ""
    @AppStorage("aobutaDateMemory3") var dateDouble = 0.0
}
