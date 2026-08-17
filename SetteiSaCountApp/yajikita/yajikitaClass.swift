//
//  yajikitaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Yajikita: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitAt: [Double] = [473.9,457.5,431.6,388.1,352.1,318.3]
    @AppStorage("yajikitaNormalGame") var normalGame: Int = 0
    @AppStorage("yajikitaFirstHitCountAt") var firstHitCountAt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "やじきた道中記参る！"
    @AppStorage("yajikitaMinusCheck") var minusCheck: Bool = false
    @AppStorage("yajikitaSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class YajikitaMemory1: ObservableObject {
    @AppStorage("yajikitaMemoMemory1") var memo = ""
    @AppStorage("yajikitaDateMemory1") var dateDouble = 0.0
}


class YajikitaMemory2: ObservableObject {
    @AppStorage("yajikitaMemoMemory2") var memo = ""
    @AppStorage("yajikitaDateMemory2") var dateDouble = 0.0
}


class YajikitaMemory3: ObservableObject {
    @AppStorage("yajikitaMemoMemory3") var memo = ""
    @AppStorage("yajikitaDateMemory3") var dateDouble = 0.0
}
