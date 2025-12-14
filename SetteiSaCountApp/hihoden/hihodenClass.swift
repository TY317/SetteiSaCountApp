//
//  hihodenClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/13.
//

import Foundation
import SwiftUI

class Hihoden: ObservableObject {
    // ----------
    // 通常時
    // ----------
    let ratioKoyakuCherry: [Double] = [54.7,52.9,51.1,49.5,48,46.5]
    @AppStorage("hihodenTotalGame") var totalGame: Int = 0
    @AppStorage("hihodenKoyakuCountCherry") var koyakuCountCherry: Int = 0
    
    func resetNormal() {
        totalGame = 0
        koyakuCountCherry = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "秘宝伝"
    @AppStorage("hihodenMinusCheck") var minusCheck: Bool = false
    @AppStorage("hihodenSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
    }
}
