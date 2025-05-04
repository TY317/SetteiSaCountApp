//
//  inuyasha2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/08.
//

import SwiftUI
import TipKit

// /////////////////////
// 変数
// /////////////////////
class Inuyasha: ObservableObject {
    // /////////////////////////
    // AT初当り履歴
    // /////////////////////////
    // 選択肢の設定
    let selectListCycle = ["1周期", "2周期", "3周期", "4周期", "5周期", "6周期", "7周期", "8周期"]
    let selectListTrigger = ["妖勝負", "魍魎丸", "直撃", "フリーズ", "その他"]
    let selectListBonus = ["妖勝負", "直AT"]
    let selectListTriggerAt = ["魍魎丸", "直撃", "フリーズ", "その他"]
    let selectListTriggerCz = ["1周期", "2周期", "3周期", "4周期", "5周期", "6周期", "7周期", "8周期"]
    let selectListAtHitCz = ["当選", "ハズレ"]
    let selectListAtHitAt = ["当選"]
    // 選択結果の設定
    @Published var inputGame = 0
    @Published var selectedCycle = "3周期"
    @Published var selectedTrigger = "1周期"
    @Published var selectedBonus = "妖勝負"
    @Published var selectedTriggerAt = "魍魎丸"
    @Published var selectedTriggerCz = "1周期"
    @Published var selectedAtHitCz = "当選"
    @Published var selectedAtHitAt = "当選"
    @Published var selectedAtHit = "当選"
    // //// 配列の設定
    // ゲーム数配列
    let gameArrayKey = "inuyashaGameArrayKey"
    @AppStorage("inuyashaGameArrayKey") var gameArrayData: Data?
    // 周期配列
    let cycleArrayKey = "inuyashaCycleArrayKey"
    @AppStorage("inuyashaCycleArrayKey") var cycleArrayData: Data?
    // 当選契機配列
    let triggerArrayKey = "inuyashaTriggerArrayKey"
    @AppStorage("inuyashaTriggerArrayKey") var triggerArrayData: Data?
    // 消化周期数配列
    let cycleNumberArrayKey = "inuyashaCycleNumberArrayKey"
    @AppStorage("inuyashaCycleNumberArrayKey") var cycleNumberArrayData: Data?
    // 当選種類配列
    let bonusArrayKey = "inuyashaBonusArrayKey"
    @AppStorage("inuyashaBonusArrayKey") var bonusArrayData: Data?
    // AT当否配列
    let atHitArrayKey = "inuyashaAtHitArrayKey"
    @AppStorage("inuyashaAtHitArrayKey") var atHitArrayData: Data?
    // //// 結果集計用
    @AppStorage("inuyashaAtHitCount") var atHitCount: Int = 0
    @AppStorage("inuyashaPlayGameSum") var playGameSum: Int = 0
    @AppStorage("inuyashaCzHitCount") var czHitCount: Int = 0
    @AppStorage("inuyashaCycleSum") var cycleSum: Int = 0
    @AppStorage("inuyashaCzHitCountWithoutTenjo") var czHitCountWithoutTenjo: Int = 0
    @AppStorage("inuyashaCycleSumWithoutTenjo") var cycleSumWithoutTenjo: Int = 0
    @Published var cycleNumber: Int = 1
    @AppStorage("inuyashaOver333CzCount") var over333CzCount: Int = 0
    @AppStorage("inuyashaCzCount") var czCount: Int = 0
    @AppStorage("inuyashaHitCountAll") var hitCountAll: Int = 0
    
    // //// データ追加
    func addDataHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
//        arrayStringAddData(arrayData: cycleArrayData, addData: selectedCycle, key: cycleArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedTrigger, key: triggerArrayKey)
        arrayStringAddData(arrayData: atHitArrayData, addData: selectedAtHit, key: atHitArrayKey)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        czCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "妖勝負")
        // ゲーム数が333＋α越えならカウント
        over333CzCount = arrayKeywordAndOverGameCount(
            intArrayData: gameArrayData,
            stringArrayData: bonusArrayData,
            overGame: 365,
            keyword: "妖勝負"
        )
        // CZ成功回数をカウント
        czHitCount = arrayString2Array2AndDataCount(
            array1Data: bonusArrayData,
            array2Data: atHitArrayData,
            key1: "妖勝負",
            key2: "当選"
        )
        // 天井CZを除いたCZ回数とCZ成功回数をカウント
        cycleSumWithoutTenjo = czCount - arrayStringDataCount(arrayData: triggerArrayData, countString: "8周期")
        czHitCountWithoutTenjo = czHitCount - arrayStringDataCount(arrayData: triggerArrayData, countString: "8周期")
        atHitCount = arrayStringDataCount(arrayData: atHitArrayData, countString: "当選")
        hitCountAll = arrayIntAllDataCount(arrayData: gameArrayData)
//        // 選択された周期に合わせて消化周期数を変数に代入
//        if selectedCycle == selectListCycle[1] {
//            cycleNumber = 2
//        } else if selectedCycle == selectListCycle[2] {
//            cycleNumber = 3
//        } else if selectedCycle == selectListCycle[3] {
//            cycleNumber = 4
//        } else if selectedCycle == selectListCycle[4] {
//            cycleNumber = 5
//        } else if selectedCycle == selectListCycle[5] {
//            cycleNumber = 6
//        } else if selectedCycle == selectListCycle[6] {
//            cycleNumber = 7
//        } else if selectedCycle == selectListCycle[7] {
//            cycleNumber = 8
//        } else {
//            cycleNumber = 1
//        }
//        // 選択された当選契機が妖決戦以外であれば変数から-1する
//        if selectedTrigger != selectListTrigger[0] {
//            cycleNumber -= 1
//        }
//        // 天井CZでの当選があればCz回数とCz当選回数から−1する
//        let tenjoCz = arrayString2Array2AndDataCount(
//            array1Data: cycleArrayData,
//            array2Data: triggerArrayData,
//            key1: selectListCycle[7],
//            key2: selectListTrigger[0]
//        )
//        arrayIntAddData(arrayData: cycleNumberArrayData, addData: cycleNumber, key: cycleNumberArrayKey)
//        atHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
//        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
//        czHitCount = arrayStringDataCount(arrayData: triggerArrayData, countString: selectListTrigger[0])
//        cycleSum = arrayIntAllDataSum(arrayData: cycleNumberArrayData)
//        czHitCountWithoutTenjo = czHitCount - tenjoCz
//        cycleSumWithoutTenjo = cycleSum - tenjoCz
        inputGame = 0
        selectedTrigger = "1周期"
        selectedBonus = "妖勝負"
        selectedTriggerAt = "魍魎丸"
        selectedTriggerCz = "1周期"
        selectedAtHitCz = "当選"
        selectedAtHitAt = "当選"
        selectedAtHit = "当選"
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: bonusArrayData, key: bonusArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveLast(arrayData: atHitArrayData, key: atHitArrayKey)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        czCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "妖勝負")
        // ゲーム数が333＋α越えならカウント
        over333CzCount = arrayKeywordAndOverGameCount(
            intArrayData: gameArrayData,
            stringArrayData: bonusArrayData,
            overGame: 365,
            keyword: "妖勝負"
        )
        // CZ成功回数をカウント
        czHitCount = arrayString2Array2AndDataCount(
            array1Data: bonusArrayData,
            array2Data: atHitArrayData,
            key1: "妖勝負",
            key2: "当選"
        )
        // 天井CZを除いたCZ回数とCZ成功回数をカウント
        cycleSumWithoutTenjo = czCount - arrayStringDataCount(arrayData: triggerArrayData, countString: "8周期")
        czHitCountWithoutTenjo = czHitCount - arrayStringDataCount(arrayData: triggerArrayData, countString: "8周期")
        atHitCount = arrayStringDataCount(arrayData: atHitArrayData, countString: "当選")
        hitCountAll = arrayIntAllDataCount(arrayData: gameArrayData)
        inputGame = 0
        selectedTrigger = "1周期"
        selectedBonus = "妖勝負"
        selectedTriggerAt = "魍魎丸"
        selectedTriggerCz = "1周期"
        selectedAtHitCz = "当選"
        selectedAtHitAt = "当選"
        selectedAtHit = "当選"
