//
//  shakeClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import Foundation
import SwiftUI
import Combine

class Shake: ObservableObject {
    // ----------
    // 通常時
    // ----------
    let ratioKoyakuBell: [Double] = [10.3,-1,-1,-1,]
    let ratioKoyakuCherry: [Double] = [36.9,-1,-1,-1,]
    let ratioKoyakuSuika: [Double] = [65.5,-1,-1,-1,]
    @AppStorage("shakeGameNumberStart") var gameNumberStart: Int = 0
    @AppStorage("shakeGameNumberCurrent") var gameNumberCurrent: Int = 0
    @AppStorage("shakeGameNumberPlay") var gameNumberPlay: Int = 0
    @AppStorage("shakeKoyakuCountBell") var koyakuCountBell: Int = 0
    @AppStorage("shakeKoyakuCountCherry") var koyakuCountCherry: Int = 0
    @AppStorage("shakeKoyakuCountSuika") var koyakuCountSuika: Int = 0
    
    func resetNormal() {
        minusCheck = false
        gameNumberStart = 0
        gameNumberCurrent = 0
        gameNumberPlay = 0
        koyakuCountBell = 0
        koyakuCountCherry = 0
        koyakuCountSuika = 0
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "シェイクBT"
    @AppStorage("shakeMinusCheck") var minusCheck: Bool = false
    @AppStorage("shakeSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
    }
}
