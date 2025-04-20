//
//  yoshimuneClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/16.
//

import Foundation
import SwiftUI
import TipKit

class Yoshimune: ObservableObject {
    // ////////////////////////
    // 初当り履歴
    // ////////////////////////
    // 選択肢の設定
    let selectListBonusKind: [String] = ["BIG", "REG"]
    let selectListTrigger: [String] = [
        "規定G数",
        "小役解除",
        "鷹狩り",
        "天井",
        "その他"
    ]
    
    // 選択結果
    @AppStorage("yoshimuneRealGameInput") var realGameInput: Int = 0
    @AppStorage("yoshimuneDisplayGameInput") var displayGameInput: Int = 0
    @AppStorage("yoshimuneSelectedBonusKind") var selectedBonusKind: String = "BIG"
    @AppStorage("yoshimuneSelectedTrigger") var selectedTrigger: String = "規定G数"
    
    // 結果集計用
    @AppStorage("yoshimuneRealGameTotal") var realGameTotal: Int = 0
    @AppStorage("yoshimuneBonusCountBig") var bonusCountBig: Int = 0
    @AppStorage("yoshimuneBonusCountReg") var bonusCountReg: Int = 0
    @AppStorage("yoshimuneBonusCountSum") var bonusCountSum: Int = 0
    
    // 実ゲーム数配列
    let realGameArrayKey = "yoshimuneRealGameArrayKey"
    @AppStorage("yoshimuneRealGameArrayKey") var realGameArrayData: Data?
    // 液晶ゲーム数配列
    let displayGameArrayKey = "yoshimuneDisplayGameArrayKey"
    @AppStorage("yoshimuneDisplayGameArrayKey") var displayGameArrayData: Data?
    // ボーナス種類配列
    let bonusKindArrayKey = "yoshimuneBonusKindArrayKey"
    @AppStorage("yoshimuneBonusKindArrayKey") var bonusKindArrayData: Data?
    // 当選契機配列
    let triggerArrayKey = "yoshimuneTriggerArrayKey"
    @AppStorage("yoshimuneTriggerArrayKey") var triggerArrayData: Data?
    
    let ratioBonusFirstHit: [Double] = [378.9,369.6,358.8,335.1,318.5,292.4]
    
