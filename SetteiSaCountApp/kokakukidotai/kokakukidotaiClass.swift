//
//  kokakukidotaiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/12.
//

import Foundation
import SwiftUI
import Combine

class Kokakukidotai: ObservableObject {
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "攻殻機動隊"
    @AppStorage("kokakukidotaiMinusCheck") var minusCheck: Bool = false
    @AppStorage("kokakukidotaiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
