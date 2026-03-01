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
    
    // --------
    // カバネリボーナス
    // --------
    // 逆押しボイス
    @AppStorage("kabaneriUnatoVoiceCount35Sisa") var voiceCount35Sisa: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountGusu") var voiceCountGusu: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighJaku") var voiceCountHighJaku: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighChu") var voiceCountHighChu: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighKyo") var voiceCountHighKyo: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountOver2") var voiceCountOver2: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountOver5") var voiceCountOver5: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountSum") var voiceCountSum: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighSum") var voiceCountHighSum: Int = 0
    
    func voiceSumFunc() {
        voiceCountSum = countSum(
            voiceCount35Sisa,
            voiceCountGusu,
            voiceCountHighJaku,
            voiceCountHighChu,
            voiceCountHighKyo,
            voiceCountOver2,
            voiceCountOver5,
        )
        voiceCountHighSum = countSum(
            voiceCountHighJaku,
            voiceCountHighChu,
            voiceCountHighKyo,
        )
    }
    
    // キャラ紹介
    @AppStorage("kabaneriUnatoCharaCount35Sisa") var charaCount35Sisa: Int = 0
    @AppStorage("kabaneriUnatoCharaCountGusu") var charaCountGusu: Int = 0
    @AppStorage("kabaneriUnatoCharaCountOver4") var charaCountOver4: Int = 0
    @AppStorage("kabaneriUnatoCharaCountSum") var charaCountSum: Int = 0
    
    func charaSumFunc() {
        charaCountSum = countSum(
            charaCount35Sisa,
            charaCountGusu,
            charaCountOver4,
        )
    }
    
    func resetKabaneriBonus() {
        voiceCount35Sisa = 0
        voiceCountGusu = 0
        voiceCountHighJaku = 0
        voiceCountHighChu = 0
        voiceCountHighKyo = 0
        voiceCountOver2 = 0
        voiceCountOver5 = 0
        voiceCountSum = 0
        voiceCountHighSum = 0
        charaCount35Sisa = 0
        charaCountGusu = 0
        charaCountOver4 = 0
        charaCountSum = 0
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
        resetKabaneriBonus()
    }
}
