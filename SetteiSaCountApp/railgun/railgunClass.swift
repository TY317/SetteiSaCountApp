//
//  railgunClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/19.
//

import Foundation
import SwiftUI

class Railgun: ObservableObject {
    
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "とある科学の超電磁砲2"
    @AppStorage("railgunMinusCheck") var minusCheck: Bool = false
    @AppStorage("railgunSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
