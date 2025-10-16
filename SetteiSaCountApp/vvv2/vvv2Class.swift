//
//  vvv2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/16.
//

import Foundation
import SwiftUI

class Vvv2: ObservableObject {
    
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "革命機ヴァルヴレイヴ2"
    @AppStorage("vvv2MinusCheck") var minusCheck: Bool = false
    @AppStorage("vvv2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
