//
//  magiaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import Foundation
import SwiftUI
import TipKit

class Magia: ObservableObject {
    // ////////////////////////
    // 通常時
    // ////////////////////////
    let ratioJakuCherry: [Double] = [60,57.7,55.5,53.5,51.7,50]
    let ratioSuikaCz: [Double] = [19.9,22.3,24.6,27.3,30.1,32.8]
    @AppStorage("magiaSuikaCzCountSuika") var suikaCzCountSuika: Int = 0
    @AppStorage("magiaSuikaCzCountCz") var suikaCzCountCz: Int = 0
    
    func resetNormal() {
        suikaCzCountSuika = 0
        suikaCzCountCz = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 初当り
    // ////////////////////////
    let ratioBonus: [Double] = [240.6,236.1,222.8,208.5,195.1,184.3]
    let ratioAt: [Double] = [654.6,633.4,571.8,516.6,456.5,416.7]
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("magiaMinusCheck") var minusCheck: Bool = false
    @AppStorage("magiaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
    }
}
