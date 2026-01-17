//
//  kokakukidotaiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/12.
//

import Foundation
import SwiftUI
import Combine

class Kokakukidotai: ObservableObject {
    
    // ----------
    // 初当り
    // ----------
    let ratioFirstHitCz: [Double] = [238.0,236.3,231.7,220.9,214,210.1]
    let ratioFirstHitAt: [Double] = [336.3,332,319.6,298.7,285.8,278]
    
    func resetFirstHit() {
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "攻殻機動隊"
    @AppStorage("kokakukidotaiMinusCheck") var minusCheck: Bool = false
    @AppStorage("kokakukidotaiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
    }
}
