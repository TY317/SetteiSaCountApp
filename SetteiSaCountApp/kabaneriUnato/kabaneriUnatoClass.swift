//
//  kabaneriUnatoClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/28.
//

import Foundation
import SwiftUI
import Combine

class KabaneriUnato: ObservableObject {
    // ------
    // 通常時
    // ------
    let ratioFlush: [Double] = [10,-80,-80,-80,-80,17]
    @AppStorage("kabaneriUnatoflushCountMiss") var flushCountMiss: Int = 0
    @AppStorage("kabaneriUnatoflushCountHit") var flushCountHit: Int = 0
    @AppStorage("kabaneriUnatoflushCountSum") var flushCountSum: Int = 0
    
    func flushSumFunc() {
        flushCountSum = flushCountMiss + flushCountHit
    }
    
    func resetNormal() {
        flushCountMiss = 0
        flushCountHit = 0
        flushCountSum = 0
        minusCheck = false
    }
    
    // ---------
    // 初当り
    // ---------
    let ratioFirstHitCz: [Double] = [-1,-1,-1,-1,-1,-1,]
    let ratioFirstHitBonus: [Double] = [254.2,242.3,239.6,214,203.2,195.1]
    let ratioFirstHitSt: [Double] = [422.5,405.9,398.7,357.2,332.6,318.5]
    
    func resetFirstHit() {
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "甲鉄城のカバネリ海門決戦"
    @AppStorage("kabaneriUnatoMinusCheck") var minusCheck: Bool = false
    @AppStorage("kabaneriUnatoSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
    }
}
