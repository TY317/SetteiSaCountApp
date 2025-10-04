//
//  ToreveClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/02.
//

import Foundation
import SwiftUI

class Toreve: ObservableObject {
    // /////////////
    // 周期
    // /////////////
    // 選択肢の設定
    let cycleList: [Int] = [1,2,3,4,5,6]
    let ptList: [Int] = [100,200,300,400,500]
    let tirggerList: [String] = ["周期到達", "その他", "?"]
    let resultList: [String] = ["ハズレ", "当選"]
    
    // 選択結果
    @AppStorage("toreveSelectedCycle") var selectedCycle: Int = 1
    @AppStorage("toreveSelectedPt") var selectedPt: Int = 100
    @AppStorage("toreveSelectedTrigger") var selectedTrigger: String = "周期到達"
    @AppStorage("toreveSelectedResult") var selectedResult: String = "ハズレ"
    
    // 周期配列
    let cycleArrayKey: String = "toreveCycleArrayKey"
    @AppStorage("toreveCycleArrayKey") var cycleArrayData: Data?
    // ポイント配列
    let ptArrayKey: String = "torevePtArrayKey"
    @AppStorage("torevePtArrayKey") var ptArrayData: Data?
    // 当選契機配列
    let triggerArrayKey: String = "toreveTriggerArrayKey"
    @AppStorage("toreveTriggerArrayKey") var triggerArrayData: Data?
    // 結果配列
    let resultArrayKey: String = "toreveResultArrayKey"
    @AppStorage("toreveResultArrayKey") var resultArrayData: Data?
    
    // データ登録
    func addHistory() {
        arrayIntAddData(arrayData: self.cycleArrayData, addData: self.selectedCycle, key: self.cycleArrayKey)
        arrayIntAddData(arrayData: self.ptArrayData, addData: self.selectedPt, key: self.ptArrayKey)
        arrayStringAddData(arrayData: self.triggerArrayData, addData: self.selectedTrigger, key: self.triggerArrayKey)
        arrayStringAddData(arrayData: self.resultArrayData, addData: self.selectedResult, key: self.resultArrayKey)
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: self.cycleArrayData, key: self.cycleArrayKey)
        arrayIntRemoveLast(arrayData: self.ptArrayData, key: self.ptArrayKey)
        arrayStringRemoveLast(arrayData: self.triggerArrayData, key: self.triggerArrayKey)
        arrayStringRemoveLast(arrayData: self.resultArrayData, key: self.resultArrayKey)
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: self.cycleArrayData, key: self.cycleArrayKey)
        arrayIntRemoveAll(arrayData: self.ptArrayData, key: self.ptArrayKey)
        arrayStringRemoveAll(arrayData: self.triggerArrayData, key: self.triggerArrayKey)
        arrayStringRemoveAll(arrayData: self.resultArrayData, key: self.resultArrayKey)
        minusCheck = false
    }
    
    // 共通
