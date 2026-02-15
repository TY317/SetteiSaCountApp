//
//  hanabiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/02.
//

import Foundation
import SwiftUI
import Combine

class Hanabi: ObservableObject {
    // ---------
    // 打ち始めデータ
    // ---------
    @AppStorage("hanabiStartGame") var startGame: Int = 0
    @AppStorage("hanabiStartBig") var startBig: Int = 0
    @AppStorage("hanabiStartReg") var startReg: Int = 0
    func resetStart() {
        startGame = 0
        startBig = 0
        startReg = 0
        minusCheck = false
    }
    
    // --------
    // プレイデータ入力
    // --------
    let ratioBig: [Double] = [297.9,292.6,284.9,273.1]
    let ratioReg: [Double] = [394.8,358.1,313.6,282.5]
    let ratioBellSum: [Double] = [9.68,9.45,9.06,8.64]
    let ratioBellA: [Double] = [12.9,12.5,12.1,11.5]
    let ratioBellB: [Double] = [38.4,38.7,36.2,34.5]
    let ratioKohriA: [Double] = [46.3,47.3,46.2,47.4]
    let ratioCherryA1: [Double] = [99.4,99.4,99.4,99.3]
    let ratioCherryA2: [Double] = [21.0,19.4,20.5,19.6]
    let ratioCherryB: [Double] = [307.7,306.2,300.6,297.9]
    let ratioHazureChallenge: [Double] = [4.7,4.5,4.3,4.2]
    let ratioHazureGame: [Double] = [6.4,6.0,5.4,5.4]
    let ratioBbBellA: [Double] = [1.111194,1.16676459,1.11262775,1.16834543]
    let ratioBbBellB: [Double] = [10,7,10,7]
    let ratioBbBarake: [Double] = [16384,16384,819.2,819.2]
    let ratioRb1Mai: [Double] = [8,8,7,7]
    let ratioRbBarake: [Double] = [16384,16384,16384,1092.3]
    @AppStorage("hanabiPlayGame") var playGame: Int = 0
    @AppStorage("hanabiTotalGame") var totalGame: Int = 0
    @AppStorage("hanabiChallengeGame") var challengeGame: Int = 0
    @AppStorage("hanabiHanabiGame") var hanabiGame: Int = 0
    @AppStorage("hanabiNormalKoyakuCountBellA") var normalKoyakuCountBellA: Int = 0
    @AppStorage("hanabiNormalKoyakuCountBellB") var normalKoyakuCountBellB: Int = 0
    @AppStorage("hanabiNormalKoyakuCountBellSum") var normalKoyakuCountBellSum: Int = 0
    @AppStorage("hanabiNormalKoyakuCountKohriA") var normalKoyakuCountKohriA: Int = 0
    @AppStorage("hanabiNormalKoyakuCountKohriB") var normalKoyakuCountKohriB: Int = 0
    @AppStorage("hanabiNormalKoyakuCountKohriSum") var normalKoyakuCountKohriSum: Int = 0
    @AppStorage("hanabiNormalKoyakuCountCherryA1") var normalKoyakuCountCherryA1: Int = 0
    @AppStorage("hanabiNormalKoyakuCountCherryA2") var normalKoyakuCountCherryA2: Int = 0
    @AppStorage("hanabiNormalKoyakuCountCherryB") var normalKoyakuCountCherryB: Int = 0
    @AppStorage("hanabiPlayBig") var playBig: Int = 0
    @AppStorage("hanabiPlayReg") var playReg: Int = 0
    @AppStorage("hanabiTotalBig") var totalBig: Int = 0
    @AppStorage("hanabiTotalReg") var totalReg: Int = 0
    @AppStorage("hanabiHazureCountChallenge") var hazureCountChallenge: Int = 0
    @AppStorage("hanabiHazureCountGame") var hazureCountGame: Int = 0
    @AppStorage("hanabiBbCountBellA") var bbCountBellA: Int = 0
    @AppStorage("hanabiBbCountBellB") var bbCountBellB: Int = 0
    @AppStorage("hanabiBbCountBarake") var bbCountBarake: Int = 0
    @AppStorage("hanabiBbCountGame") var bbCountGame: Int = 0
    @AppStorage("hanabiRbCount1Mai") var rbCount1Mai: Int = 0
    @AppStorage("hanabiRbCount1MaiDeno") var rbCount1MaiDeno: Double = 0.0
    @AppStorage("hanabiRbCountBarake") var rbCountBarake: Int = 0
    @AppStorage("hanabiRbCountGame") var rbCountGame: Int = 0
    
