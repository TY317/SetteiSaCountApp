//
//  dumbbellViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/02.
//

import SwiftUI

// ///////////////////////
// 変数
// ///////////////////////
class Dumbbell: ObservableObject {
    // ////////////////////////
    // 履歴
    // ////////////////////////
    // 選択肢の設定
    let selectListCalorie = [
        "1万台",
        "2万台",
        "3万台",
        "4万台",
        "5万台",
        "6万台",
        "7万台",
        "8万台",
        "9万台",
        "10万台"
    ]
    let selectListFirstHalf = [
        "突破",
        "失敗"
    ]
    let selectListSecondHalfAfterSuccess = [
        "成功",
        "失敗"
    ]
    let selectListSecondHalfAfterFailed = [
        "-"
    ]
    // 選択結果の設定
    @Published var inputGame = 0
    @Published var selectedCalorie: String = "5万台"
    @Published var selectedFirstHalf: String = "突破"
    @Published var selectedSecondHalfAfterSuccess: String = "成功"
    @Published var selectedSecondHalfAfterFailed: String = "-"
    @Published var selectedSecondHalf: String = "-"
    // //// 配列の設定
    // ゲーム数配列
    let gameArrayKey = "dumbbellGameArrayKey"
    @AppStorage("dumbbellGameArrayKey") var gameArrayData: Data?
    // カロリー配列
    let calorieArrayKey = "dumbbellcalorieArrayKey"
    @AppStorage("dumbbellcalorieArrayKey") var calorieArrayData: Data?
    // 前半結果配列
    let firstArrayKey = "dumbbellfirstArrayKey"
    @AppStorage("dumbbellfirstArrayKey") var firstArrayData: Data?
    // 後半結果配列
    let secondArrayKey = "dumbbellsecondArrayKey"
    @AppStorage("dumbbellsecondArrayKey") var secondArrayData: Data?
    // //// 結果集計用
    @AppStorage("dumbbellPlayGameSum") var playGameSum: Int = 0
    @AppStorage("dumbbellCzCount") var czCount: Int = 0
    @AppStorage("dumbbellCzFirstSuccessCount") var czFirstSuccessCount: Int = 0
    @AppStorage("dumbbellCzSecondSuccessCount") var czSecondSuccessCount: Int = 0 {
        didSet {
            bonusCountSum = countSum(czSecondSuccessCount + bonusCountWithoutCz)
        }
    }
        @AppStorage("dumbbellBonusCountWithoutCz") var bonusCountWithoutCz: Int = 0 {
            didSet {
                bonusCountSum = countSum(czSecondSuccessCount + bonusCountWithoutCz)
            }
        }
    @AppStorage("dumbbellBonusCountSum") var bonusCountSum: Int = 0
    
