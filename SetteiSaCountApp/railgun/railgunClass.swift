//
//  railgunClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/19.
//

import Foundation
import SwiftUI

class Railgun: ObservableObject {
    // ------------
    // 通常時
    // ------------
    let ratioCoinCzHit: [Double] = [37.7,-1,-1,-1,-1,-1]
    @AppStorage("railgunCoinCount") var coinCount: Int = 0
    @AppStorage("railgunCoinCountCzHit") var coinCountCzHit: Int = 0
    
    func resetNormal() {
        coinCount = 0
        coinCountCzHit = 0
        minusCheck = false
    }
    
    // --------------
    // 初当り
    // --------------
    let ratioFirstHitCz: [Double] = [175.7,172.6,168.5,156.6,145.7,137.5]
    let ratioFirstHitAt: [Double] = [317.8,311.8,304.4,272.4,248.1,235.2]
    @AppStorage("railgunNormalGame") var normalGame: Int = 0
    @AppStorage("railgunCzCount") var czCount: Int = 0
    @AppStorage("railgunAtCount") var atCount: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        czCount = 0
        atCount = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "とある科学の超電磁砲2"
    @AppStorage("railgunMinusCheck") var minusCheck: Bool = false
    @AppStorage("railgunSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
