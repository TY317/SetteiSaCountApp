//
//  neoplaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/09.
//

import Foundation
import SwiftUI

class Neopla: ObservableObject {
    
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "ネオプラネット"
    @AppStorage("neoplaMinusCheck") var minusCheck: Bool = false
    @AppStorage("neoplaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
