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


class HokutoTenseiMemory1: ObservableObject {
    @AppStorage("hokutoTenseiNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountTenhaMemory1") var firstHitCountTenha: Int = 0
    @AppStorage("hokutoTenseiMemoMemory1") var memo = ""
    @AppStorage("hokutoTenseiDateMemory1") var dateDouble = 0.0
}

class HokutoTenseiMemory2: ObservableObject {
    @AppStorage("hokutoTenseiNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountTenhaMemory2") var firstHitCountTenha: Int = 0
    @AppStorage("hokutoTenseiMemoMemory2") var memo = ""
    @AppStorage("hokutoTenseiDateMemory2") var dateDouble = 0.0
}

class HokutoTenseiMemory3: ObservableObject {
    @AppStorage("hokutoTenseiNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountTenhaMemory3") var firstHitCountTenha: Int = 0
    @AppStorage("hokutoTenseiMemoMemory3") var memo = ""
    @AppStorage("hokutoTenseiDateMemory3") var dateDouble = 0.0
}
