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


class GodKisekiMemory1: ObservableObject {
    @AppStorage("godKisekiNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("godKisekiFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("godKisekiMemoMemory1") var memo = ""
    @AppStorage("godKisekiDateMemory1") var dateDouble = 0.0
}


class GodKisekiMemory2: ObservableObject {
    @AppStorage("godKisekiNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("godKisekiFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("godKisekiMemoMemory2") var memo = ""
    @AppStorage("godKisekiDateMemory2") var dateDouble = 0.0
}


class GodKisekiMemory3: ObservableObject {
    @AppStorage("godKisekiNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("godKisekiFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("godKisekiMemoMemory3") var memo = ""
    @AppStorage("godKisekiDateMemory3") var dateDouble = 0.0
}
