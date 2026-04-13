//
//  godKisekiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/13.
//

import Foundation
import SwiftUI
import Combine

class GodKiseki: ObservableObject {
    
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ヨルムンガンド"
    @AppStorage("godKisekiMinusCheck") var minusCheck: Bool = false
    @AppStorage("godKisekiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
