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
    let machineName: String = "ミリオンゴッド〜神々の軌跡〜"
    @AppStorage("godKisekiMinusCheck") var minusCheck: Bool = false
    @AppStorage("godKisekiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        
    }
}
