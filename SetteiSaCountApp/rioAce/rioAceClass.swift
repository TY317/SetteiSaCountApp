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
}