//        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
//        arrayStringRemoveLast(arrayData: cycleArrayData, key: cycleArrayKey)
//        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
//        arrayIntRemoveLast(arrayData: cycleNumberArrayData, key: cycleNumberArrayKey)
//        // 天井CZでの当選があればCz回数とCz当選回数から−1する
//        let tenjoCz = arrayString2Array2AndDataCount(
//            array1Data: cycleArrayData,
//            array2Data: triggerArrayData,
//            key1: selectListCycle[7],
//            key2: selectListTrigger[0]
//        )
//        atHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
//        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
//        czHitCount = arrayStringDataCount(arrayData: triggerArrayData, countString: selectListTrigger[0])
//        cycleSum = arrayIntAllDataSum(arrayData: cycleNumberArrayData)
//        czHitCountWithoutTenjo = czHitCount - tenjoCz
//        cycleSumWithoutTenjo = cycleSum - tenjoCz
//        inputGame = 0
//        selectedCycle = "3周期"
//        selectedTrigger = "妖勝負"
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: bonusArrayData, key: bonusArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveAll(arrayData: atHitArrayData, key: atHitArrayKey)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        czCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "妖勝負")
        // ゲーム数が333＋α越えならカウント
        over333CzCount = arrayKeywordAndOverGameCount(
            intArrayData: gameArrayData,
            stringArrayData: bonusArrayData,
            overGame: 365,
            keyword: "妖勝負"
        )
        // CZ成功回数をカウント
        czHitCount = arrayString2Array2AndDataCount(
            array1Data: bonusArrayData,
            array2Data: atHitArrayData,
            key1: "妖勝負",
            key2: "当選"
        )
        // 天井CZを除いたCZ回数とCZ成功回数をカウント
        cycleSumWithoutTenjo = czCount - arrayStringDataCount(arrayData: triggerArrayData, countString: "8周期")
        czHitCountWithoutTenjo = czHitCount - arrayStringDataCount(arrayData: triggerArrayData, countString: "8周期")
        atHitCount = arrayStringDataCount(arrayData: atHitArrayData, countString: "当選")
        hitCountAll = arrayIntAllDataCount(arrayData: gameArrayData)
        inputGame = 0
        selectedTrigger = "1周期"
        selectedBonus = "妖勝負"
        selectedTriggerAt = "魍魎丸"
        selectedTriggerCz = "1周期"
        selectedAtHitCz = "当選"
        selectedAtHitAt = "当選"
        selectedAtHit = "当選"
//        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
//        arrayStringRemoveAll(arrayData: cycleArrayData, key: cycleArrayKey)
//        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
//        arrayIntRemoveAll(arrayData: cycleNumberArrayData, key: cycleNumberArrayKey)
//        atHitCount = 0
//        playGameSum = 0
//        czHitCount = 0
//        cycleSum = 0
//        czHitCountWithoutTenjo = 0
//        cycleSumWithoutTenjo = 0
//        inputGame = 0
//        selectedCycle = "3周期"
//        selectedTrigger = "妖勝負"
        minusCheck = false
    }
    
    // /////////////////////////
    // 犬夜叉ランプ
    // /////////////////////////
    @AppStorage("inuyashaInuyashaLampCountWhite") var inuyashaLampCountWhite = 0 {
        didSet {
            inuyashaLampCountSum = countSum(inuyashaLampCountWhite, inuyashaLampCountBlue, inuyashaLampCountRainbow)
        }
    }
        @AppStorage("inuyashaInuyashaLampCountBlue") var inuyashaLampCountBlue = 0 {
            didSet {
                inuyashaLampCountSum = countSum(inuyashaLampCountWhite, inuyashaLampCountBlue, inuyashaLampCountRainbow)
            }
        }
            @AppStorage("inuyashaInuyashaLampCountRainbow") var inuyashaLampCountRainbow = 0 {
                didSet {
                    inuyashaLampCountSum = countSum(inuyashaLampCountWhite, inuyashaLampCountBlue, inuyashaLampCountRainbow)
                }
            }
    @AppStorage("inuyashaInuyashaLampCountSum") var inuyashaLampCountSum = 0
    
    func resetInuyashaLamp() {
        inuyashaLampCountWhite = 0
        inuyashaLampCountBlue = 0
        inuyashaLampCountRainbow = 0
        minusCheck = false
    }
    
    // /////////////////////////
    // 目押しボイス
    // /////////////////////////
    // ボイス選択肢の設定
    @Published var selectListVoice = [
        "さすがだな",
        "ふん、当然だ",
        "おすわりぃ",
        "もうっだいっきらい",
        "信じて撃つのよあたしの矢は四魂の玉を貫く",
        "この殺生丸に切れぬものは無い",
        "俺は命を懸けてお前を守る"
    ]
    @AppStorage("inuyashaSelectedVoice") var selectedVoice = "さすがだな"
    @AppStorage("inuyashaVoiceCountDefault") var voiceCountDefault = 0 {
        didSet {
            voiceCountSum = countSum(voiceCountDefault, voiceCountHighSisaJaku, voiceCountHighSisaChu, voiceCountHighSisaKyo)
        }
    }
        @AppStorage("inuyashaVoiceCountHighSisaJaku") var voiceCountHighSisaJaku = 0 {
            didSet {
                voiceCountSum = countSum(voiceCountDefault, voiceCountHighSisaJaku, voiceCountHighSisaChu, voiceCountHighSisaKyo)
            }
        }
            @AppStorage("inuyashaVoiceCountHighSisaChu") var voiceCountHighSisaChu = 0 {
                didSet {
                    voiceCountSum = countSum(voiceCountDefault, voiceCountHighSisaJaku, voiceCountHighSisaChu, voiceCountHighSisaKyo)
                }
            }
                @AppStorage("inuyashaVoiceCountHighSisaKyo") var voiceCountHighSisaKyo = 0 {
                    didSet {
                        voiceCountSum = countSum(voiceCountDefault, voiceCountHighSisaJaku, voiceCountHighSisaChu, voiceCountHighSisaKyo)
                    }
                }
    @AppStorage("inuyashaVoiceCountSum") var voiceCountSum = 0
    
    func resetVoice() {
        selectedVoice = "さすがだな"
        voiceCountDefault = 0
        voiceCountHighSisaJaku = 0
        voiceCountHighSisaChu = 0
        voiceCountHighSisaKyo = 0
        minusCheck = false
    }
    
    // /////////////////////////
    // Big終了画面
    // /////////////////////////
    @AppStorage("inuyashaBigScreenCurrentKeyword") var bigScreenCurrentKeyword: String = ""
    let bigScreenKeywordList: [String] = [
        "inuyashaBigScreenInuyashaDfault",
        "inuyashaBigScreenInuyashaOver2",
        "inuyashaBigScreenSesshomaruDefault",
        "inuyashaBigScreenSesshomaruOver2",
        "inuyashaBigScreenKikyo",
        "inuyashaBigScreenKagomeInuyasha"
    ]
    let bigCharacterList: [String] = [
        "犬夜叉Big",
        "殺生丸Big"
    ]
    @AppStorage("inuyashaSelectedBigCharacter") var selectedBigCharacter: String = "犬夜叉Big"
    @AppStorage("inuyashaBigScreenCountDefault") var bigScreenCountDefault = 0 {
        didSet {
            bigScreenCountSum = countSum(bigScreenCountDefault, bigScreenCountOver2, bigScreenCountHighSisa, bigScreenCountOver4)
        }
    }
        @AppStorage("inuyashaBigScreenCountOver2") var bigScreenCountOver2 = 0 {
            didSet {
                bigScreenCountSum = countSum(bigScreenCountDefault, bigScreenCountOver2, bigScreenCountHighSisa, bigScreenCountOver4)
            }
        }
            @AppStorage("inuyashaBigScreenCountHighSisa") var bigScreenCountHighSisa = 0 {
                didSet {
                    bigScreenCountSum = countSum(bigScreenCountDefault, bigScreenCountOver2, bigScreenCountHighSisa, bigScreenCountOver4)
                }
            }
                @AppStorage("inuyashaBigScreenCountOver4") var bigScreenCountOver4 = 0 {
                    didSet {
                        bigScreenCountSum = countSum(bigScreenCountDefault, bigScreenCountOver2, bigScreenCountHighSisa, bigScreenCountOver4)
                    }
                }
    @AppStorage("inuyashaBigScreenCountSum") var bigScreenCountSum = 0
    
    func resetBigScreen() {
        bigScreenCurrentKeyword = ""
        bigScreenCountDefault = 0
        bigScreenCountOver2 = 0
        bigScreenCountHighSisa = 0
        bigScreenCountOver4 = 0
        minusCheck = false
    }
    
    // /////////////////////////
    // AT終了画面
    // /////////////////////////
    @AppStorage("inuyashaAtScreenCurrentKeyword") var atScreenCurrentKeyword: String = ""
    let atScreenKeywordList: [String] = [
        "inuyashaAtScreenBlueDefault",
        "inuyashaAtScreenBlueGusu",
        "inuyashaAtScreenBlueOver2",
        "inuyashaAtScreenYellow",
        "inuyashaAtScreenGreen",
        "inuyashaAtScreenRed",
        "inuyashaAtScreenGold",
        "inuyashaAtScreenRainbow"
    ]
    @AppStorage("inuyashaAtScreenCountDefault") var atScreenCountDefault = 0 {
        didSet {
            atScreenCountSum = countSum(atScreenCountDefault, atScreenCountGusu, atScreenCountOver2, atScreenCountHighJaku, atScreenCountHighChu, atScreenCountHighKyo, atScreenCountOver4, atScreenCount6Kaku)
        }
    }
        @AppStorage("inuyashaAtScreenCountGusu") var atScreenCountGusu = 0 {
            didSet {
                atScreenCountSum = countSum(atScreenCountDefault, atScreenCountGusu, atScreenCountOver2, atScreenCountHighJaku, atScreenCountHighChu, atScreenCountHighKyo, atScreenCountOver4, atScreenCount6Kaku)
            }
        }
            @AppStorage("inuyashaAtScreenCountOver2") var atScreenCountOver2 = 0 {
                didSet {
                    atScreenCountSum = countSum(atScreenCountDefault, atScreenCountGusu, atScreenCountOver2, atScreenCountHighJaku, atScreenCountHighChu, atScreenCountHighKyo, atScreenCountOver4, atScreenCount6Kaku)
                }
            }
                @AppStorage("inuyashaAtScreenCountHighJaku") var atScreenCountHighJaku = 0 {
                    didSet {
                        atScreenCountSum = countSum(atScreenCountDefault, atScreenCountGusu, atScreenCountOver2, atScreenCountHighJaku, atScreenCountHighChu, atScreenCountHighKyo, atScreenCountOver4, atScreenCount6Kaku)
                    }
                }
                    @AppStorage("inuyashaAtScreenCountHighChu") var atScreenCountHighChu = 0 {
                        didSet {
                            atScreenCountSum = countSum(atScreenCountDefault, atScreenCountGusu, atScreenCountOver2, atScreenCountHighJaku, atScreenCountHighChu, atScreenCountHighKyo, atScreenCountOver4, atScreenCount6Kaku)
                        }
                    }
                        @AppStorage("inuyashaAtScreenCountHighKyo") var atScreenCountHighKyo = 0 {
                            didSet {
                                atScreenCountSum = countSum(atScreenCountDefault, atScreenCountGusu, atScreenCountOver2, atScreenCountHighJaku, atScreenCountHighChu, atScreenCountHighKyo, atScreenCountOver4, atScreenCount6Kaku)
                            }
                        }
                            @AppStorage("inuyashaAtScreenCountOver4") var atScreenCountOver4 = 0 {
                                didSet {
                                    atScreenCountSum = countSum(atScreenCountDefault, atScreenCountGusu, atScreenCountOver2, atScreenCountHighJaku, atScreenCountHighChu, atScreenCountHighKyo, atScreenCountOver4, atScreenCount6Kaku)
                                }
                            }
                                @AppStorage("inuyashaAtScreenCount6Kaku") var atScreenCount6Kaku = 0 {
                                    didSet {
                                        atScreenCountSum = countSum(atScreenCountDefault, atScreenCountGusu, atScreenCountOver2, atScreenCountHighJaku, atScreenCountHighChu, atScreenCountHighKyo, atScreenCountOver4, atScreenCount6Kaku)
                                    }
                                }
    @AppStorage("inuyashaAtScreenCountSum") var atScreenCountSum = 0
    
    func resetAtScreen() {
        atScreenCurrentKeyword = ""
        atScreenCountDefault = 0
        atScreenCountGusu = 0
        atScreenCountOver2 = 0
        atScreenCountHighJaku = 0
        atScreenCountHighChu = 0
        atScreenCountHighKyo = 0
        atScreenCountOver4 = 0
        atScreenCount6Kaku = 0
        minusCheck = false
    }
    
    // /////////////////////////
    // 共通
    // /////////////////////////
    @AppStorage("inuyashaMinusCheck") var minusCheck: Bool = false
    @AppStorage("inuyashaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetHistory()
        resetInuyashaLamp()
        resetVoice()
        resetAtScreen()
        resetBigScreen()
        resetKoyaku()
    }
    
    // /////////////////////////
    // 小役
    // /////////////////////////
    @AppStorage("inuyashaKoyakuCountJakuCherry") var koyakuCountJakuCherry = 0 {
        didSet {
            koyakuCountSum = countSum(koyakuCountJakuCherry, koyakuCountKyoCherry, koyakuCountSuika, koyakuCountChanceA, koyakuCountChanceB)
        }
    }
        @AppStorage("inuyashaKoyakuCountKyoCherry") var koyakuCountKyoCherry = 0 {
            didSet {
                koyakuCountSum = countSum(koyakuCountJakuCherry, koyakuCountKyoCherry, koyakuCountSuika, koyakuCountChanceA, koyakuCountChanceB)
            }
        }
            @AppStorage("inuyashaKoyakuCountSuika") var koyakuCountSuika = 0 {
                didSet {
                    koyakuCountSum = countSum(koyakuCountJakuCherry, koyakuCountKyoCherry, koyakuCountSuika, koyakuCountChanceA, koyakuCountChanceB)
                }
            }
                @AppStorage("inuyashaKoyakuCountChanceA") var koyakuCountChanceA = 0 {
                    didSet {
                        koyakuCountSum = countSum(koyakuCountJakuCherry, koyakuCountKyoCherry, koyakuCountSuika, koyakuCountChanceA, koyakuCountChanceB)
                    }
                }
                    @AppStorage("inuyashaKoyakuCountChanceB") var koyakuCountChanceB = 0 {
                        didSet {
                            koyakuCountSum = countSum(koyakuCountJakuCherry, koyakuCountKyoCherry, koyakuCountSuika, koyakuCountChanceA, koyakuCountChanceB)
                        }
                    }
    @AppStorage("inuyashaKoyakuCountSum") var koyakuCountSum = 0
    @AppStorage("inuyashaKoyakuCountStartGame") var koyakuCountStartGame = 0 {
        didSet {
            let games = koyakuCountCurrentGame - koyakuCountStartGame
            koyakuCountPlayGame = games > 0 ? games : 0
        }
    }
        @AppStorage("inuyashaKoyakuCountCurrentGame") var koyakuCountCurrentGame = 0 {
            didSet {
                let games = koyakuCountCurrentGame - koyakuCountStartGame
                koyakuCountPlayGame = games > 0 ? games : 0
            }
        }
    @AppStorage("inuyashaKoyakuCountPlayGame") var koyakuCountPlayGame = 0
    
    func resetKoyaku() {
        koyakuCountJakuCherry = 0
        koyakuCountKyoCherry = 0
        koyakuCountSuika = 0
        koyakuCountChanceA = 0
        koyakuCountChanceB = 0
        koyakuCountStartGame = 0
        koyakuCountCurrentGame = 0
    }
    
}

