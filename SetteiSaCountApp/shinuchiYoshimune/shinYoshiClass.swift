//
//  shinYoshiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/29.
//

import Foundation
import SwiftUI
import Combine

class ShinYoshi: ObservableObject {
    // ----------
    // 初当り
    // ----------
    let ratioFirstHitAt: [Double] = [488.9,471.5,438.5,398.1,377,354.9]
    @AppStorage("shinYoshiNormalGame") var normalGame: Int = 0
    @AppStorage("shinYoshiFirstHitCountAt") var firstHitCountAt: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "真打 吉宗"
    @AppStorage("shinYoshiMinusCheck") var minusCheck: Bool = false
    @AppStorage("shinYoshiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
    }
}


class ShinYoshiMemory1: ObservableObject {
    @AppStorage("shinYoshiNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("shinYoshiFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("jormungandMemoMemory1") var memo = ""
    @AppStorage("jormungandDateMemory1") var dateDouble = 0.0
}


class ShinYoshiMemory2: ObservableObject {
    @AppStorage("shinYoshiNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("shinYoshiFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("jormungandMemoMemory2") var memo = ""
    @AppStorage("jormungandDateMemory2") var dateDouble = 0.0
}


class ShinYoshiMemory3: ObservableObject {
    @AppStorage("shinYoshiNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("shinYoshiFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("jormungandMemoMemory3") var memo = ""
    @AppStorage("jormungandDateMemory3") var dateDouble = 0.0
}
