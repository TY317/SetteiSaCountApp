//
//  thunderClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/09.
//

import Foundation
import SwiftUI
import Combine

class Thunder: ObservableObject {
    // ---------
    // 打ち始めデータ
    // ---------
    @AppStorage("thunderStartGame") var startGame: Int = 0
    @AppStorage("thunderStartBig") var startBig: Int = 0
    @AppStorage("thunderStartReg") var startReg: Int = 0
    func resetStart() {
        startGame = 0
        startBig = 0
        startReg = 0
        minusCheck = false
    }
    
    // --------
    // プレイデータ入力
    // --------
    let ratioBig: [Double] = [277.7,275.4,270.8,264.3]
    let ratioReg: [Double] = [434,394.8,344.9,313.6]
//    let ratioBellSum: [Double] = [9.68,9.45,9.06,8.64]
//    let ratioBellA: [Double] = [12.9,12.5,12.1,11.5]
//    let ratioBellB: [Double] = [38.4,38.7,36.2,34.5]
//    let ratioKohriA: [Double] = [46.3,47.3,46.2,47.4]
//    let ratioCherryA1: [Double] = [99.4,99.4,99.4,99.3]
//    let ratioCherryA2: [Double] = [21.0,19.4,20.5,19.6]
//    let ratioCherryB: [Double] = [307.7,306.2,300.6,297.9]
//    let ratioHazureChallenge: [Double] = [4.7,4.5,4.3,4.2]
//    let ratioHazureGame: [Double] = [6.4,6.0,5.4,5.4]
//    let ratioBbBellA: [Double] = [1.111194,1.16676459,1.11262775,1.16834543]
//    let ratioBbBellB: [Double] = [10,7,10,7]
//    let ratioBbBarake: [Double] = [16384,16384,819.2,819.2]
//    let ratioRb1Mai: [Double] = [8,8,7,7]
//    let ratioRbBarake: [Double] = [16384,16384,16384,1092.3]
    @AppStorage("thunderPlayGame") var playGame: Int = 0
    @AppStorage("thunderTotalGame") var totalGame: Int = 0
    @AppStorage("thunderChallengeGame") var challengeGame: Int = 0
    @AppStorage("thunderthunderGame") var thunderGame: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellA") var normalKoyakuCountBellA: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellB") var normalKoyakuCountBellB: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellSum") var normalKoyakuCountBellSum: Int = 0
//    @AppStorage("thunderNormalKoyakuCountKohriA") var normalKoyakuCountKohriA: Int = 0
//    @AppStorage("thunderNormalKoyakuCountKohriB") var normalKoyakuCountKohriB: Int = 0
//    @AppStorage("thunderNormalKoyakuCountKohriSum") var normalKoyakuCountKohriSum: Int = 0
    @AppStorage("thunderNormalKoyakuCountCherryA1") var normalKoyakuCountCherryA1: Int = 0
    @AppStorage("thunderNormalKoyakuCountCherryA2") var normalKoyakuCountCherryA2: Int = 0
    @AppStorage("thunderNormalKoyakuCountCherryB") var normalKoyakuCountCherryB: Int = 0
    @AppStorage("thunderPlayBig") var playBig: Int = 0
    @AppStorage("thunderPlayReg") var playReg: Int = 0
    @AppStorage("thunderTotalBig") var totalBig: Int = 0
    @AppStorage("thunderTotalReg") var totalReg: Int = 0
    @AppStorage("thunderHazureCountChallenge") var hazureCountChallenge: Int = 0
    @AppStorage("thunderHazureCountGame") var hazureCountGame: Int = 0
    @AppStorage("thunderBbCountBellA") var bbCountBellA: Int = 0
    @AppStorage("thunderBbCountBellB") var bbCountBellB: Int = 0
    @AppStorage("thunderBbCountBarake") var bbCountBarake: Int = 0
    @AppStorage("thunderBbCountGame") var bbCountGame: Int = 0
    @AppStorage("thunderRbCount1Mai") var rbCount1Mai: Int = 0
    @AppStorage("thunderRbCount1MaiDeno") var rbCount1MaiDeno: Double = 0.0
    @AppStorage("thunderRbCountBarake") var rbCountBarake: Int = 0
    @AppStorage("thunderRbCountGame") var rbCountGame: Int = 0
    
    func gameSumFunc() {
        totalGame = startGame + playGame
    }
    
    func bellSumFunc() {
        normalKoyakuCountBellSum = normalKoyakuCountBellA + normalKoyakuCountBellB
    }
    
    func bonusSumFunc() {
        totalBig = startBig + playBig
        totalReg = startReg + playReg
    }
    
    func resetPlay() {
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "サンダーV"
    @AppStorage("thunderMinusCheck") var minusCheck: Bool = false
    @AppStorage("thunderSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetStart()
        resetPlay()
    }
}
