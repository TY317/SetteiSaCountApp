//
//  otome5Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/02.
//

import Foundation
import SwiftUI
import Combine

class Otome5: ObservableObject {
    
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "戦国乙女5"
    @AppStorage("otome5MinusCheck") var minusCheck: Bool = false
    @AppStorage("otome5SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