//    func addRemoveCommon() {
//        
//    }
    
    // //////////////
    // 初当り
    // //////////////
    let ratioCzMidNight: [Double] = [1278.4,1258.6,1164.5,1017.7,1017.7,982.4]
    let ratioCzKisaki: [Double] = [14520.4,12128.4,9935.2,6586.5,6451.1,5841.0]
    let ratioCzSum: [Double] = [1174.9,1140.2,1042.3,881.5,879.0,840.9]
    let ratioTomanChallenge: [Double] = [681.5,679.7,673.3,669.4,677.9,672.5]
    let ratioTomanRush: [Double] = [482.2,474.7,456.9,414.0,393.8,373.1]
    let ratioFirstHit: [Double] = [282.4,279.5,272.2,255.8,249.1,240.1]
    @AppStorage("toreveNormalGame") var normalGame: Int = 0
    @AppStorage("toreveCzCountMidNight") var czCountMidNight: Int = 0
    @AppStorage("toreveCzCountKisaki") var czCountKisaki: Int = 0
    @AppStorage("toreveCzCountSum") var czCountSum: Int = 0
    @AppStorage("toreveTomanRushCount") var tomanRushCount: Int = 0
    @AppStorage("toreveTomanChallengeCount") var tomanChallengeCount: Int = 0
    @AppStorage("toreveFirstHitCount") var firstHitCount: Int = 0
    
    func firstHitSumFunc() {
        czCountSum = czCountMidNight + czCountKisaki
        firstHitCount = tomanRushCount + tomanChallengeCount
    }
    
    func resetFirstHit() {
        normalGame = 0
        czCountMidNight = 0
        czCountKisaki = 0
        czCountSum = 0
        tomanRushCount = 0
        tomanChallengeCount = 0
        firstHitCount = 0
        minusCheck = false
    }
    
    // ///////////////
    // 終了画面
    // ///////////////
    @AppStorage("toreveScreenCount1") var screenCount1: Int = 0
    @AppStorage("toreveScreenCount2") var screenCount2: Int = 0
    @AppStorage("toreveScreenCount3") var screenCount3: Int = 0
    @AppStorage("toreveScreenCount4") var screenCount4: Int = 0
    @AppStorage("toreveScreenCount5") var screenCount5: Int = 0
    @AppStorage("toreveScreenCount6") var screenCount6: Int = 0
    @AppStorage("toreveScreenCount7") var screenCount7: Int = 0
    @AppStorage("toreveScreenCount8") var screenCount8: Int = 0
    @AppStorage("toreveScreenCount9") var screenCount9: Int = 0
    @AppStorage("toreveScreenCount10") var screenCount10: Int = 0
    @AppStorage("toreveScreenCountSum") var screenCountSum: Int = 0
    
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
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "東京リベンジャーズ"
    @AppStorage("toreveMinusCheck") var minusCheck: Bool = false
    @AppStorage("toreveSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetHistory()
        resetFirstHit()
        resetScreen()
        resetNormal()
        resetTomanChance()
        resetEnding()
    }
    
    // /////////////
    // ver3.9.1で追加
    // /////////////
    // 共通ベル
    let ratioBell: [Double] = [99.3, -1,-1,-1,-1,-1]
    @AppStorage("toreveGameNumberStart") var gameNumberStart: Int = 0
    @AppStorage("toreveGameNumberCurrent") var gameNumberCurrent: Int = 0
    @AppStorage("toreveGameNumberPlay") var gameNumberPlay: Int = 0
    @AppStorage("toreveBellCount") var bellCount: Int = 0
    
    func resetNormal() {
        gameNumberStart = 0
        gameNumberCurrent = 0
        gameNumberPlay = 0
        bellCount = 0
        minusCheck = false
        chanceCzCountChance = 0
        chanceCzCountCzHit = 0
    }
    // レア役からのCZ当選率
    let ratioNormalChanceMidNight: [Double] = [4.7,5.1,7.0,10.9,11.3,12.5]
    let ratioNormalKyoCherryMidNight: [Double] = [20.3,20.3,20.3,20.3,20.3,20.3,]
    let ratioHighChanceMidNight: [Double] = [31.3,31.3,31.3,31.3,31.3,31.3,]
    let ratioHighKyoCherryMidNight: [Double] = [50.0,50.0,50.0,50.0,50.0,50.0,]
    let ratioNormalManjiKisaki: [Double] = [0.8,1.2,1.6,2.3,2.3,2.7]
    let ratioHighManjiKisaki: [Double] = [9.8,10.2,11.7,18.0,18.8,20.3]
    
    // モードごとの当選先振分け
    let ratioModeAChance: [Double] = [54.7,-1,-1,-1,-1,-1]
    let ratioModeARush: [Double] = [45.3,-1,-1,-1,-1,-1]
    let ratioModeBChance: [Double] = [59.8,-1,-1,-1,-1,-1]
    let ratioModeBRush: [Double] = [40.2,-1,-1,-1,-1,-1]
    let ratioChanceChance: [Double] = [39.8,-1,-1,-1,-1,-1]
    let ratioChanceRush: [Double] = [60.2,-1,-1,-1,-1,-1]
    let ratioHeavenChance: [Double] = [39.8,-1,-1,-1,-1,-1]
    let ratioHeavenRush: [Double] = [60.2,-1,-1,-1,-1,-1]
    
    // 東卍チャンス中の昇格
    let ratioAtRiseManji: [Double] = [10.2,-1,-1,-1,-1,-1]
    let ratioAtRiseChance: [Double] = [31.3,-1,-1,-1,-1,-1]
    let ratioAtRiseKyoCherry: [Double] = [66.4,-1,-1,-1,-1,-1]
    @AppStorage("toreveAtRiseCountManji") var atRiseCountManji: Int = 0
    @AppStorage("toreveAtRiseCountManjiRise") var atRiseCountManjiRise: Int = 0
    @AppStorage("toreveAtRiseCountChance") var atRiseCountChance: Int = 0
    @AppStorage("toreveAtRiseCountChanceRise") var atRiseCountChanceRise: Int = 0
    @AppStorage("toreveAtRiseCountKyoCherry") var atRiseCountKyoCherry: Int = 0
    @AppStorage("toreveAtRiseCountKyoCherryRise") var atRiseCountKyoCherryRise: Int = 0
    
    func resetTomanChance() {
        atRiseCountManji = 0
        atRiseCountManjiRise = 0
        atRiseCountChance = 0
        atRiseCountChanceRise = 0
        atRiseCountKyoCherry = 0
        atRiseCountKyoCherryRise = 0
        minusCheck = false
    }
    
    // エンディング
    @AppStorage("toreveEndingCountBlue") var endingCountBlue: Int = 0
    @AppStorage("toreveEndingCountYellow") var endingCountYellow: Int = 0
    @AppStorage("toreveEndingCountGreen") var endingCountGreen: Int = 0
    @AppStorage("toreveEndingCountRed") var endingCountRed: Int = 0
    @AppStorage("toreveEndingCountRainbow") var endingCountRainbow: Int = 0
    @AppStorage("toreveEndingCountSum") var endingCountSum: Int = 0
    
    func endingCountSumFunc() {
        endingCountSum = countSum(
            endingCountBlue,
            endingCountYellow,
            endingCountGreen,
            endingCountRed,
            endingCountRainbow,
        )
    }
    
    func resetEnding() {
        endingCountBlue = 0
        endingCountYellow = 0
        endingCountGreen = 0
        endingCountRed = 0
        endingCountRainbow = 0
        endingCountSum = 0
        minusCheck = false
    }
    
    // ///////////////
    // ver3.10.0で追加
    // ///////////////
    @AppStorage("toreveChanceCzCountChance") var chanceCzCountChance: Int = 0
    @AppStorage("toreveChanceCzCountCzHit") var chanceCzCountCzHit: Int = 0
}

