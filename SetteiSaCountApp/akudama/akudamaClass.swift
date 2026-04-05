//
//  akudamaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/05.
//

import Foundation
import SwiftUI
import Combine

class Akudama: ObservableObject {
    
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "アクダマドライブ"
    @AppStorage("akudamaMinusCheck") var minusCheck: Bool = false
    @AppStorage("akudamaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
