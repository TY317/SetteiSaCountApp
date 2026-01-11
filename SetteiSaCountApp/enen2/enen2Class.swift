//
//  enen2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/11.
//

import Foundation
import SwiftUI

class Enen2: ObservableObject {
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "炎炎ノ消防隊2"
    @AppStorage("enen2MinusCheck") var minusCheck: Bool = false
    @AppStorage("enen2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