    // データ登録
    func addHistory() {
        arrayIntAddData(arrayData: realGameArrayData, addData: realGameInput, key: realGameArrayKey)
        arrayIntAddData(arrayData: displayGameArrayData, addData: displayGameInput, key: displayGameArrayKey)
        arrayStringAddData(arrayData: bonusKindArrayData, addData: selectedBonusKind, key: bonusKindArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedTrigger, key: triggerArrayKey)
        addRemoveCommon()
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: realGameArrayData, key: realGameArrayKey)
        arrayIntRemoveLast(arrayData: displayGameArrayData, key: displayGameArrayKey)
        arrayStringRemoveLast(arrayData: bonusKindArrayData, key: bonusKindArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        addRemoveCommon()
    }
    
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: realGameArrayData, key: realGameArrayKey)
        arrayIntRemoveAll(arrayData: displayGameArrayData, key: displayGameArrayKey)
        arrayStringRemoveAll(arrayData: bonusKindArrayData, key: bonusKindArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        addRemoveCommon()
        minusCheck = false
    }
    
    func addRemoveCommon() {
        // 実ゲーム数のトータル算出
        realGameTotal = arrayIntAllDataSum(arrayData: realGameArrayData)
        // ビッグ回数の算出
        bonusCountBig = arrayStringDataCount(arrayData: bonusKindArrayData, countString: selectListBonusKind[0])
        // REG回数の算出
        bonusCountReg = arrayStringDataCount(arrayData: bonusKindArrayData, countString: selectListBonusKind[1])
        // ボーナス合算回数の算出
        bonusCountSum = countSum(bonusCountBig, bonusCountReg)
        // //// インプット数値のリセット
        realGameInput = 0
        displayGameInput = 0
    }
    
    // ///////////////////////
    // ボーナス終了画面
    // ///////////////////////
    @AppStorage("yoshimuneHanafudaCountDefault") var hanafudaCountDefault: Int = 0 {
        didSet {
            hanafudaCountSum = countSum(hanafudaCountDefault, hanafudaCountHighJaku, hanafudaCountHighKyo, hanafudaCount2Over, hanafudaCount3Over, hanafudaCount4Over, hanafudaCount5Over, hanafudaCount6Over)
        }
    }
        @AppStorage("yoshimuneHanafudaCountHighJaku") var hanafudaCountHighJaku: Int = 0 {
            didSet {
                hanafudaCountSum = countSum(hanafudaCountDefault, hanafudaCountHighJaku, hanafudaCountHighKyo, hanafudaCount2Over, hanafudaCount3Over, hanafudaCount4Over, hanafudaCount5Over, hanafudaCount6Over)
            }
        }
            @AppStorage("yoshimuneHanafudaCountHighKyo") var hanafudaCountHighKyo: Int = 0 {
                didSet {
                    hanafudaCountSum = countSum(hanafudaCountDefault, hanafudaCountHighJaku, hanafudaCountHighKyo, hanafudaCount2Over, hanafudaCount3Over, hanafudaCount4Over, hanafudaCount5Over, hanafudaCount6Over)
                }
            }
                @AppStorage("yoshimuneHanafudaCount2Over") var hanafudaCount2Over: Int = 0 {
                    didSet {
                        hanafudaCountSum = countSum(hanafudaCountDefault, hanafudaCountHighJaku, hanafudaCountHighKyo, hanafudaCount2Over, hanafudaCount3Over, hanafudaCount4Over, hanafudaCount5Over, hanafudaCount6Over)
                    }
                }
                    @AppStorage("yoshimuneHanafudaCount3Over") var hanafudaCount3Over: Int = 0 {
                        didSet {
                            hanafudaCountSum = countSum(hanafudaCountDefault, hanafudaCountHighJaku, hanafudaCountHighKyo, hanafudaCount2Over, hanafudaCount3Over, hanafudaCount4Over, hanafudaCount5Over, hanafudaCount6Over)
                        }
                    }
                        @AppStorage("yoshimuneHanafudaCount4Over") var hanafudaCount4Over: Int = 0 {
                            didSet {
                                hanafudaCountSum = countSum(hanafudaCountDefault, hanafudaCountHighJaku, hanafudaCountHighKyo, hanafudaCount2Over, hanafudaCount3Over, hanafudaCount4Over, hanafudaCount5Over, hanafudaCount6Over)
                            }
                        }
                            @AppStorage("yoshimuneHanafudaCount5Over") var hanafudaCount5Over: Int = 0 {
                                didSet {
                                    hanafudaCountSum = countSum(hanafudaCountDefault, hanafudaCountHighJaku, hanafudaCountHighKyo, hanafudaCount2Over, hanafudaCount3Over, hanafudaCount4Over, hanafudaCount5Over, hanafudaCount6Over)
                                }
                            }
                                @AppStorage("yoshimuneHanafudaCount6Over") var hanafudaCount6Over: Int = 0 {
                                    didSet {
                                        hanafudaCountSum = countSum(hanafudaCountDefault, hanafudaCountHighJaku, hanafudaCountHighKyo, hanafudaCount2Over, hanafudaCount3Over, hanafudaCount4Over, hanafudaCount5Over, hanafudaCount6Over)
                                    }
                                }
    @AppStorage("yoshimuneHanafudaCountSum") var hanafudaCountSum: Int = 0
    
    func resetScreen() {
        hanafudaCountDefault = 0
        hanafudaCountHighJaku = 0
        hanafudaCountHighKyo = 0
        hanafudaCount2Over = 0
        hanafudaCount3Over = 0
        hanafudaCount4Over = 0
        hanafudaCount5Over = 0
        hanafudaCount6Over = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("yoshimuneMinusCheck") var minusCheck: Bool = false
    @AppStorage("yoshimuneSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetHistory()
        resetScreen()
    }
}


