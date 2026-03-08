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
        
        koyakuCountLowerBell = 0
        normalGame = 0
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
    
    // ------
    // ST終了画面
    // ------
    @AppStorage("kabaneriUnatoScreenCountDefault") var screenCountDefault: Int = 0
    @AppStorage("kabaneriUnatoScreenCountHigh") var screenCountHigh: Int = 0
    @AppStorage("kabaneriUnatoScreenCountOver6") var screenCountOver6: Int = 0
    @AppStorage("kabaneriUnatoScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCountDefault,
            screenCountHigh,
            screenCountOver6,
        )
    }
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountHigh = 0
        screenCountOver6 = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // -------
    // おみくじ
    // -------
    @AppStorage("kabaneriUnatoOmikujiCount1") var omikujiCount1: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount2") var omikujiCount2: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount3") var omikujiCount3: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount4") var omikujiCount4: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount5") var omikujiCount5: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount6") var omikujiCount6: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountOver2") var omikujiCountOver2: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountOver4") var omikujiCountOver4: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountOver6") var omikujiCountOver6: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountSum") var omikujiCountSum: Int = 0
    
    func omikujiSumFunc() {
        omikujiCountSum = countSum(
            omikujiCount1,
            omikujiCount2,
            omikujiCount3,
            omikujiCount4,
            omikujiCount5,
            omikujiCount6,
            omikujiCountOver2,
            omikujiCountOver4,
            omikujiCountOver6,
        )
    }
    
    func resetOmikuji() {
        omikujiCount1 = 0
        omikujiCount2 = 0
        omikujiCount3 = 0
        omikujiCount4 = 0
        omikujiCount5 = 0
        omikujiCount6 = 0
        omikujiCountOver2 = 0
        omikujiCountOver4 = 0
        omikujiCountOver6 = 0
        omikujiCountSum = 0
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
        resetScreen()
        resetFirstHit()
        resetOmikuji()
        resetHayajiro()
    }
    
    // ---------
    // ver3.21.1
    // ---------
    // 下段ベル
    let ratioLowerBell: [Double] = [121.1,114.4,112.8,106.2,104.2,99.1]
    @AppStorage("kabaneriUnatoKoyakuCountLowerBell") var koyakuCountLowerBell: Int = 0
    @AppStorage("kabaneriUnatoNormalGame") var normalGame: Int = 0
    
    // 駿城ボーナス
    let ratioHayajiro3000: [Double] = [1.2,2,2,2,2,2.3]
    @AppStorage("kabaneriUnatoHayajiroCountMiss") var hayajiroCountMiss: Int = 0
    @AppStorage("kabaneriUnatoHayajiroCountHit") var hayajiroCountHit: Int = 0
    @AppStorage("kabaneriUnatoHayajiroCountSum") var hayajiroCountSum: Int = 0
    
    func hayajiroSumFunc() {
        hayajiroCountSum = hayajiroCountMiss + hayajiroCountHit
    }
    
    func resetHayajiro() {
        hayajiroCountMiss = 0
        hayajiroCountHit = 0
        hayajiroCountSum = 0
        minusCheck = false
    }
}


