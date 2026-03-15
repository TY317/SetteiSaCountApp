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
        gameSumFunc()
        bonusSumFunc()
    }
    
    // --------
    // プレイデータ入力
    // --------
    let ratioBig: [Double] = [277.7,275.4,270.8,264.3]
    let ratioReg: [Double] = [434,394.8,344.9,313.6]
    let ratioBellSum: [Double] = [12.5,12.6,11.9,11.2]
    let ratioBellA: [Double] = [16.3,15.8,15.3,14.8]
    let ratioBellB: [Double] = [52.9,62.1,53.9,47.1]
    let ratioSuika: [Double] = [81.1,82.2,74.6,76.3]
    let ratioCherryB: [Double] = [13.2,12.1,12.5,12.2]
    let ratioBtLoop: [Double] = [14.9,13.5,11.2,9.6]
    let ratioBbBellA: [Double] = [1.2,1.3,1.2,1.3]
    let ratioBbBellB: [Double] = [7,5.8,7,5.8]
    let ratioBbBellC: [Double] = [36,36,24.3,24.3]
    let ratioBbReach: [Double] = [10922.7,10922.7,436.9,436.9]
//    let ratioRb1Mai: [Double] = [8,8,7,7]
//    let ratioRbBarake: [Double] = [16384,16384,16384,1092.3]
    @AppStorage("thunderPlayGame") var playGame: Int = 0
    @AppStorage("thunderTotalGame") var totalGame: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellA") var normalKoyakuCountBellA: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellB") var normalKoyakuCountBellB: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellSum") var normalKoyakuCountBellSum: Int = 0
    @AppStorage("thunderNormalKoyakuCountSuika") var normalKoyakuCountSuika: Int = 0
    @AppStorage("thunderNormalKoyakuCountCherryB") var normalKoyakuCountCherryB: Int = 0
    @AppStorage("thunderPlayBig") var playBig: Int = 0
    @AppStorage("thunderPlayReg") var playReg: Int = 0
    @AppStorage("thunderTotalBig") var totalBig: Int = 0
    @AppStorage("thunderTotalReg") var totalReg: Int = 0
    @AppStorage("thunderBtRedSeven") var btRedSeven: Int = 0
    @AppStorage("thunderBbCountBellC") var bbCountBellC: Int = 0
    @AppStorage("thunderBbCountBellB") var bbCountBellB: Int = 0
    @AppStorage("thunderBbGame") var bbGame: Int = 0
    @AppStorage("thunderBbCountReach") var bbCountReach: Int = 0
    
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
        playGame = 0
        totalGame = 0
        normalKoyakuCountBellA = 0
        normalKoyakuCountBellB = 0
        normalKoyakuCountBellSum = 0
        normalKoyakuCountSuika = 0
        normalKoyakuCountCherryB = 0
        playBig = 0
        playReg = 0
        totalBig = 0
        totalReg = 0
        btRedSeven = 0
        bbCountBellC = 0
        bbCountBellB = 0
        bbGame = 0
        bbCountReach = 0
        minusCheck = false
    }
    
    func bbGameCalFunc() {
        bbGame = (playBig * 15) + (btRedSeven * 15)
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


class ThunderMemory1: ObservableObject {
    @AppStorage("thunderStartGameMemory1") var startGame: Int = 0
    @AppStorage("thunderStartBigMemory1") var startBig: Int = 0
    @AppStorage("thunderStartRegMemory1") var startReg: Int = 0
    @AppStorage("thunderPlayGameMemory1") var playGame: Int = 0
    @AppStorage("thunderTotalGameMemory1") var totalGame: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellAMemory1") var normalKoyakuCountBellA: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellBMemory1") var normalKoyakuCountBellB: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellSumMemory1") var normalKoyakuCountBellSum: Int = 0
    @AppStorage("thunderNormalKoyakuCountSuikaMemory1") var normalKoyakuCountSuika: Int = 0
    @AppStorage("thunderNormalKoyakuCountCherryBMemory1") var normalKoyakuCountCherryB: Int = 0
    @AppStorage("thunderPlayBigMemory1") var playBig: Int = 0
    @AppStorage("thunderPlayRegMemory1") var playReg: Int = 0
    @AppStorage("thunderTotalBigMemory1") var totalBig: Int = 0
    @AppStorage("thunderTotalRegMemory1") var totalReg: Int = 0
    @AppStorage("thunderBtRedSevenMemory1") var btRedSeven: Int = 0
    @AppStorage("thunderBbCountBellCMemory1") var bbCountBellC: Int = 0
    @AppStorage("thunderBbCountBellBMemory1") var bbCountBellB: Int = 0
    @AppStorage("thunderBbGameMemory1") var bbGame: Int = 0
    @AppStorage("thunderBbCountReachMemory1") var bbCountReach: Int = 0
    @AppStorage("thunderMemoMemory1") var memo = ""
    @AppStorage("thunderDateMemory1") var dateDouble = 0.0
}


