//
//  tokyoGhoulClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/20.
//

import Foundation
import SwiftUI

class TokyoGhoul: ObservableObject {
    // ////////////////////////
    // 月山招待状
    // ////////////////////////
    let selectListTsukiyama: [String] = [
        "今夜ディナーを楽しもう",
        "パーティーの時間は未定だ",
        "(青・緑・赤・紫色の文字)",
        "偶にはディナーでもどうだい",
        "不思議な香りだ",
        "君はなかなかの活字中毒らしいね",
        "本は良いよね・・",
        "僕としたことがすまない",
        "存分に楽しもうじゃないか",
        "特別な夜を楽しもうじゃないか"
    ]
    @AppStorage("tokyoGhoulSelectedTukiyama") var selectedTsukiyama: String = "パーティーの時間は未定だ"
    @AppStorage("tokyoGhoulTsukiyamaCountGusu") var tsukiyamaCountGusu: Int = 0 {
        didSet {
            tsukiyamaCountSum = countSum(tsukiyamaCountGusu, tsukiyamaCountNot1, tsukiyamaCountNot2, tsukiyamaCountNot3, tsukiyamaCountNot4, tsukiyamaCountOver4, tsukiyamaCountOver6, tsukiyamaCountDefault, tsukiyamaCountRemainGame)
        }
    }
        @AppStorage("tokyoGhoulTsukiyamaCountNot1") var tsukiyamaCountNot1: Int = 0 {
            didSet {
                tsukiyamaCountSum = countSum(tsukiyamaCountGusu, tsukiyamaCountNot1, tsukiyamaCountNot2, tsukiyamaCountNot3, tsukiyamaCountNot4, tsukiyamaCountOver4, tsukiyamaCountOver6, tsukiyamaCountDefault, tsukiyamaCountRemainGame)
            }
        }
            @AppStorage("tokyoGhoulTsukiyamaCountNot2") var tsukiyamaCountNot2: Int = 0 {
                didSet {
                    tsukiyamaCountSum = countSum(tsukiyamaCountGusu, tsukiyamaCountNot1, tsukiyamaCountNot2, tsukiyamaCountNot3, tsukiyamaCountNot4, tsukiyamaCountOver4, tsukiyamaCountOver6, tsukiyamaCountDefault, tsukiyamaCountRemainGame)
                }
            }
                @AppStorage("tokyoGhoulTsukiyamaCountNot3") var tsukiyamaCountNot3: Int = 0 {
                    didSet {
                        tsukiyamaCountSum = countSum(tsukiyamaCountGusu, tsukiyamaCountNot1, tsukiyamaCountNot2, tsukiyamaCountNot3, tsukiyamaCountNot4, tsukiyamaCountOver4, tsukiyamaCountOver6, tsukiyamaCountDefault, tsukiyamaCountRemainGame)
                    }
                }
                    @AppStorage("tokyoGhoulTsukiyamaCountNot4") var tsukiyamaCountNot4: Int = 0 {
                        didSet {
                            tsukiyamaCountSum = countSum(tsukiyamaCountGusu, tsukiyamaCountNot1, tsukiyamaCountNot2, tsukiyamaCountNot3, tsukiyamaCountNot4, tsukiyamaCountOver4, tsukiyamaCountOver6, tsukiyamaCountDefault, tsukiyamaCountRemainGame)
                        }
                    }
                        @AppStorage("tokyoGhoulTsukiyamaCountOver4") var tsukiyamaCountOver4: Int = 0 {
                            didSet {
                                tsukiyamaCountSum = countSum(tsukiyamaCountGusu, tsukiyamaCountNot1, tsukiyamaCountNot2, tsukiyamaCountNot3, tsukiyamaCountNot4, tsukiyamaCountOver4, tsukiyamaCountOver6, tsukiyamaCountDefault, tsukiyamaCountRemainGame)
                            }
                        }
                            @AppStorage("tokyoGhoulTsukiyamaCountOver6") var tsukiyamaCountOver6: Int = 0 {
                                didSet {
                                    tsukiyamaCountSum = countSum(tsukiyamaCountGusu, tsukiyamaCountNot1, tsukiyamaCountNot2, tsukiyamaCountNot3, tsukiyamaCountNot4, tsukiyamaCountOver4, tsukiyamaCountOver6, tsukiyamaCountDefault, tsukiyamaCountRemainGame)
                                }
                            }
                                @AppStorage("tokyoGhoulTsukiyamaCountDefault") var tsukiyamaCountDefault: Int = 0 {
                                    didSet {
                                        tsukiyamaCountSum = countSum(tsukiyamaCountGusu, tsukiyamaCountNot1, tsukiyamaCountNot2, tsukiyamaCountNot3, tsukiyamaCountNot4, tsukiyamaCountOver4, tsukiyamaCountOver6, tsukiyamaCountDefault, tsukiyamaCountRemainGame)
                                    }
                                }
                                    @AppStorage("tokyoGhoulTsukiyamaCountRemainGame") var tsukiyamaCountRemainGame: Int = 0 {
                                        didSet {
                                            tsukiyamaCountSum = countSum(tsukiyamaCountGusu, tsukiyamaCountNot1, tsukiyamaCountNot2, tsukiyamaCountNot3, tsukiyamaCountNot4, tsukiyamaCountOver4, tsukiyamaCountOver6, tsukiyamaCountDefault, tsukiyamaCountRemainGame)
                                        }
                                    }
    @AppStorage("tokyoGhoulTsukiyamaCountSum") var tsukiyamaCountSum: Int = 0
    
