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
