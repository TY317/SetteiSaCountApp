//
//  hokutoTenseiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/26.
//

import Foundation
import SwiftUI

class HokutoTensei: ObservableObject {
    // ----------
    // 初当り
    // ----------
    let ratioAtFirstHitAt: [Double] = [366,357,336.3,298.7,283.2,273.1]
    let ratioAtFirstHitTenha: [Double] = [-1,-1,-1,-1,-1,-1,]
    @AppStorage("hokutoTenseiNormalGame") var normalGame: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountAt") var firstHitCountAt: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountTenha") var firstHitCountTenha: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        firstHitCountTenha = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "北斗 転生の章2"
    @AppStorage("hokutoTenseiMinusCheck") var minusCheck: Bool = false
    @AppStorage("hokutoTenseiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
    }
}
