//
//  rioAceClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/02.
//

import Foundation
import SwiftUI
import Combine

class RioAce: ObservableObject {
    // -------
    // 通常時
    // -------
    // 規定リプレイ
    let ratioKiteiReplayHit: [Double] = [20.3,21.1,22.7,26.2,27.7,30.1]
    @AppStorage("rioAceKiteiReplayCount") var kiteiReplay: Int = 0
    @AppStorage("rioAceKiteiReplayCountHit") var kiteiReplayHit: Int = 0
    
    func resetNormal() {
        kiteiReplay = 0
        kiteiReplayHit = 0
        minusCheck = false
        
        aceModeCountMiss = 0
        aceModeCountHit = 0
        aceModeCountSum = 0
        
        suikaCount = 0
        roomSuccessCount = 0
        duringRoomSuikaCountMemo = 0
    }
    
    // スイカ成功抽選
    let ratioSuikaCz: [Double] = [10.2,10.9,12.9,18.0,19.5,21.9]
    
    // ---------
    // 初当り
    // ---------
    let ratioFirstHitNoirRoom: [Double] = [131.9,130.4,127.6,121.2,119.1,116.2]
    let ratioFirstHitDirectBonus: [Double] = [53905.6,26924.8,13681.4,6252.5,5208,4326.7]
    let ratioFirstHitWithoutDirect: [Double] = [291.4,284.9,273.4,248.4,240.6,230.9]
    @AppStorage("rioAceNormalGame") var normalGame: Int = 0
    @AppStorage("rioAceFirstHitCountNoirRoom") var firstHitCountNoirRoom: Int = 0
    @AppStorage("rioAceFirstHitCountDirectBonusDirectBonus") var firstHitCountDirectBonus: Int = 0
    @AppStorage("rioAceFirstHitCountDirectBonusWithoutDirect") var firstHitCountWithoutDirect: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountNoirRoom = 0
        firstHitCountDirectBonus = 0
        firstHitCountWithoutDirect = 0
        minusCheck = false
    }
    
    // ---------
    // 終了画面
    // ---------
    @AppStorage("rioAceScreenCountNone") var screenCountNone: Int = 0
    @AppStorage("rioAceScreenCountRio") var screenCountRio: Int = 0
    @AppStorage("rioAceScreenCountMint") var screenCountMint: Int = 0
    @AppStorage("rioAceScreenCountRina") var screenCountRina: Int = 0
    @AppStorage("rioAceScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCountNone,
            screenCountRio,
            screenCountMint,
            screenCountRina,
        )
    }
    
    func resetScreen() {
        screenCountNone = 0
        screenCountRio = 0
        screenCountMint = 0
        screenCountRina = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "スーパーリオエース2"
    @AppStorage("rioAceMinusCheck") var minusCheck: Bool = false
    @AppStorage("rioAceSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetVoice()
    }
    
    // ------------
    // ver3.27.1
    // ------------
    let ratioAceMode: [Double] = [30.1,32,34.4,37.5,40.6,43.8]
    @AppStorage("rioAceAceModeCountMiss") var aceModeCountMiss: Int = 0
    @AppStorage("rioAceAceModeCountHit") var aceModeCountHit: Int = 0
    @AppStorage("rioAceAceModeCountSum") var aceModeCountSum: Int = 0
    
    func aceModeSumFunc() {
        aceModeCountSum = aceModeCountMiss + aceModeCountHit
    }
    
    // リナサイン
    let ratioRinaSign: [Double] = [1,2,3,4,4.5,5]
    
    // -------
    // ver4.0.0
    // -------
    @AppStorage("rioAceSuikaCount") var suikaCount: Int = 0
    @AppStorage("rioAceRoomSuccessCount") var roomSuccessCount: Int = 0
    @AppStorage("rioAceDuringRoomSuikaCountMemo") var duringRoomSuikaCountMemo: Int = 0
    
    // -------
    // ver4.1.0
    // -------
    let ratioVoiceDefault: [Double] = [59,55,54,49,48,45]
    let ratioVoiceHighJaku: [Double] = [30,31,32,33,34,35]
    let ratioVoiceHighChu: [Double] = [10,12,12,14,14,16]
    let ratioVoiceHighKyo: [Double] = [1,2,2,3,3,3]
    let ratioVoiceOver4: [Double] = [0,0,0,1,1,1]
    @AppStorage("rioAceVoiceCount1") var voiceCount1: Int = 0
    @AppStorage("rioAceVoiceCount2") var voiceCount2: Int = 0
    @AppStorage("rioAceVoiceCount3") var voiceCount3: Int = 0
    @AppStorage("rioAceVoiceCount4") var voiceCount4: Int = 0
    @AppStorage("rioAceVoiceCount5") var voiceCount5: Int = 0
    @AppStorage("rioAceVoiceCountSum") var voiceCountSum: Int = 0
    
    func voiceSumFunc() {
        voiceCountSum = countSum(
            voiceCount1,
            voiceCount2,
            voiceCount3,
            voiceCount4,
            voiceCount5,
        )
    }
    
    func resetVoice() {
        voiceCount1 = 0
        voiceCount2 = 0
        voiceCount3 = 0
        voiceCount4 = 0
        voiceCount5 = 0
        voiceCountSum = 0
        minusCheck = false
    }
}