// //// メモリー1
class YoshimuneMemory1: ObservableObject {
    @AppStorage("yoshimuneRealGameInputMemory1") var realGameInput: Int = 0
    @AppStorage("yoshimuneDisplayGameInputMemory1") var displayGameInput: Int = 0
    @AppStorage("yoshimuneSelectedBonusKindMemory1") var selectedBonusKind: String = "BIG"
    @AppStorage("yoshimuneSelectedTriggerMemory1") var selectedTrigger: String = "規定G数"
    @AppStorage("yoshimuneRealGameTotalMemory1") var realGameTotal: Int = 0
    @AppStorage("yoshimuneBonusCountBigMemory1") var bonusCountBig: Int = 0
    @AppStorage("yoshimuneBonusCountRegMemory1") var bonusCountReg: Int = 0
    @AppStorage("yoshimuneBonusCountSumMemory1") var bonusCountSum: Int = 0
    @AppStorage("yoshimuneRealGameArrayKeyMemory1") var realGameArrayData: Data?
    @AppStorage("yoshimuneDisplayGameArrayKeyMemory1") var displayGameArrayData: Data?
    @AppStorage("yoshimuneBonusKindArrayKeyMemory1") var bonusKindArrayData: Data?
    @AppStorage("yoshimuneTriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("yoshimuneHanafudaCountDefaultMemory1") var hanafudaCountDefault: Int = 0
    @AppStorage("yoshimuneHanafudaCountHighJakuMemory1") var hanafudaCountHighJaku: Int = 0
    @AppStorage("yoshimuneHanafudaCountHighKyoMemory1") var hanafudaCountHighKyo: Int = 0
    @AppStorage("yoshimuneHanafudaCount2OverMemory1") var hanafudaCount2Over: Int = 0
    @AppStorage("yoshimuneHanafudaCount3OverMemory1") var hanafudaCount3Over: Int = 0
    @AppStorage("yoshimuneHanafudaCount4OverMemory1") var hanafudaCount4Over: Int = 0
    @AppStorage("yoshimuneHanafudaCount5OverMemory1") var hanafudaCount5Over: Int = 0
    @AppStorage("yoshimuneHanafudaCount6OverMemory1") var hanafudaCount6Over: Int = 0
    @AppStorage("yoshimuneHanafudaCountSumMemory1") var hanafudaCountSum: Int = 0
    @AppStorage("yoshimuneMemoMemory1") var memo = ""
    @AppStorage("yoshimuneDateMemory1") var dateDouble = 0.0
}


// //// メモリー2
class YoshimuneMemory2: ObservableObject {
    @AppStorage("yoshimuneRealGameInputMemory2") var realGameInput: Int = 0
    @AppStorage("yoshimuneDisplayGameInputMemory2") var displayGameInput: Int = 0
    @AppStorage("yoshimuneSelectedBonusKindMemory2") var selectedBonusKind: String = "BIG"
    @AppStorage("yoshimuneSelectedTriggerMemory2") var selectedTrigger: String = "規定G数"
    @AppStorage("yoshimuneRealGameTotalMemory2") var realGameTotal: Int = 0
    @AppStorage("yoshimuneBonusCountBigMemory2") var bonusCountBig: Int = 0
    @AppStorage("yoshimuneBonusCountRegMemory2") var bonusCountReg: Int = 0
    @AppStorage("yoshimuneBonusCountSumMemory2") var bonusCountSum: Int = 0
    @AppStorage("yoshimuneRealGameArrayKeyMemory2") var realGameArrayData: Data?
    @AppStorage("yoshimuneDisplayGameArrayKeyMemory2") var displayGameArrayData: Data?
    @AppStorage("yoshimuneBonusKindArrayKeyMemory2") var bonusKindArrayData: Data?
    @AppStorage("yoshimuneTriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("yoshimuneHanafudaCountDefaultMemory2") var hanafudaCountDefault: Int = 0
    @AppStorage("yoshimuneHanafudaCountHighJakuMemory2") var hanafudaCountHighJaku: Int = 0
    @AppStorage("yoshimuneHanafudaCountHighKyoMemory2") var hanafudaCountHighKyo: Int = 0
    @AppStorage("yoshimuneHanafudaCount2OverMemory2") var hanafudaCount2Over: Int = 0
    @AppStorage("yoshimuneHanafudaCount3OverMemory2") var hanafudaCount3Over: Int = 0
    @AppStorage("yoshimuneHanafudaCount4OverMemory2") var hanafudaCount4Over: Int = 0
    @AppStorage("yoshimuneHanafudaCount5OverMemory2") var hanafudaCount5Over: Int = 0
    @AppStorage("yoshimuneHanafudaCount6OverMemory2") var hanafudaCount6Over: Int = 0
    @AppStorage("yoshimuneHanafudaCountSumMemory2") var hanafudaCountSum: Int = 0
    @AppStorage("yoshimuneMemoMemory2") var memo = ""
    @AppStorage("yoshimuneDateMemory2") var dateDouble = 0.0
}


// //// メモリー3
class YoshimuneMemory3: ObservableObject {
    @AppStorage("yoshimuneRealGameInputMemory3") var realGameInput: Int = 0
    @AppStorage("yoshimuneDisplayGameInputMemory3") var displayGameInput: Int = 0
    @AppStorage("yoshimuneSelectedBonusKindMemory3") var selectedBonusKind: String = "BIG"
    @AppStorage("yoshimuneSelectedTriggerMemory3") var selectedTrigger: String = "規定G数"
    @AppStorage("yoshimuneRealGameTotalMemory3") var realGameTotal: Int = 0
    @AppStorage("yoshimuneBonusCountBigMemory3") var bonusCountBig: Int = 0
    @AppStorage("yoshimuneBonusCountRegMemory3") var bonusCountReg: Int = 0
    @AppStorage("yoshimuneBonusCountSumMemory3") var bonusCountSum: Int = 0
    @AppStorage("yoshimuneRealGameArrayKeyMemory3") var realGameArrayData: Data?
    @AppStorage("yoshimuneDisplayGameArrayKeyMemory3") var displayGameArrayData: Data?
    @AppStorage("yoshimuneBonusKindArrayKeyMemory3") var bonusKindArrayData: Data?
    @AppStorage("yoshimuneTriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("yoshimuneHanafudaCountDefaultMemory3") var hanafudaCountDefault: Int = 0
    @AppStorage("yoshimuneHanafudaCountHighJakuMemory3") var hanafudaCountHighJaku: Int = 0
    @AppStorage("yoshimuneHanafudaCountHighKyoMemory3") var hanafudaCountHighKyo: Int = 0
    @AppStorage("yoshimuneHanafudaCount2OverMemory3") var hanafudaCount2Over: Int = 0
    @AppStorage("yoshimuneHanafudaCount3OverMemory3") var hanafudaCount3Over: Int = 0
    @AppStorage("yoshimuneHanafudaCount4OverMemory3") var hanafudaCount4Over: Int = 0
    @AppStorage("yoshimuneHanafudaCount5OverMemory3") var hanafudaCount5Over: Int = 0
    @AppStorage("yoshimuneHanafudaCount6OverMemory3") var hanafudaCount6Over: Int = 0
    @AppStorage("yoshimuneHanafudaCountSumMemory3") var hanafudaCountSum: Int = 0
    @AppStorage("yoshimuneMemoMemory3") var memo = ""
    @AppStorage("yoshimuneDateMemory3") var dateDouble = 0.0
}
