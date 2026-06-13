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
    }
    
    // スイカ成功抽選
    let ratioSuikaCz: [Double] = [10.2,-1,12.9,-1,-1,-1]
    
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
}
