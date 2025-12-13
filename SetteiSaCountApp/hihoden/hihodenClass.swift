//
//  hihodenClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/13.
//

import Foundation
import SwiftUI

class Hihoden: ObservableObject {
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "秘宝伝"
    @AppStorage("hihodenMinusCheck") var minusCheck: Bool = false
    @AppStorage("hihodenSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
