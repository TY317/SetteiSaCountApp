//
//  mushotenClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/03.
//

import Foundation
import SwiftUI

class Mushoten: ObservableObject {
    // ---------
    // 通常時
    // ---------
    let ratioHitogamiHit: [Double] = [31.8,32.2,32.7,34.7,36.6,41]
    @AppStorage("mushotenHitogamiCountMove") var hitogamiCountMove: Int = 0
    @AppStorage("mushotenHitogamiCountHit") var hitogamiCountHit: Int = 0
    
    func resetNormal() {
        hitogamiCountMove = 0
        hitogamiCountHit = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "無職転生"
    @AppStorage("mushotenMinusCheck") var minusCheck: Bool = false
    @AppStorage("mushotenSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