class ThunderMemory2: ObservableObject {
    @AppStorage("thunderStartGameMemory2") var startGame: Int = 0
    @AppStorage("thunderStartBigMemory2") var startBig: Int = 0
    @AppStorage("thunderStartRegMemory2") var startReg: Int = 0
    @AppStorage("thunderPlayGameMemory2") var playGame: Int = 0
    @AppStorage("thunderTotalGameMemory2") var totalGame: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellAMemory2") var normalKoyakuCountBellA: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellBMemory2") var normalKoyakuCountBellB: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellSumMemory2") var normalKoyakuCountBellSum: Int = 0
    @AppStorage("thunderNormalKoyakuCountSuikaMemory2") var normalKoyakuCountSuika: Int = 0
    @AppStorage("thunderNormalKoyakuCountCherryBMemory2") var normalKoyakuCountCherryB: Int = 0
    @AppStorage("thunderPlayBigMemory2") var playBig: Int = 0
    @AppStorage("thunderPlayRegMemory2") var playReg: Int = 0
    @AppStorage("thunderTotalBigMemory2") var totalBig: Int = 0
    @AppStorage("thunderTotalRegMemory2") var totalReg: Int = 0
    @AppStorage("thunderBtRedSevenMemory2") var btRedSeven: Int = 0
    @AppStorage("thunderBbCountBellCMemory2") var bbCountBellC: Int = 0
    @AppStorage("thunderBbCountBellBMemory2") var bbCountBellB: Int = 0
    @AppStorage("thunderBbGameMemory2") var bbGame: Int = 0
    @AppStorage("thunderBbCountReachMemory2") var bbCountReach: Int = 0
    @AppStorage("thunderMemoMemory2") var memo = ""
    @AppStorage("thunderDateMemory2") var dateDouble = 0.0
}


class ThunderMemory3: ObservableObject {
    @AppStorage("thunderStartGameMemory3") var startGame: Int = 0
    @AppStorage("thunderStartBigMemory3") var startBig: Int = 0
    @AppStorage("thunderStartRegMemory3") var startReg: Int = 0
    @AppStorage("thunderPlayGameMemory3") var playGame: Int = 0
    @AppStorage("thunderTotalGameMemory3") var totalGame: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellAMemory3") var normalKoyakuCountBellA: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellBMemory3") var normalKoyakuCountBellB: Int = 0
    @AppStorage("thunderNormalKoyakuCountBellSumMemory3") var normalKoyakuCountBellSum: Int = 0
    @AppStorage("thunderNormalKoyakuCountSuikaMemory3") var normalKoyakuCountSuika: Int = 0
    @AppStorage("thunderNormalKoyakuCountCherryBMemory3") var normalKoyakuCountCherryB: Int = 0
    @AppStorage("thunderPlayBigMemory3") var playBig: Int = 0
    @AppStorage("thunderPlayRegMemory3") var playReg: Int = 0
    @AppStorage("thunderTotalBigMemory3") var totalBig: Int = 0
    @AppStorage("thunderTotalRegMemory3") var totalReg: Int = 0
    @AppStorage("thunderBtRedSevenMemory3") var btRedSeven: Int = 0
    @AppStorage("thunderBbCountBellCMemory3") var bbCountBellC: Int = 0
    @AppStorage("thunderBbCountBellBMemory3") var bbCountBellB: Int = 0
    @AppStorage("thunderBbGameMemory3") var bbGame: Int = 0
    @AppStorage("thunderBbCountReachMemory3") var bbCountReach: Int = 0
    @AppStorage("thunderMemoMemory3") var memo = ""
    @AppStorage("thunderDateMemory3") var dateDouble = 0.0
}
