//
//  hokutoTenseiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/26.
//

import Foundation
import SwiftUI

class HokutoTensei: ObservableObject {
    
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "北斗 転生の章2"
    @AppStorage("hokutoTenseiMinusCheck") var minusCheck: Bool = false
    @AppStorage("hokutoTenseiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