class KabaneriUnatoMemory1: ObservableObject {
    @AppStorage("kabaneriUnatoflushCountMissMemory1") var flushCountMiss: Int = 0
    @AppStorage("kabaneriUnatoflushCountHitMemory1") var flushCountHit: Int = 0
    @AppStorage("kabaneriUnatoflushCountSumMemory1") var flushCountSum: Int = 0
    @AppStorage("kabaneriUnatoVoiceCount35SisaMemory1") var voiceCount35Sisa: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountGusuMemory1") var voiceCountGusu: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighJakuMemory1") var voiceCountHighJaku: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighChuMemory1") var voiceCountHighChu: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighKyoMemory1") var voiceCountHighKyo: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountOver2Memory1") var voiceCountOver2: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountOver5Memory1") var voiceCountOver5: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountSumMemory1") var voiceCountSum: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighSumMemory1") var voiceCountHighSum: Int = 0
    @AppStorage("kabaneriUnatoCharaCount35SisaMemory1") var charaCount35Sisa: Int = 0
    @AppStorage("kabaneriUnatoCharaCountGusuMemory1") var charaCountGusu: Int = 0
    @AppStorage("kabaneriUnatoCharaCountOver4Memory1") var charaCountOver4: Int = 0
    @AppStorage("kabaneriUnatoCharaCountSumMemory1") var charaCountSum: Int = 0
    @AppStorage("kabaneriUnatoScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("kabaneriUnatoScreenCountHighMemory1") var screenCountHigh: Int = 0
    @AppStorage("kabaneriUnatoScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("kabaneriUnatoScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount1Memory1") var omikujiCount1: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount2Memory1") var omikujiCount2: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount3Memory1") var omikujiCount3: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount4Memory1") var omikujiCount4: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount5Memory1") var omikujiCount5: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount6Memory1") var omikujiCount6: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountOver2Memory1") var omikujiCountOver2: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountOver4Memory1") var omikujiCountOver4: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountOver6Memory1") var omikujiCountOver6: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountSumMemory1") var omikujiCountSum: Int = 0
    @AppStorage("kabaneriUnatoMemoMemory1") var memo = ""
    @AppStorage("kabaneriUnatoDateMemory1") var dateDouble = 0.0
    
    // ---------
    // ver3.21.1
    // ---------
    @AppStorage("kabaneriUnatoKoyakuCountLowerBellMemory1") var koyakuCountLowerBell: Int = 0
    @AppStorage("kabaneriUnatoNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("kabaneriUnatoHayajiroCountMissMemory1") var hayajiroCountMiss: Int = 0
    @AppStorage("kabaneriUnatoHayajiroCountHitMemory1") var hayajiroCountHit: Int = 0
    @AppStorage("kabaneriUnatoHayajiroCountSumMemory1") var hayajiroCountSum: Int = 0
}


class KabaneriUnatoMemory2: ObservableObject {
    @AppStorage("kabaneriUnatoflushCountMissMemory2") var flushCountMiss: Int = 0
    @AppStorage("kabaneriUnatoflushCountHitMemory2") var flushCountHit: Int = 0
    @AppStorage("kabaneriUnatoflushCountSumMemory2") var flushCountSum: Int = 0
    @AppStorage("kabaneriUnatoVoiceCount35SisaMemory2") var voiceCount35Sisa: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountGusuMemory2") var voiceCountGusu: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighJakuMemory2") var voiceCountHighJaku: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighChuMemory2") var voiceCountHighChu: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighKyoMemory2") var voiceCountHighKyo: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountOver2Memory2") var voiceCountOver2: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountOver5Memory2") var voiceCountOver5: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountSumMemory2") var voiceCountSum: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighSumMemory2") var voiceCountHighSum: Int = 0
    @AppStorage("kabaneriUnatoCharaCount35SisaMemory2") var charaCount35Sisa: Int = 0
    @AppStorage("kabaneriUnatoCharaCountGusuMemory2") var charaCountGusu: Int = 0
    @AppStorage("kabaneriUnatoCharaCountOver4Memory2") var charaCountOver4: Int = 0
    @AppStorage("kabaneriUnatoCharaCountSumMemory2") var charaCountSum: Int = 0
    @AppStorage("kabaneriUnatoScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("kabaneriUnatoScreenCountHighMemory2") var screenCountHigh: Int = 0
    @AppStorage("kabaneriUnatoScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("kabaneriUnatoScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount1Memory2") var omikujiCount1: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount2Memory2") var omikujiCount2: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount3Memory2") var omikujiCount3: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount4Memory2") var omikujiCount4: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount5Memory2") var omikujiCount5: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount6Memory2") var omikujiCount6: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountOver2Memory2") var omikujiCountOver2: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountOver4Memory2") var omikujiCountOver4: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountOver6Memory2") var omikujiCountOver6: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountSumMemory2") var omikujiCountSum: Int = 0
    @AppStorage("kabaneriUnatoMemoMemory2") var memo = ""
    @AppStorage("kabaneriUnatoDateMemory2") var dateDouble = 0.0
    
    // ---------
    // ver3.21.1
    // ---------
    @AppStorage("kabaneriUnatoKoyakuCountLowerBellMemory2") var koyakuCountLowerBell: Int = 0
    @AppStorage("kabaneriUnatoNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("kabaneriUnatoHayajiroCountMissMemory2") var hayajiroCountMiss: Int = 0
    @AppStorage("kabaneriUnatoHayajiroCountHitMemory2") var hayajiroCountHit: Int = 0
    @AppStorage("kabaneriUnatoHayajiroCountSumMemory2") var hayajiroCountSum: Int = 0
}


