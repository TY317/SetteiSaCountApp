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
    let ratioCzMidNight: [Double] = [1278.4,-1,-1,-1,-1,-1]
    let ratioCzKisaki: [Double] = [14520.4,-1,-1,-1,-1,-1]
    let ratioCzSum: [Double] = [1174.9,-1,-1,-1,-1,-1]
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
    }
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
}