    func gameSumFunc() {
        totalGame = startGame + playGame
    }
    
    func bellSumFunc() {
        normalKoyakuCountBellSum = normalKoyakuCountBellA + normalKoyakuCountBellB
    }
    
    func kohriSumFunc() {
        normalKoyakuCountKohriSum = normalKoyakuCountKohriA + normalKoyakuCountKohriB
    }
    
    func bonusSumFunc() {
        totalBig = startBig + playBig
        totalReg = startReg + playReg
    }
    
    func rb1MaiGameCal() {
        rbCountGame = Int(Double(rbCount1Mai) * rbCount1MaiDeno)
    }
    
    func rbGameCal() {
        rbCountGame = (playReg * 8) + rbCount1Mai
    }
    
    func bbGameCal() {
        bbCountGame = playBig * 20
    }
    
    func resetPlay() {
        playGame = 0
        totalGame = 0
        challengeGame = 0
        hanabiGame = 0
        normalKoyakuCountBellA = 0
        normalKoyakuCountBellB = 0
        normalKoyakuCountBellSum = 0
        normalKoyakuCountKohriA = 0
        normalKoyakuCountKohriB = 0
        normalKoyakuCountKohriSum = 0
        normalKoyakuCountCherryA1 = 0
        normalKoyakuCountCherryA2 = 0
        normalKoyakuCountCherryB = 0
        playBig = 0
        playReg = 0
        totalBig = 0
        totalReg = 0
        hazureCountChallenge = 0
        hazureCountGame = 0
        bbCountBellA = 0
        bbCountBellB = 0
        bbCountBarake = 0
        bbCountGame = 0
        rbCount1Mai = 0
        rbCount1MaiDeno = 0.0
        rbCountBarake = 0
        rbCountGame = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ハナビ"
    @AppStorage("hanabiMinusCheck") var minusCheck: Bool = false
    @AppStorage("hanabiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetStart()
        resetPlay()
    }
}

class HanabiMemory1: ObservableObject {
    @AppStorage("hanabiStartGameMemory1") var startGame: Int = 0
    @AppStorage("hanabiStartBigMemory1") var startBig: Int = 0
    @AppStorage("hanabiStartRegMemory1") var startReg: Int = 0
    @AppStorage("hanabiPlayGameMemory1") var playGame: Int = 0
    @AppStorage("hanabiTotalGameMemory1") var totalGame: Int = 0
    @AppStorage("hanabiChallengeGameMemory1") var challengeGame: Int = 0
    @AppStorage("hanabiHanabiGameMemory1") var hanabiGame: Int = 0
    @AppStorage("hanabiNormalKoyakuCountBellAMemory1") var normalKoyakuCountBellA: Int = 0
    @AppStorage("hanabiNormalKoyakuCountBellBMemory1") var normalKoyakuCountBellB: Int = 0
    @AppStorage("hanabiNormalKoyakuCountBellSumMemory1") var normalKoyakuCountBellSum: Int = 0
    @AppStorage("hanabiNormalKoyakuCountKohriAMemory1") var normalKoyakuCountKohriA: Int = 0
    @AppStorage("hanabiNormalKoyakuCountKohriBMemory1") var normalKoyakuCountKohriB: Int = 0
    @AppStorage("hanabiNormalKoyakuCountKohriSumMemory1") var normalKoyakuCountKohriSum: Int = 0
    @AppStorage("hanabiNormalKoyakuCountCherryA1Memory1") var normalKoyakuCountCherryA1: Int = 0
    @AppStorage("hanabiNormalKoyakuCountCherryA2Memory1") var normalKoyakuCountCherryA2: Int = 0
    @AppStorage("hanabiNormalKoyakuCountCherryBMemory1") var normalKoyakuCountCherryB: Int = 0
    @AppStorage("hanabiPlayBigMemory1") var playBig: Int = 0
    @AppStorage("hanabiPlayRegMemory1") var playReg: Int = 0
    @AppStorage("hanabiTotalBigMemory1") var totalBig: Int = 0
    @AppStorage("hanabiTotalRegMemory1") var totalReg: Int = 0
    @AppStorage("hanabiHazureCountChallengeMemory1") var hazureCountChallenge: Int = 0
    @AppStorage("hanabiHazureCountGameMemory1") var hazureCountGame: Int = 0
    @AppStorage("hanabiBbCountBellAMemory1") var bbCountBellA: Int = 0
    @AppStorage("hanabiBbCountBellBMemory1") var bbCountBellB: Int = 0
    @AppStorage("hanabiBbCountBarakeMemory1") var bbCountBarake: Int = 0
    @AppStorage("hanabiBbCountGameMemory1") var bbCountGame: Int = 0
    @AppStorage("hanabiRbCount1MaiMemory1") var rbCount1Mai: Int = 0
    @AppStorage("hanabiRbCount1MaiDenoMemory1") var rbCount1MaiDeno: Double = 0.0
    @AppStorage("hanabiRbCountBarakeMemory1") var rbCountBarake: Int = 0
    @AppStorage("hanabiRbCountGameMemory1") var rbCountGame: Int = 0
    @AppStorage("hanabiMemoMemory1") var memo = ""
    @AppStorage("hanabiDateMemory1") var dateDouble = 0.0
}

class HanabiMemory2: ObservableObject {
    @AppStorage("hanabiStartGameMemory2") var startGame: Int = 0
    @AppStorage("hanabiStartBigMemory2") var startBig: Int = 0
    @AppStorage("hanabiStartRegMemory2") var startReg: Int = 0
    @AppStorage("hanabiPlayGameMemory2") var playGame: Int = 0
    @AppStorage("hanabiTotalGameMemory2") var totalGame: Int = 0
    @AppStorage("hanabiChallengeGameMemory2") var challengeGame: Int = 0
    @AppStorage("hanabiHanabiGameMemory2") var hanabiGame: Int = 0
    @AppStorage("hanabiNormalKoyakuCountBellAMemory2") var normalKoyakuCountBellA: Int = 0
    @AppStorage("hanabiNormalKoyakuCountBellBMemory2") var normalKoyakuCountBellB: Int = 0
    @AppStorage("hanabiNormalKoyakuCountBellSumMemory2") var normalKoyakuCountBellSum: Int = 0
    @AppStorage("hanabiNormalKoyakuCountKohriAMemory2") var normalKoyakuCountKohriA: Int = 0
    @AppStorage("hanabiNormalKoyakuCountKohriBMemory2") var normalKoyakuCountKohriB: Int = 0
    @AppStorage("hanabiNormalKoyakuCountKohriSumMemory2") var normalKoyakuCountKohriSum: Int = 0
    @AppStorage("hanabiNormalKoyakuCountCherryA1Memory2") var normalKoyakuCountCherryA1: Int = 0
    @AppStorage("hanabiNormalKoyakuCountCherryA2Memory2") var normalKoyakuCountCherryA2: Int = 0
    @AppStorage("hanabiNormalKoyakuCountCherryBMemory2") var normalKoyakuCountCherryB: Int = 0
    @AppStorage("hanabiPlayBigMemory2") var playBig: Int = 0
    @AppStorage("hanabiPlayRegMemory2") var playReg: Int = 0
    @AppStorage("hanabiTotalBigMemory2") var totalBig: Int = 0
    @AppStorage("hanabiTotalRegMemory2") var totalReg: Int = 0
    @AppStorage("hanabiHazureCountChallengeMemory2") var hazureCountChallenge: Int = 0
    @AppStorage("hanabiHazureCountGameMemory2") var hazureCountGame: Int = 0
    @AppStorage("hanabiBbCountBellAMemory2") var bbCountBellA: Int = 0
    @AppStorage("hanabiBbCountBellBMemory2") var bbCountBellB: Int = 0
    @AppStorage("hanabiBbCountBarakeMemory2") var bbCountBarake: Int = 0
    @AppStorage("hanabiBbCountGameMemory2") var bbCountGame: Int = 0
    @AppStorage("hanabiRbCount1MaiMemory2") var rbCount1Mai: Int = 0
    @AppStorage("hanabiRbCount1MaiDenoMemory2") var rbCount1MaiDeno: Double = 0.0
    @AppStorage("hanabiRbCountBarakeMemory2") var rbCountBarake: Int = 0
    @AppStorage("hanabiRbCountGameMemory2") var rbCountGame: Int = 0
    @AppStorage("hanabiMemoMemory2") var memo = ""
    @AppStorage("hanabiDateMemory2") var dateDouble = 0.0
}

class HanabiMemory3: ObservableObject {
    @AppStorage("hanabiStartGameMemory3") var startGame: Int = 0
    @AppStorage("hanabiStartBigMemory3") var startBig: Int = 0
    @AppStorage("hanabiStartRegMemory3") var startReg: Int = 0
    @AppStorage("hanabiPlayGameMemory3") var playGame: Int = 0
    @AppStorage("hanabiTotalGameMemory3") var totalGame: Int = 0
    @AppStorage("hanabiChallengeGameMemory3") var challengeGame: Int = 0
    @AppStorage("hanabiHanabiGameMemory3") var hanabiGame: Int = 0
    @AppStorage("hanabiNormalKoyakuCountBellAMemory3") var normalKoyakuCountBellA: Int = 0
    @AppStorage("hanabiNormalKoyakuCountBellBMemory3") var normalKoyakuCountBellB: Int = 0
    @AppStorage("hanabiNormalKoyakuCountBellSumMemory3") var normalKoyakuCountBellSum: Int = 0
    @AppStorage("hanabiNormalKoyakuCountKohriAMemory3") var normalKoyakuCountKohriA: Int = 0
    @AppStorage("hanabiNormalKoyakuCountKohriBMemory3") var normalKoyakuCountKohriB: Int = 0
    @AppStorage("hanabiNormalKoyakuCountKohriSumMemory3") var normalKoyakuCountKohriSum: Int = 0
    @AppStorage("hanabiNormalKoyakuCountCherryA1Memory3") var normalKoyakuCountCherryA1: Int = 0
    @AppStorage("hanabiNormalKoyakuCountCherryA2Memory3") var normalKoyakuCountCherryA2: Int = 0
    @AppStorage("hanabiNormalKoyakuCountCherryBMemory3") var normalKoyakuCountCherryB: Int = 0
    @AppStorage("hanabiPlayBigMemory3") var playBig: Int = 0
    @AppStorage("hanabiPlayRegMemory3") var playReg: Int = 0
    @AppStorage("hanabiTotalBigMemory3") var totalBig: Int = 0
    @AppStorage("hanabiTotalRegMemory3") var totalReg: Int = 0
    @AppStorage("hanabiHazureCountChallengeMemory3") var hazureCountChallenge: Int = 0
    @AppStorage("hanabiHazureCountGameMemory3") var hazureCountGame: Int = 0
    @AppStorage("hanabiBbCountBellAMemory3") var bbCountBellA: Int = 0
    @AppStorage("hanabiBbCountBellBMemory3") var bbCountBellB: Int = 0
    @AppStorage("hanabiBbCountBarakeMemory3") var bbCountBarake: Int = 0
    @AppStorage("hanabiBbCountGameMemory3") var bbCountGame: Int = 0
    @AppStorage("hanabiRbCount1MaiMemory3") var rbCount1Mai: Int = 0
    @AppStorage("hanabiRbCount1MaiDenoMemory3") var rbCount1MaiDeno: Double = 0.0
    @AppStorage("hanabiRbCountBarakeMemory3") var rbCountBarake: Int = 0
    @AppStorage("hanabiRbCountGameMemory3") var rbCountGame: Int = 0
    @AppStorage("hanabiMemoMemory3") var memo = ""
    @AppStorage("hanabiDateMemory3") var dateDouble = 0.0
}
