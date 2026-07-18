//
//  karakuri2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/27.
//

import Foundation
import SwiftUI
import Combine

class Karakuri2: ObservableObject {
    // -------
    // 通常時
    // -------
    
    func resetNormal() {
        minusCheck = false
        
        kyoCherryCount = 0
        kyoCherryCountHit = 0
    }
    
    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [342,341,339,339,327,318]
    let ratioFirstHitAt: [Double] = [519,504,474,458,430,410]
    @AppStorage("karakuri2NormalGame") var normalGame: Int = 0
    @AppStorage("karakuri2FirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("karakuri2FirstHitCountAt") var firstHitCountAt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountAt = 0
        minusCheck = false
    }

    // --------
    // 終了画面
    // --------
    @AppStorage("karakuri2ScreenCount1") var screenCount1: Int = 0
    @AppStorage("karakuri2ScreenCount2") var screenCount2: Int = 0
    @AppStorage("karakuri2ScreenCount3") var screenCount3: Int = 0
    @AppStorage("karakuri2ScreenCount4") var screenCount4: Int = 0
    @AppStorage("karakuri2ScreenCount5") var screenCount5: Int = 0
    @AppStorage("karakuri2ScreenCount6") var screenCount6: Int = 0
    @AppStorage("karakuri2ScreenCountSum") var screenCountSum: Int = 0

    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
            screenCount4,
            screenCount5,
            screenCount6,
        )
    }

    func resetScreen() {
        screenCount1 = 0
        screenCount2 = 0
        screenCount3 = 0
        screenCount4 = 0
        screenCount5 = 0
        screenCount6 = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // ----------
    // 履歴
    // ----------
    // 選択肢
    let kindList: [String] = ["機械仕掛けの女神","幕間チャンス(AT後)","幕間チャンス(通常時)","劇場ジャッジ"]
    // 選択結果
    @AppStorage("karakuri2InputGame") var inputGame: Int = 0
    @AppStorage("karakuri2SelectedKind") var selectedKind: String = "機械仕掛けの女神"
    @AppStorage("karakuri2SelectedImageName") var selectedImageName: String = ""
    
    // ゲーム数配列
    let gameArrayKey: String = "karakuri2GameArrayKey"
    @AppStorage("karakuri2GameArrayKey") var gameArrayData: Data?
    // 種類配列
    let kindArrayKey: String = "karakuri2KindArrayKey"
    @AppStorage("karakuri2KindArrayKey") var kindArrayData: Data?
    // 画面配列
    let screenArrayKey: String = "karakuri2ScreenArrayKey"
    @AppStorage("karakuri2ScreenArrayKey") var screenArrayData: Data?
    
    // データ登録
    func addHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: kindArrayData, addData: selectedKind, key: kindArrayKey)
        arrayStringAddData(arrayData: screenArrayData, addData: selectedImageName, key: screenArrayKey)
        addRemoveCommon()
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: kindArrayData, key: kindArrayKey)
        arrayStringRemoveLast(arrayData: screenArrayData, key: screenArrayKey)
        addRemoveCommon()
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: kindArrayData, key: kindArrayKey)
        arrayStringRemoveAll(arrayData: screenArrayData, key: screenArrayKey)
        addRemoveCommon()
        inputGame = 0
        minusCheck = false
    }
    
    func addRemoveCommon() {
        
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "からくりサーカス2"
    @AppStorage("karakuri2MinusCheck") var minusCheck: Bool = false
    @AppStorage("karakuri2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetHistory()
    }
    
    // ----------
    // ver4.1.2
    // ----------
    let ratioScreenOver2: [Double] = [0,1,1,1,1,1]
    let ratioScreenOver4: [Double] = [0,0,0,1,1,1]
    let ratioScreenOver6: [Double] = [0,0,0,0,0,1]
    
    // 強チェリー当選率
    let ratioKyoCherryHit: [Double] = [9.8,-1,-1,-1,-1,-1]
    @AppStorage("karakuri2KyoCherryCount") var kyoCherryCount: Int = 0
    @AppStorage("karakuri2KyoCherryCountHit") var kyoCherryCountHit: Int = 0
}


class Karakuri2Memory1: ObservableObject {
    @AppStorage("karakuri2NormalGameMemory1") var normalGame: Int = 0
    @AppStorage("karakuri2FirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("karakuri2FirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("karakuri2ScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("karakuri2ScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("karakuri2ScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("karakuri2ScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("karakuri2ScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("karakuri2ScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("karakuri2ScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("karakuri2GameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("karakuri2KindArrayKeyMemory1") var kindArrayData: Data?
    @AppStorage("karakuri2ScreenArrayKeyMemory1") var screenArrayData: Data?
    @AppStorage("karakuri2KyoCherryCountMemory1") var kyoCherryCount: Int = 0
    @AppStorage("karakuri2KyoCherryCountHitMemory1") var kyoCherryCountHit: Int = 0
    @AppStorage("karakuri2MemoMemory1") var memo = ""
    @AppStorage("karakuri2DateMemory1") var dateDouble = 0.0
}


class Karakuri2Memory2: ObservableObject {
    @AppStorage("karakuri2NormalGameMemory2") var normalGame: Int = 0
    @AppStorage("karakuri2FirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("karakuri2FirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("karakuri2ScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("karakuri2ScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("karakuri2ScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("karakuri2ScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("karakuri2ScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("karakuri2ScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("karakuri2ScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("karakuri2GameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("karakuri2KindArrayKeyMemory2") var kindArrayData: Data?
    @AppStorage("karakuri2ScreenArrayKeyMemory2") var screenArrayData: Data?
    @AppStorage("karakuri2KyoCherryCountMemory2") var kyoCherryCount: Int = 0
    @AppStorage("karakuri2KyoCherryCountHitMemory2") var kyoCherryCountHit: Int = 0
    @AppStorage("karakuri2MemoMemory2") var memo = ""
    @AppStorage("karakuri2DateMemory2") var dateDouble = 0.0
}


class Karakuri2Memory3: ObservableObject {
    @AppStorage("karakuri2NormalGameMemory3") var normalGame: Int = 0
    @AppStorage("karakuri2FirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("karakuri2FirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("karakuri2ScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("karakuri2ScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("karakuri2ScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("karakuri2ScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("karakuri2ScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("karakuri2ScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("karakuri2ScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("karakuri2GameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("karakuri2KindArrayKeyMemory3") var kindArrayData: Data?
    @AppStorage("karakuri2ScreenArrayKeyMemory3") var screenArrayData: Data?
    @AppStorage("karakuri2KyoCherryCountMemory3") var kyoCherryCount: Int = 0
    @AppStorage("karakuri2KyoCherryCountHitMemory3") var kyoCherryCountHit: Int = 0
    @AppStorage("karakuri2MemoMemory3") var memo = ""
    @AppStorage("karakuri2DateMemory3") var dateDouble = 0.0
}
