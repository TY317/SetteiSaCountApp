//
//  jormungandClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import Foundation
import SwiftUI
import Combine

class Jormungand: ObservableObject {
    // ----------
    // CZ
    // ----------
    let ratioFirstHitCz: [Double] = [194.2,188.6,175.7,169.4,167.8,167.2]
    @AppStorage("jormungandNormalGame") var normalGame: Int = 0
    @AppStorage("jormungandFirstHitCountCz") var firstHitCountCz: Int = 0
    
    func resetCz() {
        normalGame = 0
        firstHitCountCz = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ヨルムンガンド"
    @AppStorage("jormungandMinusCheck") var minusCheck: Bool = false
    @AppStorage("jormungandSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetCz()
    }
}
