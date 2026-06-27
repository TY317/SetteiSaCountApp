//
//  karakuri2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/27.
//

import Foundation
import SwiftUI
import Combine

class Karakuri2: ObservableObject {
    // -------
    // 通常時
    // -------
    
    func resetNormal() {
        minusCheck = false
    }
    
    // --------
    // 初当り
    // --------
    
    func resetFirstHit() {
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "からくりサーカス2"
    @AppStorage("karakuri2MinusCheck") var minusCheck: Bool = false
    @AppStorage("karakuri2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class Karakuri2Memory1: ObservableObject {
    @AppStorage("karakuri2MemoMemory1") var memo = ""
    @AppStorage("karakuri2DateMemory1") var dateDouble = 0.0
}


class Karakuri2Memory2: ObservableObject {
    @AppStorage("karakuri2MemoMemory2") var memo = ""
    @AppStorage("karakuri2DateMemory2") var dateDouble = 0.0
}


class Karakuri2Memory3: ObservableObject {
    @AppStorage("karakuri2MemoMemory3") var memo = ""
    @AppStorage("karakuri2DateMemory3") var dateDouble = 0.0
}
