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
}


class Karakuri2Memory1: ObservableObject {
    @AppStorage("karakuri2MemoMemory1") var memo = ""
    @AppStorage("karakuri2DateMemory1") var dateDouble = 0.0
}


class Karakuri2Memory2: ObservableObject {
    @AppStorage("karakuri2MemoMemory2") var memo = ""
    @AppStorage("karakuri2DateMemory2") var dateDouble = 0.0
}


class Karakuri2Memory3: ObservableObject {
    @AppStorage("karakuri2MemoMemory3") var memo = ""
    @AppStorage("karakuri2DateMemory3") var dateDouble = 0.0
}
