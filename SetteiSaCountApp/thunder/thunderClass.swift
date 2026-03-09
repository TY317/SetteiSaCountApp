//
//  thunderClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/09.
//

import Foundation
import SwiftUI
import Combine

class Thunder: ObservableObject {
    
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "サンダーV"
    @AppStorage("thunderMinusCheck") var minusCheck: Bool = false
    @AppStorage("thunderSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
