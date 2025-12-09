//
//  bakemonoClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/30.
//

import Foundation
import SwiftUI

class Bakemono: ObservableObject {
    // -----------
    // 通常時
    // -----------
    let ratioSuika: [Double] = [87.4,-1,-1,-1,-1,-1,]
    @AppStorage("bakemonoTotalGame") var totalGame: Int = 0
    @AppStorage("bakemonoKoyakuCountSuika") var koyakuCountSuika: Int = 0
    
    func resetNormal() {
        totalGame = 0
        koyakuCountSuika = 0
        minusCheck = false
    }
    
    // ------------
    // 初当り
    // ------------
    let ratioAtFirstHit: [Double] = [265.1,260.7,252.1,238.8,230.8,219.6]
    @AppStorage("bakemonoNormalGame") var normalGame: Int = 0
    @AppStorage("bakemonoFirstHitCountAt") var firstHitCountAt: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        minusCheck = false
    }
    
    // -------------
    // AT中
    // -------------
    @AppStorage("bakemonoFixScreen1") var fixScreen1: Int = 0
    @AppStorage("bakemonoFixScreen2") var fixScreen2: Int = 0
    @AppStorage("bakemonoFixScreen3") var fixScreen3: Int = 0
    @AppStorage("bakemonoFixScreenSum") var fixScreenSum: Int = 0
    
    func fixScreenSumFunc() {
        fixScreenSum = countSum(
            fixScreen1,
            fixScreen2,
            fixScreen3,
        )
    }
    
    func resetAt() {
        fixScreen1 = 0
        fixScreen2 = 0
        fixScreen3 = 0
        fixScreenSum = 0
        minusCheck = false
    }
    
    // ----------
    // 終了画面
    // ----------
    @AppStorage("bakemonoScreenCount1") var screenCount1: Int = 0
    @AppStorage("bakemonoScreenCount2") var screenCount2: Int = 0
    @AppStorage("bakemonoScreenCount3") var screenCount3: Int = 0
    @AppStorage("bakemonoScreenCount4") var screenCount4: Int = 0
    @AppStorage("bakemonoScreenCount5") var screenCount5: Int = 0
    @AppStorage("bakemonoScreenCount6") var screenCount6: Int = 0
    @AppStorage("bakemonoScreenCount7") var screenCount7: Int = 0
    @AppStorage("bakemonoScreenCount8") var screenCount8: Int = 0
    @AppStorage("bakemonoScreenCount9") var screenCount9: Int = 0
    @AppStorage("bakemonoScreenCount10") var screenCount10: Int = 0
    @AppStorage("bakemonoScreenCount11") var screenCount11: Int = 0
    @AppStorage("bakemonoScreenCountSum") var screenCountSum: Int = 0
    
    func screenCountSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
            screenCount4,
            screenCount5,
            screenCount6,
            screenCount7,
            screenCount8,
            screenCount9,
            screenCount10,
            screenCount11,
        )
    }
    
    func resetScreen() {
        screenCount1 = 0
        screenCount2 = 0
        screenCount3 = 0
        screenCount4 = 0
        screenCount5 = 0
        screenCount6 = 0
        screenCount7 = 0
        screenCount8 = 0
        screenCount9 = 0
        screenCount10 = 0
        screenCount11 = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "化物語"
    @AppStorage("bakemonoMinusCheck") var minusCheck: Bool = false
    @AppStorage("bakemonoSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetAt()
        resetScreen()
        resetFirstHit()
    }
}
