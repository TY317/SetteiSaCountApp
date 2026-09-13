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
    let ratioFirstHitSt: [Double] = [350.8,336.5,295.1,274.6,207.8]
    @AppStorage("aobutaNormalGame") var normalGame: Int = 0
    @AppStorage("aobutaFirstHitCountSt") var firstHitCountSt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountSt = 0
        minusCheck = false
    }

    // -------
    // ST中
    // -------
    let ratioSyndrome: [Double] = [20.4,-1,-1,-1,-1]
    @AppStorage("aobutaSyndromeCountMiss") var syndromeCountMiss: Int = 0
    @AppStorage("aobutaSyndromeCountHit") var syndromeCountHit: Int = 0
    @AppStorage("aobutaSyndromeCountSum") var syndromeCountSum: Int = 0

    func syndromeSumFunc() {
        syndromeCountSum = syndromeCountHit + syndromeCountMiss
    }

    func resetDuringSt() {
        syndromeCountMiss = 0
        syndromeCountHit = 0
        syndromeCountSum = 0
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
        resetDuringSt()
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
