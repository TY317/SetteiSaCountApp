//
//  rioAceClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/02.
//

import Foundation
import SwiftUI
import Combine

class RioAce: ObservableObject {
    
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "スーパーリオエース2"
    @AppStorage("rioAceMinusCheck") var minusCheck: Bool = false
    @AppStorage("rioAceSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
