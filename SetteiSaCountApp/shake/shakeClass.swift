//
//  shakeClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import Foundation
import SwiftUI

class Shake: ObservableObject {
    
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "シェイクBT"
    @AppStorage("shakeMinusCheck") var minusCheck: Bool = false
    @AppStorage("shakeSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
