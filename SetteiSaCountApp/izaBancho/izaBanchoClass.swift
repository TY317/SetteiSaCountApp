//
//  izaBanchoClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import Foundation
import SwiftUI

class IzaBancho: ObservableObject {
    // /////////////////
    // 通常時
    // /////////////////
    let ratioCommonBellA: [Double] = [74.9,-1,-1,-1,-1,-1]
    
    
    
    // /////////////////
    // 初当り
    // /////////////////
    let ratioFirstHit: [Double] = [386.9,368.5,375.8,332.4,351.6,312.1]
    let ratioBBChokugeki: [Double] = [-1,-1,-1,-1,-1,-1]
    
    
    // /////////////////
    // AT終了画面
    // /////////////////
    @AppStorage("izaBanchoScreenCountDefault") var screenCountDefault: Int = 0 {
        didSet {
            screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
        }
    }
        @AppStorage("izaBanchoScreenCountScreen2") var screenCountScreen2: Int = 0 {
            didSet {
                screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
            }
        }
            @AppStorage("izaBanchoScreenCountScreen3") var screenCountScreen3: Int = 0 {
                didSet {
                    screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
                }
            }
                @AppStorage("izaBanchoScreenCountScreen4") var screenCountScreen4: Int = 0 {
                    didSet {
                        screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
                    }
                }
                    @AppStorage("izaBanchoScreenCountScreen5") var screenCountScreen5: Int = 0 {
                        didSet {
                            screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
                        }
                    }
                        @AppStorage("izaBanchoScreenCountScreen6") var screenCountScreen6: Int = 0 {
                            didSet {
                                screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
                            }
                        }
                            @AppStorage("izaBanchoScreenCountScreen7") var screenCountScreen7: Int = 0 {
                                didSet {
                                    screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
                                }
                            }
                                @AppStorage("izaBanchoScreenCountScreen8") var screenCountScreen8: Int = 0 {
                                    didSet {
                                        screenCountSum = countSum(screenCountDefault, screenCountScreen2, screenCountScreen3, screenCountScreen4, screenCountScreen5, screenCountScreen6, screenCountScreen7, screenCountScreen8)
                                    }
                                }
    @AppStorage("izaBanchoScreenCountSum") var screenCountSum: Int = 0
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountScreen2 = 0
        screenCountScreen3 = 0
        screenCountScreen4 = 0
        screenCountScreen5 = 0
        screenCountScreen6 = 0
        screenCountScreen7 = 0
        screenCountScreen8 = 0
        minusCheck = false
    }
    
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "いざ！番長"
    @AppStorage("izaBanchoMinusCheck") var minusCheck: Bool = false
    @AppStorage("izaBanchoSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetScreen()
        resetHistory()
    }
    
    // //////////////////
    // ver3.4.0で追加
    // 初当り履歴
    // //////////////////
    // 選択肢の設定
    let selectListBonusKind: [String] = ["AT", "通常ボーナス"]
    let selectListTrigger: [String] = ["CZ", "ゲーム数", "直撃", "天井", "その他"]
    
    // 選択結果
    @AppStorage("izaBanchoSelectedBonusKind") var selectedBonusKind: String = "AT"
    @AppStorage("izaBanchoSelectedTrigger") var selectedTrigger: String = "CZ"
    @AppStorage("izaBanchoInputGame") var inputGame: Int = 0
    
    // ゲーム数配列
    let gameArrayKey: String = "izaBanchoGameArrayKey"
    @AppStorage("izaBanchoGameArrayKey") var gameArrayData: Data?
    // 種類配列
    let bonusKindArrayKey: String = "izaBanchoBonusKindArrayKey"
    @AppStorage("izaBanchoBonusKindArrayKey") var bonusKindArrayData: Data?
    // 当選契機配列
    let triggerArrayKey: String = "izaBanchotriggerArrayKey"
    @AppStorage("izaBanchotriggerArrayKey") var triggerArrayData: Data?
    
    // 結果集計用
    @AppStorage("izaBanchoPlayGameSum") var playGameSum: Int = 0
    @AppStorage("izaBanchoAtCount") var atCount: Int = 0
    @AppStorage("izaBanchoBonusCount") var bonusCount: Int = 0
    @AppStorage("izaBanchoFirstHitCount") var firstHitCount: Int = 0
    
    // データ登録
    func addHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusKindArrayData, addData: selectedBonusKind, key: bonusKindArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedTrigger, key: triggerArrayKey)
        addRemoveCommon()
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: bonusKindArrayData, key: bonusKindArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        addRemoveCommon()
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: bonusKindArrayData, key: bonusKindArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        addRemoveCommon()
        inputGame = 0
        minusCheck = false
    }
    
    func addRemoveCommon() {
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        atCount = arrayStringDataCount(arrayData: bonusKindArrayData, countString: selectListBonusKind[0])
        bonusCount = arrayStringDataCount(arrayData: bonusKindArrayData, countString: selectListBonusKind[1])
        firstHitCount = atCount + bonusCount
    }
    
    // //// 弱チェリー確率
    let ratioJakuCherry: [Double] = [79.9,-1,-1,-1,-1,-1]
}


