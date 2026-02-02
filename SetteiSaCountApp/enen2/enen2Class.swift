//
//  enen2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/11.
//

import Foundation
import SwiftUI

class Enen2: ObservableObject {
    // ----------
    // 初当り
    // ----------
    let ratioFirstHitBonus: [Double] = [272,269,257,242,236,227]
    let ratioFirstHitLoop: [Double] = [684,662,617,546,518,486]
    @AppStorage("enen2NormalGame") var normalGame: Int = 0
    @AppStorage("enen2FirstHitCountBonus") var firstHitCountBonus: Int = 0
    @AppStorage("enen2FirstHitCountLoop") var firstHitCountLoop: Int = 0
    
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountBonus = 0
        firstHitCountLoop = 0
        minusCheck = false
    }
    
    // ----------
    // 伝道者の罠
    // ----------
    @AppStorage("enen2WanaCountMiss") var wanaCountMiss: Int = 0
    @AppStorage("enen2WanaCountHit") var wanaCountHit: Int = 0
    @AppStorage("enen2WanaCountSum") var wanaCountSum: Int = 0
    
    func wanaSumFunc() {
        wanaCountSum = wanaCountMiss + wanaCountHit
    }
    
    func resetWana() {
        wanaCountMiss = 0
        wanaCountHit = 0
        wanaCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "炎炎ノ消防隊2"
    @AppStorage("enen2MinusCheck") var minusCheck: Bool = false
    @AppStorage("enen2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
        resetWana()
    }
}