class KabaneriUnatoMemory3: ObservableObject {
    @AppStorage("kabaneriUnatoflushCountMissMemory3") var flushCountMiss: Int = 0
    @AppStorage("kabaneriUnatoflushCountHitMemory3") var flushCountHit: Int = 0
    @AppStorage("kabaneriUnatoflushCountSumMemory3") var flushCountSum: Int = 0
    @AppStorage("kabaneriUnatoVoiceCount35SisaMemory3") var voiceCount35Sisa: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountGusuMemory3") var voiceCountGusu: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighJakuMemory3") var voiceCountHighJaku: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighChuMemory3") var voiceCountHighChu: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighKyoMemory3") var voiceCountHighKyo: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountOver2Memory3") var voiceCountOver2: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountOver5Memory3") var voiceCountOver5: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountSumMemory3") var voiceCountSum: Int = 0
    @AppStorage("kabaneriUnatoVoiceCountHighSumMemory3") var voiceCountHighSum: Int = 0
    @AppStorage("kabaneriUnatoCharaCount35SisaMemory3") var charaCount35Sisa: Int = 0
    @AppStorage("kabaneriUnatoCharaCountGusuMemory3") var charaCountGusu: Int = 0
    @AppStorage("kabaneriUnatoCharaCountOver4Memory3") var charaCountOver4: Int = 0
    @AppStorage("kabaneriUnatoCharaCountSumMemory3") var charaCountSum: Int = 0
    @AppStorage("kabaneriUnatoScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("kabaneriUnatoScreenCountHighMemory3") var screenCountHigh: Int = 0
    @AppStorage("kabaneriUnatoScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("kabaneriUnatoScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount1Memory3") var omikujiCount1: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount2Memory3") var omikujiCount2: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount3Memory3") var omikujiCount3: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount4Memory3") var omikujiCount4: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount5Memory3") var omikujiCount5: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCount6Memory3") var omikujiCount6: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountOver2Memory3") var omikujiCountOver2: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountOver4Memory3") var omikujiCountOver4: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountOver6Memory3") var omikujiCountOver6: Int = 0
    @AppStorage("kabaneriUnatoOmikujiCountSumMemory3") var omikujiCountSum: Int = 0
    @AppStorage("kabaneriUnatoMemoMemory3") var memo = ""
    @AppStorage("kabaneriUnatoDateMemory3") var dateDouble = 0.0
    
    // ---------
    // ver3.21.1
    // ---------
    @AppStorage("kabaneriUnatoKoyakuCountLowerBellMemory3") var koyakuCountLowerBell: Int = 0
    @AppStorage("kabaneriUnatoNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("kabaneriUnatoHayajiroCountMissMemory3") var hayajiroCountMiss: Int = 0
    @AppStorage("kabaneriUnatoHayajiroCountHitMemory3") var hayajiroCountHit: Int = 0
    @AppStorage("kabaneriUnatoHayajiroCountSumMemory3") var hayajiroCountSum: Int = 0
}
