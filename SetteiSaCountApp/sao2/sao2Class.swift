//
//  sao2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/30.
//

import Foundation
import SwiftUI
import Combine

class Sao2: ObservableObject {
    
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ソードアート・オンラインⅡ"
    @AppStorage("sao2MinusCheck") var minusCheck: Bool = false
    @AppStorage("sao2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
