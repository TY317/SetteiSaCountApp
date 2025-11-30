//
//  bakemonoClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/30.
//

import Foundation
import SwiftUI

class Bakemono: ObservableObject {
    
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "化物語"
    @AppStorage("bakemonoMinusCheck") var minusCheck: Bool = false
    @AppStorage("bakemonoSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
