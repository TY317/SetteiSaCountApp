//
//  sao2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/30.
//

import Foundation
import SwiftUI
import Combine

class Sao2: ObservableObject {
    // ----------
    // 通常時
    // ----------
    let ratioLowSuikaShooting: [Double] = [40.2,44.5,41,48.4,42.2,55.1]
    let ratioKyoCherryCz: [Double] = [20,21,20,25,20,33]
    let ratioHighKyoCherryCz: [Double] = [50,51,52,55,58,60]
    @AppStorage("sao2LowSuikaCount") var lowSuikaCount: Int = 0
    @AppStorage("sao2LowSuikaCountShootingHit") var lowSuikaCountShootingHit: Int = 0
    @AppStorage("sao2KyoCherryCount") var kyoCherryCount: Int = 0
    @AppStorage("sao2KyoCherryCountCzHit") var kyoCherryCountCzHit: Int = 0
    @AppStorage("sao2HighKyoCherryCount") var highKyoCherryCount: Int = 0
    @AppStorage("sao2HighKyoCherryCountCzHit") var highKyoCherryCountCzHit: Int = 0
    
    func resetNormal() {
        lowSuikaCount = 0
        lowSuikaCountShootingHit = 0
        kyoCherryCount = 0
        kyoCherryCountCzHit = 0
        highKyoCherryCount = 0
        highKyoCherryCountCzHit = 0
        minusCheck = false
    }
    
    // GGOモード
    let ratioGgoMode: [Double] = [20,-1,-1,-1,-1,-1,]
    
    // ---------
    // CZ
    // ---------
    let ratioCzItemGet: [Double] = [20.3,21.1,21.9,22.7,25,30.1]
    @AppStorage("sao2CzItemCountMiss") var czItemCountMiss: Int = 0
    @AppStorage("sao2CzItemCountHit") var czItemCountHit: Int = 0
    @AppStorage("sao2CzItemCountSum") var czItemCountSum: Int = 0
    
    func czItemSumFunc() {
        czItemCountSum = czItemCountMiss + czItemCountHit
    }
    
    // 曠野の決闘 突入率
    let ratioCzKettouGet: [Double] = [0.78,-1,-1,-1,-1,1.56]
    @AppStorage("sao2CzKettouCountMiss") var czKettouCountMiss: Int = 0
    @AppStorage("sao2CzKettouCountHit") var czKettouCountHit: Int = 0
    @AppStorage("sao2CzKettouCountSum") var czKettouCountSum: Int = 0
    
    func czKettouSumFunc() {
        czKettouCountSum = czKettouCountMiss + czKettouCountHit
    }
    