// //// メモリー1
class ToreveMemory1: ObservableObject {
    @AppStorage("toreveCycleArrayKeyMemory1") var cycleArrayData: Data?
    @AppStorage("torevePtArrayKeyMemory1") var ptArrayData: Data?
    @AppStorage("toreveTriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("toreveResultArrayKeyMemory1") var resultArrayData: Data?
    @AppStorage("toreveNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("toreveCzCountMidNightMemory1") var czCountMidNight: Int = 0
    @AppStorage("toreveCzCountKisakiMemory1") var czCountKisaki: Int = 0
    @AppStorage("toreveCzCountSumMemory1") var czCountSum: Int = 0
    @AppStorage("toreveTomanRushCountMemory1") var tomanRushCount: Int = 0
    @AppStorage("toreveTomanChallengeCountMemory1") var tomanChallengeCount: Int = 0
    @AppStorage("toreveFirstHitCountMemory1") var firstHitCount: Int = 0
    @AppStorage("toreveScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("toreveScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("toreveScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("toreveScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("toreveScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("toreveScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("toreveScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("toreveScreenCount8Memory1") var screenCount8: Int = 0
    @AppStorage("toreveScreenCount9Memory1") var screenCount9: Int = 0
    @AppStorage("toreveScreenCount10Memory1") var screenCount10: Int = 0
    @AppStorage("toreveScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("toreveMemoMemory1") var memo = ""
    @AppStorage("toreveDateMemory1") var dateDouble = 0.0
    
    // /////////////
    // ver3.9.1で追加
    // /////////////
    @AppStorage("toreveGameNumberStartMemory1") var gameNumberStart: Int = 0
    @AppStorage("toreveGameNumberCurrentMemory1") var gameNumberCurrent: Int = 0
    @AppStorage("toreveGameNumberPlayMemory1") var gameNumberPlay: Int = 0
    @AppStorage("toreveBellCountMemory1") var bellCount: Int = 0
    @AppStorage("toreveAtRiseCountManjiMemory1") var atRiseCountManji: Int = 0
    @AppStorage("toreveAtRiseCountManjiRiseMemory1") var atRiseCountManjiRise: Int = 0
    @AppStorage("toreveAtRiseCountChanceMemory1") var atRiseCountChance: Int = 0
    @AppStorage("toreveAtRiseCountChanceRiseMemory1") var atRiseCountChanceRise: Int = 0
    @AppStorage("toreveAtRiseCountKyoCherryMemory1") var atRiseCountKyoCherry: Int = 0
    @AppStorage("toreveAtRiseCountKyoCherryRiseMemory1") var atRiseCountKyoCherryRise: Int = 0
    @AppStorage("toreveEndingCountBlueMemory1") var endingCountBlue: Int = 0
    @AppStorage("toreveEndingCountYellowMemory1") var endingCountYellow: Int = 0
    @AppStorage("toreveEndingCountGreenMemory1") var endingCountGreen: Int = 0
    @AppStorage("toreveEndingCountRedMemory1") var endingCountRed: Int = 0
    @AppStorage("toreveEndingCountRainbowMemory1") var endingCountRainbow: Int = 0
    @AppStorage("toreveEndingCountSumMemory1") var endingCountSum: Int = 0
    
    // ///////////////
    // ver3.10.0で追加
    // ///////////////
    @AppStorage("toreveChanceCzCountChanceMemory1") var chanceCzCountChance: Int = 0
    @AppStorage("toreveChanceCzCountCzHitMemory1") var chanceCzCountCzHit: Int = 0
}

// //// メモリー2
class ToreveMemory2: ObservableObject {
    @AppStorage("toreveCycleArrayKeyMemory2") var cycleArrayData: Data?
    @AppStorage("torevePtArrayKeyMemory2") var ptArrayData: Data?
    @AppStorage("toreveTriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("toreveResultArrayKeyMemory2") var resultArrayData: Data?
    @AppStorage("toreveNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("toreveCzCountMidNightMemory2") var czCountMidNight: Int = 0
    @AppStorage("toreveCzCountKisakiMemory2") var czCountKisaki: Int = 0
    @AppStorage("toreveCzCountSumMemory2") var czCountSum: Int = 0
    @AppStorage("toreveTomanRushCountMemory2") var tomanRushCount: Int = 0
    @AppStorage("toreveTomanChallengeCountMemory2") var tomanChallengeCount: Int = 0
    @AppStorage("toreveFirstHitCountMemory2") var firstHitCount: Int = 0
    @AppStorage("toreveScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("toreveScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("toreveScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("toreveScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("toreveScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("toreveScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("toreveScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("toreveScreenCount8Memory2") var screenCount8: Int = 0
    @AppStorage("toreveScreenCount9Memory2") var screenCount9: Int = 0
    @AppStorage("toreveScreenCount10Memory2") var screenCount10: Int = 0
    @AppStorage("toreveScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("toreveMemoMemory2") var memo = ""
    @AppStorage("toreveDateMemory2") var dateDouble = 0.0
    
    // /////////////
    // ver3.9.1で追加
    // /////////////
    @AppStorage("toreveGameNumberStartMemory2") var gameNumberStart: Int = 0
    @AppStorage("toreveGameNumberCurrentMemory2") var gameNumberCurrent: Int = 0
    @AppStorage("toreveGameNumberPlayMemory2") var gameNumberPlay: Int = 0
    @AppStorage("toreveBellCountMemory2") var bellCount: Int = 0
    @AppStorage("toreveAtRiseCountManjiMemory2") var atRiseCountManji: Int = 0
    @AppStorage("toreveAtRiseCountManjiRiseMemory2") var atRiseCountManjiRise: Int = 0
    @AppStorage("toreveAtRiseCountChanceMemory2") var atRiseCountChance: Int = 0
    @AppStorage("toreveAtRiseCountChanceRiseMemory2") var atRiseCountChanceRise: Int = 0
    @AppStorage("toreveAtRiseCountKyoCherryMemory2") var atRiseCountKyoCherry: Int = 0
    @AppStorage("toreveAtRiseCountKyoCherryRiseMemory2") var atRiseCountKyoCherryRise: Int = 0
    @AppStorage("toreveEndingCountBlueMemory2") var endingCountBlue: Int = 0
    @AppStorage("toreveEndingCountYellowMemory2") var endingCountYellow: Int = 0
    @AppStorage("toreveEndingCountGreenMemory2") var endingCountGreen: Int = 0
    @AppStorage("toreveEndingCountRedMemory2") var endingCountRed: Int = 0
    @AppStorage("toreveEndingCountRainbowMemory2") var endingCountRainbow: Int = 0
    @AppStorage("toreveEndingCountSumMemory2") var endingCountSum: Int = 0
    
    // ///////////////
    // ver3.10.0で追加
    // ///////////////
    @AppStorage("toreveChanceCzCountChanceMemory2") var chanceCzCountChance: Int = 0
    @AppStorage("toreveChanceCzCountCzHitMemory2") var chanceCzCountCzHit: Int = 0
}

// //// メモリー3
class ToreveMemory3: ObservableObject {
    @AppStorage("toreveCycleArrayKeyMemory3") var cycleArrayData: Data?
    @AppStorage("torevePtArrayKeyMemory3") var ptArrayData: Data?
    @AppStorage("toreveTriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("toreveResultArrayKeyMemory3") var resultArrayData: Data?
    @AppStorage("toreveNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("toreveCzCountMidNightMemory3") var czCountMidNight: Int = 0
    @AppStorage("toreveCzCountKisakiMemory3") var czCountKisaki: Int = 0
    @AppStorage("toreveCzCountSumMemory3") var czCountSum: Int = 0
    @AppStorage("toreveTomanRushCountMemory3") var tomanRushCount: Int = 0
    @AppStorage("toreveTomanChallengeCountMemory3") var tomanChallengeCount: Int = 0
    @AppStorage("toreveFirstHitCountMemory3") var firstHitCount: Int = 0
    @AppStorage("toreveScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("toreveScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("toreveScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("toreveScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("toreveScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("toreveScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("toreveScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("toreveScreenCount8Memory3") var screenCount8: Int = 0
    @AppStorage("toreveScreenCount9Memory3") var screenCount9: Int = 0
    @AppStorage("toreveScreenCount10Memory3") var screenCount10: Int = 0
    @AppStorage("toreveScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("toreveMemoMemory3") var memo = ""
    @AppStorage("toreveDateMemory3") var dateDouble = 0.0
    
    // /////////////
    // ver3.9.1で追加
    // /////////////
    @AppStorage("toreveGameNumberStartMemory3") var gameNumberStart: Int = 0
    @AppStorage("toreveGameNumberCurrentMemory3") var gameNumberCurrent: Int = 0
    @AppStorage("toreveGameNumberPlayMemory3") var gameNumberPlay: Int = 0
    @AppStorage("toreveBellCountMemory3") var bellCount: Int = 0
    @AppStorage("toreveAtRiseCountManjiMemory3") var atRiseCountManji: Int = 0
    @AppStorage("toreveAtRiseCountManjiRiseMemory3") var atRiseCountManjiRise: Int = 0
    @AppStorage("toreveAtRiseCountChanceMemory3") var atRiseCountChance: Int = 0
    @AppStorage("toreveAtRiseCountChanceRiseMemory3") var atRiseCountChanceRise: Int = 0
    @AppStorage("toreveAtRiseCountKyoCherryMemory3") var atRiseCountKyoCherry: Int = 0
    @AppStorage("toreveAtRiseCountKyoCherryRiseMemory3") var atRiseCountKyoCherryRise: Int = 0
    @AppStorage("toreveEndingCountBlueMemory3") var endingCountBlue: Int = 0
    @AppStorage("toreveEndingCountYellowMemory3") var endingCountYellow: Int = 0
    @AppStorage("toreveEndingCountGreenMemory3") var endingCountGreen: Int = 0
    @AppStorage("toreveEndingCountRedMemory3") var endingCountRed: Int = 0
    @AppStorage("toreveEndingCountRainbowMemory3") var endingCountRainbow: Int = 0
    @AppStorage("toreveEndingCountSumMemory3") var endingCountSum: Int = 0
    
    // ///////////////
    // ver3.10.0で追加
    // ///////////////
    @AppStorage("toreveChanceCzCountChanceMemory3") var chanceCzCountChance: Int = 0
    @AppStorage("toreveChanceCzCountCzHitMemory3") var chanceCzCountCzHit: Int = 0
}
