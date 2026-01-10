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
    let ratioSuika: [Double] = [87.4,85.8,84.9,79.7,74.8,69.9]
    @AppStorage("bakemonoTotalGame") var totalGame: Int = 0
    @AppStorage("bakemonoKoyakuCountSuika") var koyakuCountSuika: Int = 0
    
    func resetNormal() {
        totalGame = 0
        koyakuCountSuika = 0
        minusCheck = false
        koyakuCountJakuCherry = 0
        jakuCherryAtCount = 0
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
    
    // -------------
    // ver3.15.0で追加
    // -------------
    let ratioJakuCherryAt: [Double] = [0.4,0.8,1.3,2.1,2.9,3.8]
    @AppStorage("bakemonoKoyakuCountJakuCherry") var koyakuCountJakuCherry: Int = 0
    @AppStorage("bakemonoJakuCherryAtCount") var jakuCherryAtCount: Int = 0
}

class BakemonoMemory1: ObservableObject {
    @AppStorage("bakemonoTotalGameMemory1") var totalGame: Int = 0
    @AppStorage("bakemonoKoyakuCountSuikaMemory1") var koyakuCountSuika: Int = 0
    @AppStorage("bakemonoNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("bakemonoFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("bakemonoFixScreen1Memory1") var fixScreen1: Int = 0
    @AppStorage("bakemonoFixScreen2Memory1") var fixScreen2: Int = 0
    @AppStorage("bakemonoFixScreen3Memory1") var fixScreen3: Int = 0
    @AppStorage("bakemonoFixScreenSumMemory1") var fixScreenSum: Int = 0
    @AppStorage("bakemonoScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("bakemonoScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("bakemonoScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("bakemonoScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("bakemonoScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("bakemonoScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("bakemonoScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("bakemonoScreenCount8Memory1") var screenCount8: Int = 0
    @AppStorage("bakemonoScreenCount9Memory1") var screenCount9: Int = 0
    @AppStorage("bakemonoScreenCount10Memory1") var screenCount10: Int = 0
    @AppStorage("bakemonoScreenCount11Memory1") var screenCount11: Int = 0
    @AppStorage("bakemonoScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("bakemonoMemoMemory1") var memo = ""
    @AppStorage("bakemonoDateMemory1") var dateDouble = 0.0
    
    // -------------
    // ver3.15.0で追加
    // -------------
    @AppStorage("bakemonoKoyakuCountJakuCherryMemory1") var koyakuCountJakuCherry: Int = 0
    @AppStorage("bakemonoJakuCherryAtCountMemory1") var jakuCherryAtCount: Int = 0
}

class BakemonoMemory2: ObservableObject {
    @AppStorage("bakemonoTotalGameMemory2") var totalGame: Int = 0
    @AppStorage("bakemonoKoyakuCountSuikaMemory2") var koyakuCountSuika: Int = 0
    @AppStorage("bakemonoNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("bakemonoFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("bakemonoFixScreen1Memory2") var fixScreen1: Int = 0
    @AppStorage("bakemonoFixScreen2Memory2") var fixScreen2: Int = 0
    @AppStorage("bakemonoFixScreen3Memory2") var fixScreen3: Int = 0
    @AppStorage("bakemonoFixScreenSumMemory2") var fixScreenSum: Int = 0
    @AppStorage("bakemonoScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("bakemonoScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("bakemonoScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("bakemonoScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("bakemonoScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("bakemonoScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("bakemonoScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("bakemonoScreenCount8Memory2") var screenCount8: Int = 0
    @AppStorage("bakemonoScreenCount9Memory2") var screenCount9: Int = 0
    @AppStorage("bakemonoScreenCount10Memory2") var screenCount10: Int = 0
    @AppStorage("bakemonoScreenCount11Memory2") var screenCount11: Int = 0
    @AppStorage("bakemonoScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("bakemonoMemoMemory2") var memo = ""
    @AppStorage("bakemonoDateMemory2") var dateDouble = 0.0
    
    // -------------
    // ver3.15.0で追加
    // -------------
    @AppStorage("bakemonoKoyakuCountJakuCherryMemory2") var koyakuCountJakuCherry: Int = 0
    @AppStorage("bakemonoJakuCherryAtCountMemory2") var jakuCherryAtCount: Int = 0
}

class BakemonoMemory3: ObservableObject {
    @AppStorage("bakemonoTotalGameMemory3") var totalGame: Int = 0
    @AppStorage("bakemonoKoyakuCountSuikaMemory3") var koyakuCountSuika: Int = 0
    @AppStorage("bakemonoNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("bakemonoFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("bakemonoFixScreen1Memory3") var fixScreen1: Int = 0
    @AppStorage("bakemonoFixScreen2Memory3") var fixScreen2: Int = 0
    @AppStorage("bakemonoFixScreen3Memory3") var fixScreen3: Int = 0
    @AppStorage("bakemonoFixScreenSumMemory3") var fixScreenSum: Int = 0
    @AppStorage("bakemonoScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("bakemonoScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("bakemonoScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("bakemonoScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("bakemonoScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("bakemonoScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("bakemonoScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("bakemonoScreenCount8Memory3") var screenCount8: Int = 0
    @AppStorage("bakemonoScreenCount9Memory3") var screenCount9: Int = 0
    @AppStorage("bakemonoScreenCount10Memory3") var screenCount10: Int = 0
    @AppStorage("bakemonoScreenCount11Memory3") var screenCount11: Int = 0
    @AppStorage("bakemonoScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("bakemonoMemoMemory3") var memo = ""
    @AppStorage("bakemonoDateMemory3") var dateDouble = 0.0
    
    // -------------
    // ver3.15.0で追加
    // -------------
    @AppStorage("bakemonoKoyakuCountJakuCherryMemory3") var koyakuCountJakuCherry: Int = 0
    @AppStorage("bakemonoJakuCherryAtCountMemory3") var jakuCherryAtCount: Int = 0
}
