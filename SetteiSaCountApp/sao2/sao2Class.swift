//
//  sao2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/30.
//

import Foundation
import SwiftUI
import Combine

class Sao2: ObservableObject {
    // ----------
    // 通常時
    // ----------
    let ratioLowSuikaShooting: [Double] = [40.2,44.5,41,48.4,42.2,55.1]
    let ratioKyoCherryCz: [Double] = [20,21,20,25,20,33]
    let ratioHighKyoCherryCz: [Double] = [50,51,52,55,58,60]
    @AppStorage("sao2LowSuikaCount") var lowSuikaCount: Int = 0
    @AppStorage("sao2LowSuikaCountShootingHit") var lowSuikaCountShootingHit: Int = 0
    @AppStorage("sao2KyoCherryCount") var kyoCherryCount: Int = 0
    @AppStorage("sao2KyoCherryCountCzHit") var kyoCherryCountCzHit: Int = 0
    @AppStorage("sao2HighKyoCherryCount") var highKyoCherryCount: Int = 0
    @AppStorage("sao2HighKyoCherryCountCzHit") var highKyoCherryCountCzHit: Int = 0
    
    func resetNormal() {
        lowSuikaCount = 0
        lowSuikaCountShootingHit = 0
        kyoCherryCount = 0
        kyoCherryCountCzHit = 0
        highKyoCherryCount = 0
        highKyoCherryCountCzHit = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ソードアート・オンラインⅡ"
    @AppStorage("sao2MinusCheck") var minusCheck: Bool = false
    @AppStorage("sao2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
    }
}