    // データ追加
    func addDataHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: calorieArrayData, addData: selectedCalorie, key: calorieArrayKey)
        arrayStringAddData(arrayData: firstArrayData, addData: selectedFirstHalf, key: firstArrayKey)
        arrayStringAddData(arrayData: secondArrayData, addData: selectedSecondHalf, key: secondArrayKey)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        czCount = arrayStringAllDataCount(arrayData: calorieArrayData)
        czFirstSuccessCount = arrayStringDataCount(arrayData: firstArrayData, countString: "突破")
        czSecondSuccessCount = arrayStringDataCount(arrayData: secondArrayData, countString: "成功")
        selectedCalorie = "5万台"
        selectedFirstHalf = "突破"
        selectedSecondHalfAfterSuccess = "成功"
        selectedSecondHalfAfterFailed = "-"
        selectedSecondHalf = "-"
    }
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: calorieArrayData, key: calorieArrayKey)
        arrayStringRemoveLast(arrayData: firstArrayData, key: firstArrayKey)
        arrayStringRemoveLast(arrayData: secondArrayData, key: secondArrayKey)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        czCount = arrayStringAllDataCount(arrayData: calorieArrayData)
        czFirstSuccessCount = arrayStringDataCount(arrayData: firstArrayData, countString: "突破")
        czSecondSuccessCount = arrayStringDataCount(arrayData: secondArrayData, countString: "成功")
        selectedCalorie = "5万台"
        selectedFirstHalf = "突破"
        selectedSecondHalfAfterSuccess = "成功"
        selectedSecondHalfAfterFailed = "-"
        selectedSecondHalf = "-"
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: calorieArrayData, key: calorieArrayKey)
        arrayStringRemoveAll(arrayData: firstArrayData, key: firstArrayKey)
        arrayStringRemoveAll(arrayData: secondArrayData, key: secondArrayKey)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        czCount = arrayStringAllDataCount(arrayData: calorieArrayData)
        czFirstSuccessCount = arrayStringDataCount(arrayData: firstArrayData, countString: "突破")
        czSecondSuccessCount = arrayStringDataCount(arrayData: secondArrayData, countString: "成功")
        bonusCountWithoutCz = 0
        selectedCalorie = "5万台"
        selectedFirstHalf = "突破"
        selectedSecondHalfAfterSuccess = "成功"
        selectedSecondHalfAfterFailed = "-"
        selectedSecondHalf = "-"
        minusCheck = false
    }
    
    // ////////////////////////
    // CZ・AT終了画面
    // ////////////////////////
    let czBonusScreenKeywordList: [String] = [
        "dumbbellCzBonusScreenHibiki",
        "dumbbellCzBonusScreenWhiteAkemi",
        "dumbbellCzBonusScreenWhiteSayaka",
        "dumbbellCzBonusScreenWhiteGina",
        "dumbbellCzBonusScreenWhiteSatomi",
        "dumbbellCzBonusScreenRed",
        "dumbbellCzBonusScreenPurple",
        "dumbbellCzBonusScreenSilverDress",
        "dumbbellCzBonusScreenSilverMizugi",
        "dumbbellCzBonusScreenGold",
        "dumbbellCzBonusScreenSauna",
        "dumbbellCzBonusScreenTrump"
    ]
    @AppStorage("dumbbellCzBonusScreenCurrentKeyword") var czBonusScreenCurrentKeyword: String = ""
    @AppStorage("dumbbellCzBonusScreenCountDefault") var czBonusScreenCountDefault = 0 {
        didSet {
            czBonusScreenCountSum = countSum(czBonusScreenCountDefault, czBonusScreenCountAny, czBonusScreenCountOver3Sisa, czBonusScreenCountHigh, czBonusScreenCountOverTokutei, czBonusScreenCountOver4, czBonusScreenCountOver4Kyo, czBonusScreenCountOver6, czBonusScreenCountMode, czBonusScreenCount1or6, czBonusScreenCountOver2Sisa, czBonusScreenCountKisuSisa, czBonusScreenCountGusuSisa)
        }
    }
    @AppStorage("dumbbellCzBonusScreenCountAny") var czBonusScreenCountAny = 0 {
        didSet {
            czBonusScreenCountSum = countSum(czBonusScreenCountDefault, czBonusScreenCountAny, czBonusScreenCountOver3Sisa, czBonusScreenCountHigh, czBonusScreenCountOverTokutei, czBonusScreenCountOver4, czBonusScreenCountOver4Kyo, czBonusScreenCountOver6, czBonusScreenCountMode, czBonusScreenCount1or6, czBonusScreenCountOver2Sisa, czBonusScreenCountKisuSisa, czBonusScreenCountGusuSisa)
        }
    }
        @AppStorage("dumbbellCzBonusScreenCountOver3Sisa") var czBonusScreenCountOver3Sisa = 0 {
            didSet {
                czBonusScreenCountSum = countSum(czBonusScreenCountDefault, czBonusScreenCountAny, czBonusScreenCountOver3Sisa, czBonusScreenCountHigh, czBonusScreenCountOverTokutei, czBonusScreenCountOver4, czBonusScreenCountOver4Kyo, czBonusScreenCountOver6, czBonusScreenCountMode, czBonusScreenCount1or6, czBonusScreenCountOver2Sisa, czBonusScreenCountKisuSisa, czBonusScreenCountGusuSisa)
            }
        }
            @AppStorage("dumbbellCzBonusScreenCountHighJaku") var czBonusScreenCountHigh = 0 {
                didSet {
                    czBonusScreenCountSum = countSum(czBonusScreenCountDefault, czBonusScreenCountAny, czBonusScreenCountOver3Sisa, czBonusScreenCountHigh, czBonusScreenCountOverTokutei, czBonusScreenCountOver4, czBonusScreenCountOver4Kyo, czBonusScreenCountOver6, czBonusScreenCountMode, czBonusScreenCount1or6, czBonusScreenCountOver2Sisa, czBonusScreenCountKisuSisa, czBonusScreenCountGusuSisa)
                }
            }
                @AppStorage("dumbbellCzBonusScreenCountOverTokutei") var czBonusScreenCountOverTokutei = 0 {
                    didSet {
                        czBonusScreenCountSum = countSum(czBonusScreenCountDefault, czBonusScreenCountAny, czBonusScreenCountOver3Sisa, czBonusScreenCountHigh, czBonusScreenCountOverTokutei, czBonusScreenCountOver4, czBonusScreenCountOver4Kyo, czBonusScreenCountOver6, czBonusScreenCountMode, czBonusScreenCount1or6, czBonusScreenCountOver2Sisa, czBonusScreenCountKisuSisa, czBonusScreenCountGusuSisa)
                    }
                }
                    @AppStorage("dumbbellCzBonusScreenCountOver4") var czBonusScreenCountOver4 = 0 {
                        didSet {
                            czBonusScreenCountSum = countSum(czBonusScreenCountDefault, czBonusScreenCountAny, czBonusScreenCountOver3Sisa, czBonusScreenCountHigh, czBonusScreenCountOverTokutei, czBonusScreenCountOver4, czBonusScreenCountOver4Kyo, czBonusScreenCountOver6, czBonusScreenCountMode, czBonusScreenCount1or6, czBonusScreenCountOver2Sisa, czBonusScreenCountKisuSisa, czBonusScreenCountGusuSisa)
                        }
                    }
                        @AppStorage("dumbbellCzBonusScreenCountOver4Kyo") var czBonusScreenCountOver4Kyo = 0 {
                            didSet {
                                czBonusScreenCountSum = countSum(czBonusScreenCountDefault, czBonusScreenCountAny, czBonusScreenCountOver3Sisa, czBonusScreenCountHigh, czBonusScreenCountOverTokutei, czBonusScreenCountOver4, czBonusScreenCountOver4Kyo, czBonusScreenCountOver6, czBonusScreenCountMode, czBonusScreenCount1or6, czBonusScreenCountOver2Sisa, czBonusScreenCountKisuSisa, czBonusScreenCountGusuSisa)
                            }
                        }
                            @AppStorage("dumbbellCzBonusScreenCountOver6") var czBonusScreenCountOver6 = 0 {
                                didSet {
                                    czBonusScreenCountSum = countSum(czBonusScreenCountDefault, czBonusScreenCountAny, czBonusScreenCountOver3Sisa, czBonusScreenCountHigh, czBonusScreenCountOverTokutei, czBonusScreenCountOver4, czBonusScreenCountOver4Kyo, czBonusScreenCountOver6, czBonusScreenCountMode, czBonusScreenCount1or6, czBonusScreenCountOver2Sisa, czBonusScreenCountKisuSisa, czBonusScreenCountGusuSisa)
                                }
                            }
                                @AppStorage("dumbbellCzBonusScreenCountMode") var czBonusScreenCountMode = 0 {
                                    didSet {
                                        czBonusScreenCountSum = countSum(czBonusScreenCountDefault, czBonusScreenCountAny, czBonusScreenCountOver3Sisa, czBonusScreenCountHigh, czBonusScreenCountOverTokutei, czBonusScreenCountOver4, czBonusScreenCountOver4Kyo, czBonusScreenCountOver6, czBonusScreenCountMode, czBonusScreenCount1or6, czBonusScreenCountOver2Sisa, czBonusScreenCountKisuSisa, czBonusScreenCountGusuSisa)
                                    }
                                }
                                    @AppStorage("dumbbellCzBonusScreenCount1or6") var czBonusScreenCount1or6 = 0 {
                                        didSet {
                                            czBonusScreenCountSum = countSum(czBonusScreenCountDefault, czBonusScreenCountAny, czBonusScreenCountOver3Sisa, czBonusScreenCountHigh, czBonusScreenCountOverTokutei, czBonusScreenCountOver4, czBonusScreenCountOver4Kyo, czBonusScreenCountOver6, czBonusScreenCountMode, czBonusScreenCount1or6, czBonusScreenCountOver2Sisa, czBonusScreenCountKisuSisa, czBonusScreenCountGusuSisa)
                                        }
                                    }
    @AppStorage("dumbbellCzBonusScreenCountOver2Sisa") var czBonusScreenCountOver2Sisa = 0 {
        didSet {
            czBonusScreenCountSum = countSum(czBonusScreenCountDefault, czBonusScreenCountAny, czBonusScreenCountOver3Sisa, czBonusScreenCountHigh, czBonusScreenCountOverTokutei, czBonusScreenCountOver4, czBonusScreenCountOver4Kyo, czBonusScreenCountOver6, czBonusScreenCountMode, czBonusScreenCount1or6, czBonusScreenCountOver2Sisa, czBonusScreenCountKisuSisa, czBonusScreenCountGusuSisa)
        }
    }
    @AppStorage("dumbbellCzBonusScreenCountGusuSisa") var czBonusScreenCountGusuSisa = 0 {
        didSet {
            czBonusScreenCountSum = countSum(czBonusScreenCountDefault, czBonusScreenCountAny, czBonusScreenCountOver3Sisa, czBonusScreenCountHigh, czBonusScreenCountOverTokutei, czBonusScreenCountOver4, czBonusScreenCountOver4Kyo, czBonusScreenCountOver6, czBonusScreenCountMode, czBonusScreenCount1or6, czBonusScreenCountOver2Sisa, czBonusScreenCountKisuSisa, czBonusScreenCountGusuSisa)
        }
    }
    @AppStorage("dumbbellCzBonusScreenCountKisuSisa") var czBonusScreenCountKisuSisa = 0 {
        didSet {
            czBonusScreenCountSum = countSum(czBonusScreenCountDefault, czBonusScreenCountAny, czBonusScreenCountOver3Sisa, czBonusScreenCountHigh, czBonusScreenCountOverTokutei, czBonusScreenCountOver4, czBonusScreenCountOver4Kyo, czBonusScreenCountOver6, czBonusScreenCountMode, czBonusScreenCount1or6, czBonusScreenCountOver2Sisa, czBonusScreenCountKisuSisa, czBonusScreenCountGusuSisa)
        }
    }
    @AppStorage("dumbbellCzBonusScreenCountSum") var czBonusScreenCountSum = 0
    
    func resetCzBonusScreen() {
        czBonusScreenCurrentKeyword = ""
        czBonusScreenCountDefault = 0
        czBonusScreenCountAny = 0
        czBonusScreenCountOver3Sisa = 0
        czBonusScreenCountHigh = 0
        czBonusScreenCountOverTokutei = 0
        czBonusScreenCountOver4 = 0
        czBonusScreenCountOver4Kyo = 0
        czBonusScreenCountOver6 = 0
        czBonusScreenCountMode = 0
        czBonusScreenCount1or6 = 0
        czBonusScreenCountOver2Sisa = 0
        czBonusScreenCountGusuSisa = 0
        czBonusScreenCountKisuSisa = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // ゴールデンチャレンジ
    // ////////////////////////
    @AppStorage("dumbbellGoldenChallengeCountSuccess") var goldenChallengeCountSuccess: Int = 0 {
        didSet {
            goldenChallengeCountSum = countSum(goldenChallengeCountSuccess, goldenChallengeCountFailed)
        }
    }
        @AppStorage("dumbbellGoldenChallengeCountFailed") var goldenChallengeCountFailed: Int = 0 {
            didSet {
                goldenChallengeCountSum = countSum(goldenChallengeCountSuccess, goldenChallengeCountFailed)
            }
        }
    @AppStorage("dumbbellGoldenChallengeCountSum") var goldenChallengeCountSum: Int = 0
    
    func resetGoldenChallenge() {
        goldenChallengeCountSuccess = 0
        goldenChallengeCountFailed = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 金肉ボーナス
    // ////////////////////////
    @AppStorage("dumbbellAinoteCount1Person") var ainoteCount1Person = 0 {
        didSet {
            ainoteCountSum = countSum(ainoteCount1Person, ainoteCount2Person, ainoteCount5Person)
        }
    }
        @AppStorage("dumbbellAinoteCount2Person") var ainoteCount2Person = 0 {
            didSet {
                ainoteCountSum = countSum(ainoteCount1Person, ainoteCount2Person, ainoteCount5Person)
            }
        }
            @AppStorage("dumbbellAinoteCount5Person") var ainoteCount5Person = 0 {
                didSet {
                    ainoteCountSum = countSum(ainoteCount1Person, ainoteCount2Person, ainoteCount5Person)
                }
            }
    @AppStorage("dumbbellAinoteCountSum") var ainoteCountSum = 0
    @AppStorage("dumbbellRupCountSuccess") var rupCountSuccess = 0 {
        didSet {
            rupCountSum = countSum(rupCountSuccess, rupCountFailed)
        }
    }
        @AppStorage("dumbbellRupCountFailed") var rupCountFailed = 0 {
            didSet {
                rupCountSum = countSum(rupCountSuccess, rupCountFailed)
            }
        }
    @AppStorage("dumbbellRupCountSum") var rupCountSum = 0
    
    let kinnikuScreenKeywordList = [
        "dumbbellKinnikuScreenSayakaAkemi",
        "dumbbellKinnikuScreenGinaSatomi",
        "dumbbellKinnikuScreenAll",
        "dumbbellKinnikuScreenHibiki",
        "dumbbellKinnikuScreenMachio"
    ]
    @AppStorage("dumbbellKinnikuScreenCurrentKeyword") var kinnikuScreenCurrentKeyword: String = ""
    @AppStorage("dumbbellKinnikuScreenCountDefault") var kinnikuScreenCountDefault = 0 {
        didSet {
            kinnikuScreenCountSum = countSum(kinnikuScreenCountDefault, kinnikuScreenCountHigh, kinnikuScreenCountHighKyo, kinnikuScreenCountGusu)
        }
    }
        @AppStorage("dumbbellKinnikuScreenCountHigh") var kinnikuScreenCountHigh = 0 {
            didSet {
                kinnikuScreenCountSum = countSum(kinnikuScreenCountDefault, kinnikuScreenCountHigh, kinnikuScreenCountHighKyo, kinnikuScreenCountGusu)
            }
        }
            @AppStorage("dumbbellKinnikuScreenCountHighKyo") var kinnikuScreenCountHighKyo = 0 {
                didSet {
                    kinnikuScreenCountSum = countSum(kinnikuScreenCountDefault, kinnikuScreenCountHigh, kinnikuScreenCountHighKyo, kinnikuScreenCountGusu)
                }
            }
    @AppStorage("dumbbellKinnikuScreenCountGusu") var kinnikuScreenCountGusu = 0 {
        didSet {
            kinnikuScreenCountSum = countSum(kinnikuScreenCountDefault, kinnikuScreenCountHigh, kinnikuScreenCountHighKyo, kinnikuScreenCountGusu)
        }
    }
    @AppStorage("dumbbellKinnikuScreenCountSum") var kinnikuScreenCountSum = 0
    
    func resetKinnikuBonus() {
        ainoteCount1Person = 0
        ainoteCount2Person = 0
        ainoteCount5Person = 0
        rupCountSuccess = 0
        rupCountFailed = 0
        kinnikuScreenCurrentKeyword = ""
        kinnikuScreenCountDefault = 0
        kinnikuScreenCountHigh = 0
        kinnikuScreenCountHighKyo = 0
        kinnikuScreenCountGusu = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("dumbbellMinusCheck") var minusCheck: Bool = false
    @AppStorage("dumbbellSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetHistory()
        resetGoldenChallenge()
        resetCzBonusScreen()
        resetKinnikuBonus()
    }
}


// //// メモリー1
class DumbbellMemory1: ObservableObject {
    @AppStorage("dumbbellGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("dumbbellcalorieArrayKeyMemory1") var calorieArrayData: Data?
    @AppStorage("dumbbellfirstArrayKeyMemory1") var firstArrayData: Data?
    @AppStorage("dumbbellsecondArrayKeyMemory1") var secondArrayData: Data?
    @AppStorage("dumbbellPlayGameSumMemory1") var playGameSum: Int = 0
    @AppStorage("dumbbellCzCountMemory1") var czCount: Int = 0
    @AppStorage("dumbbellCzFirstSuccessCountMemory1") var czFirstSuccessCount: Int = 0
    @AppStorage("dumbbellCzSecondSuccessCountMemory1") var czSecondSuccessCount: Int = 0
    @AppStorage("dumbbellBonusCountWithoutCzMemory1") var bonusCountWithoutCz: Int = 0
    @AppStorage("dumbbellBonusCountSumMemory1") var bonusCountSum: Int = 0
    @AppStorage("dumbbellCzBonusScreenCountDefaultMemory1") var czBonusScreenCountDefault = 0
    @AppStorage("dumbbellCzBonusScreenCountAnyMemory1") var czBonusScreenCountAny = 0
    @AppStorage("dumbbellCzBonusScreenCountOver3SisaMemory1") var czBonusScreenCountOver3Sisa = 0
    @AppStorage("dumbbellCzBonusScreenCountHighJakuMemory1") var czBonusScreenCountHigh = 0
    @AppStorage("dumbbellCzBonusScreenCountOverTokuteiMemory1") var czBonusScreenCountOverTokutei = 0
    @AppStorage("dumbbellCzBonusScreenCountOver4Memory1") var czBonusScreenCountOver4 = 0
    @AppStorage("dumbbellCzBonusScreenCountOver4KyoMemory1") var czBonusScreenCountOver4Kyo = 0
    @AppStorage("dumbbellCzBonusScreenCountOver6Memory1") var czBonusScreenCountOver6 = 0
    @AppStorage("dumbbellCzBonusScreenCountModeMemory1") var czBonusScreenCountMode = 0
    @AppStorage("dumbbellCzBonusScreenCount1or6Memory1") var czBonusScreenCount1or6 = 0
    @AppStorage("dumbbellCzBonusScreenCountSumMemory1") var czBonusScreenCountSum = 0
    @AppStorage("dumbbellGoldenChallengeCountSuccessMemory1") var goldenChallengeCountSuccess: Int = 0
    @AppStorage("dumbbellGoldenChallengeCountFailedMemory1") var goldenChallengeCountFailed: Int = 0
    @AppStorage("dumbbellGoldenChallengeCountSumMemory1") var goldenChallengeCountSum: Int = 0
    @AppStorage("dumbbellAinoteCount1PersonMemory1") var ainoteCount1Person = 0
    @AppStorage("dumbbellAinoteCount2PersonMemory1") var ainoteCount2Person = 0
    @AppStorage("dumbbellAinoteCount5PersonMemory1") var ainoteCount5Person = 0
    @AppStorage("dumbbellAinoteCountSumMemory1") var ainoteCountSum = 0
    @AppStorage("dumbbellRupCountSuccessMemory1") var rupCountSuccess = 0
    @AppStorage("dumbbellRupCountFailedMemory1") var rupCountFailed = 0
    @AppStorage("dumbbellRupCountSumMemory1") var rupCountSum = 0
    @AppStorage("dumbbellKinnikuScreenCountDefaultMemory1") var kinnikuScreenCountDefault = 0
    @AppStorage("dumbbellKinnikuScreenCountHighMemory1") var kinnikuScreenCountHigh = 0
    @AppStorage("dumbbellKinnikuScreenCountHighKyoMemory1") var kinnikuScreenCountHighKyo = 0
    @AppStorage("dumbbellKinnikuScreenCountSumMemory1") var kinnikuScreenCountSum = 0
    @AppStorage("dumbbellMemoMemory1") var memo = ""
    @AppStorage("dumbbellDateMemory1") var dateDouble = 0.0
    @AppStorage("dumbbellCzBonusScreenCountOver2SisaMemory1") var czBonusScreenCountOver2Sisa = 0
    @AppStorage("dumbbellCzBonusScreenCountGusuSisaMemory1") var czBonusScreenCountGusuSisa = 0
    @AppStorage("dumbbellCzBonusScreenCountKisuSisaMemory1") var czBonusScreenCountKisuSisa = 0
    @AppStorage("dumbbellKinnikuScreenCountGusuMemory1") var kinnikuScreenCountGusu = 0
}


// //// メモリー2
class DumbbellMemory2: ObservableObject {
    @AppStorage("dumbbellGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("dumbbellcalorieArrayKeyMemory2") var calorieArrayData: Data?
    @AppStorage("dumbbellfirstArrayKeyMemory2") var firstArrayData: Data?
    @AppStorage("dumbbellsecondArrayKeyMemory2") var secondArrayData: Data?
    @AppStorage("dumbbellPlayGameSumMemory2") var playGameSum: Int = 0
    @AppStorage("dumbbellCzCountMemory2") var czCount: Int = 0
    @AppStorage("dumbbellCzFirstSuccessCountMemory2") var czFirstSuccessCount: Int = 0
    @AppStorage("dumbbellCzSecondSuccessCountMemory2") var czSecondSuccessCount: Int = 0
    @AppStorage("dumbbellBonusCountWithoutCzMemory2") var bonusCountWithoutCz: Int = 0
    @AppStorage("dumbbellBonusCountSumMemory2") var bonusCountSum: Int = 0
    @AppStorage("dumbbellCzBonusScreenCountDefaultMemory2") var czBonusScreenCountDefault = 0
    @AppStorage("dumbbellCzBonusScreenCountAnyMemory2") var czBonusScreenCountAny = 0
    @AppStorage("dumbbellCzBonusScreenCountOver3SisaMemory2") var czBonusScreenCountOver3Sisa = 0
    @AppStorage("dumbbellCzBonusScreenCountHighJakuMemory2") var czBonusScreenCountHigh = 0
    @AppStorage("dumbbellCzBonusScreenCountOverTokuteiMemory2") var czBonusScreenCountOverTokutei = 0
    @AppStorage("dumbbellCzBonusScreenCountOver4Memory2") var czBonusScreenCountOver4 = 0
    @AppStorage("dumbbellCzBonusScreenCountOver4KyoMemory2") var czBonusScreenCountOver4Kyo = 0
    @AppStorage("dumbbellCzBonusScreenCountOver6Memory2") var czBonusScreenCountOver6 = 0
    @AppStorage("dumbbellCzBonusScreenCountModeMemory2") var czBonusScreenCountMode = 0
    @AppStorage("dumbbellCzBonusScreenCount1or6Memory2") var czBonusScreenCount1or6 = 0
    @AppStorage("dumbbellCzBonusScreenCountSumMemory2") var czBonusScreenCountSum = 0
    @AppStorage("dumbbellGoldenChallengeCountSuccessMemory2") var goldenChallengeCountSuccess: Int = 0
    @AppStorage("dumbbellGoldenChallengeCountFailedMemory2") var goldenChallengeCountFailed: Int = 0
    @AppStorage("dumbbellGoldenChallengeCountSumMemory2") var goldenChallengeCountSum: Int = 0
    @AppStorage("dumbbellAinoteCount1PersonMemory2") var ainoteCount1Person = 0
    @AppStorage("dumbbellAinoteCount2PersonMemory2") var ainoteCount2Person = 0
    @AppStorage("dumbbellAinoteCount5PersonMemory2") var ainoteCount5Person = 0
    @AppStorage("dumbbellAinoteCountSumMemory2") var ainoteCountSum = 0
    @AppStorage("dumbbellRupCountSuccessMemory2") var rupCountSuccess = 0
    @AppStorage("dumbbellRupCountFailedMemory2") var rupCountFailed = 0
    @AppStorage("dumbbellRupCountSumMemory2") var rupCountSum = 0
    @AppStorage("dumbbellKinnikuScreenCountDefaultMemory2") var kinnikuScreenCountDefault = 0
    @AppStorage("dumbbellKinnikuScreenCountHighMemory2") var kinnikuScreenCountHigh = 0
    @AppStorage("dumbbellKinnikuScreenCountHighKyoMemory2") var kinnikuScreenCountHighKyo = 0
    @AppStorage("dumbbellKinnikuScreenCountSumMemory2") var kinnikuScreenCountSum = 0
    @AppStorage("dumbbellMemoMemory2") var memo = ""
    @AppStorage("dumbbellDateMemory2") var dateDouble = 0.0
    @AppStorage("dumbbellCzBonusScreenCountOver2SisaMemory2") var czBonusScreenCountOver2Sisa = 0
    @AppStorage("dumbbellCzBonusScreenCountGusuSisaMemory2") var czBonusScreenCountGusuSisa = 0
    @AppStorage("dumbbellCzBonusScreenCountKisuSisaMemory2") var czBonusScreenCountKisuSisa = 0
    @AppStorage("dumbbellKinnikuScreenCountGusuMemory2") var kinnikuScreenCountGusu = 0
}


// //// メモリー3
class DumbbellMemory3: ObservableObject {
    @AppStorage("dumbbellGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("dumbbellcalorieArrayKeyMemory3") var calorieArrayData: Data?
    @AppStorage("dumbbellfirstArrayKeyMemory3") var firstArrayData: Data?
    @AppStorage("dumbbellsecondArrayKeyMemory3") var secondArrayData: Data?
    @AppStorage("dumbbellPlayGameSumMemory3") var playGameSum: Int = 0
    @AppStorage("dumbbellCzCountMemory3") var czCount: Int = 0
    @AppStorage("dumbbellCzFirstSuccessCountMemory3") var czFirstSuccessCount: Int = 0
    @AppStorage("dumbbellCzSecondSuccessCountMemory3") var czSecondSuccessCount: Int = 0
    @AppStorage("dumbbellBonusCountWithoutCzMemory3") var bonusCountWithoutCz: Int = 0
    @AppStorage("dumbbellBonusCountSumMemory3") var bonusCountSum: Int = 0
    @AppStorage("dumbbellCzBonusScreenCountDefaultMemory3") var czBonusScreenCountDefault = 0
    @AppStorage("dumbbellCzBonusScreenCountAnyMemory3") var czBonusScreenCountAny = 0
    @AppStorage("dumbbellCzBonusScreenCountOver3SisaMemory3") var czBonusScreenCountOver3Sisa = 0
    @AppStorage("dumbbellCzBonusScreenCountHighJakuMemory3") var czBonusScreenCountHigh = 0
    @AppStorage("dumbbellCzBonusScreenCountOverTokuteiMemory3") var czBonusScreenCountOverTokutei = 0
    @AppStorage("dumbbellCzBonusScreenCountOver4Memory3") var czBonusScreenCountOver4 = 0
    @AppStorage("dumbbellCzBonusScreenCountOver4KyoMemory3") var czBonusScreenCountOver4Kyo = 0
    @AppStorage("dumbbellCzBonusScreenCountOver6Memory3") var czBonusScreenCountOver6 = 0
    @AppStorage("dumbbellCzBonusScreenCountModeMemory3") var czBonusScreenCountMode = 0
    @AppStorage("dumbbellCzBonusScreenCount1or6Memory3") var czBonusScreenCount1or6 = 0
    @AppStorage("dumbbellCzBonusScreenCountSumMemory3") var czBonusScreenCountSum = 0
    @AppStorage("dumbbellGoldenChallengeCountSuccessMemory3") var goldenChallengeCountSuccess: Int = 0
    @AppStorage("dumbbellGoldenChallengeCountFailedMemory3") var goldenChallengeCountFailed: Int = 0
    @AppStorage("dumbbellGoldenChallengeCountSumMemory3") var goldenChallengeCountSum: Int = 0
    @AppStorage("dumbbellAinoteCount1PersonMemory3") var ainoteCount1Person = 0
    @AppStorage("dumbbellAinoteCount2PersonMemory3") var ainoteCount2Person = 0
    @AppStorage("dumbbellAinoteCount5PersonMemory3") var ainoteCount5Person = 0
    @AppStorage("dumbbellAinoteCountSumMemory3") var ainoteCountSum = 0
    @AppStorage("dumbbellRupCountSuccessMemory3") var rupCountSuccess = 0
    @AppStorage("dumbbellRupCountFailedMemory3") var rupCountFailed = 0
    @AppStorage("dumbbellRupCountSumMemory3") var rupCountSum = 0
    @AppStorage("dumbbellKinnikuScreenCountDefaultMemory3") var kinnikuScreenCountDefault = 0
    @AppStorage("dumbbellKinnikuScreenCountHighMemory3") var kinnikuScreenCountHigh = 0
    @AppStorage("dumbbellKinnikuScreenCountHighKyoMemory3") var kinnikuScreenCountHighKyo = 0
    @AppStorage("dumbbellKinnikuScreenCountSumMemory3") var kinnikuScreenCountSum = 0
    @AppStorage("dumbbellMemoMemory3") var memo = ""
    @AppStorage("dumbbellDateMemory3") var dateDouble = 0.0
    @AppStorage("dumbbellCzBonusScreenCountOver2SisaMemory3") var czBonusScreenCountOver2Sisa = 0
    @AppStorage("dumbbellCzBonusScreenCountGusuSisaMemory3") var czBonusScreenCountGusuSisa = 0
    @AppStorage("dumbbellCzBonusScreenCountKisuSisaMemory3") var czBonusScreenCountKisuSisa = 0
    @AppStorage("dumbbellKinnikuScreenCountGusuMemory3") var kinnikuScreenCountGusu = 0
}


struct dumbbellViewTop: View {
    @ObservedObject var dumbbell = Dumbbell()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // チートデイ
                    NavigationLink(destination: dumbbellViewCheatDay()) {
                        unitLabelMenu(
                            imageSystemName: "dumbbell.fill",
                            textBody: "チートデイ")
                    }
                    // 初当り履歴
                    NavigationLink(destination: dumbbellViewHistory()) {
                        unitLabelMenu(
                            imageSystemName: "dumbbell",
                            textBody: "CZ,ボーナス初当り履歴"
                        )
                    }
                    // CZ・AT終了画面
                    NavigationLink(destination: dumbbellCzAtScreen()) {
                        unitLabelMenu(
                            imageSystemName: "dumbbell.fill",
                            textBody: "CZ,ボーナス終了画面"
                        )
                    }
//                    .popoverTip(tipVer200DumbbellUpdateInfo())
                    // ゴールデンチャレンジ
                    NavigationLink(destination: dumbbellViewGoldenChallenge()) {
                        unitLabelMenu(
                            imageSystemName: "dumbbell",
                            textBody: "ゴールデンチャレンジ"
                        )
                    }
                    // 金肉ボーナス
                    NavigationLink(destination: dumbbellViewKinnikuBonus()) {
                        unitLabelMenu(
                            imageSystemName: "dumbbell.fill",
                            textBody: "金肉ボーナス"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "ダンベル何キロ持てる？")
                }
                // 設定推測グラフ
                NavigationLink(destination: dumbbellView95Ci(selection: 2)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(dumbbellSubViewLoadMemory()))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(dumbbellSubViewSaveMemory()))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: dumbbell.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct dumbbellSubViewSaveMemory: View {
    @ObservedObject var dumbbell = Dumbbell()
    @ObservedObject var dumbbellMemory1 = DumbbellMemory1()
    @ObservedObject var dumbbellMemory2 = DumbbellMemory2()
    @ObservedObject var dumbbellMemory3 = DumbbellMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ダンベル何キロ持てる？",
            selectedMemory: $dumbbell.selectedMemory,
            memoMemory1: $dumbbellMemory1.memo,
            dateDoubleMemory1: $dumbbellMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $dumbbellMemory2.memo,
            dateDoubleMemory2: $dumbbellMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $dumbbellMemory3.memo,
            dateDoubleMemory3: $dumbbellMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        dumbbellMemory1.gameArrayData = dumbbell.gameArrayData
        dumbbellMemory1.calorieArrayData = dumbbell.calorieArrayData
        dumbbellMemory1.firstArrayData = dumbbell.firstArrayData
        dumbbellMemory1.secondArrayData = dumbbell.secondArrayData
        dumbbellMemory1.playGameSum = dumbbell.playGameSum
        dumbbellMemory1.czCount = dumbbell.czCount
        dumbbellMemory1.czFirstSuccessCount = dumbbell.czFirstSuccessCount
        dumbbellMemory1.czSecondSuccessCount = dumbbell.czSecondSuccessCount
        dumbbellMemory1.bonusCountWithoutCz = dumbbell.bonusCountWithoutCz
        dumbbellMemory1.bonusCountSum = dumbbell.bonusCountSum
        dumbbellMemory1.czBonusScreenCountDefault = dumbbell.czBonusScreenCountDefault
        dumbbellMemory1.czBonusScreenCountAny = dumbbell.czBonusScreenCountAny
        dumbbellMemory1.czBonusScreenCountOver3Sisa = dumbbell.czBonusScreenCountOver3Sisa
        dumbbellMemory1.czBonusScreenCountHigh = dumbbell.czBonusScreenCountHigh
        dumbbellMemory1.czBonusScreenCountOverTokutei = dumbbell.czBonusScreenCountOverTokutei
        dumbbellMemory1.czBonusScreenCountOver4 = dumbbell.czBonusScreenCountOver4
        dumbbellMemory1.czBonusScreenCountOver4Kyo = dumbbell.czBonusScreenCountOver4Kyo
        dumbbellMemory1.czBonusScreenCountOver6 = dumbbell.czBonusScreenCountOver6
        dumbbellMemory1.czBonusScreenCountMode = dumbbell.czBonusScreenCountMode
        dumbbellMemory1.czBonusScreenCount1or6 = dumbbell.czBonusScreenCount1or6
        dumbbellMemory1.czBonusScreenCountSum = dumbbell.czBonusScreenCountSum
        dumbbellMemory1.goldenChallengeCountSuccess = dumbbell.goldenChallengeCountSuccess
        dumbbellMemory1.goldenChallengeCountFailed = dumbbell.goldenChallengeCountFailed
        dumbbellMemory1.goldenChallengeCountSum = dumbbell.goldenChallengeCountSum
        dumbbellMemory1.ainoteCount1Person = dumbbell.ainoteCount1Person
        dumbbellMemory1.ainoteCount2Person = dumbbell.ainoteCount2Person
        dumbbellMemory1.ainoteCount5Person = dumbbell.ainoteCount5Person
        dumbbellMemory1.ainoteCountSum = dumbbell.ainoteCountSum
        dumbbellMemory1.rupCountSuccess = dumbbell.rupCountSuccess
        dumbbellMemory1.rupCountFailed = dumbbell.rupCountFailed
        dumbbellMemory1.rupCountSum = dumbbell.rupCountSum
        dumbbellMemory1.kinnikuScreenCountDefault = dumbbell.kinnikuScreenCountDefault
        dumbbellMemory1.kinnikuScreenCountHigh = dumbbell.kinnikuScreenCountHigh
        dumbbellMemory1.kinnikuScreenCountHighKyo = dumbbell.kinnikuScreenCountHighKyo
        dumbbellMemory1.kinnikuScreenCountSum = dumbbell.kinnikuScreenCountSum
        dumbbellMemory1.czBonusScreenCountOver2Sisa = dumbbell.czBonusScreenCountOver2Sisa
        dumbbellMemory1.czBonusScreenCountGusuSisa = dumbbell.czBonusScreenCountGusuSisa
        dumbbellMemory1.czBonusScreenCountKisuSisa = dumbbell.czBonusScreenCountKisuSisa
        dumbbellMemory1.kinnikuScreenCountGusu = dumbbell.kinnikuScreenCountGusu
    }
    func saveMemory2() {
        dumbbellMemory2.gameArrayData = dumbbell.gameArrayData
        dumbbellMemory2.calorieArrayData = dumbbell.calorieArrayData
        dumbbellMemory2.firstArrayData = dumbbell.firstArrayData
        dumbbellMemory2.secondArrayData = dumbbell.secondArrayData
        dumbbellMemory2.playGameSum = dumbbell.playGameSum
        dumbbellMemory2.czCount = dumbbell.czCount
        dumbbellMemory2.czFirstSuccessCount = dumbbell.czFirstSuccessCount
        dumbbellMemory2.czSecondSuccessCount = dumbbell.czSecondSuccessCount
        dumbbellMemory2.bonusCountWithoutCz = dumbbell.bonusCountWithoutCz
        dumbbellMemory2.bonusCountSum = dumbbell.bonusCountSum
        dumbbellMemory2.czBonusScreenCountDefault = dumbbell.czBonusScreenCountDefault
        dumbbellMemory2.czBonusScreenCountAny = dumbbell.czBonusScreenCountAny
        dumbbellMemory2.czBonusScreenCountOver3Sisa = dumbbell.czBonusScreenCountOver3Sisa
        dumbbellMemory2.czBonusScreenCountHigh = dumbbell.czBonusScreenCountHigh
        dumbbellMemory2.czBonusScreenCountOverTokutei = dumbbell.czBonusScreenCountOverTokutei
        dumbbellMemory2.czBonusScreenCountOver4 = dumbbell.czBonusScreenCountOver4
        dumbbellMemory2.czBonusScreenCountOver4Kyo = dumbbell.czBonusScreenCountOver4Kyo
        dumbbellMemory2.czBonusScreenCountOver6 = dumbbell.czBonusScreenCountOver6
        dumbbellMemory2.czBonusScreenCountMode = dumbbell.czBonusScreenCountMode
        dumbbellMemory2.czBonusScreenCount1or6 = dumbbell.czBonusScreenCount1or6
        dumbbellMemory2.czBonusScreenCountSum = dumbbell.czBonusScreenCountSum
        dumbbellMemory2.goldenChallengeCountSuccess = dumbbell.goldenChallengeCountSuccess
        dumbbellMemory2.goldenChallengeCountFailed = dumbbell.goldenChallengeCountFailed
        dumbbellMemory2.goldenChallengeCountSum = dumbbell.goldenChallengeCountSum
        dumbbellMemory2.ainoteCount1Person = dumbbell.ainoteCount1Person
        dumbbellMemory2.ainoteCount2Person = dumbbell.ainoteCount2Person
        dumbbellMemory2.ainoteCount5Person = dumbbell.ainoteCount5Person
        dumbbellMemory2.ainoteCountSum = dumbbell.ainoteCountSum
        dumbbellMemory2.rupCountSuccess = dumbbell.rupCountSuccess
        dumbbellMemory2.rupCountFailed = dumbbell.rupCountFailed
        dumbbellMemory2.rupCountSum = dumbbell.rupCountSum
        dumbbellMemory2.kinnikuScreenCountDefault = dumbbell.kinnikuScreenCountDefault
        dumbbellMemory2.kinnikuScreenCountHigh = dumbbell.kinnikuScreenCountHigh
        dumbbellMemory2.kinnikuScreenCountHighKyo = dumbbell.kinnikuScreenCountHighKyo
        dumbbellMemory2.kinnikuScreenCountSum = dumbbell.kinnikuScreenCountSum
        dumbbellMemory2.czBonusScreenCountOver2Sisa = dumbbell.czBonusScreenCountOver2Sisa
        dumbbellMemory2.czBonusScreenCountGusuSisa = dumbbell.czBonusScreenCountGusuSisa
        dumbbellMemory2.czBonusScreenCountKisuSisa = dumbbell.czBonusScreenCountKisuSisa
        dumbbellMemory2.kinnikuScreenCountGusu = dumbbell.kinnikuScreenCountGusu
    }
    func saveMemory3() {
        dumbbellMemory3.gameArrayData = dumbbell.gameArrayData
        dumbbellMemory3.calorieArrayData = dumbbell.calorieArrayData
        dumbbellMemory3.firstArrayData = dumbbell.firstArrayData
        dumbbellMemory3.secondArrayData = dumbbell.secondArrayData
        dumbbellMemory3.playGameSum = dumbbell.playGameSum
        dumbbellMemory3.czCount = dumbbell.czCount
        dumbbellMemory3.czFirstSuccessCount = dumbbell.czFirstSuccessCount
        dumbbellMemory3.czSecondSuccessCount = dumbbell.czSecondSuccessCount
        dumbbellMemory3.bonusCountWithoutCz = dumbbell.bonusCountWithoutCz
        dumbbellMemory3.bonusCountSum = dumbbell.bonusCountSum
        dumbbellMemory3.czBonusScreenCountDefault = dumbbell.czBonusScreenCountDefault
        dumbbellMemory3.czBonusScreenCountAny = dumbbell.czBonusScreenCountAny
        dumbbellMemory3.czBonusScreenCountOver3Sisa = dumbbell.czBonusScreenCountOver3Sisa
        dumbbellMemory3.czBonusScreenCountHigh = dumbbell.czBonusScreenCountHigh
        dumbbellMemory3.czBonusScreenCountOverTokutei = dumbbell.czBonusScreenCountOverTokutei
        dumbbellMemory3.czBonusScreenCountOver4 = dumbbell.czBonusScreenCountOver4
        dumbbellMemory3.czBonusScreenCountOver4Kyo = dumbbell.czBonusScreenCountOver4Kyo
        dumbbellMemory3.czBonusScreenCountOver6 = dumbbell.czBonusScreenCountOver6
        dumbbellMemory3.czBonusScreenCountMode = dumbbell.czBonusScreenCountMode
        dumbbellMemory3.czBonusScreenCount1or6 = dumbbell.czBonusScreenCount1or6
        dumbbellMemory3.czBonusScreenCountSum = dumbbell.czBonusScreenCountSum
        dumbbellMemory3.goldenChallengeCountSuccess = dumbbell.goldenChallengeCountSuccess
        dumbbellMemory3.goldenChallengeCountFailed = dumbbell.goldenChallengeCountFailed
        dumbbellMemory3.goldenChallengeCountSum = dumbbell.goldenChallengeCountSum
        dumbbellMemory3.ainoteCount1Person = dumbbell.ainoteCount1Person
        dumbbellMemory3.ainoteCount2Person = dumbbell.ainoteCount2Person
        dumbbellMemory3.ainoteCount5Person = dumbbell.ainoteCount5Person
        dumbbellMemory3.ainoteCountSum = dumbbell.ainoteCountSum
        dumbbellMemory3.rupCountSuccess = dumbbell.rupCountSuccess
        dumbbellMemory3.rupCountFailed = dumbbell.rupCountFailed
        dumbbellMemory3.rupCountSum = dumbbell.rupCountSum
        dumbbellMemory3.kinnikuScreenCountDefault = dumbbell.kinnikuScreenCountDefault
        dumbbellMemory3.kinnikuScreenCountHigh = dumbbell.kinnikuScreenCountHigh
        dumbbellMemory3.kinnikuScreenCountHighKyo = dumbbell.kinnikuScreenCountHighKyo
        dumbbellMemory3.kinnikuScreenCountSum = dumbbell.kinnikuScreenCountSum
        dumbbellMemory3.czBonusScreenCountOver2Sisa = dumbbell.czBonusScreenCountOver2Sisa
        dumbbellMemory3.czBonusScreenCountGusuSisa = dumbbell.czBonusScreenCountGusuSisa
        dumbbellMemory3.czBonusScreenCountKisuSisa = dumbbell.czBonusScreenCountKisuSisa
        dumbbellMemory3.kinnikuScreenCountGusu = dumbbell.kinnikuScreenCountGusu
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct dumbbellSubViewLoadMemory: View {
    @ObservedObject var dumbbell = Dumbbell()
    @ObservedObject var dumbbellMemory1 = DumbbellMemory1()
    @ObservedObject var dumbbellMemory2 = DumbbellMemory2()
    @ObservedObject var dumbbellMemory3 = DumbbellMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ダンベル何キロ持てる？",
            selectedMemory: $dumbbell.selectedMemory,
            memoMemory1: dumbbellMemory1.memo,
            dateDoubleMemory1: dumbbellMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: dumbbellMemory2.memo,
            dateDoubleMemory2: dumbbellMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: dumbbellMemory3.memo,
            dateDoubleMemory3: dumbbellMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        dumbbell.gameArrayData = dumbbellMemory1.gameArrayData
        dumbbell.calorieArrayData = dumbbellMemory1.calorieArrayData
        dumbbell.firstArrayData = dumbbellMemory1.firstArrayData
        dumbbell.secondArrayData = dumbbellMemory1.secondArrayData
        dumbbell.playGameSum = dumbbellMemory1.playGameSum
        dumbbell.czCount = dumbbellMemory1.czCount
        dumbbell.czFirstSuccessCount = dumbbellMemory1.czFirstSuccessCount
        dumbbell.czSecondSuccessCount = dumbbellMemory1.czSecondSuccessCount
        dumbbell.bonusCountWithoutCz = dumbbellMemory1.bonusCountWithoutCz
        dumbbell.bonusCountSum = dumbbellMemory1.bonusCountSum
        dumbbell.czBonusScreenCountDefault = dumbbellMemory1.czBonusScreenCountDefault
        dumbbell.czBonusScreenCountAny = dumbbellMemory1.czBonusScreenCountAny
        dumbbell.czBonusScreenCountOver3Sisa = dumbbellMemory1.czBonusScreenCountOver3Sisa
        dumbbell.czBonusScreenCountHigh = dumbbellMemory1.czBonusScreenCountHigh
        dumbbell.czBonusScreenCountOverTokutei = dumbbellMemory1.czBonusScreenCountOverTokutei
        dumbbell.czBonusScreenCountOver4 = dumbbellMemory1.czBonusScreenCountOver4
        dumbbell.czBonusScreenCountOver4Kyo = dumbbellMemory1.czBonusScreenCountOver4Kyo
        dumbbell.czBonusScreenCountOver6 = dumbbellMemory1.czBonusScreenCountOver6
        dumbbell.czBonusScreenCountMode = dumbbellMemory1.czBonusScreenCountMode
        dumbbell.czBonusScreenCount1or6 = dumbbellMemory1.czBonusScreenCount1or6
        dumbbell.czBonusScreenCountSum = dumbbellMemory1.czBonusScreenCountSum
        dumbbell.goldenChallengeCountSuccess = dumbbellMemory1.goldenChallengeCountSuccess
        dumbbell.goldenChallengeCountFailed = dumbbellMemory1.goldenChallengeCountFailed
        dumbbell.goldenChallengeCountSum = dumbbellMemory1.goldenChallengeCountSum
        dumbbell.ainoteCount1Person = dumbbellMemory1.ainoteCount1Person
        dumbbell.ainoteCount2Person = dumbbellMemory1.ainoteCount2Person
        dumbbell.ainoteCount5Person = dumbbellMemory1.ainoteCount5Person
        dumbbell.ainoteCountSum = dumbbellMemory1.ainoteCountSum
        dumbbell.rupCountSuccess = dumbbellMemory1.rupCountSuccess
        dumbbell.rupCountFailed = dumbbellMemory1.rupCountFailed
        dumbbell.rupCountSum = dumbbellMemory1.rupCountSum
        dumbbell.kinnikuScreenCountDefault = dumbbellMemory1.kinnikuScreenCountDefault
        dumbbell.kinnikuScreenCountHigh = dumbbellMemory1.kinnikuScreenCountHigh
        dumbbell.kinnikuScreenCountHighKyo = dumbbellMemory1.kinnikuScreenCountHighKyo
        dumbbell.kinnikuScreenCountSum = dumbbellMemory1.kinnikuScreenCountSum
        dumbbell.czBonusScreenCountOver2Sisa = dumbbellMemory1.czBonusScreenCountOver2Sisa
        dumbbell.czBonusScreenCountGusuSisa = dumbbellMemory1.czBonusScreenCountGusuSisa
        dumbbell.czBonusScreenCountKisuSisa = dumbbellMemory1.czBonusScreenCountKisuSisa
        dumbbell.kinnikuScreenCountGusu = dumbbellMemory1.kinnikuScreenCountGusu
    }
    func loadMemory2() {
        dumbbell.gameArrayData = dumbbellMemory2.gameArrayData
        dumbbell.calorieArrayData = dumbbellMemory2.calorieArrayData
        dumbbell.firstArrayData = dumbbellMemory2.firstArrayData
        dumbbell.secondArrayData = dumbbellMemory2.secondArrayData
        dumbbell.playGameSum = dumbbellMemory2.playGameSum
        dumbbell.czCount = dumbbellMemory2.czCount
        dumbbell.czFirstSuccessCount = dumbbellMemory2.czFirstSuccessCount
        dumbbell.czSecondSuccessCount = dumbbellMemory2.czSecondSuccessCount
        dumbbell.bonusCountWithoutCz = dumbbellMemory2.bonusCountWithoutCz
        dumbbell.bonusCountSum = dumbbellMemory2.bonusCountSum
        dumbbell.czBonusScreenCountDefault = dumbbellMemory2.czBonusScreenCountDefault
        dumbbell.czBonusScreenCountAny = dumbbellMemory2.czBonusScreenCountAny
        dumbbell.czBonusScreenCountOver3Sisa = dumbbellMemory2.czBonusScreenCountOver3Sisa
        dumbbell.czBonusScreenCountHigh = dumbbellMemory2.czBonusScreenCountHigh
        dumbbell.czBonusScreenCountOverTokutei = dumbbellMemory2.czBonusScreenCountOverTokutei
        dumbbell.czBonusScreenCountOver4 = dumbbellMemory2.czBonusScreenCountOver4
        dumbbell.czBonusScreenCountOver4Kyo = dumbbellMemory2.czBonusScreenCountOver4Kyo
        dumbbell.czBonusScreenCountOver6 = dumbbellMemory2.czBonusScreenCountOver6
        dumbbell.czBonusScreenCountMode = dumbbellMemory2.czBonusScreenCountMode
        dumbbell.czBonusScreenCount1or6 = dumbbellMemory2.czBonusScreenCount1or6
        dumbbell.czBonusScreenCountSum = dumbbellMemory2.czBonusScreenCountSum
        dumbbell.goldenChallengeCountSuccess = dumbbellMemory2.goldenChallengeCountSuccess
        dumbbell.goldenChallengeCountFailed = dumbbellMemory2.goldenChallengeCountFailed
        dumbbell.goldenChallengeCountSum = dumbbellMemory2.goldenChallengeCountSum
        dumbbell.ainoteCount1Person = dumbbellMemory2.ainoteCount1Person
        dumbbell.ainoteCount2Person = dumbbellMemory2.ainoteCount2Person
        dumbbell.ainoteCount5Person = dumbbellMemory2.ainoteCount5Person
        dumbbell.ainoteCountSum = dumbbellMemory2.ainoteCountSum
        dumbbell.rupCountSuccess = dumbbellMemory2.rupCountSuccess
        dumbbell.rupCountFailed = dumbbellMemory2.rupCountFailed
        dumbbell.rupCountSum = dumbbellMemory2.rupCountSum
        dumbbell.kinnikuScreenCountDefault = dumbbellMemory2.kinnikuScreenCountDefault
        dumbbell.kinnikuScreenCountHigh = dumbbellMemory2.kinnikuScreenCountHigh
        dumbbell.kinnikuScreenCountHighKyo = dumbbellMemory2.kinnikuScreenCountHighKyo
        dumbbell.kinnikuScreenCountSum = dumbbellMemory2.kinnikuScreenCountSum
        dumbbell.czBonusScreenCountOver2Sisa = dumbbellMemory2.czBonusScreenCountOver2Sisa
        dumbbell.czBonusScreenCountGusuSisa = dumbbellMemory2.czBonusScreenCountGusuSisa
        dumbbell.czBonusScreenCountKisuSisa = dumbbellMemory2.czBonusScreenCountKisuSisa
        dumbbell.kinnikuScreenCountGusu = dumbbellMemory2.kinnikuScreenCountGusu
    }
    func loadMemory3() {
        dumbbell.gameArrayData = dumbbellMemory3.gameArrayData
        dumbbell.calorieArrayData = dumbbellMemory3.calorieArrayData
        dumbbell.firstArrayData = dumbbellMemory3.firstArrayData
        dumbbell.secondArrayData = dumbbellMemory3.secondArrayData
        dumbbell.playGameSum = dumbbellMemory3.playGameSum
        dumbbell.czCount = dumbbellMemory3.czCount
        dumbbell.czFirstSuccessCount = dumbbellMemory3.czFirstSuccessCount
        dumbbell.czSecondSuccessCount = dumbbellMemory3.czSecondSuccessCount
        dumbbell.bonusCountWithoutCz = dumbbellMemory3.bonusCountWithoutCz
        dumbbell.bonusCountSum = dumbbellMemory3.bonusCountSum
        dumbbell.czBonusScreenCountDefault = dumbbellMemory3.czBonusScreenCountDefault
        dumbbell.czBonusScreenCountAny = dumbbellMemory3.czBonusScreenCountAny
        dumbbell.czBonusScreenCountOver3Sisa = dumbbellMemory3.czBonusScreenCountOver3Sisa
        dumbbell.czBonusScreenCountHigh = dumbbellMemory3.czBonusScreenCountHigh
        dumbbell.czBonusScreenCountOverTokutei = dumbbellMemory3.czBonusScreenCountOverTokutei
        dumbbell.czBonusScreenCountOver4 = dumbbellMemory3.czBonusScreenCountOver4
        dumbbell.czBonusScreenCountOver4Kyo = dumbbellMemory3.czBonusScreenCountOver4Kyo
        dumbbell.czBonusScreenCountOver6 = dumbbellMemory3.czBonusScreenCountOver6
        dumbbell.czBonusScreenCountMode = dumbbellMemory3.czBonusScreenCountMode
        dumbbell.czBonusScreenCount1or6 = dumbbellMemory3.czBonusScreenCount1or6
        dumbbell.czBonusScreenCountSum = dumbbellMemory3.czBonusScreenCountSum
        dumbbell.goldenChallengeCountSuccess = dumbbellMemory3.goldenChallengeCountSuccess
        dumbbell.goldenChallengeCountFailed = dumbbellMemory3.goldenChallengeCountFailed
        dumbbell.goldenChallengeCountSum = dumbbellMemory3.goldenChallengeCountSum
        dumbbell.ainoteCount1Person = dumbbellMemory3.ainoteCount1Person
        dumbbell.ainoteCount2Person = dumbbellMemory3.ainoteCount2Person
        dumbbell.ainoteCount5Person = dumbbellMemory3.ainoteCount5Person
        dumbbell.ainoteCountSum = dumbbellMemory3.ainoteCountSum
        dumbbell.rupCountSuccess = dumbbellMemory3.rupCountSuccess
        dumbbell.rupCountFailed = dumbbellMemory3.rupCountFailed
        dumbbell.rupCountSum = dumbbellMemory3.rupCountSum
        dumbbell.kinnikuScreenCountDefault = dumbbellMemory3.kinnikuScreenCountDefault
        dumbbell.kinnikuScreenCountHigh = dumbbellMemory3.kinnikuScreenCountHigh
        dumbbell.kinnikuScreenCountHighKyo = dumbbellMemory3.kinnikuScreenCountHighKyo
        dumbbell.kinnikuScreenCountSum = dumbbellMemory3.kinnikuScreenCountSum
        dumbbell.czBonusScreenCountOver2Sisa = dumbbellMemory3.czBonusScreenCountOver2Sisa
        dumbbell.czBonusScreenCountGusuSisa = dumbbellMemory3.czBonusScreenCountGusuSisa
        dumbbell.czBonusScreenCountKisuSisa = dumbbellMemory3.czBonusScreenCountKisuSisa
        dumbbell.kinnikuScreenCountGusu = dumbbellMemory3.kinnikuScreenCountGusu
    }
}


#Preview {
    dumbbellViewTop()
}
