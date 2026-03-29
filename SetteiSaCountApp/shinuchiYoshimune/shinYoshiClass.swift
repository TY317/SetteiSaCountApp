//
//  shinYoshiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/29.
//

import Foundation
import SwiftUI
import Combine

class ShinYoshi: ObservableObject {
    
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "真打 吉宗"
    @AppStorage("shinYoshiMinusCheck") var minusCheck: Bool = false
    @AppStorage("shinYoshiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
