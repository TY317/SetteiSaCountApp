//
//  tekken6Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/29.
//

import Foundation
import SwiftUI

class Tekken6: ObservableObject {
    // -----------
    // 共通
    // -----------
    let machineName: String = "北斗 転生の章2"
    @AppStorage("tekken6MinusCheck") var minusCheck: Bool = false
    @AppStorage("tekken6SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
