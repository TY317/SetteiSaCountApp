//
//  tonskillClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Tonskill: ObservableObject {
    // -------
    // 通常時
    // -------
    // ポイント推定
    @AppStorage("tonskillPtSui") var ptSui: Int = 0
    @AppStorage("tonskillPtMukoda") var ptMukoda: Int = 0
    @AppStorage("tonskillPtFeru") var ptFeru: Int = 0

    func resetPtSui() {
        ptSui = 0
    }

    func resetPtMukoda() {
        ptMukoda = 0
    }

    func resetPtFeru() {
        ptFeru = 0
    }

    func resetPt() {
        ptSui = 0
        ptMukoda = 0
        ptFeru = 0
    }

    func resetNormal() {
        resetPt()
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [216.7,215.6,212.7,203.7,195.3,189.5]
    let ratioFirstHitBonus: [Double] = [349.3,339.2,322.4,286.5,263.7,247.3]
    @AppStorage("tonskillNormalGame") var normalGame: Int = 0
    @AppStorage("tonskillFirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("tonskillFirstHitCountBonus") var firstHitCountBonus: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountBonus = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "とんでもスキルで異世界放浪メシ"
    @AppStorage("tonskillMinusCheck") var minusCheck: Bool = false
    @AppStorage("tonskillSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class TonskillMemory1: ObservableObject {
    @AppStorage("tonskillMemoMemory1") var memo = ""
    @AppStorage("tonskillDateMemory1") var dateDouble = 0.0
}


class TonskillMemory2: ObservableObject {
    @AppStorage("tonskillMemoMemory2") var memo = ""
    @AppStorage("tonskillDateMemory2") var dateDouble = 0.0
}


class TonskillMemory3: ObservableObject {
    @AppStorage("tonskillMemoMemory3") var memo = ""
    @AppStorage("tonskillDateMemory3") var dateDouble = 0.0
}