    func resetTsukiyama() {
        tsukiyamaCountGusu = 0
        tsukiyamaCountNot1 = 0
        tsukiyamaCountNot2 = 0
        tsukiyamaCountNot3 = 0
        tsukiyamaCountNot4 = 0
        tsukiyamaCountOver4 = 0
        tsukiyamaCountOver6 = 0
        tsukiyamaCountDefault = 0
        tsukiyamaCountRemainGame = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // CZ,AT 初当り履歴
    // ////////////////////////
    // //// セグメント選択
    let selectListSegment: [String] = [
        "CZ初当り",
        "AT直撃"
    ]
    @AppStorage("tokyoGhoulSelectedSegment") var selectedSegment: String = "CZ初当り"
    
    // //// CZ選択
    let selectListCzKind: [String] = [
        "REMINISCENCE",
        "大喰いの利世",
        "エピソードボーナス"
    ]
    let selectListCzTrigger: [String] = [
        "規定G数",
        "強レア役",
        "弱レア役",
        "天井",
        "その他"
    ]
    let selectListCzAtHit: [String] = [
        "当選",
        "ハズレ"
    ]
    @AppStorage("tokyoGhoulSelectedCzKind") var selectedCzKind: String = "REMINISCENCE"
    @AppStorage("tokyoGhoulSelectedCzTrigger") var selectedCzTrigger: String = "規定G数"
    @AppStorage("tokyoGhoulSelectedCzAtHit") var selectedCzAtHit: String = "当選"
    
    // //// AT選択
    let selectListAtTrigger: [String] = [
        "規定G数",
        "強レア役",
        "弱レア役",
        "天井",
        "その他"
    ]
    @AppStorage("tokyoGhoulSelectedAtTrigger") var selectedAtTrigger: String = "規定G数"
    
    // //// 選択結果の設定
    @AppStorage("tokyoGhoulInputGame") var inputGame: Int = 0
    
    // ゲーム数配列
    let gameArrayKey = "tokyoGhoulGameArrayKey"
    @AppStorage("tokyoGhoulGameArrayKey") var gameArrayData: Data?
    // 種類配列
    let kindArrayKey = "tokyoGhoulKindArrayKey"
    @AppStorage("tokyoGhoulKindArrayKey") var kindArrayData: Data?
    // 当選契機配列
    let triggerArrayKey = "tokyoGhoulTriggerArrayKey"
    @AppStorage("tokyoGhoulTriggerArrayKey") var triggerArrayData: Data?
    // AT当否配列
    let atHitArrayKey = "tokyoGhoulAtHitArrayKey"
    @AppStorage("tokyoGhoulAtHitArrayKey") var atHitArrayData: Data?
    
    // 結果集計用
    @AppStorage("tokyoGhoulPlayGameSum") var playGameSum: Int = 0
    @AppStorage("tokyoGhoulCzCountRemini") var czCountRemini: Int = 0
    @AppStorage("tokyoGhoulCzCountRise") var czCountRise: Int = 0
    @AppStorage("tokyoGhoulCzCountEpisode") var czCountEpisode: Int = 0
    @AppStorage("tokyoGhoulCzCountSum") var czCountSum: Int = 0
    @AppStorage("tokyoGhoulAtCount") var atCount: Int = 0
    
    // 100G以内確率用
    @AppStorage("tokyoGhoulMorningModeEnable") var morningModeEnable: Bool = false {
        didSet {
            addRemoveCommon()
        }
    }
    @AppStorage("tokyoGhoulUnder100Count") var under100CountHit: Int = 0
    @AppStorage("tokyoGhoulFirstHitCountSum") var firstHitCountSum: Int = 0
    
    // CZデータ登録
    func addHistoryCz() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: kindArrayData, addData: selectedCzKind, key: kindArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedCzTrigger, key: triggerArrayKey)
        arrayStringAddData(arrayData: atHitArrayData, addData: selectedCzAtHit, key: atHitArrayKey)
        addRemoveCommon()
    }
    
    // ATデータ登録
    func addHistoryAt() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: kindArrayData, addData: "AT直撃", key: kindArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedAtTrigger, key: triggerArrayKey)
        arrayStringAddData(arrayData: atHitArrayData, addData: selectListCzAtHit[0], key: atHitArrayKey)
        addRemoveCommon()
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: kindArrayData, key: kindArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveLast(arrayData: atHitArrayData, key: atHitArrayKey)
        addRemoveCommon()
    }
    
    // 登録・削除時に共通で実行する内容
    func addRemoveCommon() {
        // //// 累計ゲーム数の集計
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        // //// CZ回数の集計
        czCountRemini = arrayStringDataCount(arrayData: kindArrayData, countString: selectListCzKind[0])
        czCountRise = arrayStringDataCount(arrayData: kindArrayData, countString: selectListCzKind[1])
        czCountEpisode = arrayStringDataCount(arrayData: kindArrayData, countString: selectListCzKind[2])
        czCountSum = countSum(czCountRemini, czCountRise)
        // //// AT回数の集計
        atCount = arrayStringDataCount(arrayData: atHitArrayData, countString: selectListCzAtHit[0])
        // 100G以内用の集計
        let over100Count = arrayIntOverGameCount(intArrayData: gameArrayData, overGame: 100)
        firstHitCountSum = arrayIntAllDataCount(arrayData: gameArrayData)
        under100CountHit = firstHitCountSum - over100Count
        if morningModeEnable {
            let gameArray = decodeIntArray(from: gameArrayData)
            if gameArray.count > 0 {
                firstHitCountSum -= 1
                if gameArray[0] <= 100 {
                    under100CountHit -= 1
                }
            }
        }
        inputGame = 0
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: kindArrayData, key: kindArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveAll(arrayData: atHitArrayData, key: atHitArrayKey)
        addRemoveCommon()
        minusCheck = false
        
        comeBackCountNone = 0
        comeBackCountHit = 0
        comeBackCountSum = 0
    }
    
    // ////////////////////////
    // AT終了画面
    // ////////////////////////
    let atScreenKeywordList: [String] = [
        "tokyoGhoulScreenDefault",
        "tokyoGhoulScreenKisu",
        "tokyoGhoulScreenGusu",
        "tokyoGhoulScreenNot1",
        "tokyoGhoulScreenHighJaku",
        "tokyoGhoulScreenHighKyo",
        "tokyoGhoulScreenOver4",
        "tokyoGhoulScreenOver6"
    ]
    @AppStorage("tokyoGhoulScreenCurrentKeyword") var screenCurrentKeyword: String = ""
    @AppStorage("tokyoGhoulScreenCountDefault") var screenCountDefault: Int = 0 {
        didSet {
            screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountNot1, screenCountHighJaku, screenCountHighKyo, screenCountOver4, screenCountOver6)
        }
    }
        @AppStorage("tokyoGhoulScreenCountKisu") var screenCountKisu: Int = 0 {
            didSet {
                screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountNot1, screenCountHighJaku, screenCountHighKyo, screenCountOver4, screenCountOver6)
            }
        }
            @AppStorage("tokyoGhoulScreenCountGusu") var screenCountGusu: Int = 0 {
                didSet {
                    screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountNot1, screenCountHighJaku, screenCountHighKyo, screenCountOver4, screenCountOver6)
                }
            }
                @AppStorage("tokyoGhoulScreenCountNot1") var screenCountNot1: Int = 0 {
                    didSet {
                        screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountNot1, screenCountHighJaku, screenCountHighKyo, screenCountOver4, screenCountOver6)
                    }
                }
                    @AppStorage("tokyoGhoulScreenCountHighJaku") var screenCountHighJaku: Int = 0 {
                        didSet {
                            screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountNot1, screenCountHighJaku, screenCountHighKyo, screenCountOver4, screenCountOver6)
                        }
                    }
                        @AppStorage("tokyoGhoulScreenCountHighKyo") var screenCountHighKyo: Int = 0 {
                            didSet {
                                screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountNot1, screenCountHighJaku, screenCountHighKyo, screenCountOver4, screenCountOver6)
                            }
                        }
                            @AppStorage("tokyoGhoulScreenCountOver4") var screenCountOver4: Int = 0 {
                                didSet {
                                    screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountNot1, screenCountHighJaku, screenCountHighKyo, screenCountOver4, screenCountOver6)
                                }
                            }
                                @AppStorage("tokyoGhoulScreenCountOver6") var screenCountOver6: Int = 0 {
                                    didSet {
                                        screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountNot1, screenCountHighJaku, screenCountHighKyo, screenCountOver4, screenCountOver6)
                                    }
                                }
    @AppStorage("tokyoGhoulScreenCountSum") var screenCountSum: Int = 0
    
    func resetScreen() {
        screenCurrentKeyword = ""
        screenCountDefault = 0
        screenCountKisu = 0
        screenCountGusu = 0
        screenCountNot1 = 0
        screenCountHighJaku = 0
        screenCountHighKyo = 0
        screenCountOver4 = 0
        screenCountOver6 = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // エンディング
    // ////////////////////////
    @AppStorage("tokyoGhoulEndingCountKisuJaku") var endingCountKisuJaku: Int = 0 {
        didSet {
            endingCountSum = countSum(endingCountKisuJaku, endingCountKisuKyo, endingCountGusuJaku, endingCountGusuKyo, endingCountHighJaku, endingCountHighKyo, endingCountExcept1, endingCountExcept2, endingCountExcept3, endingCountExcept4, endingCountOver3, endingCountOver4, endingCountOver5, endingCountOver6)
        }
    }
        @AppStorage("tokyoGhoulEndingCountKisuKyo") var endingCountKisuKyo: Int = 0 {
            didSet {
                endingCountSum = countSum(endingCountKisuJaku, endingCountKisuKyo, endingCountGusuJaku, endingCountGusuKyo, endingCountHighJaku, endingCountHighKyo, endingCountExcept1, endingCountExcept2, endingCountExcept3, endingCountExcept4, endingCountOver3, endingCountOver4, endingCountOver5, endingCountOver6)
            }
        }
            @AppStorage("tokyoGhoulEndingCountGusuJaku") var endingCountGusuJaku: Int = 0 {
                didSet {
                    endingCountSum = countSum(endingCountKisuJaku, endingCountKisuKyo, endingCountGusuJaku, endingCountGusuKyo, endingCountHighJaku, endingCountHighKyo, endingCountExcept1, endingCountExcept2, endingCountExcept3, endingCountExcept4, endingCountOver3, endingCountOver4, endingCountOver5, endingCountOver6)
                }
            }
                @AppStorage("tokyoGhoulEndingCountGusuKyo") var endingCountGusuKyo: Int = 0 {
                    didSet {
                        endingCountSum = countSum(endingCountKisuJaku, endingCountKisuKyo, endingCountGusuJaku, endingCountGusuKyo, endingCountHighJaku, endingCountHighKyo, endingCountExcept1, endingCountExcept2, endingCountExcept3, endingCountExcept4, endingCountOver3, endingCountOver4, endingCountOver5, endingCountOver6)
                    }
                }
                    @AppStorage("tokyoGhoulEndingCountHighJaku") var endingCountHighJaku: Int = 0 {
                        didSet {
                            endingCountSum = countSum(endingCountKisuJaku, endingCountKisuKyo, endingCountGusuJaku, endingCountGusuKyo, endingCountHighJaku, endingCountHighKyo, endingCountExcept1, endingCountExcept2, endingCountExcept3, endingCountExcept4, endingCountOver3, endingCountOver4, endingCountOver5, endingCountOver6)
                        }
                    }
                        @AppStorage("tokyoGhoulEndingCountHighKyo") var endingCountHighKyo: Int = 0 {
                            didSet {
                                endingCountSum = countSum(endingCountKisuJaku, endingCountKisuKyo, endingCountGusuJaku, endingCountGusuKyo, endingCountHighJaku, endingCountHighKyo, endingCountExcept1, endingCountExcept2, endingCountExcept3, endingCountExcept4, endingCountOver3, endingCountOver4, endingCountOver5, endingCountOver6)
                            }
                        }
    @AppStorage("tokyoGhoulEndingCountSum") var endingCountSum: Int = 0
    
    func resetEnding() {
        endingCountKisuJaku = 0
        endingCountKisuKyo = 0
        endingCountGusuJaku = 0
        endingCountGusuKyo = 0
        endingCountHighJaku = 0
        endingCountHighKyo = 0
        minusCheck = false
        endingCountExcept1 = 0
        endingCountExcept2 = 0
        endingCountExcept3 = 0
        endingCountExcept4 = 0
        endingCountOver3 = 0
        endingCountOver4 = 0
        endingCountOver5 = 0
        endingCountOver6 = 0
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("tokyoGhoulMinusCheck") var minusCheck: Bool = false
    @AppStorage("tokyoGhoulSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetHistory()
        resetTsukiyama()
        resetScreen()
        resetEnding()
        resetSuperHigh()
    }
    
    // ///////////////////////
    // ver240追加
    // ///////////////////////
    @AppStorage("tokyoGhoulEndingCountExcept1") var endingCountExcept1: Int = 0 {
        didSet {
            endingCountSum = countSum(endingCountKisuJaku, endingCountKisuKyo, endingCountGusuJaku, endingCountGusuKyo, endingCountHighJaku, endingCountHighKyo, endingCountExcept1, endingCountExcept2, endingCountExcept3, endingCountExcept4, endingCountOver3, endingCountOver4, endingCountOver5, endingCountOver6)
        }
    }
        @AppStorage("tokyoGhoulEndingCountExcept2") var endingCountExcept2: Int = 0 {
            didSet {
                endingCountSum = countSum(endingCountKisuJaku, endingCountKisuKyo, endingCountGusuJaku, endingCountGusuKyo, endingCountHighJaku, endingCountHighKyo, endingCountExcept1, endingCountExcept2, endingCountExcept3, endingCountExcept4, endingCountOver3, endingCountOver4, endingCountOver5, endingCountOver6)
            }
        }
            @AppStorage("tokyoGhoulEndingCountExcept3") var endingCountExcept3: Int = 0 {
                didSet {
                    endingCountSum = countSum(endingCountKisuJaku, endingCountKisuKyo, endingCountGusuJaku, endingCountGusuKyo, endingCountHighJaku, endingCountHighKyo, endingCountExcept1, endingCountExcept2, endingCountExcept3, endingCountExcept4, endingCountOver3, endingCountOver4, endingCountOver5, endingCountOver6)
                }
            }
                @AppStorage("tokyoGhoulEndingCountExcept4") var endingCountExcept4: Int = 0 {
                    didSet {
                        endingCountSum = countSum(endingCountKisuJaku, endingCountKisuKyo, endingCountGusuJaku, endingCountGusuKyo, endingCountHighJaku, endingCountHighKyo, endingCountExcept1, endingCountExcept2, endingCountExcept3, endingCountExcept4, endingCountOver3, endingCountOver4, endingCountOver5, endingCountOver6)
                    }
                }
                    @AppStorage("tokyoGhoulEndingCountOver3") var endingCountOver3: Int = 0 {
                        didSet {
                            endingCountSum = countSum(endingCountKisuJaku, endingCountKisuKyo, endingCountGusuJaku, endingCountGusuKyo, endingCountHighJaku, endingCountHighKyo, endingCountExcept1, endingCountExcept2, endingCountExcept3, endingCountExcept4, endingCountOver3, endingCountOver4, endingCountOver5, endingCountOver6)
                        }
                    }
                        @AppStorage("tokyoGhoulEndingCountOver4") var endingCountOver4: Int = 0 {
                            didSet {
                                endingCountSum = countSum(endingCountKisuJaku, endingCountKisuKyo, endingCountGusuJaku, endingCountGusuKyo, endingCountHighJaku, endingCountHighKyo, endingCountExcept1, endingCountExcept2, endingCountExcept3, endingCountExcept4, endingCountOver3, endingCountOver4, endingCountOver5, endingCountOver6)
                            }
                        }
                            @AppStorage("tokyoGhoulEndingCountOver5") var endingCountOver5: Int = 0 {
                                didSet {
                                    endingCountSum = countSum(endingCountKisuJaku, endingCountKisuKyo, endingCountGusuJaku, endingCountGusuKyo, endingCountHighJaku, endingCountHighKyo, endingCountExcept1, endingCountExcept2, endingCountExcept3, endingCountExcept4, endingCountOver3, endingCountOver4, endingCountOver5, endingCountOver6)
                                }
                            }
                                @AppStorage("tokyoGhoulEndingCountOver6") var endingCountOver6: Int = 0 {
                                    didSet {
                                        endingCountSum = countSum(endingCountKisuJaku, endingCountKisuKyo, endingCountGusuJaku, endingCountGusuKyo, endingCountHighJaku, endingCountHighKyo, endingCountExcept1, endingCountExcept2, endingCountExcept3, endingCountExcept4, endingCountOver3, endingCountOver4, endingCountOver5, endingCountOver6)
                                    }
                                }
    // ///////////////////
    // ver2.5.0で追加
    // ///////////////////
    let ratioUraAt: [Double] = [
        1.1,
        1.32,
        1.63,
        2.19,
        2.85,
        3.32
    ]
    let ratioGedanReplay: [Double] = [
        1260.3,
        1213.6,
        1170.3,
        1129.0,
        1092.3,
        1024.0
    ]
    
    // ---------------
    // ver3.12.0で追加
    // ---------------
    let ratioSuperHighGame13: [Double] = [81.3,81.3,75,71.9,67.2,65.6]
    let ratioSuperHighGame23: [Double] = [15.6,15.6,18.8,18.8,21.9,21.9]
    let ratioSuperHighGame33: [Double] = [3.1,3.1,6.3,9.4,10.9,12.5]
    @AppStorage("tokyoGhoulSuperHighCountGame13") var superHighCountGame13: Int = 0
    @AppStorage("tokyoGhoulSuperHighCountGame23") var superHighCountGame23: Int = 0
    @AppStorage("tokyoGhoulSuperHighCountGame33") var superHighCountGame33: Int = 0
    @AppStorage("tokyoGhoulSuperHighCountSum") var superHighCountSum: Int = 0
    
    func superHighSumFunc() {
        superHighCountSum = countSum(
            superHighCountGame13,
            superHighCountGame23,
            superHighCountGame33,
        )
    }
    
    func resetSuperHigh() {
        superHighCountGame13 = 0
        superHighCountGame23 = 0
        superHighCountGame33 = 0
        superHighCountSum = 0
        minusCheck = false
    }
    
    // --------------
    // ver3.15.0で追加
    // --------------
    let ratioComeBack: [Double] = [7.8,7.8,9.4,10.9,12.5,15.2]
    @AppStorage("tokyoGhoulComeBackCountNone") var comeBackCountNone: Int = 0
    @AppStorage("tokyoGhoulComeBackCountHit") var comeBackCountHit: Int = 0
    @AppStorage("tokyoGhoulComeBackCountSum") var comeBackCountSum: Int = 0
    
    func comeBackSumFunc() {
        comeBackCountSum = countSum(
            comeBackCountNone,
            comeBackCountHit,
        )
    }
}

// //// メモリー1
class TokyoGhoulMemory1: ObservableObject {
    @AppStorage("tokyoGhoulTsukiyamaCountGusuMemory1") var tsukiyamaCountGusu: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountNot1Memory1") var tsukiyamaCountNot1: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountNot2Memory1") var tsukiyamaCountNot2: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountNot3Memory1") var tsukiyamaCountNot3: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountNot4Memory1") var tsukiyamaCountNot4: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountOver4Memory1") var tsukiyamaCountOver4: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountOver6Memory1") var tsukiyamaCountOver6: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountDefaultMemory1") var tsukiyamaCountDefault: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountRemainGameMemory1") var tsukiyamaCountRemainGame: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountSumMemory1") var tsukiyamaCountSum: Int = 0
    @AppStorage("tokyoGhoulInputGameMemory1") var inputGame: Int = 0
    @AppStorage("tokyoGhoulGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("tokyoGhoulKindArrayKeyMemory1") var kindArrayData: Data?
    @AppStorage("tokyoGhoulTriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("tokyoGhoulAtHitArrayKeyMemory1") var atHitArrayData: Data?
    @AppStorage("tokyoGhoulPlayGameSumMemory1") var playGameSum: Int = 0
    @AppStorage("tokyoGhoulCzCountReminiMemory1") var czCountRemini: Int = 0
    @AppStorage("tokyoGhoulCzCountRiseMemory1") var czCountRise: Int = 0
    @AppStorage("tokyoGhoulCzCountSumMemory1") var czCountSum: Int = 0
    @AppStorage("tokyoGhoulAtCountMemory1") var atCount: Int = 0
    @AppStorage("tokyoGhoulScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("tokyoGhoulScreenCountKisuMemory1") var screenCountKisu: Int = 0
    @AppStorage("tokyoGhoulScreenCountGusuMemory1") var screenCountGusu: Int = 0
    @AppStorage("tokyoGhoulScreenCountNot1Memory1") var screenCountNot1: Int = 0
    @AppStorage("tokyoGhoulScreenCountHighJakuMemory1") var screenCountHighJaku: Int = 0
    @AppStorage("tokyoGhoulScreenCountHighKyoMemory1") var screenCountHighKyo: Int = 0
    @AppStorage("tokyoGhoulScreenCountOver4Memory1") var screenCountOver4: Int = 0
    @AppStorage("tokyoGhoulScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("tokyoGhoulScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("tokyoGhoulMemoMemory1") var memo = ""
    @AppStorage("tokyoGhoulDateMemory1") var dateDouble = 0.0
    
    @AppStorage("tokyoGhoulCzCountEpisodeMemory1") var czCountEpisode: Int = 0
    @AppStorage("tokyoGhoulMorningModeEnableMemory1") var morningModeEnable: Bool = false
    @AppStorage("tokyoGhoulUnder100CountMemory1") var under100CountHit: Int = 0
    @AppStorage("tokyoGhoulFirstHitCountSumMemory1") var firstHitCountSum: Int = 0
    @AppStorage("tokyoGhoulEndingCountKisuJakuMemory1") var endingCountKisuJaku: Int = 0
    @AppStorage("tokyoGhoulEndingCountKisuKyoMemory1") var endingCountKisuKyo: Int = 0
    @AppStorage("tokyoGhoulEndingCountGusuJakuMemory1") var endingCountGusuJaku: Int = 0
    @AppStorage("tokyoGhoulEndingCountGusuKyoMemory1") var endingCountGusuKyo: Int = 0
    @AppStorage("tokyoGhoulEndingCountHighJakuMemory1") var endingCountHighJaku: Int = 0
    @AppStorage("tokyoGhoulEndingCountHighKyoMemory1") var endingCountHighKyo: Int = 0
    @AppStorage("tokyoGhoulEndingCountSumMemory1") var endingCountSum: Int = 0
    // ///////////////////////
    // ver240追加
    // ///////////////////////
    @AppStorage("tokyoGhoulEndingCountExcept1Memory1") var endingCountExcept1: Int = 0
    @AppStorage("tokyoGhoulEndingCountExcept2Memory1") var endingCountExcept2: Int = 0
    @AppStorage("tokyoGhoulEndingCountExcept3Memory1") var endingCountExcept3: Int = 0
    @AppStorage("tokyoGhoulEndingCountExcept4Memory1") var endingCountExcept4: Int = 0
    @AppStorage("tokyoGhoulEndingCountOver3Memory1") var endingCountOver3: Int = 0
    @AppStorage("tokyoGhoulEndingCountOver4Memory1") var endingCountOver4: Int = 0
    @AppStorage("tokyoGhoulEndingCountOver5Memory1") var endingCountOver5: Int = 0
    @AppStorage("tokyoGhoulEndingCountOver6Memory1") var endingCountOver6: Int = 0
    
    // ---------------
    // ver3.12.0で追加
    // ---------------
    @AppStorage("tokyoGhoulSuperHighCountGame13Memory1") var superHighCountGame13: Int = 0
    @AppStorage("tokyoGhoulSuperHighCountGame23Memory1") var superHighCountGame23: Int = 0
    @AppStorage("tokyoGhoulSuperHighCountGame33Memory1") var superHighCountGame33: Int = 0
    @AppStorage("tokyoGhoulSuperHighCountSumMemory1") var superHighCountSum: Int = 0
    
    // --------------
    // ver3.15.0で追加
    // --------------
    @AppStorage("tokyoGhoulComeBackCountNoneMemory1") var comeBackCountNone: Int = 0
    @AppStorage("tokyoGhoulComeBackCountHitMemory1") var comeBackCountHit: Int = 0
    @AppStorage("tokyoGhoulComeBackCountSumMemory1") var comeBackCountSum: Int = 0
}

// //// メモリー2
class TokyoGhoulMemory2: ObservableObject {
    @AppStorage("tokyoGhoulTsukiyamaCountGusuMemory2") var tsukiyamaCountGusu: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountNot1Memory2") var tsukiyamaCountNot1: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountNot2Memory2") var tsukiyamaCountNot2: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountNot3Memory2") var tsukiyamaCountNot3: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountNot4Memory2") var tsukiyamaCountNot4: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountOver4Memory2") var tsukiyamaCountOver4: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountOver6Memory2") var tsukiyamaCountOver6: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountDefaultMemory2") var tsukiyamaCountDefault: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountRemainGameMemory2") var tsukiyamaCountRemainGame: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountSumMemory2") var tsukiyamaCountSum: Int = 0
    @AppStorage("tokyoGhoulInputGameMemory2") var inputGame: Int = 0
    @AppStorage("tokyoGhoulGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("tokyoGhoulKindArrayKeyMemory2") var kindArrayData: Data?
    @AppStorage("tokyoGhoulTriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("tokyoGhoulAtHitArrayKeyMemory2") var atHitArrayData: Data?
    @AppStorage("tokyoGhoulPlayGameSumMemory2") var playGameSum: Int = 0
    @AppStorage("tokyoGhoulCzCountReminiMemory2") var czCountRemini: Int = 0
    @AppStorage("tokyoGhoulCzCountRiseMemory2") var czCountRise: Int = 0
    @AppStorage("tokyoGhoulCzCountSumMemory2") var czCountSum: Int = 0
    @AppStorage("tokyoGhoulAtCountMemory2") var atCount: Int = 0
    @AppStorage("tokyoGhoulScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("tokyoGhoulScreenCountKisuMemory2") var screenCountKisu: Int = 0
    @AppStorage("tokyoGhoulScreenCountGusuMemory2") var screenCountGusu: Int = 0
    @AppStorage("tokyoGhoulScreenCountNot1Memory2") var screenCountNot1: Int = 0
    @AppStorage("tokyoGhoulScreenCountHighJakuMemory2") var screenCountHighJaku: Int = 0
    @AppStorage("tokyoGhoulScreenCountHighKyoMemory2") var screenCountHighKyo: Int = 0
    @AppStorage("tokyoGhoulScreenCountOver4Memory2") var screenCountOver4: Int = 0
    @AppStorage("tokyoGhoulScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("tokyoGhoulScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("tokyoGhoulMemoMemory2") var memo = ""
    @AppStorage("tokyoGhoulDateMemory2") var dateDouble = 0.0
    
    @AppStorage("tokyoGhoulCzCountEpisodeMemory2") var czCountEpisode: Int = 0
    @AppStorage("tokyoGhoulMorningModeEnableMemory2") var morningModeEnable: Bool = false
    @AppStorage("tokyoGhoulUnder100CountMemory2") var under100CountHit: Int = 0
    @AppStorage("tokyoGhoulFirstHitCountSumMemory2") var firstHitCountSum: Int = 0
    @AppStorage("tokyoGhoulEndingCountKisuJakuMemory2") var endingCountKisuJaku: Int = 0
    @AppStorage("tokyoGhoulEndingCountKisuKyoMemory2") var endingCountKisuKyo: Int = 0
    @AppStorage("tokyoGhoulEndingCountGusuJakuMemory2") var endingCountGusuJaku: Int = 0
    @AppStorage("tokyoGhoulEndingCountGusuKyoMemory2") var endingCountGusuKyo: Int = 0
    @AppStorage("tokyoGhoulEndingCountHighJakuMemory2") var endingCountHighJaku: Int = 0
    @AppStorage("tokyoGhoulEndingCountHighKyoMemory2") var endingCountHighKyo: Int = 0
    @AppStorage("tokyoGhoulEndingCountSumMemory2") var endingCountSum: Int = 0
    // ///////////////////////
    // ver240追加
    // ///////////////////////
    @AppStorage("tokyoGhoulEndingCountExcept1Memory2") var endingCountExcept1: Int = 0
    @AppStorage("tokyoGhoulEndingCountExcept2Memory2") var endingCountExcept2: Int = 0
    @AppStorage("tokyoGhoulEndingCountExcept3Memory2") var endingCountExcept3: Int = 0
    @AppStorage("tokyoGhoulEndingCountExcept4Memory2") var endingCountExcept4: Int = 0
    @AppStorage("tokyoGhoulEndingCountOver3Memory2") var endingCountOver3: Int = 0
    @AppStorage("tokyoGhoulEndingCountOver4Memory2") var endingCountOver4: Int = 0
    @AppStorage("tokyoGhoulEndingCountOver5Memory2") var endingCountOver5: Int = 0
    @AppStorage("tokyoGhoulEndingCountOver6Memory2") var endingCountOver6: Int = 0
    
    // ---------------
    // ver3.12.0で追加
    // ---------------
    @AppStorage("tokyoGhoulSuperHighCountGame13Memory2") var superHighCountGame13: Int = 0
    @AppStorage("tokyoGhoulSuperHighCountGame23Memory2") var superHighCountGame23: Int = 0
    @AppStorage("tokyoGhoulSuperHighCountGame33Memory2") var superHighCountGame33: Int = 0
    @AppStorage("tokyoGhoulSuperHighCountSumMemory2") var superHighCountSum: Int = 0
    
    // --------------
    // ver3.15.0で追加
    // --------------
    @AppStorage("tokyoGhoulComeBackCountNoneMemory2") var comeBackCountNone: Int = 0
    @AppStorage("tokyoGhoulComeBackCountHitMemory2") var comeBackCountHit: Int = 0
    @AppStorage("tokyoGhoulComeBackCountSumMemory2") var comeBackCountSum: Int = 0
}

// //// メモリー3
class TokyoGhoulMemory3: ObservableObject {
    @AppStorage("tokyoGhoulTsukiyamaCountGusuMemory3") var tsukiyamaCountGusu: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountNot1Memory3") var tsukiyamaCountNot1: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountNot2Memory3") var tsukiyamaCountNot2: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountNot3Memory3") var tsukiyamaCountNot3: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountNot4Memory3") var tsukiyamaCountNot4: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountOver4Memory3") var tsukiyamaCountOver4: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountOver6Memory3") var tsukiyamaCountOver6: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountDefaultMemory3") var tsukiyamaCountDefault: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountRemainGameMemory3") var tsukiyamaCountRemainGame: Int = 0
    @AppStorage("tokyoGhoulTsukiyamaCountSumMemory3") var tsukiyamaCountSum: Int = 0
    @AppStorage("tokyoGhoulInputGameMemory3") var inputGame: Int = 0
    @AppStorage("tokyoGhoulGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("tokyoGhoulKindArrayKeyMemory3") var kindArrayData: Data?
    @AppStorage("tokyoGhoulTriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("tokyoGhoulAtHitArrayKeyMemory3") var atHitArrayData: Data?
    @AppStorage("tokyoGhoulPlayGameSumMemory3") var playGameSum: Int = 0
    @AppStorage("tokyoGhoulCzCountReminiMemory3") var czCountRemini: Int = 0
    @AppStorage("tokyoGhoulCzCountRiseMemory3") var czCountRise: Int = 0
    @AppStorage("tokyoGhoulCzCountSumMemory3") var czCountSum: Int = 0
    @AppStorage("tokyoGhoulAtCountMemory3") var atCount: Int = 0
    @AppStorage("tokyoGhoulScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("tokyoGhoulScreenCountKisuMemory3") var screenCountKisu: Int = 0
    @AppStorage("tokyoGhoulScreenCountGusuMemory3") var screenCountGusu: Int = 0
    @AppStorage("tokyoGhoulScreenCountNot1Memory3") var screenCountNot1: Int = 0
    @AppStorage("tokyoGhoulScreenCountHighJakuMemory3") var screenCountHighJaku: Int = 0
    @AppStorage("tokyoGhoulScreenCountHighKyoMemory3") var screenCountHighKyo: Int = 0
    @AppStorage("tokyoGhoulScreenCountOver4Memory3") var screenCountOver4: Int = 0
    @AppStorage("tokyoGhoulScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("tokyoGhoulScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("tokyoGhoulMemoMemory3") var memo = ""
    @AppStorage("tokyoGhoulDateMemory3") var dateDouble = 0.0
    
    @AppStorage("tokyoGhoulCzCountEpisodeMemory3") var czCountEpisode: Int = 0
    @AppStorage("tokyoGhoulMorningModeEnableMemory3") var morningModeEnable: Bool = false
    @AppStorage("tokyoGhoulUnder100CountMemory3") var under100CountHit: Int = 0
    @AppStorage("tokyoGhoulFirstHitCountSumMemory3") var firstHitCountSum: Int = 0
    @AppStorage("tokyoGhoulEndingCountKisuJakuMemory3") var endingCountKisuJaku: Int = 0
    @AppStorage("tokyoGhoulEndingCountKisuKyoMemory3") var endingCountKisuKyo: Int = 0
    @AppStorage("tokyoGhoulEndingCountGusuJakuMemory3") var endingCountGusuJaku: Int = 0
    @AppStorage("tokyoGhoulEndingCountGusuKyoMemory3") var endingCountGusuKyo: Int = 0
    @AppStorage("tokyoGhoulEndingCountHighJakuMemory3") var endingCountHighJaku: Int = 0
    @AppStorage("tokyoGhoulEndingCountHighKyoMemory3") var endingCountHighKyo: Int = 0
    @AppStorage("tokyoGhoulEndingCountSumMemory3") var endingCountSum: Int = 0
    // ///////////////////////
    // ver240追加
    // ///////////////////////
    @AppStorage("tokyoGhoulEndingCountExcept1Memory3") var endingCountExcept1: Int = 0
    @AppStorage("tokyoGhoulEndingCountExcept2Memory3") var endingCountExcept2: Int = 0
    @AppStorage("tokyoGhoulEndingCountExcept3Memory3") var endingCountExcept3: Int = 0
    @AppStorage("tokyoGhoulEndingCountExcept4Memory3") var endingCountExcept4: Int = 0
    @AppStorage("tokyoGhoulEndingCountOver3Memory3") var endingCountOver3: Int = 0
    @AppStorage("tokyoGhoulEndingCountOver4Memory3") var endingCountOver4: Int = 0
    @AppStorage("tokyoGhoulEndingCountOver5Memory3") var endingCountOver5: Int = 0
    @AppStorage("tokyoGhoulEndingCountOver6Memory3") var endingCountOver6: Int = 0
    
    // ---------------
    // ver3.12.0で追加
    // ---------------
    @AppStorage("tokyoGhoulSuperHighCountGame13Memory3") var superHighCountGame13: Int = 0
    @AppStorage("tokyoGhoulSuperHighCountGame23Memory3") var superHighCountGame23: Int = 0
    @AppStorage("tokyoGhoulSuperHighCountGame33Memory3") var superHighCountGame33: Int = 0
    @AppStorage("tokyoGhoulSuperHighCountSumMemory3") var superHighCountSum: Int = 0
    
    // --------------
    // ver3.15.0で追加
    // --------------
    @AppStorage("tokyoGhoulComeBackCountNoneMemory3") var comeBackCountNone: Int = 0
    @AppStorage("tokyoGhoulComeBackCountHitMemory3") var comeBackCountHit: Int = 0
    @AppStorage("tokyoGhoulComeBackCountSumMemory3") var comeBackCountSum: Int = 0
}
