//
//  gobsla2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/23.
//

import Foundation
import SwiftUI
import Combine

class Gobsla2: ObservableObject {
    
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ゴブリンスレイヤー2"
    @AppStorage("gobsla2MinusCheck") var minusCheck: Bool = false
    @AppStorage("gobsla2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
