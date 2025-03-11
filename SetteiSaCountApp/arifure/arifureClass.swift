//
//  arifureClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/02.
//

import Foundation
import SwiftUI

class Arifure: ObservableObject {
    // /////////////////////////
    // 通常時
    // /////////////////////////
    @AppStorage("arifureJakuCherryCount") var jakuCherryCount: Int = 0
    @AppStorage("arifureJakuCherryKokakuCount") var jakuCherryKokakuCount: Int = 0
    @AppStorage("arifureJakuChanceCount") var jakuChanceCount: Int = 0
    @AppStorage("arifureJakuChanceKokakuCount") var jakuChanceKokakuCount: Int = 0
    @AppStorage("arifureKokakuSuikaCount") var kokakuSuikaCount: Int = 0
    @AppStorage("arifureKokakuSuikaKokakuCount") var kokakuSuikaKokakuCount: Int = 0
    @AppStorage("arifureCz100GCountMiss") var cz100GCountMiss: Int = 0 {
        didSet {
            cz100GCountSum = countSum(cz100GCountMiss, cz100GCountHit)
        }
    }
        @AppStorage("arifureCz100GCountHit") var cz100GCountHit: Int = 0 {
            didSet {
                cz100GCountSum = countSum(cz100GCountMiss, cz100GCountHit)
            }
        }
    @AppStorage("arifureCz100GCountSum") var cz100GCountSum: Int = 0
    