    func resetCz() {
        czItemCountMiss = 0
        czItemCountHit = 0
        czItemCountSum = 0
        czKettouCountMiss = 0
        czKettouCountHit = 0
        czKettouCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // 初当り
    // -----------
    let ratioFirstHitCz: [Double] = [238.4,232.3,232.7,218.9,225.2,191.7]
    let ratioFirstHitAt: [Double] = [386.2,364.3,368.1,326.8,340.6,269.6]
    @AppStorage("sao2NormalGame") var normalGame: Int = 0
    @AppStorage("sao2FirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("sao2FirstHitCountAt") var firstHitCountAt: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountAt = 0
        minusCheck = false
    }
    
    // ---------
    // 終了画面
    // ---------
    @AppStorage("sao2ScreenCount1") var screenCount1: Int = 0
    @AppStorage("sao2ScreenCount2") var screenCount2: Int = 0
    @AppStorage("sao2ScreenCount3") var screenCount3: Int = 0
    @AppStorage("sao2ScreenCount4") var screenCount4: Int = 0
    @AppStorage("sao2ScreenCount5") var screenCount5: Int = 0
    @AppStorage("sao2ScreenCount6") var screenCount6: Int = 0
    @AppStorage("sao2ScreenCount7") var screenCount7: Int = 0
    @AppStorage("sao2ScreenCount8") var screenCount8: Int = 0
    @AppStorage("sao2ScreenCount9") var screenCount9: Int = 0
    @AppStorage("sao2ScreenCount10") var screenCount10: Int = 0
    @AppStorage("sao2ScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
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
        screenCountSum = 0
        minusCheck = false
    }
    
    // ----------
    // 引き戻し
    // ----------
    let ratioComeBack: [Double] = [-1,-1,-1,-1,-1,-1,]
    @AppStorage("sao2ComeBackCountMiss") var comeBackCountMiss: Int = 0
    @AppStorage("sao2ComeBackCountHit") var comeBackCountHit: Int = 0
    @AppStorage("sao2ComeBackCountSum") var comeBackCountSum: Int = 0
    
    func comeBackSumFunc() {
        comeBackCountSum = comeBackCountMiss + comeBackCountHit
    }
    
    func resetComeBack() {
        comeBackCountMiss = 0
        comeBackCountHit = 0
        comeBackCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ソードアート・オンラインⅡ"
    @AppStorage("sao2MinusCheck") var minusCheck: Bool = false
    @AppStorage("sao2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetCz()
        resetFirstHit()
        resetScreen()
        resetComeBack()
        resetMiniChara()
        resetMotherMiniChara()
    }

    // -------
    // ミニキャラ選択
    // -------
    let ratioMiniCharaOver4: [Double] = [0,0,0,1,1,1]
    let ratioMiniCharaOver6: [Double] = [0,0,0,0,0,1]
    @AppStorage("sao2MiniCharaCount1") var miniCharaCount1: Int = 0
    @AppStorage("sao2MiniCharaCount2") var miniCharaCount2: Int = 0
    @AppStorage("sao2MiniCharaCount3") var miniCharaCount3: Int = 0
    @AppStorage("sao2MiniCharaCount4") var miniCharaCount4: Int = 0
    @AppStorage("sao2MiniCharaCount5") var miniCharaCount5: Int = 0
    @AppStorage("sao2MiniCharaCount6") var miniCharaCount6: Int = 0
    @AppStorage("sao2MiniCharaCount7") var miniCharaCount7: Int = 0
    @AppStorage("sao2MiniCharaCount8") var miniCharaCount8: Int = 0
    @AppStorage("sao2MiniCharaCountSum") var miniCharaCountSum: Int = 0

    func miniCharaSumFunc() {
        miniCharaCountSum = countSum(
            miniCharaCount1,
            miniCharaCount2,
            miniCharaCount3,
            miniCharaCount4,
            miniCharaCount5,
            miniCharaCount6,
            miniCharaCount7,
            miniCharaCount8,
        )
    }

    func resetMiniChara() {
        miniCharaCount1 = 0
        miniCharaCount2 = 0
        miniCharaCount3 = 0
        miniCharaCount4 = 0
        miniCharaCount5 = 0
        miniCharaCount6 = 0
        miniCharaCount7 = 0
        miniCharaCount8 = 0
        miniCharaCountSum = 0
        minusCheck = false
    }

    // -------
    // キャラ選択
    // -------
    let ratioMotherMiniCharaOver4: [Double] = [0,0,0,1,1,1]
    let ratioMotherMiniCharaOver6: [Double] = [0,0,0,0,0,1]
    @AppStorage("sao2MotherMiniCharaCount1") var motherMiniCharaCount1: Int = 0
    @AppStorage("sao2MotherMiniCharaCount2") var motherMiniCharaCount2: Int = 0
    @AppStorage("sao2MotherMiniCharaCount3") var motherMiniCharaCount3: Int = 0
    @AppStorage("sao2MotherMiniCharaCount4") var motherMiniCharaCount4: Int = 0
    @AppStorage("sao2MotherMiniCharaCount5") var motherMiniCharaCount5: Int = 0
    @AppStorage("sao2MotherMiniCharaCount6") var motherMiniCharaCount6: Int = 0
    @AppStorage("sao2MotherMiniCharaCount7") var motherMiniCharaCount7: Int = 0
    @AppStorage("sao2MotherMiniCharaCount8") var motherMiniCharaCount8: Int = 0
    @AppStorage("sao2MotherMiniCharaCountSum") var motherMiniCharaCountSum: Int = 0

    func motherMiniCharaSumFunc() {
        motherMiniCharaCountSum = countSum(
            motherMiniCharaCount1,
            motherMiniCharaCount2,
            motherMiniCharaCount3,
            motherMiniCharaCount4,
            motherMiniCharaCount5,
            motherMiniCharaCount6,
            motherMiniCharaCount7,
            motherMiniCharaCount8,
        )
    }

    func resetMotherMiniChara() {
        motherMiniCharaCount1 = 0
        motherMiniCharaCount2 = 0
        motherMiniCharaCount3 = 0
        motherMiniCharaCount4 = 0
        motherMiniCharaCount5 = 0
        motherMiniCharaCount6 = 0
        motherMiniCharaCount7 = 0
        motherMiniCharaCount8 = 0
        motherMiniCharaCountSum = 0
        minusCheck = false
    }
}


class Sao2Memory1: ObservableObject {
    @AppStorage("sao2LowSuikaCountMemory1") var lowSuikaCount: Int = 0
    @AppStorage("sao2LowSuikaCountShootingHitMemory1") var lowSuikaCountShootingHit: Int = 0
    @AppStorage("sao2KyoCherryCountMemory1") var kyoCherryCount: Int = 0
    @AppStorage("sao2KyoCherryCountCzHitMemory1") var kyoCherryCountCzHit: Int = 0
    @AppStorage("sao2HighKyoCherryCountMemory1") var highKyoCherryCount: Int = 0
    @AppStorage("sao2HighKyoCherryCountCzHitMemory1") var highKyoCherryCountCzHit: Int = 0
    @AppStorage("sao2CzItemCountMissMemory1") var czItemCountMiss: Int = 0
    @AppStorage("sao2CzItemCountHitMemory1") var czItemCountHit: Int = 0
    @AppStorage("sao2CzItemCountSumMemory1") var czItemCountSum: Int = 0
    @AppStorage("sao2CzKettouCountMissMemory1") var czKettouCountMiss: Int = 0
    @AppStorage("sao2CzKettouCountHitMemory1") var czKettouCountHit: Int = 0
    @AppStorage("sao2CzKettouCountSumMemory1") var czKettouCountSum: Int = 0
    @AppStorage("sao2NormalGameMemory1") var normalGame: Int = 0
    @AppStorage("sao2FirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("sao2FirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("sao2ScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("sao2ScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("sao2ScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("sao2ScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("sao2ScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("sao2ScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("sao2ScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("sao2ScreenCount8Memory1") var screenCount8: Int = 0
    @AppStorage("sao2ScreenCount9Memory1") var screenCount9: Int = 0
    @AppStorage("sao2ScreenCount10Memory1") var screenCount10: Int = 0
    @AppStorage("sao2ScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("sao2ComeBackCountMissMemory1") var comeBackCountMiss: Int = 0
    @AppStorage("sao2ComeBackCountHitMemory1") var comeBackCountHit: Int = 0
    @AppStorage("sao2ComeBackCountSumMemory1") var comeBackCountSum: Int = 0
    @AppStorage("sao2MiniCharaCount1Memory1") var miniCharaCount1: Int = 0
    @AppStorage("sao2MiniCharaCount2Memory1") var miniCharaCount2: Int = 0
    @AppStorage("sao2MiniCharaCount3Memory1") var miniCharaCount3: Int = 0
    @AppStorage("sao2MiniCharaCount4Memory1") var miniCharaCount4: Int = 0
    @AppStorage("sao2MiniCharaCount5Memory1") var miniCharaCount5: Int = 0
    @AppStorage("sao2MiniCharaCount6Memory1") var miniCharaCount6: Int = 0
    @AppStorage("sao2MiniCharaCount7Memory1") var miniCharaCount7: Int = 0
    @AppStorage("sao2MiniCharaCount8Memory1") var miniCharaCount8: Int = 0
    @AppStorage("sao2MiniCharaCountSumMemory1") var miniCharaCountSum: Int = 0
    @AppStorage("sao2MotherMiniCharaCount1Memory1") var motherMiniCharaCount1: Int = 0
    @AppStorage("sao2MotherMiniCharaCount2Memory1") var motherMiniCharaCount2: Int = 0
    @AppStorage("sao2MotherMiniCharaCount3Memory1") var motherMiniCharaCount3: Int = 0
    @AppStorage("sao2MotherMiniCharaCount4Memory1") var motherMiniCharaCount4: Int = 0
    @AppStorage("sao2MotherMiniCharaCount5Memory1") var motherMiniCharaCount5: Int = 0
    @AppStorage("sao2MotherMiniCharaCount6Memory1") var motherMiniCharaCount6: Int = 0
    @AppStorage("sao2MotherMiniCharaCount7Memory1") var motherMiniCharaCount7: Int = 0
    @AppStorage("sao2MotherMiniCharaCount8Memory1") var motherMiniCharaCount8: Int = 0
    @AppStorage("sao2MotherMiniCharaCountSumMemory1") var motherMiniCharaCountSum: Int = 0
    @AppStorage("sao2MemoMemory1") var memo = ""
    @AppStorage("sao2DateMemory1") var dateDouble = 0.0
}


class Sao2Memory2: ObservableObject {
    @AppStorage("sao2LowSuikaCountMemory2") var lowSuikaCount: Int = 0
    @AppStorage("sao2LowSuikaCountShootingHitMemory2") var lowSuikaCountShootingHit: Int = 0
    @AppStorage("sao2KyoCherryCountMemory2") var kyoCherryCount: Int = 0
    @AppStorage("sao2KyoCherryCountCzHitMemory2") var kyoCherryCountCzHit: Int = 0
    @AppStorage("sao2HighKyoCherryCountMemory2") var highKyoCherryCount: Int = 0
    @AppStorage("sao2HighKyoCherryCountCzHitMemory2") var highKyoCherryCountCzHit: Int = 0
    @AppStorage("sao2CzItemCountMissMemory2") var czItemCountMiss: Int = 0
    @AppStorage("sao2CzItemCountHitMemory2") var czItemCountHit: Int = 0
    @AppStorage("sao2CzItemCountSumMemory2") var czItemCountSum: Int = 0
    @AppStorage("sao2CzKettouCountMissMemory2") var czKettouCountMiss: Int = 0
    @AppStorage("sao2CzKettouCountHitMemory2") var czKettouCountHit: Int = 0
    @AppStorage("sao2CzKettouCountSumMemory2") var czKettouCountSum: Int = 0
    @AppStorage("sao2NormalGameMemory2") var normalGame: Int = 0
    @AppStorage("sao2FirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("sao2FirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("sao2ScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("sao2ScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("sao2ScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("sao2ScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("sao2ScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("sao2ScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("sao2ScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("sao2ScreenCount8Memory2") var screenCount8: Int = 0
    @AppStorage("sao2ScreenCount9Memory2") var screenCount9: Int = 0
    @AppStorage("sao2ScreenCount10Memory2") var screenCount10: Int = 0
    @AppStorage("sao2ScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("sao2ComeBackCountMissMemory2") var comeBackCountMiss: Int = 0
    @AppStorage("sao2ComeBackCountHitMemory2") var comeBackCountHit: Int = 0
    @AppStorage("sao2ComeBackCountSumMemory2") var comeBackCountSum: Int = 0
    @AppStorage("sao2MiniCharaCount1Memory2") var miniCharaCount1: Int = 0
    @AppStorage("sao2MiniCharaCount2Memory2") var miniCharaCount2: Int = 0
    @AppStorage("sao2MiniCharaCount3Memory2") var miniCharaCount3: Int = 0
    @AppStorage("sao2MiniCharaCount4Memory2") var miniCharaCount4: Int = 0
    @AppStorage("sao2MiniCharaCount5Memory2") var miniCharaCount5: Int = 0
    @AppStorage("sao2MiniCharaCount6Memory2") var miniCharaCount6: Int = 0
    @AppStorage("sao2MiniCharaCount7Memory2") var miniCharaCount7: Int = 0
    @AppStorage("sao2MiniCharaCount8Memory2") var miniCharaCount8: Int = 0
    @AppStorage("sao2MiniCharaCountSumMemory2") var miniCharaCountSum: Int = 0
    @AppStorage("sao2MotherMiniCharaCount1Memory2") var motherMiniCharaCount1: Int = 0
    @AppStorage("sao2MotherMiniCharaCount2Memory2") var motherMiniCharaCount2: Int = 0
    @AppStorage("sao2MotherMiniCharaCount3Memory2") var motherMiniCharaCount3: Int = 0
    @AppStorage("sao2MotherMiniCharaCount4Memory2") var motherMiniCharaCount4: Int = 0
    @AppStorage("sao2MotherMiniCharaCount5Memory2") var motherMiniCharaCount5: Int = 0
    @AppStorage("sao2MotherMiniCharaCount6Memory2") var motherMiniCharaCount6: Int = 0
    @AppStorage("sao2MotherMiniCharaCount7Memory2") var motherMiniCharaCount7: Int = 0
    @AppStorage("sao2MotherMiniCharaCount8Memory2") var motherMiniCharaCount8: Int = 0
    @AppStorage("sao2MotherMiniCharaCountSumMemory2") var motherMiniCharaCountSum: Int = 0
    @AppStorage("sao2MemoMemory2") var memo = ""
    @AppStorage("sao2DateMemory2") var dateDouble = 0.0
}


class Sao2Memory3: ObservableObject {
    @AppStorage("sao2LowSuikaCountMemory3") var lowSuikaCount: Int = 0
    @AppStorage("sao2LowSuikaCountShootingHitMemory3") var lowSuikaCountShootingHit: Int = 0
    @AppStorage("sao2KyoCherryCountMemory3") var kyoCherryCount: Int = 0
    @AppStorage("sao2KyoCherryCountCzHitMemory3") var kyoCherryCountCzHit: Int = 0
    @AppStorage("sao2HighKyoCherryCountMemory3") var highKyoCherryCount: Int = 0
    @AppStorage("sao2HighKyoCherryCountCzHitMemory3") var highKyoCherryCountCzHit: Int = 0
    @AppStorage("sao2CzItemCountMissMemory3") var czItemCountMiss: Int = 0
    @AppStorage("sao2CzItemCountHitMemory3") var czItemCountHit: Int = 0
    @AppStorage("sao2CzItemCountSumMemory3") var czItemCountSum: Int = 0
    @AppStorage("sao2CzKettouCountMissMemory3") var czKettouCountMiss: Int = 0
    @AppStorage("sao2CzKettouCountHitMemory3") var czKettouCountHit: Int = 0
    @AppStorage("sao2CzKettouCountSumMemory3") var czKettouCountSum: Int = 0
    @AppStorage("sao2NormalGameMemory3") var normalGame: Int = 0
    @AppStorage("sao2FirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("sao2FirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("sao2ScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("sao2ScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("sao2ScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("sao2ScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("sao2ScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("sao2ScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("sao2ScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("sao2ScreenCount8Memory3") var screenCount8: Int = 0
    @AppStorage("sao2ScreenCount9Memory3") var screenCount9: Int = 0
    @AppStorage("sao2ScreenCount10Memory3") var screenCount10: Int = 0
    @AppStorage("sao2ScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("sao2ComeBackCountMissMemory3") var comeBackCountMiss: Int = 0
    @AppStorage("sao2ComeBackCountHitMemory3") var comeBackCountHit: Int = 0
    @AppStorage("sao2ComeBackCountSumMemory3") var comeBackCountSum: Int = 0
    @AppStorage("sao2MiniCharaCount1Memory3") var miniCharaCount1: Int = 0
    @AppStorage("sao2MiniCharaCount2Memory3") var miniCharaCount2: Int = 0
    @AppStorage("sao2MiniCharaCount3Memory3") var miniCharaCount3: Int = 0
    @AppStorage("sao2MiniCharaCount4Memory3") var miniCharaCount4: Int = 0
    @AppStorage("sao2MiniCharaCount5Memory3") var miniCharaCount5: Int = 0
    @AppStorage("sao2MiniCharaCount6Memory3") var miniCharaCount6: Int = 0
    @AppStorage("sao2MiniCharaCount7Memory3") var miniCharaCount7: Int = 0
    @AppStorage("sao2MiniCharaCount8Memory3") var miniCharaCount8: Int = 0
    @AppStorage("sao2MiniCharaCountSumMemory3") var miniCharaCountSum: Int = 0
    @AppStorage("sao2MotherMiniCharaCount1Memory3") var motherMiniCharaCount1: Int = 0
    @AppStorage("sao2MotherMiniCharaCount2Memory3") var motherMiniCharaCount2: Int = 0
    @AppStorage("sao2MotherMiniCharaCount3Memory3") var motherMiniCharaCount3: Int = 0
    @AppStorage("sao2MotherMiniCharaCount4Memory3") var motherMiniCharaCount4: Int = 0
    @AppStorage("sao2MotherMiniCharaCount5Memory3") var motherMiniCharaCount5: Int = 0
    @AppStorage("sao2MotherMiniCharaCount6Memory3") var motherMiniCharaCount6: Int = 0
    @AppStorage("sao2MotherMiniCharaCount7Memory3") var motherMiniCharaCount7: Int = 0
    @AppStorage("sao2MotherMiniCharaCount8Memory3") var motherMiniCharaCount8: Int = 0
    @AppStorage("sao2MotherMiniCharaCountSumMemory3") var motherMiniCharaCountSum: Int = 0
    @AppStorage("sao2MemoMemory3") var memo = ""
    @AppStorage("sao2DateMemory3") var dateDouble = 0.0
}