// //// メモリー1
class InuyashaMemory1: ObservableObject {
    @AppStorage("inuyashaGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("inuyashaCycleArrayKeyMemory1") var cycleArrayData: Data?
    @AppStorage("inuyashaTriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("inuyashaCycleNumberArrayKeyMemory1") var cycleNumberArrayData: Data?
    @AppStorage("inuyashaAtHitCountMemory1") var atHitCount: Int = 0
    @AppStorage("inuyashaPlayGameSumMemory1") var playGameSum: Int = 0
    @AppStorage("inuyashaCzHitCountMemory1") var czHitCount: Int = 0
    @AppStorage("inuyashaCycleSumMemory1") var cycleSum: Int = 0
    @AppStorage("inuyashaCzHitCountWithoutTenjoMemory1") var czHitCountWithoutTenjo: Int = 0
    @AppStorage("inuyashaCycleSumWithoutTenjoMemory1") var cycleSumWithoutTenjo: Int = 0
    @AppStorage("inuyashaInuyashaLampCountWhiteMemory1") var inuyashaLampCountWhite = 0
    @AppStorage("inuyashaInuyashaLampCountBlueMemory1") var inuyashaLampCountBlue = 0
    @AppStorage("inuyashaInuyashaLampCountRainbowMemory1") var inuyashaLampCountRainbow = 0
    @AppStorage("inuyashaInuyashaLampCountSumMemory1") var inuyashaLampCountSum = 0
    @AppStorage("inuyashaVoiceCountDefaultMemory1") var voiceCountDefault = 0
    @AppStorage("inuyashaVoiceCountHighSisaJakuMemory1") var voiceCountHighSisaJaku = 0
    @AppStorage("inuyashaVoiceCountHighSisaChuMemory1") var voiceCountHighSisaChu = 0
    @AppStorage("inuyashaVoiceCountHighSisaKyoMemory1") var voiceCountHighSisaKyo = 0
    @AppStorage("inuyashaVoiceCountSumMemory1") var voiceCountSum = 0
    @AppStorage("inuyashaBigScreenCountDefaultMemory1") var bigScreenCountDefault = 0
    @AppStorage("inuyashaBigScreenCountOver2Memory1") var bigScreenCountOver2 = 0
    @AppStorage("inuyashaBigScreenCountHighSisaMemory1") var bigScreenCountHighSisa = 0
    @AppStorage("inuyashaBigScreenCountOver4Memory1") var bigScreenCountOver4 = 0
    @AppStorage("inuyashaBigScreenCountSumMemory1") var bigScreenCountSum = 0
    @AppStorage("inuyashaAtScreenCountDefaultMemory1") var atScreenCountDefault = 0
    @AppStorage("inuyashaAtScreenCountGusuMemory1") var atScreenCountGusu = 0
    @AppStorage("inuyashaAtScreenCountOver2Memory1") var atScreenCountOver2 = 0
    @AppStorage("inuyashaAtScreenCountHighJakuMemory1") var atScreenCountHighJaku = 0
    @AppStorage("inuyashaAtScreenCountHighChuMemory1") var atScreenCountHighChu = 0
    @AppStorage("inuyashaAtScreenCountHighKyoMemory1") var atScreenCountHighKyo = 0
    @AppStorage("inuyashaAtScreenCountOver4Memory1") var atScreenCountOver4 = 0
    @AppStorage("inuyashaAtScreenCount6KakuMemory1") var atScreenCount6Kaku = 0
    @AppStorage("inuyashaAtScreenCountSumMemory1") var atScreenCountSum = 0
    @AppStorage("inuyashaMemoMemory1") var memo = ""
    @AppStorage("inuyashaDateMemory1") var dateDouble = 0.0
    @AppStorage("inuyashaBonusArrayKeyMemory1") var bonusArrayData: Data?
    @AppStorage("inuyashaAtHitArrayKeyMemory1") var atHitArrayData: Data?
    @AppStorage("inuyashaOver333CzCountMemory1") var over333CzCount: Int = 0
    @AppStorage("inuyashaCzCountMemory1") var czCount: Int = 0
    @AppStorage("inuyashaHitCountAllMemory1") var hitCountAll: Int = 0
    @AppStorage("inuyashaKoyakuCountJakuCherryMemory1") var koyakuCountJakuCherry = 0
    @AppStorage("inuyashaKoyakuCountKyoCherryMemory1") var koyakuCountKyoCherry = 0
    @AppStorage("inuyashaKoyakuCountSuikaMemory1") var koyakuCountSuika = 0
    @AppStorage("inuyashaKoyakuCountChanceAMemory1") var koyakuCountChanceA = 0
    @AppStorage("inuyashaKoyakuCountChanceBMemory1") var koyakuCountChanceB = 0
    @AppStorage("inuyashaKoyakuCountSumMemory1") var koyakuCountSum = 0
    @AppStorage("inuyashaKoyakuCountStartGameMemory1") var koyakuCountStartGame = 0
    @AppStorage("inuyashaKoyakuCountCurrentGameMemory1") var koyakuCountCurrentGame = 0
    @AppStorage("inuyashaKoyakuCountPlayGameMemory1") var koyakuCountPlayGame = 0
}

// //// メモリー2
class InuyashaMemory2: ObservableObject {
    @AppStorage("inuyashaGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("inuyashaCycleArrayKeyMemory2") var cycleArrayData: Data?
    @AppStorage("inuyashaTriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("inuyashaCycleNumberArrayKeyMemory2") var cycleNumberArrayData: Data?
    @AppStorage("inuyashaAtHitCountMemory2") var atHitCount: Int = 0
    @AppStorage("inuyashaPlayGameSumMemory2") var playGameSum: Int = 0
    @AppStorage("inuyashaCzHitCountMemory2") var czHitCount: Int = 0
    @AppStorage("inuyashaCycleSumMemory2") var cycleSum: Int = 0
    @AppStorage("inuyashaCzHitCountWithoutTenjoMemory2") var czHitCountWithoutTenjo: Int = 0
    @AppStorage("inuyashaCycleSumWithoutTenjoMemory2") var cycleSumWithoutTenjo: Int = 0
    @AppStorage("inuyashaInuyashaLampCountWhiteMemory2") var inuyashaLampCountWhite = 0
    @AppStorage("inuyashaInuyashaLampCountBlueMemory2") var inuyashaLampCountBlue = 0
    @AppStorage("inuyashaInuyashaLampCountRainbowMemory2") var inuyashaLampCountRainbow = 0
    @AppStorage("inuyashaInuyashaLampCountSumMemory2") var inuyashaLampCountSum = 0
    @AppStorage("inuyashaVoiceCountDefaultMemory2") var voiceCountDefault = 0
    @AppStorage("inuyashaVoiceCountHighSisaJakuMemory2") var voiceCountHighSisaJaku = 0
    @AppStorage("inuyashaVoiceCountHighSisaChuMemory2") var voiceCountHighSisaChu = 0
    @AppStorage("inuyashaVoiceCountHighSisaKyoMemory2") var voiceCountHighSisaKyo = 0
    @AppStorage("inuyashaVoiceCountSumMemory2") var voiceCountSum = 0
    @AppStorage("inuyashaBigScreenCountDefaultMemory2") var bigScreenCountDefault = 0
    @AppStorage("inuyashaBigScreenCountOver2Memory2") var bigScreenCountOver2 = 0
    @AppStorage("inuyashaBigScreenCountHighSisaMemory2") var bigScreenCountHighSisa = 0
    @AppStorage("inuyashaBigScreenCountOver4Memory2") var bigScreenCountOver4 = 0
    @AppStorage("inuyashaBigScreenCountSumMemory2") var bigScreenCountSum = 0
    @AppStorage("inuyashaAtScreenCountDefaultMemory2") var atScreenCountDefault = 0
    @AppStorage("inuyashaAtScreenCountGusuMemory2") var atScreenCountGusu = 0
    @AppStorage("inuyashaAtScreenCountOver2Memory2") var atScreenCountOver2 = 0
    @AppStorage("inuyashaAtScreenCountHighJakuMemory2") var atScreenCountHighJaku = 0
    @AppStorage("inuyashaAtScreenCountHighChuMemory2") var atScreenCountHighChu = 0
    @AppStorage("inuyashaAtScreenCountHighKyoMemory2") var atScreenCountHighKyo = 0
    @AppStorage("inuyashaAtScreenCountOver4Memory2") var atScreenCountOver4 = 0
    @AppStorage("inuyashaAtScreenCount6KakuMemory2") var atScreenCount6Kaku = 0
    @AppStorage("inuyashaAtScreenCountSumMemory2") var atScreenCountSum = 0
    @AppStorage("inuyashaMemoMemory2") var memo = ""
    @AppStorage("inuyashaDateMemory2") var dateDouble = 0.0
    @AppStorage("inuyashaBonusArrayKeyMemory2") var bonusArrayData: Data?
    @AppStorage("inuyashaAtHitArrayKeyMemory2") var atHitArrayData: Data?
    @AppStorage("inuyashaOver333CzCountMemory2") var over333CzCount: Int = 0
    @AppStorage("inuyashaCzCountMemory2") var czCount: Int = 0
    @AppStorage("inuyashaHitCountAllMemory2") var hitCountAll: Int = 0
    @AppStorage("inuyashaKoyakuCountJakuCherryMemory2") var koyakuCountJakuCherry = 0
    @AppStorage("inuyashaKoyakuCountKyoCherryMemory2") var koyakuCountKyoCherry = 0
    @AppStorage("inuyashaKoyakuCountSuikaMemory2") var koyakuCountSuika = 0
    @AppStorage("inuyashaKoyakuCountChanceAMemory2") var koyakuCountChanceA = 0
    @AppStorage("inuyashaKoyakuCountChanceBMemory2") var koyakuCountChanceB = 0
    @AppStorage("inuyashaKoyakuCountSumMemory2") var koyakuCountSum = 0
    @AppStorage("inuyashaKoyakuCountStartGameMemory2") var koyakuCountStartGame = 0
    @AppStorage("inuyashaKoyakuCountCurrentGameMemory2") var koyakuCountCurrentGame = 0
    @AppStorage("inuyashaKoyakuCountPlayGameMemory2") var koyakuCountPlayGame = 0
}

// //// メモリー3
class InuyashaMemory3: ObservableObject {
    @AppStorage("inuyashaGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("inuyashaCycleArrayKeyMemory3") var cycleArrayData: Data?
    @AppStorage("inuyashaTriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("inuyashaCycleNumberArrayKeyMemory3") var cycleNumberArrayData: Data?
    @AppStorage("inuyashaAtHitCountMemory3") var atHitCount: Int = 0
    @AppStorage("inuyashaPlayGameSumMemory3") var playGameSum: Int = 0
    @AppStorage("inuyashaCzHitCountMemory3") var czHitCount: Int = 0
    @AppStorage("inuyashaCycleSumMemory3") var cycleSum: Int = 0
    @AppStorage("inuyashaCzHitCountWithoutTenjoMemory3") var czHitCountWithoutTenjo: Int = 0
    @AppStorage("inuyashaCycleSumWithoutTenjoMemory3") var cycleSumWithoutTenjo: Int = 0
    @AppStorage("inuyashaInuyashaLampCountWhiteMemory3") var inuyashaLampCountWhite = 0
    @AppStorage("inuyashaInuyashaLampCountBlueMemory3") var inuyashaLampCountBlue = 0
    @AppStorage("inuyashaInuyashaLampCountRainbowMemory3") var inuyashaLampCountRainbow = 0
    @AppStorage("inuyashaInuyashaLampCountSumMemory3") var inuyashaLampCountSum = 0
    @AppStorage("inuyashaVoiceCountDefaultMemory3") var voiceCountDefault = 0
    @AppStorage("inuyashaVoiceCountHighSisaJakuMemory3") var voiceCountHighSisaJaku = 0
    @AppStorage("inuyashaVoiceCountHighSisaChuMemory3") var voiceCountHighSisaChu = 0
    @AppStorage("inuyashaVoiceCountHighSisaKyoMemory3") var voiceCountHighSisaKyo = 0
    @AppStorage("inuyashaVoiceCountSumMemory3") var voiceCountSum = 0
    @AppStorage("inuyashaBigScreenCountDefaultMemory3") var bigScreenCountDefault = 0
    @AppStorage("inuyashaBigScreenCountOver2Memory3") var bigScreenCountOver2 = 0
    @AppStorage("inuyashaBigScreenCountHighSisaMemory3") var bigScreenCountHighSisa = 0
    @AppStorage("inuyashaBigScreenCountOver4Memory3") var bigScreenCountOver4 = 0
    @AppStorage("inuyashaBigScreenCountSumMemory3") var bigScreenCountSum = 0
    @AppStorage("inuyashaAtScreenCountDefaultMemory3") var atScreenCountDefault = 0
    @AppStorage("inuyashaAtScreenCountGusuMemory3") var atScreenCountGusu = 0
    @AppStorage("inuyashaAtScreenCountOver2Memory3") var atScreenCountOver2 = 0
    @AppStorage("inuyashaAtScreenCountHighJakuMemory3") var atScreenCountHighJaku = 0
    @AppStorage("inuyashaAtScreenCountHighChuMemory3") var atScreenCountHighChu = 0
    @AppStorage("inuyashaAtScreenCountHighKyoMemory3") var atScreenCountHighKyo = 0
    @AppStorage("inuyashaAtScreenCountOver4Memory3") var atScreenCountOver4 = 0
    @AppStorage("inuyashaAtScreenCount6KakuMemory3") var atScreenCount6Kaku = 0
    @AppStorage("inuyashaAtScreenCountSumMemory3") var atScreenCountSum = 0
    @AppStorage("inuyashaMemoMemory3") var memo = ""
    @AppStorage("inuyashaDateMemory3") var dateDouble = 0.0
    @AppStorage("inuyashaBonusArrayKeyMemory3") var bonusArrayData: Data?
    @AppStorage("inuyashaAtHitArrayKeyMemory3") var atHitArrayData: Data?
    @AppStorage("inuyashaOver333CzCountMemory3") var over333CzCount: Int = 0
    @AppStorage("inuyashaCzCountMemory3") var czCount: Int = 0
    @AppStorage("inuyashaHitCountAllMemory3") var hitCountAll: Int = 0
    @AppStorage("inuyashaKoyakuCountJakuCherryMemory3") var koyakuCountJakuCherry = 0
    @AppStorage("inuyashaKoyakuCountKyoCherryMemory3") var koyakuCountKyoCherry = 0
    @AppStorage("inuyashaKoyakuCountSuikaMemory3") var koyakuCountSuika = 0
    @AppStorage("inuyashaKoyakuCountChanceAMemory3") var koyakuCountChanceA = 0
    @AppStorage("inuyashaKoyakuCountChanceBMemory3") var koyakuCountChanceB = 0
    @AppStorage("inuyashaKoyakuCountSumMemory3") var koyakuCountSum = 0
    @AppStorage("inuyashaKoyakuCountStartGameMemory3") var koyakuCountStartGame = 0
    @AppStorage("inuyashaKoyakuCountCurrentGameMemory3") var koyakuCountCurrentGame = 0
    @AppStorage("inuyashaKoyakuCountPlayGameMemory3") var koyakuCountPlayGame = 0
}

struct inuyasha2ViewTop: View {
//    @ObservedObject var inuyasha = Inuyasha()
    @StateObject var inuyasha = Inuyasha()
    @State var isShowAlert: Bool = false
    @StateObject var inuyashaMemory1 = InuyashaMemory1()
    @StateObject var inuyashaMemory2 = InuyashaMemory2()
    @StateObject var inuyashaMemory3 = InuyashaMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // お札演出
                    NavigationLink(destination: inuyashViewOfuda()) {
                        unitLabelMenu(
                            imageSystemName: "tag",
                            textBody: "お札演出"
                        )
                    }
                    // 小役
                    NavigationLink(destination: inuyashaViewKoyaku(inuyasha: inuyasha)) {
                        unitLabelMenu(
                            imageSystemName: "gift",
                            textBody: "設定差のある小役"
                        )
                    }
                    // AT初当り履歴
//                    NavigationLink(destination: inuyashaViewHistory()) {
//                        unitLabelMenu(
//                            imageSystemName: "pencil.and.list.clipboard",
//                            textBody: "AT初当たり履歴"
//                        )
//                    }
                    NavigationLink(destination: inuyashaViewHistoryVer2(inuyasha: inuyasha)) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "AT初当たり履歴"
                        )
//                        .popoverTip(tipVer171Inuyasha333TenjoAdd())
                    }
                    // 狙え演出
                    NavigationLink(destination: inuyashaViewAim(inuyasha: inuyasha)) {
                        unitLabelMenu(
                            imageSystemName: "light.beacon.min",
                            textBody: "狙え 成功時の犬夜叉ランプ")
                    }
                    // 目押しボイス
                    NavigationLink(destination: inuyashaViewVoice(inuyasha: inuyasha)) {
                        unitLabelMenu(
                            imageSystemName: "message",
                            textBody: "目押し成功時のボイス"
                        )
                    }
                    // Big終了画面
                    NavigationLink(destination: inuyashaViewBigScreen(inuyasha: inuyasha)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle",
                            textBody: "Big終了画面"
                        )
                    }
                    // AT終了画面
                    NavigationLink(destination: inuyashaViewAtScreen(inuyasha: inuyasha)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle",
                            textBody: "AT終了画面"
                        )
                    }
                    // エンディング
                    NavigationLink(destination: inuyashaViewEnding()) {
                        unitLabelMenu(
                            imageSystemName: "flag.checkered",
                            textBody: "エンディング"
                        )
                    }
                    // なみちゃんトロフィー
                    NavigationLink(destination: commonViewNamichanTrophy(textBodyAfterImage1: "※犬夜叉2の特殊柄は紅白柄")) {
                        unitLabelMenu(
                            imageSystemName: "trophy",
                            textBody: "なみちゃんトロフィー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "犬夜叉2")
                }
                // 設定推測グラフ
                NavigationLink(destination: inuyashaView95Ci(inuyasha: inuyasha, selection: 4)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4690")
//                    .popoverTip(tipVer220AddLink())
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(inuyashaSubViewLoadMemory(
                        inuyasha: inuyasha,
                        inuyashaMemory1: inuyashaMemory1,
                        inuyashaMemory2: inuyashaMemory2,
                        inuyashaMemory3: inuyashaMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(inuyashaSubViewSaveMemory(
                        inuyasha: inuyasha,
                        inuyashaMemory1: inuyashaMemory1,
                        inuyashaMemory2: inuyashaMemory2,
                        inuyashaMemory3: inuyashaMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: inuyasha.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct inuyashaSubViewSaveMemory: View {
    @ObservedObject var inuyasha: Inuyasha
    @ObservedObject var inuyashaMemory1: InuyashaMemory1
    @ObservedObject var inuyashaMemory2: InuyashaMemory2
    @ObservedObject var inuyashaMemory3: InuyashaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "犬夜叉2",
            selectedMemory: $inuyasha.selectedMemory,
            memoMemory1: $inuyashaMemory1.memo,
            dateDoubleMemory1: $inuyashaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $inuyashaMemory2.memo,
            dateDoubleMemory2: $inuyashaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $inuyashaMemory3.memo,
            dateDoubleMemory3: $inuyashaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        inuyashaMemory1.gameArrayData = inuyasha.gameArrayData
        inuyashaMemory1.cycleArrayData = inuyasha.cycleArrayData
        inuyashaMemory1.triggerArrayData = inuyasha.triggerArrayData
        inuyashaMemory1.cycleNumberArrayData = inuyasha.cycleNumberArrayData
        inuyashaMemory1.atHitCount = inuyasha.atHitCount
        inuyashaMemory1.playGameSum = inuyasha.playGameSum
        inuyashaMemory1.czHitCount = inuyasha.czHitCount
        inuyashaMemory1.cycleSum = inuyasha.cycleSum
        inuyashaMemory1.czHitCountWithoutTenjo = inuyasha.czHitCountWithoutTenjo
        inuyashaMemory1.cycleSumWithoutTenjo = inuyasha.cycleSumWithoutTenjo
        inuyashaMemory1.inuyashaLampCountWhite = inuyasha.inuyashaLampCountWhite
        inuyashaMemory1.inuyashaLampCountBlue = inuyasha.inuyashaLampCountBlue
        inuyashaMemory1.inuyashaLampCountRainbow = inuyasha.inuyashaLampCountRainbow
        inuyashaMemory1.inuyashaLampCountSum = inuyasha.inuyashaLampCountSum
        inuyashaMemory1.voiceCountDefault = inuyasha.voiceCountDefault
        inuyashaMemory1.voiceCountHighSisaJaku = inuyasha.voiceCountHighSisaJaku
        inuyashaMemory1.voiceCountHighSisaChu = inuyasha.voiceCountHighSisaChu
        inuyashaMemory1.voiceCountHighSisaKyo = inuyasha.voiceCountHighSisaKyo
        inuyashaMemory1.voiceCountSum = inuyasha.voiceCountSum
        inuyashaMemory1.bigScreenCountDefault = inuyasha.bigScreenCountDefault
        inuyashaMemory1.bigScreenCountOver2 = inuyasha.bigScreenCountOver2
        inuyashaMemory1.bigScreenCountHighSisa = inuyasha.bigScreenCountHighSisa
        inuyashaMemory1.bigScreenCountOver4 = inuyasha.bigScreenCountOver4
        inuyashaMemory1.bigScreenCountSum = inuyasha.bigScreenCountSum
        inuyashaMemory1.atScreenCountDefault = inuyasha.atScreenCountDefault
        inuyashaMemory1.atScreenCountGusu = inuyasha.atScreenCountGusu
        inuyashaMemory1.atScreenCountOver2 = inuyasha.atScreenCountOver2
        inuyashaMemory1.atScreenCountHighJaku = inuyasha.atScreenCountHighJaku
        inuyashaMemory1.atScreenCountHighChu = inuyasha.atScreenCountHighChu
        inuyashaMemory1.atScreenCountHighKyo = inuyasha.atScreenCountHighKyo
        inuyashaMemory1.atScreenCountOver4 = inuyasha.atScreenCountOver4
        inuyashaMemory1.atScreenCount6Kaku = inuyasha.atScreenCount6Kaku
        inuyashaMemory1.atScreenCountSum = inuyasha.atScreenCountSum
        inuyashaMemory1.bonusArrayData = inuyasha.bonusArrayData
        inuyashaMemory1.atHitArrayData = inuyasha.atHitArrayData
        inuyashaMemory1.over333CzCount = inuyasha.over333CzCount
        inuyashaMemory1.czCount = inuyasha.czCount
        inuyashaMemory1.hitCountAll = inuyasha.hitCountAll
        inuyashaMemory1.koyakuCountJakuCherry = inuyasha.koyakuCountJakuCherry
        inuyashaMemory1.koyakuCountKyoCherry = inuyasha.koyakuCountKyoCherry
        inuyashaMemory1.koyakuCountSuika = inuyasha.koyakuCountSuika
        inuyashaMemory1.koyakuCountChanceA = inuyasha.koyakuCountChanceA
        inuyashaMemory1.koyakuCountChanceB = inuyasha.koyakuCountChanceB
        inuyashaMemory1.koyakuCountSum = inuyasha.koyakuCountSum
        inuyashaMemory1.koyakuCountStartGame = inuyasha.koyakuCountStartGame
        inuyashaMemory1.koyakuCountCurrentGame = inuyasha.koyakuCountCurrentGame
        inuyashaMemory1.koyakuCountPlayGame = inuyasha.koyakuCountPlayGame
    }
    func saveMemory2() {
        inuyashaMemory2.gameArrayData = inuyasha.gameArrayData
        inuyashaMemory2.cycleArrayData = inuyasha.cycleArrayData
        inuyashaMemory2.triggerArrayData = inuyasha.triggerArrayData
        inuyashaMemory2.cycleNumberArrayData = inuyasha.cycleNumberArrayData
        inuyashaMemory2.atHitCount = inuyasha.atHitCount
        inuyashaMemory2.playGameSum = inuyasha.playGameSum
        inuyashaMemory2.czHitCount = inuyasha.czHitCount
        inuyashaMemory2.cycleSum = inuyasha.cycleSum
        inuyashaMemory2.czHitCountWithoutTenjo = inuyasha.czHitCountWithoutTenjo
        inuyashaMemory2.cycleSumWithoutTenjo = inuyasha.cycleSumWithoutTenjo
        inuyashaMemory2.inuyashaLampCountWhite = inuyasha.inuyashaLampCountWhite
        inuyashaMemory2.inuyashaLampCountBlue = inuyasha.inuyashaLampCountBlue
        inuyashaMemory2.inuyashaLampCountRainbow = inuyasha.inuyashaLampCountRainbow
        inuyashaMemory2.inuyashaLampCountSum = inuyasha.inuyashaLampCountSum
        inuyashaMemory2.voiceCountDefault = inuyasha.voiceCountDefault
        inuyashaMemory2.voiceCountHighSisaJaku = inuyasha.voiceCountHighSisaJaku
        inuyashaMemory2.voiceCountHighSisaChu = inuyasha.voiceCountHighSisaChu
        inuyashaMemory2.voiceCountHighSisaKyo = inuyasha.voiceCountHighSisaKyo
        inuyashaMemory2.voiceCountSum = inuyasha.voiceCountSum
        inuyashaMemory2.bigScreenCountDefault = inuyasha.bigScreenCountDefault
        inuyashaMemory2.bigScreenCountOver2 = inuyasha.bigScreenCountOver2
        inuyashaMemory2.bigScreenCountHighSisa = inuyasha.bigScreenCountHighSisa
        inuyashaMemory2.bigScreenCountOver4 = inuyasha.bigScreenCountOver4
        inuyashaMemory2.bigScreenCountSum = inuyasha.bigScreenCountSum
        inuyashaMemory2.atScreenCountDefault = inuyasha.atScreenCountDefault
        inuyashaMemory2.atScreenCountGusu = inuyasha.atScreenCountGusu
        inuyashaMemory2.atScreenCountOver2 = inuyasha.atScreenCountOver2
        inuyashaMemory2.atScreenCountHighJaku = inuyasha.atScreenCountHighJaku
        inuyashaMemory2.atScreenCountHighChu = inuyasha.atScreenCountHighChu
        inuyashaMemory2.atScreenCountHighKyo = inuyasha.atScreenCountHighKyo
        inuyashaMemory2.atScreenCountOver4 = inuyasha.atScreenCountOver4
        inuyashaMemory2.atScreenCount6Kaku = inuyasha.atScreenCount6Kaku
        inuyashaMemory2.atScreenCountSum = inuyasha.atScreenCountSum
        inuyashaMemory2.bonusArrayData = inuyasha.bonusArrayData
        inuyashaMemory2.atHitArrayData = inuyasha.atHitArrayData
        inuyashaMemory2.over333CzCount = inuyasha.over333CzCount
        inuyashaMemory2.czCount = inuyasha.czCount
        inuyashaMemory2.hitCountAll = inuyasha.hitCountAll
        inuyashaMemory2.koyakuCountJakuCherry = inuyasha.koyakuCountJakuCherry
        inuyashaMemory2.koyakuCountKyoCherry = inuyasha.koyakuCountKyoCherry
        inuyashaMemory2.koyakuCountSuika = inuyasha.koyakuCountSuika
        inuyashaMemory2.koyakuCountChanceA = inuyasha.koyakuCountChanceA
        inuyashaMemory2.koyakuCountChanceB = inuyasha.koyakuCountChanceB
        inuyashaMemory2.koyakuCountSum = inuyasha.koyakuCountSum
        inuyashaMemory2.koyakuCountStartGame = inuyasha.koyakuCountStartGame
        inuyashaMemory2.koyakuCountCurrentGame = inuyasha.koyakuCountCurrentGame
        inuyashaMemory2.koyakuCountPlayGame = inuyasha.koyakuCountPlayGame
    }
    func saveMemory3() {
        inuyashaMemory3.gameArrayData = inuyasha.gameArrayData
        inuyashaMemory3.cycleArrayData = inuyasha.cycleArrayData
        inuyashaMemory3.triggerArrayData = inuyasha.triggerArrayData
        inuyashaMemory3.cycleNumberArrayData = inuyasha.cycleNumberArrayData
        inuyashaMemory3.atHitCount = inuyasha.atHitCount
        inuyashaMemory3.playGameSum = inuyasha.playGameSum
        inuyashaMemory3.czHitCount = inuyasha.czHitCount
        inuyashaMemory3.cycleSum = inuyasha.cycleSum
        inuyashaMemory3.czHitCountWithoutTenjo = inuyasha.czHitCountWithoutTenjo
        inuyashaMemory3.cycleSumWithoutTenjo = inuyasha.cycleSumWithoutTenjo
        inuyashaMemory3.inuyashaLampCountWhite = inuyasha.inuyashaLampCountWhite
        inuyashaMemory3.inuyashaLampCountBlue = inuyasha.inuyashaLampCountBlue
        inuyashaMemory3.inuyashaLampCountRainbow = inuyasha.inuyashaLampCountRainbow
        inuyashaMemory3.inuyashaLampCountSum = inuyasha.inuyashaLampCountSum
        inuyashaMemory3.voiceCountDefault = inuyasha.voiceCountDefault
        inuyashaMemory3.voiceCountHighSisaJaku = inuyasha.voiceCountHighSisaJaku
        inuyashaMemory3.voiceCountHighSisaChu = inuyasha.voiceCountHighSisaChu
        inuyashaMemory3.voiceCountHighSisaKyo = inuyasha.voiceCountHighSisaKyo
        inuyashaMemory3.voiceCountSum = inuyasha.voiceCountSum
        inuyashaMemory3.bigScreenCountDefault = inuyasha.bigScreenCountDefault
        inuyashaMemory3.bigScreenCountOver2 = inuyasha.bigScreenCountOver2
        inuyashaMemory3.bigScreenCountHighSisa = inuyasha.bigScreenCountHighSisa
        inuyashaMemory3.bigScreenCountOver4 = inuyasha.bigScreenCountOver4
        inuyashaMemory3.bigScreenCountSum = inuyasha.bigScreenCountSum
        inuyashaMemory3.atScreenCountDefault = inuyasha.atScreenCountDefault
        inuyashaMemory3.atScreenCountGusu = inuyasha.atScreenCountGusu
        inuyashaMemory3.atScreenCountOver2 = inuyasha.atScreenCountOver2
        inuyashaMemory3.atScreenCountHighJaku = inuyasha.atScreenCountHighJaku
        inuyashaMemory3.atScreenCountHighChu = inuyasha.atScreenCountHighChu
        inuyashaMemory3.atScreenCountHighKyo = inuyasha.atScreenCountHighKyo
        inuyashaMemory3.atScreenCountOver4 = inuyasha.atScreenCountOver4
        inuyashaMemory3.atScreenCount6Kaku = inuyasha.atScreenCount6Kaku
        inuyashaMemory3.atScreenCountSum = inuyasha.atScreenCountSum
        inuyashaMemory3.bonusArrayData = inuyasha.bonusArrayData
        inuyashaMemory3.atHitArrayData = inuyasha.atHitArrayData
        inuyashaMemory3.over333CzCount = inuyasha.over333CzCount
        inuyashaMemory3.czCount = inuyasha.czCount
        inuyashaMemory3.hitCountAll = inuyasha.hitCountAll
        inuyashaMemory3.koyakuCountJakuCherry = inuyasha.koyakuCountJakuCherry
        inuyashaMemory3.koyakuCountKyoCherry = inuyasha.koyakuCountKyoCherry
        inuyashaMemory3.koyakuCountSuika = inuyasha.koyakuCountSuika
        inuyashaMemory3.koyakuCountChanceA = inuyasha.koyakuCountChanceA
        inuyashaMemory3.koyakuCountChanceB = inuyasha.koyakuCountChanceB
        inuyashaMemory3.koyakuCountSum = inuyasha.koyakuCountSum
        inuyashaMemory3.koyakuCountStartGame = inuyasha.koyakuCountStartGame
        inuyashaMemory3.koyakuCountCurrentGame = inuyasha.koyakuCountCurrentGame
        inuyashaMemory3.koyakuCountPlayGame = inuyasha.koyakuCountPlayGame
    }
}

// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct inuyashaSubViewLoadMemory: View {
    @ObservedObject var inuyasha: Inuyasha
    @ObservedObject var inuyashaMemory1: InuyashaMemory1
    @ObservedObject var inuyashaMemory2: InuyashaMemory2
    @ObservedObject var inuyashaMemory3: InuyashaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "犬夜叉2",
            selectedMemory: $inuyasha.selectedMemory,
            memoMemory1: inuyashaMemory1.memo,
            dateDoubleMemory1: inuyashaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: inuyashaMemory2.memo,
            dateDoubleMemory2: inuyashaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: inuyashaMemory3.memo,
            dateDoubleMemory3: inuyashaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        let memoryGameArray = decodeIntArray(from: inuyashaMemory1.gameArrayData)
        saveArray(memoryGameArray, forKey: inuyasha.gameArrayKey)
        let memoryCycleArray = decodeStringArray(from: inuyashaMemory1.cycleArrayData)
        saveArray(memoryCycleArray, forKey: inuyasha.cycleArrayKey)
        let memoryTriggerArray = decodeStringArray(from: inuyashaMemory1.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: inuyasha.triggerArrayKey)
        let memoryCycleNumberArray = decodeIntArray(from: inuyashaMemory1.cycleNumberArrayData)
        saveArray(memoryCycleNumberArray, forKey: inuyasha.cycleNumberArrayKey)
//        inuyasha.gameArrayData = inuyashaMemory1.gameArrayData
//        inuyasha.cycleArrayData = inuyashaMemory1.cycleArrayData
//        inuyasha.triggerArrayData = inuyashaMemory1.triggerArrayData
//        inuyasha.cycleNumberArrayData = inuyashaMemory1.cycleNumberArrayData
        inuyasha.atHitCount = inuyashaMemory1.atHitCount
        inuyasha.playGameSum = inuyashaMemory1.playGameSum
        inuyasha.czHitCount = inuyashaMemory1.czHitCount
        inuyasha.cycleSum = inuyashaMemory1.cycleSum
        inuyasha.czHitCountWithoutTenjo = inuyashaMemory1.czHitCountWithoutTenjo
        inuyasha.cycleSumWithoutTenjo = inuyashaMemory1.cycleSumWithoutTenjo
        inuyasha.inuyashaLampCountWhite = inuyashaMemory1.inuyashaLampCountWhite
        inuyasha.inuyashaLampCountBlue = inuyashaMemory1.inuyashaLampCountBlue
        inuyasha.inuyashaLampCountRainbow = inuyashaMemory1.inuyashaLampCountRainbow
        inuyasha.inuyashaLampCountSum = inuyashaMemory1.inuyashaLampCountSum
        inuyasha.voiceCountDefault = inuyashaMemory1.voiceCountDefault
        inuyasha.voiceCountHighSisaJaku = inuyashaMemory1.voiceCountHighSisaJaku
        inuyasha.voiceCountHighSisaChu = inuyashaMemory1.voiceCountHighSisaChu
        inuyasha.voiceCountHighSisaKyo = inuyashaMemory1.voiceCountHighSisaKyo
        inuyasha.voiceCountSum = inuyashaMemory1.voiceCountSum
        inuyasha.bigScreenCountDefault = inuyashaMemory1.bigScreenCountDefault
        inuyasha.bigScreenCountOver2 = inuyashaMemory1.bigScreenCountOver2
        inuyasha.bigScreenCountHighSisa = inuyashaMemory1.bigScreenCountHighSisa
        inuyasha.bigScreenCountOver4 = inuyashaMemory1.bigScreenCountOver4
        inuyasha.bigScreenCountSum = inuyashaMemory1.bigScreenCountSum
        inuyasha.atScreenCountDefault = inuyashaMemory1.atScreenCountDefault
        inuyasha.atScreenCountGusu = inuyashaMemory1.atScreenCountGusu
        inuyasha.atScreenCountOver2 = inuyashaMemory1.atScreenCountOver2
        inuyasha.atScreenCountHighJaku = inuyashaMemory1.atScreenCountHighJaku
        inuyasha.atScreenCountHighChu = inuyashaMemory1.atScreenCountHighChu
        inuyasha.atScreenCountHighKyo = inuyashaMemory1.atScreenCountHighKyo
        inuyasha.atScreenCountOver4 = inuyashaMemory1.atScreenCountOver4
        inuyasha.atScreenCount6Kaku = inuyashaMemory1.atScreenCount6Kaku
        inuyasha.atScreenCountSum = inuyashaMemory1.atScreenCountSum
        let memoryBonusArray = decodeStringArray(from: inuyashaMemory1.bonusArrayData)
        saveArray(memoryBonusArray, forKey: inuyasha.bonusArrayKey)
        let memoryAtHitArray = decodeStringArray(from: inuyashaMemory1.atHitArrayData)
        saveArray(memoryAtHitArray, forKey: inuyasha.atHitArrayKey)
//        inuyasha.bonusArrayData = inuyashaMemory1.bonusArrayData
//        inuyasha.atHitArrayData = inuyashaMemory1.atHitArrayData
        inuyasha.over333CzCount = inuyashaMemory1.over333CzCount
        inuyasha.czCount = inuyashaMemory1.czCount
        inuyasha.hitCountAll = inuyashaMemory1.hitCountAll
        inuyasha.koyakuCountJakuCherry = inuyashaMemory1.koyakuCountJakuCherry
        inuyasha.koyakuCountKyoCherry = inuyashaMemory1.koyakuCountKyoCherry
        inuyasha.koyakuCountSuika = inuyashaMemory1.koyakuCountSuika
        inuyasha.koyakuCountChanceA = inuyashaMemory1.koyakuCountChanceA
        inuyasha.koyakuCountChanceB = inuyashaMemory1.koyakuCountChanceB
        inuyasha.koyakuCountSum = inuyashaMemory1.koyakuCountSum
        inuyasha.koyakuCountStartGame = inuyashaMemory1.koyakuCountStartGame
        inuyasha.koyakuCountCurrentGame = inuyashaMemory1.koyakuCountCurrentGame
        inuyasha.koyakuCountPlayGame = inuyashaMemory1.koyakuCountPlayGame
    }
    func loadMemory2() {
        let memoryGameArray = decodeIntArray(from: inuyashaMemory2.gameArrayData)
        saveArray(memoryGameArray, forKey: inuyasha.gameArrayKey)
        let memoryCycleArray = decodeStringArray(from: inuyashaMemory2.cycleArrayData)
        saveArray(memoryCycleArray, forKey: inuyasha.cycleArrayKey)
        let memoryTriggerArray = decodeStringArray(from: inuyashaMemory2.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: inuyasha.triggerArrayKey)
        let memoryCycleNumberArray = decodeIntArray(from: inuyashaMemory2.cycleNumberArrayData)
        saveArray(memoryCycleNumberArray, forKey: inuyasha.cycleNumberArrayKey)
//        inuyasha.gameArrayData = inuyashaMemory2.gameArrayData
//        inuyasha.cycleArrayData = inuyashaMemory2.cycleArrayData
//        inuyasha.triggerArrayData = inuyashaMemory2.triggerArrayData
//        inuyasha.cycleNumberArrayData = inuyashaMemory2.cycleNumberArrayData
        inuyasha.atHitCount = inuyashaMemory2.atHitCount
        inuyasha.playGameSum = inuyashaMemory2.playGameSum
        inuyasha.czHitCount = inuyashaMemory2.czHitCount
        inuyasha.cycleSum = inuyashaMemory2.cycleSum
        inuyasha.czHitCountWithoutTenjo = inuyashaMemory2.czHitCountWithoutTenjo
        inuyasha.cycleSumWithoutTenjo = inuyashaMemory2.cycleSumWithoutTenjo
        inuyasha.inuyashaLampCountWhite = inuyashaMemory2.inuyashaLampCountWhite
        inuyasha.inuyashaLampCountBlue = inuyashaMemory2.inuyashaLampCountBlue
        inuyasha.inuyashaLampCountRainbow = inuyashaMemory2.inuyashaLampCountRainbow
        inuyasha.inuyashaLampCountSum = inuyashaMemory2.inuyashaLampCountSum
        inuyasha.voiceCountDefault = inuyashaMemory2.voiceCountDefault
        inuyasha.voiceCountHighSisaJaku = inuyashaMemory2.voiceCountHighSisaJaku
        inuyasha.voiceCountHighSisaChu = inuyashaMemory2.voiceCountHighSisaChu
        inuyasha.voiceCountHighSisaKyo = inuyashaMemory2.voiceCountHighSisaKyo
        inuyasha.voiceCountSum = inuyashaMemory2.voiceCountSum
        inuyasha.bigScreenCountDefault = inuyashaMemory2.bigScreenCountDefault
        inuyasha.bigScreenCountOver2 = inuyashaMemory2.bigScreenCountOver2
        inuyasha.bigScreenCountHighSisa = inuyashaMemory2.bigScreenCountHighSisa
        inuyasha.bigScreenCountOver4 = inuyashaMemory2.bigScreenCountOver4
        inuyasha.bigScreenCountSum = inuyashaMemory2.bigScreenCountSum
        inuyasha.atScreenCountDefault = inuyashaMemory2.atScreenCountDefault
        inuyasha.atScreenCountGusu = inuyashaMemory2.atScreenCountGusu
        inuyasha.atScreenCountOver2 = inuyashaMemory2.atScreenCountOver2
        inuyasha.atScreenCountHighJaku = inuyashaMemory2.atScreenCountHighJaku
        inuyasha.atScreenCountHighChu = inuyashaMemory2.atScreenCountHighChu
        inuyasha.atScreenCountHighKyo = inuyashaMemory2.atScreenCountHighKyo
        inuyasha.atScreenCountOver4 = inuyashaMemory2.atScreenCountOver4
        inuyasha.atScreenCount6Kaku = inuyashaMemory2.atScreenCount6Kaku
        inuyasha.atScreenCountSum = inuyashaMemory2.atScreenCountSum
        let memoryBonusArray = decodeStringArray(from: inuyashaMemory2.bonusArrayData)
        saveArray(memoryBonusArray, forKey: inuyasha.bonusArrayKey)
        let memoryAtHitArray = decodeStringArray(from: inuyashaMemory2.atHitArrayData)
        saveArray(memoryAtHitArray, forKey: inuyasha.atHitArrayKey)
//        inuyasha.bonusArrayData = inuyashaMemory2.bonusArrayData
//        inuyasha.atHitArrayData = inuyashaMemory2.atHitArrayData
        inuyasha.over333CzCount = inuyashaMemory2.over333CzCount
        inuyasha.czCount = inuyashaMemory2.czCount
        inuyasha.hitCountAll = inuyashaMemory2.hitCountAll
        inuyasha.koyakuCountJakuCherry = inuyashaMemory2.koyakuCountJakuCherry
        inuyasha.koyakuCountKyoCherry = inuyashaMemory2.koyakuCountKyoCherry
        inuyasha.koyakuCountSuika = inuyashaMemory2.koyakuCountSuika
        inuyasha.koyakuCountChanceA = inuyashaMemory2.koyakuCountChanceA
        inuyasha.koyakuCountChanceB = inuyashaMemory2.koyakuCountChanceB
        inuyasha.koyakuCountSum = inuyashaMemory2.koyakuCountSum
        inuyasha.koyakuCountStartGame = inuyashaMemory2.koyakuCountStartGame
        inuyasha.koyakuCountCurrentGame = inuyashaMemory2.koyakuCountCurrentGame
        inuyasha.koyakuCountPlayGame = inuyashaMemory2.koyakuCountPlayGame
    }
    func loadMemory3() {
        let memoryGameArray = decodeIntArray(from: inuyashaMemory3.gameArrayData)
        saveArray(memoryGameArray, forKey: inuyasha.gameArrayKey)
        let memoryCycleArray = decodeStringArray(from: inuyashaMemory3.cycleArrayData)
        saveArray(memoryCycleArray, forKey: inuyasha.cycleArrayKey)
        let memoryTriggerArray = decodeStringArray(from: inuyashaMemory3.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: inuyasha.triggerArrayKey)
        let memoryCycleNumberArray = decodeIntArray(from: inuyashaMemory3.cycleNumberArrayData)
        saveArray(memoryCycleNumberArray, forKey: inuyasha.cycleNumberArrayKey)
//        inuyasha.gameArrayData = inuyashaMemory3.gameArrayData
//        inuyasha.cycleArrayData = inuyashaMemory3.cycleArrayData
//        inuyasha.triggerArrayData = inuyashaMemory3.triggerArrayData
//        inuyasha.cycleNumberArrayData = inuyashaMemory3.cycleNumberArrayData
        inuyasha.atHitCount = inuyashaMemory3.atHitCount
        inuyasha.playGameSum = inuyashaMemory3.playGameSum
        inuyasha.czHitCount = inuyashaMemory3.czHitCount
        inuyasha.cycleSum = inuyashaMemory3.cycleSum
        inuyasha.czHitCountWithoutTenjo = inuyashaMemory3.czHitCountWithoutTenjo
        inuyasha.cycleSumWithoutTenjo = inuyashaMemory3.cycleSumWithoutTenjo
        inuyasha.inuyashaLampCountWhite = inuyashaMemory3.inuyashaLampCountWhite
        inuyasha.inuyashaLampCountBlue = inuyashaMemory3.inuyashaLampCountBlue
        inuyasha.inuyashaLampCountRainbow = inuyashaMemory3.inuyashaLampCountRainbow
        inuyasha.inuyashaLampCountSum = inuyashaMemory3.inuyashaLampCountSum
        inuyasha.voiceCountDefault = inuyashaMemory3.voiceCountDefault
        inuyasha.voiceCountHighSisaJaku = inuyashaMemory3.voiceCountHighSisaJaku
        inuyasha.voiceCountHighSisaChu = inuyashaMemory3.voiceCountHighSisaChu
        inuyasha.voiceCountHighSisaKyo = inuyashaMemory3.voiceCountHighSisaKyo
        inuyasha.voiceCountSum = inuyashaMemory3.voiceCountSum
        inuyasha.bigScreenCountDefault = inuyashaMemory3.bigScreenCountDefault
        inuyasha.bigScreenCountOver2 = inuyashaMemory3.bigScreenCountOver2
        inuyasha.bigScreenCountHighSisa = inuyashaMemory3.bigScreenCountHighSisa
        inuyasha.bigScreenCountOver4 = inuyashaMemory3.bigScreenCountOver4
        inuyasha.bigScreenCountSum = inuyashaMemory3.bigScreenCountSum
        inuyasha.atScreenCountDefault = inuyashaMemory3.atScreenCountDefault
        inuyasha.atScreenCountGusu = inuyashaMemory3.atScreenCountGusu
        inuyasha.atScreenCountOver2 = inuyashaMemory3.atScreenCountOver2
        inuyasha.atScreenCountHighJaku = inuyashaMemory3.atScreenCountHighJaku
        inuyasha.atScreenCountHighChu = inuyashaMemory3.atScreenCountHighChu
        inuyasha.atScreenCountHighKyo = inuyashaMemory3.atScreenCountHighKyo
        inuyasha.atScreenCountOver4 = inuyashaMemory3.atScreenCountOver4
        inuyasha.atScreenCount6Kaku = inuyashaMemory3.atScreenCount6Kaku
        inuyasha.atScreenCountSum = inuyashaMemory3.atScreenCountSum
        let memoryBonusArray = decodeStringArray(from: inuyashaMemory3.bonusArrayData)
        saveArray(memoryBonusArray, forKey: inuyasha.bonusArrayKey)
        let memoryAtHitArray = decodeStringArray(from: inuyashaMemory3.atHitArrayData)
        saveArray(memoryAtHitArray, forKey: inuyasha.atHitArrayKey)
//        inuyasha.bonusArrayData = inuyashaMemory3.bonusArrayData
//        inuyasha.atHitArrayData = inuyashaMemory3.atHitArrayData
        inuyasha.over333CzCount = inuyashaMemory3.over333CzCount
        inuyasha.czCount = inuyashaMemory3.czCount
        inuyasha.hitCountAll = inuyashaMemory3.hitCountAll
        inuyasha.koyakuCountJakuCherry = inuyashaMemory3.koyakuCountJakuCherry
        inuyasha.koyakuCountKyoCherry = inuyashaMemory3.koyakuCountKyoCherry
        inuyasha.koyakuCountSuika = inuyashaMemory3.koyakuCountSuika
        inuyasha.koyakuCountChanceA = inuyashaMemory3.koyakuCountChanceA
        inuyasha.koyakuCountChanceB = inuyashaMemory3.koyakuCountChanceB
        inuyasha.koyakuCountSum = inuyashaMemory3.koyakuCountSum
        inuyasha.koyakuCountStartGame = inuyashaMemory3.koyakuCountStartGame
        inuyasha.koyakuCountCurrentGame = inuyashaMemory3.koyakuCountCurrentGame
        inuyasha.koyakuCountPlayGame = inuyashaMemory3.koyakuCountPlayGame
    }
}

#Preview {
    inuyasha2ViewTop()
}
