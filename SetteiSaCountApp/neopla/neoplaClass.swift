//
//  neoplaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/09.
//

import Foundation
import SwiftUI

class Neopla: ObservableObject {
    // ---------
    // 初当り
    // ---------
    let ratioBigSum: [Double] = [280.4,273.4,247.3,232.2,210.5]
    let ratioReg: [Double] = [596.7,584.1,553.6,526.4,504.2]
    let ratioBonusSum: [Double] = [190.8,186.2,171.0,161.1,148.5]
    @AppStorage("neoplaBonusCountBigRed") var bonusCountBigRed: Int = 0
    @AppStorage("neoplaBonusCountBigBlue") var bonusCountBigBlue: Int = 0
    @AppStorage("neoplaBonusCountBigSum") var bonusCountBigSum: Int = 0
    @AppStorage("neoplaBonusCountReg") var bonusCountReg: Int = 0
    @AppStorage("neoplaBonusCountSum") var bonusCountSum: Int = 0
    @AppStorage("neoplaNormalGame") var normalGame: Int = 0
    
    func bonusSumFunc() {
        bonusCountBigSum = bonusCountBigRed + bonusCountBigBlue
        bonusCountSum = bonusCountBigSum + bonusCountReg
    }
    
    func resetFirstHit() {
        bonusCountBigRed = 0
        bonusCountBigBlue = 0
        bonusCountBigSum = 0
        bonusCountReg = 0
        bonusCountSum = 0
        normalGame = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "ネオプラネット"
    @AppStorage("neoplaMinusCheck") var minusCheck: Bool = false
    @AppStorage("neoplaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
    }
}


class NeoplaMemory1: ObservableObject {
    @AppStorage("neoplaBonusCountBigRedMemory1") var bonusCountBigRed: Int = 0
    @AppStorage("neoplaBonusCountBigBlueMemory1") var bonusCountBigBlue: Int = 0
    @AppStorage("neoplaBonusCountBigSumMemory1") var bonusCountBigSum: Int = 0
    @AppStorage("neoplaBonusCountRegMemory1") var bonusCountReg: Int = 0
    @AppStorage("neoplaBonusCountSumMemory1") var bonusCountSum: Int = 0
    @AppStorage("neoplaNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("neoplaMemoMemory1") var memo = ""
    @AppStorage("neoplaDateMemory1") var dateDouble = 0.0
}


class NeoplaMemory2: ObservableObject {
    @AppStorage("neoplaBonusCountBigRedMemory2") var bonusCountBigRed: Int = 0
    @AppStorage("neoplaBonusCountBigBlueMemory2") var bonusCountBigBlue: Int = 0
    @AppStorage("neoplaBonusCountBigSumMemory2") var bonusCountBigSum: Int = 0
    @AppStorage("neoplaBonusCountRegMemory2") var bonusCountReg: Int = 0
    @AppStorage("neoplaBonusCountSumMemory2") var bonusCountSum: Int = 0
    @AppStorage("neoplaNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("neoplaMemoMemory2") var memo = ""
    @AppStorage("neoplaDateMemory2") var dateDouble = 0.0
}


class NeoplaMemory3: ObservableObject {
    @AppStorage("neoplaBonusCountBigRedMemory3") var bonusCountBigRed: Int = 0
    @AppStorage("neoplaBonusCountBigBlueMemory3") var bonusCountBigBlue: Int = 0
    @AppStorage("neoplaBonusCountBigSumMemory3") var bonusCountBigSum: Int = 0
    @AppStorage("neoplaBonusCountRegMemory3") var bonusCountReg: Int = 0
    @AppStorage("neoplaBonusCountSumMemory3") var bonusCountSum: Int = 0
    @AppStorage("neoplaNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("neoplaMemoMemory3") var memo = ""
    @AppStorage("neoplaDateMemory3") var dateDouble = 0.0
}