// //// メモリー1
class IzaBanchoMemory1: ObservableObject {
    @AppStorage("izaBanchoScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("izaBanchoScreenCountScreen2Memory1") var screenCountScreen2: Int = 0
    @AppStorage("izaBanchoScreenCountScreen3Memory1") var screenCountScreen3: Int = 0
    @AppStorage("izaBanchoScreenCountScreen4Memory1") var screenCountScreen4: Int = 0
    @AppStorage("izaBanchoScreenCountScreen5Memory1") var screenCountScreen5: Int = 0
    @AppStorage("izaBanchoScreenCountScreen6Memory1") var screenCountScreen6: Int = 0
    @AppStorage("izaBanchoScreenCountScreen7Memory1") var screenCountScreen7: Int = 0
    @AppStorage("izaBanchoScreenCountScreen8Memory1") var screenCountScreen8: Int = 0
    @AppStorage("izaBanchoScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("izaBanchoGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("izaBanchoBonusKindArrayKeyMemory1") var bonusKindArrayData: Data?
    @AppStorage("izaBanchotriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("izaBanchoPlayGameSumMemory1") var playGameSum: Int = 0
    @AppStorage("izaBanchoAtCountMemory1") var atCount: Int = 0
    @AppStorage("izaBanchoBonusCountMemory1") var bonusCount: Int = 0
    @AppStorage("izaBanchoFirstHitCountMemory1") var firstHitCount: Int = 0
    @AppStorage("izaBanchoMemoMemory1") var memo = ""
    @AppStorage("izaBanchoDateMemory1") var dateDouble = 0.0
}


// //// メモリー2
class IzaBanchoMemory2: ObservableObject {
    @AppStorage("izaBanchoScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("izaBanchoScreenCountScreen2Memory2") var screenCountScreen2: Int = 0
    @AppStorage("izaBanchoScreenCountScreen3Memory2") var screenCountScreen3: Int = 0
    @AppStorage("izaBanchoScreenCountScreen4Memory2") var screenCountScreen4: Int = 0
    @AppStorage("izaBanchoScreenCountScreen5Memory2") var screenCountScreen5: Int = 0
    @AppStorage("izaBanchoScreenCountScreen6Memory2") var screenCountScreen6: Int = 0
    @AppStorage("izaBanchoScreenCountScreen7Memory2") var screenCountScreen7: Int = 0
    @AppStorage("izaBanchoScreenCountScreen8Memory2") var screenCountScreen8: Int = 0
    @AppStorage("izaBanchoScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("izaBanchoGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("izaBanchoBonusKindArrayKeyMemory2") var bonusKindArrayData: Data?
    @AppStorage("izaBanchotriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("izaBanchoPlayGameSumMemory2") var playGameSum: Int = 0
    @AppStorage("izaBanchoAtCountMemory2") var atCount: Int = 0
    @AppStorage("izaBanchoBonusCountMemory2") var bonusCount: Int = 0
    @AppStorage("izaBanchoFirstHitCountMemory2") var firstHitCount: Int = 0
    @AppStorage("izaBanchoMemoMemory2") var memo = ""
    @AppStorage("izaBanchoDateMemory2") var dateDouble = 0.0
}


// //// メモリー3
class IzaBanchoMemory3: ObservableObject {
    @AppStorage("izaBanchoScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("izaBanchoScreenCountScreen2Memory3") var screenCountScreen2: Int = 0
    @AppStorage("izaBanchoScreenCountScreen3Memory3") var screenCountScreen3: Int = 0
    @AppStorage("izaBanchoScreenCountScreen4Memory3") var screenCountScreen4: Int = 0
    @AppStorage("izaBanchoScreenCountScreen5Memory3") var screenCountScreen5: Int = 0
    @AppStorage("izaBanchoScreenCountScreen6Memory3") var screenCountScreen6: Int = 0
    @AppStorage("izaBanchoScreenCountScreen7Memory3") var screenCountScreen7: Int = 0
    @AppStorage("izaBanchoScreenCountScreen8Memory3") var screenCountScreen8: Int = 0
    @AppStorage("izaBanchoScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("izaBanchoGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("izaBanchoBonusKindArrayKeyMemory3") var bonusKindArrayData: Data?
    @AppStorage("izaBanchotriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("izaBanchoPlayGameSumMemory3") var playGameSum: Int = 0
    @AppStorage("izaBanchoAtCountMemory3") var atCount: Int = 0
    @AppStorage("izaBanchoBonusCountMemory3") var bonusCount: Int = 0
    @AppStorage("izaBanchoFirstHitCountMemory3") var firstHitCount: Int = 0
    @AppStorage("izaBanchoMemoMemory3") var memo = ""
    @AppStorage("izaBanchoDateMemory3") var dateDouble = 0.0
}
