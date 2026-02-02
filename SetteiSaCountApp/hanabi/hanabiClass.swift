//
//  hanabiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/02.
//

import Foundation
import SwiftUI
import Combine

class Hanabi: ObservableObject {
    
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ハナビ"
    @AppStorage("hanabiMinusCheck") var minusCheck: Bool = false
    @AppStorage("hanabiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
