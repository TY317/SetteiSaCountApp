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
//            charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
            charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu)
        }
    }
        @AppStorage("arifureCharaCountKisu") var charaCountKisu: Int = 0 {
            didSet {
//                charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu)
            }
        }
            @AppStorage("arifureCharaCountHighJaku") var charaCountHighJaku: Int = 0 {
                didSet {
//                    charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                    charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu)
                }
            }
                @AppStorage("arifureCharaCountHighKyo") var charaCountHighKyo: Int = 0 {
                    didSet {
//                        charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                        charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu)
                    }
                }
                    @AppStorage("arifureCharaCountGusuKyo") var charaCountGusuKyo: Int = 0 {
                        didSet {
//                            charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                            charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu)
                        }
                    }
                        @AppStorage("arifureCharaCountOver2") var charaCountOver2: Int = 0 {
                            didSet {
//                                charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                                charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu)
                            }
                        }
                            @AppStorage("arifureCharaCountOver2Kyo") var charaCountOver2Kyo: Int = 0 {
                                didSet {
//                                    charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                                    charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu)
                                }
                            }
                                @AppStorage("arifureCharaCountOver2Gusu") var charaCountOver2Gusu: Int = 0 {
                                    didSet {
//                                        charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu, charaCountAt, charaCountOver4, charaCountOver5, charaCountOver6)
                                        charaCountSum = countSum(charaCountKisu, charaCountGusu, charaCountHighJaku, charaCountHighKyo, charaCountGusuKyo, charaCountOver2, charaCountOver2Kyo, charaCountOver2Gusu)
                                    }
                                }
                                    @AppStorage("arifureCharaCountAt") var charaCountAt: Int = 0
                                        @AppStorage("arifureCharaCountOver4") var charaCountOver4: Int = 0
                                            @AppStorage("arifureCharaCountOver5") var charaCountOver5: Int = 0
                                                @AppStorage("arifureCharaCountOver6") var charaCountOver6: Int = 0
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
    @AppStorage("arifureEndingCountKisu") var endingCountKisu: Int = 0 {
        didSet {
            endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
        }
    }
        @AppStorage("arifureEndingCountGusu") var endingCountGusu: Int = 0 {
            didSet {
                endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
            }
        }
            @AppStorage("arifureEndingCountHighJaku") var endingCountHighJaku: Int = 0 {
                didSet {
                    endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
                }
            }
                @AppStorage("arifureEndingCountHighKyo") var endingCountHighKyo: Int = 0 {
                    didSet {
                        endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
                    }
                }
                    @AppStorage("arifureEndingCountOver4") var endingCountOver4: Int = 0 {
                        didSet {
                            endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
                        }
                    }
                        @AppStorage("arifureEndingCountOver5") var endingCountOver5: Int = 0 {
                            didSet {
                                endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
                            }
                        }
                            @AppStorage("arifureEndingCountOver6") var endingCountOver6: Int = 0 {
                                didSet {
                                    endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
                                }
                            }
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
        resetPremium()
    }
    
    // ///////////////////////
    // ver2.5.0で追加
    // ///////////////////////
    // 上位AT初当り確率
    let ratioPremiumAtHit: [Double] = [
        8800,
        8200,
        7300,
        5900,
        5200,
        4100
    ]
    // 覚醒チャレンジ成功率
    let ratioKakuseiSuccess: [Double] = [
        44,
        45,
        48,
        53,
        54,
        57
    ]
    // ビッグトリガー10％選択率
    let ratioBigTrigger10Percent: [Double] = [
        90,
        86,
        76,
        58,
        50,
        28
    ]
    // ビッグトリガー56％選択率
    let ratioBigTrigger56Percent: [Double] = [
        5,
        7,
        12,
        21,
        25,
        28
    ]
    // ビッグトリガー73％選択率
    let ratioBigTrigger73Percent: [Double] = [
        5,
        7,
        12,
        21,
        25,
        44
    ]
    // ビッグトリガー継続２G
    let ratioBigTriggerContinuous2G: [Double] = [
        84.5,
        82.4,
        76.9,
        67.1,
        62.7,
        49.4
    ]
    // ビッグトリガー継続3G
    let ratioBigTriggerContinuous3G: [Double] = [
        10.4,
        10.8,
        12.2,
        14.6,
        15.7,
        18.1
    ]
    // ビッグトリガー継続4G以上
    let ratioBigTriggerContinuous4GOver: [Double] = [
        5.1,
        6.8,
        10.9,
        18.3,
        21.6,
        32.5
    ]
    @AppStorage("arifureBtaGameCount2G") var btaGameCount2G: Int = 0 {
        didSet {
            btaGameCountSum = countSum(btaGameCount2G, btaGameCount3G, btaGameCount4GOver)
        }
    }
        @AppStorage("arifureBtaGameCount3G") var btaGameCount3G: Int = 0 {
            didSet {
                btaGameCountSum = countSum(btaGameCount2G, btaGameCount3G, btaGameCount4GOver)
            }
        }
            @AppStorage("arifureBtaGameCount4GOver") var btaGameCount4GOver: Int = 0 {
                didSet {
                    btaGameCountSum = countSum(btaGameCount2G, btaGameCount3G, btaGameCount4GOver)
                }
            }
    @AppStorage("arifureBtaGameCountSum") var btaGameCountSum: Int = 0
    
    func resetPremium() {
        btaGameCount2G = 0
        btaGameCount3G = 0
        btaGameCount4GOver = 0
        minusCheck = false
    }
    // キャラ紹介インデックス
    let charaIndex: [String] = [
        "偶数示唆",
        "奇数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "偶数濃厚",
        "2以上濃厚",
        "2以上濃厚+\n356示唆",
        "2以上濃厚+\n偶数示唆"
    ]
    // キャラ紹介振り分け設定1
    let ratioCharaSetting1: [Double] = [
        36,
        43,
        20,
        1,
        0,
        0,
        0,
        0
    ]
    // キャラ紹介振り分け設定2
    let ratioCharaSetting2: [Double] = [
        39,
        31,
        20,
        1,
        1,
        5,
        1,
        2
    ]
    // キャラ紹介振り分け設定3
    let ratioCharaSetting3: [Double] = [
        31,
        37,
        22,
        2,
        0,
        5,
        2,
        1
    ]
    // キャラ紹介振り分け設定4
    let ratioCharaSetting4: [Double] = [
        36,
        29,
        22,
        2,
        3,
        5,
        1,
        2
    ]
    // キャラ紹介振り分け設定5
    let ratioCharaSetting5: [Double] = [
        29,
        35,
        25,
        3,
        0,
        5,
        2,
        1
    ]
    // キャラ紹介振り分け設定6
    let ratioCharaSetting6: [Double] = [
        33,
        27,
        25,
        3,
        3,
        5,
        2,
        2
    ]
    // AT終了画面インデックス
    let atEndScreenIndex: [String] = [
        "デフォルト",
        "高設定示唆",
        "4以上",
        "5以上",
        "6濃厚"
    ]
    // AT終了画面振り分け設定1
    let ratioAtEndScreenSetting1: [Double] = [
        85,
        15,
        0,
        0,
        0
    ]
    // AT終了画面振り分け設定2
    let ratioAtEndScreenSetting2: [Double] = [
        82,
        18,
        0,
        0,
        0
    ]
    // AT終了画面振り分け設定3
    let ratioAtEndScreenSetting3: [Double] = [
        80,
        20,
        0,
        0,
        0
    ]
    // AT終了画面振り分け設定4
    let ratioAtEndScreenSetting4: [Double] = [
        77,
        22,
        1,
        0,
        0
    ]
    // AT終了画面振り分け設定5
    let ratioAtEndScreenSetting5: [Double] = [
        74,
        25,
        1,
        1,
        0
    ]
    // AT終了画面振り分け設定6
    let ratioAtEndScreenSetting6: [Double] = [
        74,
        25,
        1,
        1,
        1
    ]
    // エンディング振り分けインデックス
    let endingIndex: [String] = [
        "奇数示唆",
        "偶数示唆",
        "高設定示唆 弱",
        "高設定示唆 強",
        "4以上",
        "5以上",
        "6濃厚"
    ]
    // エンディング振り分け設定1
    let ratioEndingSetting1: [Double] = [
        45,
        30,
        15,
        10,
        0,
        0,
        0
    ]
    // エンディング振り分け設定2
    let ratioEndingSetting2: [Double] = [
        29,
        45,
        15,
        11,
        0,
        0,
        0
    ]
    // エンディング振り分け設定3
    let ratioEndingSetting3: [Double] = [
        44,
        28,
        16,
        12,
        0,
        0,
        0
    ]
    // エンディング振り分け設定4
    let ratioEndingSetting4: [Double] = [
        27,
        40,
        17,
        13,
        3,
        0,
        0
    ]
    // エンディング振り分け設定5
    let ratioEndingSetting5: [Double] = [
        38,
        26,
        17,
        14,
        3,
        2,
        0
    ]
    // エンディング振り分け設定6
    let ratioEndingSetting6: [Double] = [
        25,
        36,
        18,
        15,
        3,
        2,
        1
    ]
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
    
    // ///////////////////////
    // ver2.5.0で追加
    // ///////////////////////
    @AppStorage("arifureBtaGameCount2GMemory1") var btaGameCount2G: Int = 0
    @AppStorage("arifureBtaGameCount3GMemory1") var btaGameCount3G: Int = 0
    @AppStorage("arifureBtaGameCount4GOverMemory1") var btaGameCount4GOver: Int = 0
    @AppStorage("arifureBtaGameCountSumMemory1") var btaGameCountSum: Int = 0
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
    
    // ///////////////////////
    // ver2.5.0で追加
    // ///////////////////////
    @AppStorage("arifureBtaGameCount2GMemory2") var btaGameCount2G: Int = 0
    @AppStorage("arifureBtaGameCount3GMemory2") var btaGameCount3G: Int = 0
    @AppStorage("arifureBtaGameCount4GOverMemory2") var btaGameCount4GOver: Int = 0
    @AppStorage("arifureBtaGameCountSumMemory2") var btaGameCountSum: Int = 0
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
    
    // ///////////////////////
    // ver2.5.0で追加
    // ///////////////////////
    @AppStorage("arifureBtaGameCount2GMemory3") var btaGameCount2G: Int = 0
    @AppStorage("arifureBtaGameCount3GMemory3") var btaGameCount3G: Int = 0
    @AppStorage("arifureBtaGameCount4GOverMemory3") var btaGameCount4GOver: Int = 0
    @AppStorage("arifureBtaGameCountSumMemory3") var btaGameCountSum: Int = 0
}
