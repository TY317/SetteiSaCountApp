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