class RioAceMemory1: ObservableObject {
    @AppStorage("rioAceKiteiReplayCountMemory1") var kiteiReplay: Int = 0
    @AppStorage("rioAceKiteiReplayCountHitMemory1") var kiteiReplayHit: Int = 0
    @AppStorage("rioAceNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("rioAceFirstHitCountNoirRoomMemory1") var firstHitCountNoirRoom: Int = 0
    @AppStorage("rioAceFirstHitCountDirectBonusDirectBonusMemory1") var firstHitCountDirectBonus: Int = 0
    @AppStorage("rioAceFirstHitCountDirectBonusWithoutDirectMemory1") var firstHitCountWithoutDirect: Int = 0
    @AppStorage("rioAceScreenCountNoneMemory1") var screenCountNone: Int = 0
    @AppStorage("rioAceScreenCountRioMemory1") var screenCountRio: Int = 0
    @AppStorage("rioAceScreenCountMintMemory1") var screenCountMint: Int = 0
    @AppStorage("rioAceScreenCountRinaMemory1") var screenCountRina: Int = 0
    @AppStorage("rioAceScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("rioAceMemoMemory1") var memo = ""
    @AppStorage("rioAceDateMemory1") var dateDouble = 0.0
    
    // ------------
    // ver3.27.1
    // ------------
    @AppStorage("rioAceAceModeCountMissMemory1") var aceModeCountMiss: Int = 0
    @AppStorage("rioAceAceModeCountHitMemory1") var aceModeCountHit: Int = 0
    @AppStorage("rioAceAceModeCountSumMemory1") var aceModeCountSum: Int = 0
    
    // -------
    // ver4.0.0
    // -------
    @AppStorage("rioAceSuikaCountMemory1") var suikaCount: Int = 0
    @AppStorage("rioAceRoomSuccessCountMemory1") var roomSuccessCount: Int = 0
    @AppStorage("rioAceDuringRoomSuikaCountMemoMemory1") var duringRoomSuikaCountMemo: Int = 0
}

class RioAceMemory2: ObservableObject {
    @AppStorage("rioAceKiteiReplayCountMemory2") var kiteiReplay: Int = 0
    @AppStorage("rioAceKiteiReplayCountHitMemory2") var kiteiReplayHit: Int = 0
    @AppStorage("rioAceNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("rioAceFirstHitCountNoirRoomMemory2") var firstHitCountNoirRoom: Int = 0
    @AppStorage("rioAceFirstHitCountDirectBonusDirectBonusMemory2") var firstHitCountDirectBonus: Int = 0
    @AppStorage("rioAceFirstHitCountDirectBonusWithoutDirectMemory2") var firstHitCountWithoutDirect: Int = 0
    @AppStorage("rioAceScreenCountNoneMemory2") var screenCountNone: Int = 0
    @AppStorage("rioAceScreenCountRioMemory2") var screenCountRio: Int = 0
    @AppStorage("rioAceScreenCountMintMemory2") var screenCountMint: Int = 0
    @AppStorage("rioAceScreenCountRinaMemory2") var screenCountRina: Int = 0
    @AppStorage("rioAceScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("rioAceMemoMemory2") var memo = ""
    @AppStorage("rioAceDateMemory2") var dateDouble = 0.0
    
    // ------------
    // ver3.27.1
    // ------------
    @AppStorage("rioAceAceModeCountMissMemory2") var aceModeCountMiss: Int = 0
    @AppStorage("rioAceAceModeCountHitMemory2") var aceModeCountHit: Int = 0
    @AppStorage("rioAceAceModeCountSumMemory2") var aceModeCountSum: Int = 0
    
    // -------
    // ver4.0.0
    // -------
    @AppStorage("rioAceSuikaCountMemory2") var suikaCount: Int = 0
    @AppStorage("rioAceRoomSuccessCountMemory2") var roomSuccessCount: Int = 0
    @AppStorage("rioAceDuringRoomSuikaCountMemoMemory2") var duringRoomSuikaCountMemo: Int = 0
}

class RioAceMemory3: ObservableObject {
    @AppStorage("rioAceKiteiReplayCountMemory3") var kiteiReplay: Int = 0
    @AppStorage("rioAceKiteiReplayCountHitMemory3") var kiteiReplayHit: Int = 0
    @AppStorage("rioAceNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("rioAceFirstHitCountNoirRoomMemory3") var firstHitCountNoirRoom: Int = 0
    @AppStorage("rioAceFirstHitCountDirectBonusDirectBonusMemory3") var firstHitCountDirectBonus: Int = 0
    @AppStorage("rioAceFirstHitCountDirectBonusWithoutDirectMemory3") var firstHitCountWithoutDirect: Int = 0
    @AppStorage("rioAceScreenCountNoneMemory3") var screenCountNone: Int = 0
    @AppStorage("rioAceScreenCountRioMemory3") var screenCountRio: Int = 0
    @AppStorage("rioAceScreenCountMintMemory3") var screenCountMint: Int = 0
    @AppStorage("rioAceScreenCountRinaMemory3") var screenCountRina: Int = 0
    @AppStorage("rioAceScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("rioAceMemoMemory3") var memo = ""
    @AppStorage("rioAceDateMemory3") var dateDouble = 0.0
    
    // ------------
    // ver3.27.1
    // ------------
    @AppStorage("rioAceAceModeCountMissMemory3") var aceModeCountMiss: Int = 0
    @AppStorage("rioAceAceModeCountHitMemory3") var aceModeCountHit: Int = 0
    @AppStorage("rioAceAceModeCountSumMemory3") var aceModeCountSum: Int = 0
    
    // -------
    // ver4.0.0
    // -------
    @AppStorage("rioAceSuikaCountMemory3") var suikaCount: Int = 0
    @AppStorage("rioAceRoomSuccessCountMemory3") var roomSuccessCount: Int = 0
    @AppStorage("rioAceDuringRoomSuikaCountMemoMemory3") var duringRoomSuikaCountMemo: Int = 0
}
