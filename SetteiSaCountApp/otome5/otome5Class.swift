//
//  otome5Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/02.
//

import Foundation
import SwiftUI
import Combine

class Otome5: ObservableObject {
    // ----------
    // 通常時
    // ----------
    // 乙女アタック
    let ratioOtomeAttack: [Double] = [20.3,21.4,23.2,24.7,25.2,25.7]
    @AppStorage("otome5OtomeAttackCountMiss") var otomeAttackMiss: Int = 0
    @AppStorage("otome5OtomeAttackCountHit") var otomeAttackHit: Int = 0
    @AppStorage("otome5OtomeAttackCountSum") var otomeAttackSum: Int = 0
    
    func attackSumFunc() {
        otomeAttackSum = otomeAttackHit + otomeAttackMiss
    }
    
    func resetNormal() {
        otomeAttackMiss = 0
        otomeAttackHit = 0
        otomeAttackSum = 0
        minusCheck = false
    }
    
    // -----------
    // 周期履歴
    // -----------
    // 選択肢
    let cycleList: [Int] = [1,2,3,4,5,6]
    let kindList: [String] = ["焔舞", "紫炎"]
    
    // 選択結果
    @AppStorage("otome5InputGame") var inputGame: Int = 0
    @AppStorage("otome5SelectedCycle") var selectedCycle: Int = 1
    @AppStorage("otome5SelectedKind") var selectedKind: String = "焔舞"
    
    // ゲーム数配列
    let gameArrayKey: String = "otome5GameArrayKey"
    @AppStorage("otome5GameArrayKey") var gameArrayData: Data?
    // 周期配列
    let cycleArrayKey: String = "otome5CycleArrayKey"
    @AppStorage("otome5CycleArrayKey") var cycleArrayData: Data?
    // 種類配列
    let kindArrayKey: String = "otome5KindArrayKey"
    @AppStorage("otome5KindArrayKey") var kindArrayData: Data?
    
    // データ登録
    func addHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayIntAddData(arrayData: cycleArrayData, addData: selectedCycle, key: cycleArrayKey)
        arrayStringAddData(arrayData: kindArrayData, addData: selectedKind, key: kindArrayKey)
        addRemoveCommon()
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayIntRemoveLast(arrayData: cycleArrayData, key: cycleArrayKey)
        arrayStringRemoveLast(arrayData: kindArrayData, key: kindArrayKey)
        addRemoveCommon()
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayIntRemoveAll(arrayData: cycleArrayData, key: cycleArrayKey)
        arrayStringRemoveAll(arrayData: kindArrayData, key: kindArrayKey)
        addRemoveCommon()
        inputGame = 0
        minusCheck = false
    }
    
    func addRemoveCommon() {
        
    }
    
    // --------
    // 初当り
    // --------
    let ratioFirstHitAt: [Double] = [359.5,350.8,332.5,302.8,281.0,262.9]
    let ratioFirstHitDirect: [Double] = [21206.7,15648.9,13143.5,8143.4,6427.6,5502.7]
    @AppStorage("otome5NormalGame") var normalGame: Int = 0
    @AppStorage("otome5FirstHitCountAt") var firstHitCountAt: Int = 0
    @AppStorage("otome5FirstHitCountDirect") var firstHitCountDirect: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        firstHitCountDirect = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "戦国乙女5"
    @AppStorage("otome5MinusCheck") var minusCheck: Bool = false
    @AppStorage("otome5SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetHistory()
        resetFirstHit()
    }
}
