//
//  godKisekiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/13.
//

import Foundation
import SwiftUI
import Combine

class GodKiseki: ObservableObject {
    // ---------
    // 初当り
    // ---------
    let ratioFirstHitAt: [Double] = [533,420,496,338,455,295]
    @AppStorage("godKisekiNormalGame") var normalGame: Int = 0
    @AppStorage("godKisekiFirstHitCountAt") var firstHitCountAt: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ミリオンゴッド〜神々の軌跡〜"
    @AppStorage("godKisekiMinusCheck") var minusCheck: Bool = false
    @AppStorage("godKisekiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
    }
}