    func resetNormal() {
        jakuCherryCount = 0
        jakuCherryKokakuCount = 0
        jakuChanceCount = 0
        jakuChanceKokakuCount = 0
        kokakuSuikaCount = 0
        kokakuSuikaKokakuCount = 0
        cz100GCountMiss = 0
        cz100GCountHit = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 初当り履歴
    // ////////////////////////
    // 選択肢の設定
    let selectListBonusKind: [String] = [
        "大迷宮ボーナス",
        "ミュウボーナス"
    ]
    let selectListAtHit: [String] = [
        "当選",
        "ハズレ"
    ]
    
    // 選択結果
    @AppStorage("arifureSelectedBonusKind") var selectedBonusKind: String = "大迷宮ボーナス"
    @AppStorage("arifureSelectedAtHit") var selectedAtHit: String = "ハズレ"
    @AppStorage("arifureInputGame") var inputGame: Int = 0
    
    // ゲーム数配列
    let gameArrayKey = "arifureGameArrayKey"
    @AppStorage("arifureGameArrayKey") var gameArrayData: Data?
    // 種類配列
    let kindArrayKey = "arifureKindArrayKey"
    @AppStorage("arifureKindArrayKey") var kindArrayData: Data?
    // AT当否配列
    let atHitArrayKey = "arifureAtHitArrayKey"
    @AppStorage("arifureAtHitArrayKey") var atHitArrayData: Data?
    
    // 結果集計用
    @AppStorage("arifurePlayGameSum") var playGameSum: Int = 0
    @AppStorage("arifureMyuBonusCountAll") var myuBonusCountAll: Int = 0
    @AppStorage("arifureMyuBonusCountAtHit") var myuBonusCountAtHit: Int = 0
    @AppStorage("arifureAtCount") var atCount: Int = 0
    @AppStorage("arifureHitUnder100gCount") var hitUnder100gCount: Int = 0
    @AppStorage("arifureHitCountAll") var hitCountAll: Int = 0
    
    // ATデータ登録
    func addHistoryAt() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: kindArrayData, addData: selectedBonusKind, key: kindArrayKey)
        arrayStringAddData(arrayData: atHitArrayData, addData: selectListAtHit[0], key: atHitArrayKey)
        addRemoveCommon()
    }
    
    // ミュウボーナスデータ登録
    func addHistoryMyu() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: kindArrayData, addData: selectedBonusKind, key: kindArrayKey)
        arrayStringAddData(arrayData: atHitArrayData, addData: selectedAtHit, key: atHitArrayKey)
        addRemoveCommon()
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: kindArrayData, key: kindArrayKey)
        arrayStringRemoveLast(arrayData: atHitArrayData, key: atHitArrayKey)
        addRemoveCommon()
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: kindArrayData, key: kindArrayKey)
        arrayStringRemoveAll(arrayData: atHitArrayData, key: atHitArrayKey)
        addRemoveCommon()
        minusCheck = false
    }
    
    func addRemoveCommon() {
        // //// 累計ゲーム数の集計
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        // ミュウボーナス回数の集計
        myuBonusCountAll = arrayStringDataCount(arrayData: kindArrayData, countString: selectListBonusKind[1])
        // 第迷宮ボーナス回数の集計
        atCount = arrayStringDataCount(arrayData: atHitArrayData, countString: selectListAtHit[0])
        // ミュウボーナスでAT当選の回数の集計
        myuBonusCountAtHit = arrayString2Array2AndDataCount(
            array1Data: kindArrayData,
            array2Data: atHitArrayData,
            key1: selectListBonusKind[1],
            key2: selectListAtHit[0]
        )
        // 100G以内の当選の回数の集計
        let over100Count = arrayIntOverGameCount(intArrayData: gameArrayData, overGame: 132)
        hitCountAll = arrayIntAllDataCount(arrayData: gameArrayData)
        hitUnder100gCount = hitCountAll - over100Count
        inputGame = 0
    }
    
    // ////////////////////////
    // ミュウボーナス中のキャラ紹介
    // ////////////////////////
    @AppStorage("arifureCharaCountGusu") var charaCountGusu: Int = 0 {
        didSet {
            charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
        }
    }
        @AppStorage("arifureCharaCountKisu") var charaCountKisu: Int = 0 {
            didSet {
                charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
            }
        }
            @AppStorage("arifureCharaCountHighJaku") var charaCountHighJaku: Int = 0 {
                didSet {
                    charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                }
            }
                @AppStorage("arifureCharaCountHighKyo") var charaCountHighKyo: Int = 0 {
                    didSet {
                        charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                    }
                }
                    @AppStorage("arifureCharaCountGusuKyo") var charaCountGusuKyo: Int = 0 {
                        didSet {
                            charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                        }
                    }
                        @AppStorage("arifureCharaCountOver2") var charaCountOver2: Int = 0 {
                            didSet {
                                charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                            }
                        }
                            @AppStorage("arifureCharaCountOver2Kyo") var charaCountOver2Kyo: Int = 0 {
                                didSet {
                                    charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                                }
                            }
                                @AppStorage("arifureCharaCountOver2Gusu") var charaCountOver2Gusu: Int = 0 {
                                    didSet {
                                        charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                                    }
                                }
                                    @AppStorage("arifureCharaCountAt") var charaCountAt: Int = 0 {
                                        didSet {
                                            charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                                        }
                                    }
                                        @AppStorage("arifureCharaCountOver4") var charaCountOver4: Int = 0 {
                                            didSet {
                                                charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                                            }
                                        }
                                            @AppStorage("arifureCharaCountOver5") var charaCountOver5: Int = 0 {
                                                didSet {
                                                    charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                                                }
                                            }
                                                @AppStorage("arifureCharaCountOver6") var charaCountOver6: Int = 0 {
                                                    didSet {
                                                        charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                                                    }
                                                }
    @AppStorage("arifureCharaCountSum") var charaCountSum: Int = 0
    
    func resetCharacter() {
        charaCountGusu = 0
        charaCountKisu = 0
        charaCountHighJaku = 0
        charaCountHighKyo = 0
        charaCountGusuKyo = 0
        charaCountOver2 = 0
        charaCountOver2Kyo = 0
        charaCountOver2Gusu = 0
        charaCountAt = 0
        charaCountOver4 = 0
        charaCountOver5 = 0
        charaCountOver6 = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // AT終了画面
    // ////////////////////////
    @AppStorage("arifureEndScreenCountDefault") var endScreenCountDefault: Int = 0 {
        didSet {
            endScreenCountSum = countSum(endScreenCountDefault, endScreenCountHigh, endScreenCountOver4, endScreenCountOver5, endScreenCountOver6)
        }
    }
        @AppStorage("arifureEndScreenCountHigh") var endScreenCountHigh: Int = 0 {
            didSet {
                endScreenCountSum = countSum(endScreenCountDefault, endScreenCountHigh, endScreenCountOver4, endScreenCountOver5, endScreenCountOver6)
            }
        }
            @AppStorage("arifureEndScreenCountOver4") var endScreenCountOver4: Int = 0 {
                didSet {
                    endScreenCountSum = countSum(endScreenCountDefault, endScreenCountHigh, endScreenCountOver4, endScreenCountOver5, endScreenCountOver6)
                }
            }
                @AppStorage("arifureEndScreenCountOver5") var endScreenCountOver5: Int = 0 {
                    didSet {
                        endScreenCountSum = countSum(endScreenCountDefault, endScreenCountHigh, endScreenCountOver4, endScreenCountOver5, endScreenCountOver6)
                    }
                }
                    @AppStorage("arifureEndScreenCountOver6") var endScreenCountOver6: Int = 0 {
                        didSet {
                            endScreenCountSum = countSum(endScreenCountDefault, endScreenCountHigh, endScreenCountOver4, endScreenCountOver5, endScreenCountOver6)
                        }
                    }
    @AppStorage("arifureEndScreenCountSum") var endScreenCountSum: Int = 0
    func resetScreen() {
        endScreenCountDefault = 0
        endScreenCountHigh = 0
        endScreenCountOver4 = 0
        endScreenCountOver5 = 0
        endScreenCountOver6 = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // AT終了後の高確
    // ////////////////////////
    @AppStorage("arifureAfterKokakuCountMiss") var afterKokakuCountMiss: Int = 0 {
        didSet {
            afterKokakuCountSum = countSum(afterKokakuCountMiss, afterKokakuCountHit)
        }
    }
        @AppStorage("arifureAfterKokakuCountHit") var afterKokakuCountHit: Int = 0 {
            didSet {
                afterKokakuCountSum = countSum(afterKokakuCountMiss, afterKokakuCountHit)
            }
        }
    @AppStorage("arifureAfterKokakuCountSum") var afterKokakuCountSum: Int = 0
    func resetAfterKokaku() {
        afterKokakuCountMiss = 0
        afterKokakuCountHit = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // エンディング
    // ////////////////////////
    @AppStorage("arifureEndingCountKisu") var endingCountKisu: Int = 0
    @AppStorage("arifureEndingCountGusu") var endingCountGusu: Int = 0
    @AppStorage("arifureEndingCountHighJaku") var endingCountHighJaku: Int = 0
    @AppStorage("arifureEndingCountHighKyo") var endingCountHighKyo: Int = 0
    @AppStorage("arifureEndingCountOver4") var endingCountOver4: Int = 0
    @AppStorage("arifureEndingCountOver5") var endingCountOver5: Int = 0
    @AppStorage("arifureEndingCountOver6") var endingCountOver6: Int = 0
    @AppStorage("arifureEndingCountSum") var endingCountSum: Int = 0
    
    func resetEnding() {
        endingCountKisu = 0
        endingCountGusu = 0
        endingCountHighJaku = 0
        endingCountHighKyo = 0
        endingCountOver4 = 0
        endingCountOver5 = 0
        endingCountOver6 = 0
        minusCheck = false
    }
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("arifureMinusCheck") var minusCheck: Bool = false
    @AppStorage("arifureSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetHistory()
        resetCharacter()
        resetScreen()
        resetAfterKokaku()
        resetEnding()
    }
}


// //// メモリー1
class ArifureMemory1: ObservableObject {
    @AppStorage("arifureJakuCherryCountMemory1") var jakuCherryCount: Int = 0
    @AppStorage("arifureJakuCherryKokakuCountMemory1") var jakuCherryKokakuCount: Int = 0
    @AppStorage("arifureJakuChanceCountMemory1") var jakuChanceCount: Int = 0
    @AppStorage("arifureJakuChanceKokakuCountMemory1") var jakuChanceKokakuCount: Int = 0
    @AppStorage("arifureKokakuSuikaCountMemory1") var kokakuSuikaCount: Int = 0
    @AppStorage("arifureKokakuSuikaKokakuCountMemory1") var kokakuSuikaKokakuCount: Int = 0
    @AppStorage("arifureCz100GCountMissMemory1") var cz100GCountMiss: Int = 0
    @AppStorage("arifureCz100GCountHitMemory1") var cz100GCountHit: Int = 0
    @AppStorage("arifureCz100GCountSumMemory1") var cz100GCountSum: Int = 0
    @AppStorage("arifureInputGameMemory1") var inputGame: Int = 0
    @AppStorage("arifureGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("arifureKindArrayKeyMemory1") var kindArrayData: Data?
    @AppStorage("arifureAtHitArrayKeyMemory1") var atHitArrayData: Data?
    @AppStorage("arifurePlayGameSumMemory1") var playGameSum: Int = 0
    @AppStorage("arifureMyuBonusCountAllMemory1") var myuBonusCountAll: Int = 0
    @AppStorage("arifureMyuBonusCountAtHitMemory1") var myuBonusCountAtHit: Int = 0
    @AppStorage("arifureAtCountMemory1") var atCount: Int = 0
    @AppStorage("arifureHitUnder100gCountMemory1") var hitUnder100gCount: Int = 0
    @AppStorage("arifureHitCountAllMemory1") var hitCountAll: Int = 0
    @AppStorage("arifureCharaCountGusuMemory1") var charaCountGusu: Int = 0
    @AppStorage("arifureCharaCountKisuMemory1") var charaCountKisu: Int = 0
    @AppStorage("arifureCharaCountHighJakuMemory1") var charaCountHighJaku: Int = 0
    @AppStorage("arifureCharaCountHighKyoMemory1") var charaCountHighKyo: Int = 0
    @AppStorage("arifureCharaCountGusuKyoMemory1") var charaCountGusuKyo: Int = 0
    @AppStorage("arifureCharaCountOver2Memory1") var charaCountOver2: Int = 0
    @AppStorage("arifureCharaCountOver2KyoMemory1") var charaCountOver2Kyo: Int = 0
    @AppStorage("arifureCharaCountOver2GusuMemory1") var charaCountOver2Gusu: Int = 0
    @AppStorage("arifureCharaCountAtMemory1") var charaCountAt: Int = 0
    @AppStorage("arifureCharaCountOver4Memory1") var charaCountOver4: Int = 0
    @AppStorage("arifureCharaCountOver5Memory1") var charaCountOver5: Int = 0
    @AppStorage("arifureCharaCountOver6Memory1") var charaCountOver6: Int = 0
    @AppStorage("arifureCharaCountSumMemory1") var charaCountSum: Int = 0
    @AppStorage("arifureEndScreenCountDefaultMemory1") var endScreenCountDefault: Int = 0
    @AppStorage("arifureEndScreenCountHighMemory1") var endScreenCountHigh: Int = 0
    @AppStorage("arifureEndScreenCountOver4Memory1") var endScreenCountOver4: Int = 0
    @AppStorage("arifureEndScreenCountOver5Memory1") var endScreenCountOver5: Int = 0
    @AppStorage("arifureEndScreenCountOver6Memory1") var endScreenCountOver6: Int = 0
    @AppStorage("arifureEndScreenCountSumMemory1") var endScreenCountSum: Int = 0
    @AppStorage("arifureAfterKokakuCountMissMemory1") var afterKokakuCountMiss: Int = 0
    @AppStorage("arifureAfterKokakuCountHitMemory1") var afterKokakuCountHit: Int = 0
    @AppStorage("arifureAfterKokakuCountSumMemory1") var afterKokakuCountSum: Int = 0
    @AppStorage("arifureEndingCountKisuMemory1") var endingCountKisu: Int = 0
    @AppStorage("arifureEndingCountGusuMemory1") var endingCountGusu: Int = 0
    @AppStorage("arifureEndingCountHighJakuMemory1") var endingCountHighJaku: Int = 0
    @AppStorage("arifureEndingCountHighKyoMemory1") var endingCountHighKyo: Int = 0
    @AppStorage("arifureEndingCountOver4Memory1") var endingCountOver4: Int = 0
    @AppStorage("arifureEndingCountOver5Memory1") var endingCountOver5: Int = 0
    @AppStorage("arifureEndingCountOver6Memory1") var endingCountOver6: Int = 0
    @AppStorage("arifureEndingCountSumMemory1") var endingCountSum: Int = 0
    @AppStorage("arifureMemoMemory1") var memo = ""
    @AppStorage("arifureDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class ArifureMemory2: ObservableObject {
    @AppStorage("arifureJakuCherryCountMemory2") var jakuCherryCount: Int = 0
    @AppStorage("arifureJakuCherryKokakuCountMemory2") var jakuCherryKokakuCount: Int = 0
    @AppStorage("arifureJakuChanceCountMemory2") var jakuChanceCount: Int = 0
    @AppStorage("arifureJakuChanceKokakuCountMemory2") var jakuChanceKokakuCount: Int = 0
    @AppStorage("arifureKokakuSuikaCountMemory2") var kokakuSuikaCount: Int = 0
    @AppStorage("arifureKokakuSuikaKokakuCountMemory2") var kokakuSuikaKokakuCount: Int = 0
    @AppStorage("arifureCz100GCountMissMemory2") var cz100GCountMiss: Int = 0
    @AppStorage("arifureCz100GCountHitMemory2") var cz100GCountHit: Int = 0
    @AppStorage("arifureCz100GCountSumMemory2") var cz100GCountSum: Int = 0
    @AppStorage("arifureInputGameMemory2") var inputGame: Int = 0
    @AppStorage("arifureGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("arifureKindArrayKeyMemory2") var kindArrayData: Data?
    @AppStorage("arifureAtHitArrayKeyMemory2") var atHitArrayData: Data?
    @AppStorage("arifurePlayGameSumMemory2") var playGameSum: Int = 0
    @AppStorage("arifureMyuBonusCountAllMemory2") var myuBonusCountAll: Int = 0
    @AppStorage("arifureMyuBonusCountAtHitMemory2") var myuBonusCountAtHit: Int = 0
    @AppStorage("arifureAtCountMemory2") var atCount: Int = 0
    @AppStorage("arifureHitUnder100gCountMemory2") var hitUnder100gCount: Int = 0
    @AppStorage("arifureHitCountAllMemory2") var hitCountAll: Int = 0
    @AppStorage("arifureCharaCountGusuMemory2") var charaCountGusu: Int = 0
    @AppStorage("arifureCharaCountKisuMemory2") var charaCountKisu: Int = 0
    @AppStorage("arifureCharaCountHighJakuMemory2") var charaCountHighJaku: Int = 0
    @AppStorage("arifureCharaCountHighKyoMemory2") var charaCountHighKyo: Int = 0
    @AppStorage("arifureCharaCountGusuKyoMemory2") var charaCountGusuKyo: Int = 0
    @AppStorage("arifureCharaCountOver2Memory2") var charaCountOver2: Int = 0
    @AppStorage("arifureCharaCountOver2KyoMemory2") var charaCountOver2Kyo: Int = 0
    @AppStorage("arifureCharaCountOver2GusuMemory2") var charaCountOver2Gusu: Int = 0
    @AppStorage("arifureCharaCountAtMemory2") var charaCountAt: Int = 0
    @AppStorage("arifureCharaCountOver4Memory2") var charaCountOver4: Int = 0
    @AppStorage("arifureCharaCountOver5Memory2") var charaCountOver5: Int = 0
    @AppStorage("arifureCharaCountOver6Memory2") var charaCountOver6: Int = 0
    @AppStorage("arifureCharaCountSumMemory2") var charaCountSum: Int = 0
    @AppStorage("arifureEndScreenCountDefaultMemory2") var endScreenCountDefault: Int = 0
    @AppStorage("arifureEndScreenCountHighMemory2") var endScreenCountHigh: Int = 0
    @AppStorage("arifureEndScreenCountOver4Memory2") var endScreenCountOver4: Int = 0
    @AppStorage("arifureEndScreenCountOver5Memory2") var endScreenCountOver5: Int = 0
    @AppStorage("arifureEndScreenCountOver6Memory2") var endScreenCountOver6: Int = 0
    @AppStorage("arifureEndScreenCountSumMemory2") var endScreenCountSum: Int = 0
    @AppStorage("arifureAfterKokakuCountMissMemory2") var afterKokakuCountMiss: Int = 0
    @AppStorage("arifureAfterKokakuCountHitMemory2") var afterKokakuCountHit: Int = 0
    @AppStorage("arifureAfterKokakuCountSumMemory2") var afterKokakuCountSum: Int = 0
    @AppStorage("arifureEndingCountKisuMemory2") var endingCountKisu: Int = 0
    @AppStorage("arifureEndingCountGusuMemory2") var endingCountGusu: Int = 0
    @AppStorage("arifureEndingCountHighJakuMemory2") var endingCountHighJaku: Int = 0
    @AppStorage("arifureEndingCountHighKyoMemory2") var endingCountHighKyo: Int = 0
    @AppStorage("arifureEndingCountOver4Memory2") var endingCountOver4: Int = 0
    @AppStorage("arifureEndingCountOver5Memory2") var endingCountOver5: Int = 0
    @AppStorage("arifureEndingCountOver6Memory2") var endingCountOver6: Int = 0
    @AppStorage("arifureEndingCountSumMemory2") var endingCountSum: Int = 0
    @AppStorage("arifureMemoMemory2") var memo = ""
    @AppStorage("arifureDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class ArifureMemory3: ObservableObject {
    @AppStorage("arifureJakuCherryCountMemory3") var jakuCherryCount: Int = 0
    @AppStorage("arifureJakuCherryKokakuCountMemory3") var jakuCherryKokakuCount: Int = 0
    @AppStorage("arifureJakuChanceCountMemory3") var jakuChanceCount: Int = 0
    @AppStorage("arifureJakuChanceKokakuCountMemory3") var jakuChanceKokakuCount: Int = 0
    @AppStorage("arifureKokakuSuikaCountMemory3") var kokakuSuikaCount: Int = 0
    @AppStorage("arifureKokakuSuikaKokakuCountMemory3") var kokakuSuikaKokakuCount: Int = 0
    @AppStorage("arifureCz100GCountMissMemory3") var cz100GCountMiss: Int = 0
    @AppStorage("arifureCz100GCountHitMemory3") var cz100GCountHit: Int = 0
    @AppStorage("arifureCz100GCountSumMemory3") var cz100GCountSum: Int = 0
    @AppStorage("arifureInputGameMemory3") var inputGame: Int = 0
    @AppStorage("arifureGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("arifureKindArrayKeyMemory3") var kindArrayData: Data?
    @AppStorage("arifureAtHitArrayKeyMemory3") var atHitArrayData: Data?
    @AppStorage("arifurePlayGameSumMemory3") var playGameSum: Int = 0
    @AppStorage("arifureMyuBonusCountAllMemory3") var myuBonusCountAll: Int = 0
    @AppStorage("arifureMyuBonusCountAtHitMemory3") var myuBonusCountAtHit: Int = 0
    @AppStorage("arifureAtCountMemory3") var atCount: Int = 0
    @AppStorage("arifureHitUnder100gCountMemory3") var hitUnder100gCount: Int = 0
    @AppStorage("arifureHitCountAllMemory3") var hitCountAll: Int = 0
    @AppStorage("arifureCharaCountGusuMemory3") var charaCountGusu: Int = 0
    @AppStorage("arifureCharaCountKisuMemory3") var charaCountKisu: Int = 0
    @AppStorage("arifureCharaCountHighJakuMemory3") var charaCountHighJaku: Int = 0
    @AppStorage("arifureCharaCountHighKyoMemory3") var charaCountHighKyo: Int = 0
    @AppStorage("arifureCharaCountGusuKyoMemory3") var charaCountGusuKyo: Int = 0
    @AppStorage("arifureCharaCountOver2Memory3") var charaCountOver2: Int = 0
    @AppStorage("arifureCharaCountOver2KyoMemory3") var charaCountOver2Kyo: Int = 0
    @AppStorage("arifureCharaCountOver2GusuMemory3") var charaCountOver2Gusu: Int = 0
    @AppStorage("arifureCharaCountAtMemory3") var charaCountAt: Int = 0
    @AppStorage("arifureCharaCountOver4Memory3") var charaCountOver4: Int = 0
    @AppStorage("arifureCharaCountOver5Memory3") var charaCountOver5: Int = 0
    @AppStorage("arifureCharaCountOver6Memory3") var charaCountOver6: Int = 0
    @AppStorage("arifureCharaCountSumMemory3") var charaCountSum: Int = 0
    @AppStorage("arifureEndScreenCountDefaultMemory3") var endScreenCountDefault: Int = 0
    @AppStorage("arifureEndScreenCountHighMemory3") var endScreenCountHigh: Int = 0
    @AppStorage("arifureEndScreenCountOver4Memory3") var endScreenCountOver4: Int = 0
    @AppStorage("arifureEndScreenCountOver5Memory3") var endScreenCountOver5: Int = 0
    @AppStorage("arifureEndScreenCountOver6Memory3") var endScreenCountOver6: Int = 0
    @AppStorage("arifureEndScreenCountSumMemory3") var endScreenCountSum: Int = 0
    @AppStorage("arifureAfterKokakuCountMissMemory3") var afterKokakuCountMiss: Int = 0
    @AppStorage("arifureAfterKokakuCountHitMemory3") var afterKokakuCountHit: Int = 0
    @AppStorage("arifureAfterKokakuCountSumMemory3") var afterKokakuCountSum: Int = 0
    @AppStorage("arifureEndingCountKisuMemory3") var endingCountKisu: Int = 0
    @AppStorage("arifureEndingCountGusuMemory3") var endingCountGusu: Int = 0
    @AppStorage("arifureEndingCountHighJakuMemory3") var endingCountHighJaku: Int = 0
    @AppStorage("arifureEndingCountHighKyoMemory3") var endingCountHighKyo: Int = 0
    @AppStorage("arifureEndingCountOver4Memory3") var endingCountOver4: Int = 0
    @AppStorage("arifureEndingCountOver5Memory3") var endingCountOver5: Int = 0
    @AppStorage("arifureEndingCountOver6Memory3") var endingCountOver6: Int = 0
    @AppStorage("arifureEndingCountSumMemory3") var endingCountSum: Int = 0
    @AppStorage("arifureMemoMemory3") var memo = ""
    @AppStorage("arifureDateMemory3") var dateDouble = 0.0
}
