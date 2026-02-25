//
//  gobsla2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/23.
//

import Foundation
import SwiftUI
import Combine

class Gobsla2: ObservableObject {
    // --------
    // 通常時
    // --------
    // 弱レア役からのCZ
    let ratioJakuRareCZ: [Double] = [0.4,0.8,1.2,1.6,2.0,2.3]
    @AppStorage("gobsla2JakuRareCountJakuCherry") var jakuRareCountJakuCherry: Int = 0
    @AppStorage("gobsla2JakuRareCountSuika") var jakuRareCountSuika: Int = 0
    @AppStorage("gobsla2JakuRareCountSum") var jakuRareCountSum: Int = 0
    @AppStorage("gobsla2JakuRareCountHit") var jakuRareCountHit: Int = 0
    
    func normalSumFunc() {
        jakuRareCountSum = jakuRareCountJakuCherry + jakuRareCountSuika
    }
    
    // 300or500での当選
    let ratio35Hit: [Double] = [5.1,5.9,7,8.6,9.4,10.2]
    @AppStorage("gobsla2game35CountMiss") var game35HitCountMiss: Int = 0
    @AppStorage("gobsla2game35CountHit") var game35HitCountHit: Int = 0
    @AppStorage("gobsla2game35CountSum") var game35HitCountSum: Int = 0
    
    func game35SumFunc() {
        game35HitCountSum = game35HitCountMiss + game35HitCountHit
    }
    
    func resetNormal() {
        jakuRareCountJakuCherry = 0
        jakuRareCountSuika = 0
        jakuRareCountSum = 0
        jakuRareCountHit = 0
        game35HitCountMiss = 0
        game35HitCountHit = 0
        game35HitCountSum = 0
        minusCheck = false
    }
    
    // --------
    // 兜pt
    // --------
    let ratioPt10: [Double] = [18,18.4,19.6,22.9,23.7,23.9]
    let ratioPt20: [Double] = [8.8,9.1,10.1,12.7,13.3,13.4]
    let ratioPt30: [Double] = [18.5,18.6,18.9,19.6,19.7,19.8]
    let ratioPt40: [Double] = [8.7,8.6,8.2,7.1,6.9,6.8]
    let ratioPt50: [Double] = [6.8,6.7,6.4,5.6,5.4,5.3]
    let ratioPt60: [Double] = [15,14.8,14.1,12.3,11.9,11.8]
    let ratioPt70: [Double] = [4.8,4.8,4.6,4.0,3.8,3.8]
    let ratioPt80: [Double] = [4,3.9,3.7,3.2,3.1,3.1]
    let ratioPt90: [Double] = [11.3,11.1,10.6,9.3,9.0,8.9]
    let ratioPt100: [Double] = [4.1,4,3.9,3.4,3.3,3.2]
    let ratioPtU20: [Double] = [26.8,27.5,29.7,35.6,37,38.3]
    let ratioPtO40: [Double] = [54.7,53.9,51.4,44.8,43.3,42.9]
    @AppStorage("gobsla2PtCount10") var ptCount10: Int = 0
    @AppStorage("gobsla2PtCount20") var ptCount20: Int = 0
    @AppStorage("gobsla2PtCount30") var ptCount30: Int = 0
    @AppStorage("gobsla2PtCount40") var ptCount40: Int = 0
    @AppStorage("gobsla2PtCount50") var ptCount50: Int = 0
    @AppStorage("gobsla2PtCount60") var ptCount60: Int = 0
    @AppStorage("gobsla2PtCount70") var ptCount70: Int = 0
    @AppStorage("gobsla2PtCount80") var ptCount80: Int = 0
    @AppStorage("gobsla2PtCount90") var ptCount90: Int = 0
    @AppStorage("gobsla2PtCount100") var ptCount100: Int = 0
    @AppStorage("gobsla2PtCountSum") var ptCountSum: Int = 0
    @AppStorage("gobsla2PtCountU20") var ptCountU20: Int = 0
    @AppStorage("gobsla2PtCountO40") var ptCountO40: Int = 0
    
    func ptSumFunc() {
        ptCountSum = countSum(
            ptCount10,
            ptCount20,
            ptCount30,
            ptCount40,
            ptCount50,
            ptCount60,
            ptCount70,
            ptCount80,
            ptCount90,
            ptCount100,
        )
        ptCountU20 = countSum(
            ptCount10,
            ptCount20,
        )
        ptCountO40 = countSum(
            ptCount40,
            ptCount50,
            ptCount60,
            ptCount70,
            ptCount80,
            ptCount90,
            ptCount100,
        )
    }
    
    func resetKabuto() {
        ptCount10 = 0
        ptCount20 = 0
        ptCount30 = 0
        ptCount40 = 0
        ptCount50 = 0
        ptCount60 = 0
        ptCount70 = 0
        ptCount80 = 0
        ptCount90 = 0
        ptCount100 = 0
        ptCountSum = 0
        ptCountU20 = 0
        ptCountO40 = 0
        minusCheck = false
    }
    
    // ---------
    // 初あたり
    // ---------
    let ratioFirstHitCz: [Double] = [239.3,232.3,222.9,200.4,187.3,181.9]
    let ratioFirstHitAt: [Double] = [541.6,526.4,506.4,453.2,417.8,402.4]
    
    func resetFirstHit() {
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ゴブリンスレイヤー2"
    @AppStorage("gobsla2MinusCheck") var minusCheck: Bool = false
    @AppStorage("gobsla2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetKabuto()
        resetFirstHit()
    }
}
