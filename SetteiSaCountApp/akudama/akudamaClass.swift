//
//  akudamaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/05.
//

import Foundation
import SwiftUI
import Combine

class Akudama: ObservableObject {
    // --------
    // 通常時
    // --------
    let ratioPtCzHit: [Double] = [21.9,22.7,24.2,28.9,33.6,36.7]
    @AppStorage("akudamaPtCountFull") var ptCountFull: Int = 0
    @AppStorage("akudamaPtCountCzHit") var ptCountCzHit: Int = 0
    
    func resetNormal() {
        ptCountFull = 0
        ptCountCzHit = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "アクダマドライブ"
    @AppStorage("akudamaMinusCheck") var minusCheck: Bool = false
    @AppStorage("akudamaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
    }
}
