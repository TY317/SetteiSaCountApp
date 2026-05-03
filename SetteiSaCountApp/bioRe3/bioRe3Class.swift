//
//  bioRe3Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/03.
//

import Foundation
import SwiftUI
import Combine

class BioRe3: ObservableObject {
    // ---------
    // 初当り
    // ---------
    let ratioFirstHitAt: [Double] = [399,391.4,372.8,349.8,323.5,311.2]
    @AppStorage("bioRe3NormalGame") var normalGame: Int = 0
    @AppStorage("bioRe3FirstHitCountAt") var firstHitCountAt: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "バイオハザードRE:3"
    @AppStorage("bioRe3MinusCheck") var minusCheck: Bool = false
    @AppStorage("bioRe3SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
    }
}
