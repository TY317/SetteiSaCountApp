//
//  lupinViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/08.
//

import SwiftUI
import TipKit

// /////////////////////////
// 変数
// /////////////////////////
class Lupin: ObservableObject {
    // /////////////////////////
    // 履歴
    // /////////////////////////
    // 選択肢の設定
    let selectListBonus = ["SH", "ルパン", "次元", "五エ門", "不二子"]
    let selectListTrigger = ["規定G数", "強🍒直撃", "レア役直撃", "ICPO", "フリーズ", "天井", "その他"]
    let selectListAtHitDouble = ["当選"]
    let selectListAtHitSingle = ["当選", "ハズレ"]
    // 選択結果の設定
    @Published var inputGame = 0
    @Published var selectedBonus = "ルパン"
    @Published var selectedTriger = "規定G数"
    @Published var selectedAtHit = "当選"
    // //// 配列の設定
    // ゲーム数配列
    let gameArrayKey = "lupinGameArrayKey"
    @AppStorage("lupinGameArrayKey") var gameArrayData: Data?
    // ボーナス種類配列
    let bonusArrayKey = "lupinBonusArrayKey"
    @AppStorage("lupinBonusArrayKey") var bonusArrayData: Data?
    // 当選契機配列
    let triggerArrayKey = "lupinTriggerArrayKey"
    @AppStorage("lupinTriggerArrayKey") var triggerArrayData: Data?
    // AT当否配列
    let atHitArrayKey = "lupinAtHitArrayKey"
    @AppStorage("lupinAtHitArrayKey") var atHitArrayData: Data?
    // //// 結果集計、カウント用
    @AppStorage("lupinCherryCountAll") var cherryCountAll = 0
    @AppStorage("lupinCherryCountHit") var cherryCountHit = 0
    @AppStorage("lupinCzCountAll") var czCountAll = 0
    @AppStorage("lupinCzCountHit") var czCountHit = 0
    @AppStorage("lupinBonusCount") var bonusCount = 0
    @AppStorage("lupinAtCount") var atCount = 0
    @AppStorage("lupinBonusCharaCountLupin") var bonusCharaCountLupin = 0
    @AppStorage("lupinBonusCharaCountJigen") var bonusCharaCountJigen = 0
    @AppStorage("lupinBonusCharaCountGoemon") var bonusCharaCountGoemon = 0
    @AppStorage("lupinBonusCharaCountFujiko") var bonusCharaCountFujiko = 0
    @AppStorage("lupinBonusCharaCountSum") var bonusCharaCountSum = 0
    @AppStorage("lupinPlayGameSum") var playGameSum = 0
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: bonusArrayData, key: bonusArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveLast(arrayData: atHitArrayData, key: atHitArrayKey)
        cherryCountHit = arrayStringDataCount(arrayData: triggerArrayData, countString: selectListTrigger[1])
        czCountHit = arrayStringDataCount(arrayData: triggerArrayData, countString: selectListTrigger[3])
        bonusCount = arrayIntAllDataCount(arrayData: gameArrayData)
        atCount = arrayStringDataCount(arrayData: atHitArrayData, countString: selectListAtHitSingle[0])
        bonusCharaCountLupin = arrayStringDataCount(arrayData: bonusArrayData, countString: selectListBonus[1])
        bonusCharaCountJigen = arrayStringDataCount(arrayData: bonusArrayData, countString: selectListBonus[2])
        bonusCharaCountGoemon = arrayStringDataCount(arrayData: bonusArrayData, countString: selectListBonus[3])
        bonusCharaCountFujiko = arrayStringDataCount(arrayData: bonusArrayData, countString: selectListBonus[4])
        bonusCharaCountSum = countSum(bonusCharaCountLupin, bonusCharaCountJigen, bonusCharaCountGoemon, bonusCharaCountFujiko)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedBonus = "ルパン"
        selectedTriger = "規定G数"
        selectedAtHit = "当選"
    }
    // データ追加
    func addDataHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedTriger, key: triggerArrayKey)
        arrayStringAddData(arrayData: atHitArrayData, addData: selectedAtHit, key: atHitArrayKey)
        cherryCountHit = arrayStringDataCount(arrayData: triggerArrayData, countString: selectListTrigger[1])
        czCountHit = arrayStringDataCount(arrayData: triggerArrayData, countString: selectListTrigger[3])
        bonusCount = arrayIntAllDataCount(arrayData: gameArrayData)
        atCount = arrayStringDataCount(arrayData: atHitArrayData, countString: selectListAtHitSingle[0])
        bonusCharaCountLupin = arrayStringDataCount(arrayData: bonusArrayData, countString: selectListBonus[1])
        bonusCharaCountJigen = arrayStringDataCount(arrayData: bonusArrayData, countString: selectListBonus[2])
        bonusCharaCountGoemon = arrayStringDataCount(arrayData: bonusArrayData, countString: selectListBonus[3])
        bonusCharaCountFujiko = arrayStringDataCount(arrayData: bonusArrayData, countString: selectListBonus[4])
        bonusCharaCountSum = countSum(bonusCharaCountLupin, bonusCharaCountJigen, bonusCharaCountGoemon, bonusCharaCountFujiko)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedBonus = "ルパン"
        selectedTriger = "規定G数"
        selectedAtHit = "当選"
    }
    
    func resetHistory() {
        cherryCountAll = 0
        czCountAll = 0
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: bonusArrayData, key: bonusArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveAll(arrayData: atHitArrayData, key: atHitArrayKey)
        cherryCountHit = arrayStringDataCount(arrayData: triggerArrayData, countString: selectListTrigger[1])
        czCountHit = arrayStringDataCount(arrayData: triggerArrayData, countString: selectListTrigger[3])
        bonusCount = arrayIntAllDataCount(arrayData: gameArrayData)
        atCount = arrayStringDataCount(arrayData: atHitArrayData, countString: selectListAtHitSingle[0])
        bonusCharaCountLupin = arrayStringDataCount(arrayData: bonusArrayData, countString: selectListBonus[1])
        bonusCharaCountJigen = arrayStringDataCount(arrayData: bonusArrayData, countString: selectListBonus[2])
        bonusCharaCountGoemon = arrayStringDataCount(arrayData: bonusArrayData, countString: selectListBonus[3])
        bonusCharaCountFujiko = arrayStringDataCount(arrayData: bonusArrayData, countString: selectListBonus[4])
        bonusCharaCountSum = countSum(bonusCharaCountLupin, bonusCharaCountJigen, bonusCharaCountGoemon, bonusCharaCountFujiko)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedBonus = "ルパン"
        selectedTriger = "規定G数"
        selectedAtHit = "当選"
        minusCheck = false
    }
    
    // /////////////////////////
    // シングル揃いボーナス終了後のボイス
    // /////////////////////////
    // ボイス選択肢の設定
    @Published var selectListBonusVoice = [
        "さーてひと仕事すっかー",
        "そろそろスピード上げてこうぜ",
        "今宵の斬鉄剣は一味違うぞ",
        "お前さんは勘が鋭いねぇ",
        "面白くなってきやがった",
        "善は急げだ",
        "獲物は近いぞ〜",
        "目的地は近そうだなぁ(次元)",
        "目的地は近そうだな(五エ門)",
        "とびっきりのスリルが味わえる場面さぁ",
        "こいつぁ大仕事になりそうだ",
        "お主らが持つお宝、某がもらい受ける",
        "ウヒョー極上のお宝ちゃん",
        "お前の魅力はでっかいことをやることにあるんだぜ",
        "人の心に残るものが、本当の宝"
    ]
    @AppStorage("lupinSelectedVoice") var selectedBonusVoice = "さーてひと仕事すっかー"
    @AppStorage("lupinBonusVoiceCountDefault") var bonusVoiceCountDefault = 0 {
        didSet {
            bonusVoiceCountSum = countSum(bonusVoiceCountDefault, bonusVoiceCountHighSisaJaku, bonusVoiceCountHighSisaKyo, bonusVoiceCountOver4, bonusVoiceCount6kaku)
        }
    }
        @AppStorage("lupinBonusVoiceCountHighSisaJaku") var bonusVoiceCountHighSisaJaku = 0 {
            didSet {
                bonusVoiceCountSum = countSum(bonusVoiceCountDefault, bonusVoiceCountHighSisaJaku, bonusVoiceCountHighSisaKyo, bonusVoiceCountOver4, bonusVoiceCount6kaku)
            }
        }
            @AppStorage("lupinBonusVoiceCountHighSisaKyo") var bonusVoiceCountHighSisaKyo = 0 {
                didSet {
                    bonusVoiceCountSum = countSum(bonusVoiceCountDefault, bonusVoiceCountHighSisaJaku, bonusVoiceCountHighSisaKyo, bonusVoiceCountOver4, bonusVoiceCount6kaku)
                }
            }
                @AppStorage("lupinBonusVoiceCountOver4") var bonusVoiceCountOver4 = 0 {
                    didSet {
                        bonusVoiceCountSum = countSum(bonusVoiceCountDefault, bonusVoiceCountHighSisaJaku, bonusVoiceCountHighSisaKyo, bonusVoiceCountOver4, bonusVoiceCount6kaku)
                    }
                }
                    @AppStorage("lupinBonusVoiceCount6kaku") var bonusVoiceCount6kaku = 0 {
                        didSet {
                            bonusVoiceCountSum = countSum(bonusVoiceCountDefault, bonusVoiceCountHighSisaJaku, bonusVoiceCountHighSisaKyo, bonusVoiceCountOver4, bonusVoiceCount6kaku)
                        }
                    }
    @AppStorage("lupinBonusVoiceCountSum") var bonusVoiceCountSum = 0
    func resetBonusVoice() {
        bonusVoiceCountDefault = 0
        bonusVoiceCountHighSisaJaku = 0
        bonusVoiceCountHighSisaKyo = 0
        bonusVoiceCountOver4 = 0
        bonusVoiceCount6kaku = 0
        selectedBonusVoice = "さーてひと仕事すっかー"
        minusCheck = false
    }
    
    
    // /////////////////////////
    // AT終了後のセリフ
    // /////////////////////////
    // セリフ選択肢の設定
    @Published var selectListAtVoice = [
        "なし",
        "謎は解けるまでが楽しいのよ",
        "道が無けりゃ作っていくまでよ",
        "自分で決めなきゃ明日は開かれねぇんだぜ",
        "男はよ、女に騙されるために生きているのさ",
        "いい女ほど簡単に微笑んでくれないのさ",
        "夢、盗まれちまったからな取り返しに行かにゃ",
        "今は、これが精いっぱい"
    ]
    @AppStorage("lupinSelectedAtVoice") var selectedAtVoice = "なし"
    @AppStorage("lupinAtVoiceCountDefault") var atVoiceCountDefault = 0 {
        didSet {
            atVoiceCountSum = countSum(atVoiceCountDefault, atVoiceCountGusu, atVoiceCount356Sisa, atVoiceCountOver2Sisa, atVoiceCountOver4Sisa, atVoiceCountHighSisa, atVoiceCountSilverGold)
        }
    }
        @AppStorage("lupinAtVoiceCountGusu") var atVoiceCountGusu = 0 {
            didSet {
                atVoiceCountSum = countSum(atVoiceCountDefault, atVoiceCountGusu, atVoiceCount356Sisa, atVoiceCountOver2Sisa, atVoiceCountOver4Sisa, atVoiceCountHighSisa, atVoiceCountSilverGold)
            }
        }
            @AppStorage("lupinAtVoiceCount356Sisa") var atVoiceCount356Sisa = 0 {
                didSet {
                    atVoiceCountSum = countSum(atVoiceCountDefault, atVoiceCountGusu, atVoiceCount356Sisa, atVoiceCountOver2Sisa, atVoiceCountOver4Sisa, atVoiceCountHighSisa, atVoiceCountSilverGold)
                }
            }
                @AppStorage("lupinAtVoiceCountOver2Sisa") var atVoiceCountOver2Sisa = 0 {
                    didSet {
                        atVoiceCountSum = countSum(atVoiceCountDefault, atVoiceCountGusu, atVoiceCount356Sisa, atVoiceCountOver2Sisa, atVoiceCountOver4Sisa, atVoiceCountHighSisa, atVoiceCountSilverGold)
                    }
                }
                    @AppStorage("lupinAtVoiceCountOver4Sisa") var atVoiceCountOver4Sisa = 0 {
                        didSet {
                            atVoiceCountSum = countSum(atVoiceCountDefault, atVoiceCountGusu, atVoiceCount356Sisa, atVoiceCountOver2Sisa, atVoiceCountOver4Sisa, atVoiceCountHighSisa, atVoiceCountSilverGold)
                        }
                    }
                        @AppStorage("lupinAtVoiceCountHighSisa") var atVoiceCountHighSisa = 0 {
                            didSet {
                                atVoiceCountSum = countSum(atVoiceCountDefault, atVoiceCountGusu, atVoiceCount356Sisa, atVoiceCountOver2Sisa, atVoiceCountOver4Sisa, atVoiceCountHighSisa, atVoiceCountSilverGold)
                            }
                        }
                            @AppStorage("lupinAtVoiceCountSilverGold") var atVoiceCountSilverGold = 0 {
                                didSet {
                                    atVoiceCountSum = countSum(atVoiceCountDefault, atVoiceCountGusu, atVoiceCount356Sisa, atVoiceCountOver2Sisa, atVoiceCountOver4Sisa, atVoiceCountHighSisa, atVoiceCountSilverGold)
                                }
                            }
    @AppStorage("lupinAtVoiceCountSum") var atVoiceCountSum = 0
    
    func resetAtVoice() {
        atVoiceCountDefault = 0
        atVoiceCountGusu = 0
        atVoiceCount356Sisa = 0
        atVoiceCountOver2Sisa = 0
        atVoiceCountOver4Sisa = 0
        atVoiceCountHighSisa = 0
        atVoiceCountSilverGold = 0
        minusCheck = false
    }
    
    // /////////////////////////
    // AT終了画面
    // /////////////////////////
    @AppStorage("lupinAtScreenCurrentKeyword") var atScreenCurrentKeyword: String = ""
    let atScreenKeywordList: [String] = [
        "lupinAtScreenDefault",
        "lupinAtScreenIchimi",
        "lupinAtScreenKa",
        "lupinAtScreenKichi",
        "lupinAtScreenRyo",
        "lupinAtScreenYu",
        "lupinAtScreenKiwami"
    ]
    @AppStorage("lupinAtScreenCountDefault") var atScreenCountDefault = 0 {
        didSet {
            atScreenCountSum = countSum(atScreenCountDefault, atScreenCountIchimi, atScreenCountKa, atScreenCountKichi, atScreenCountRyo, atScreenCountYu, atScreenCountKiwami)
        }
    }
        @AppStorage("lupinAtScreenCountIchimi") var atScreenCountIchimi = 0 {
            didSet {
                atScreenCountSum = countSum(atScreenCountDefault, atScreenCountIchimi, atScreenCountKa, atScreenCountKichi, atScreenCountRyo, atScreenCountYu, atScreenCountKiwami)
            }
        }
            @AppStorage("lupinAtScreenCountKa") var atScreenCountKa = 0 {
                didSet {
                    atScreenCountSum = countSum(atScreenCountDefault, atScreenCountIchimi, atScreenCountKa, atScreenCountKichi, atScreenCountRyo, atScreenCountYu, atScreenCountKiwami)
                }
            }
                @AppStorage("lupinAtScreenCountKichi") var atScreenCountKichi = 0 {
                    didSet {
                        atScreenCountSum = countSum(atScreenCountDefault, atScreenCountIchimi, atScreenCountKa, atScreenCountKichi, atScreenCountRyo, atScreenCountYu, atScreenCountKiwami)
                    }
                }
                    @AppStorage("lupinAtScreenCountRyo") var atScreenCountRyo = 0 {
                        didSet {
                            atScreenCountSum = countSum(atScreenCountDefault, atScreenCountIchimi, atScreenCountKa, atScreenCountKichi, atScreenCountRyo, atScreenCountYu, atScreenCountKiwami)
                        }
                    }
                        @AppStorage("lupinAtScreenCountYu") var atScreenCountYu = 0 {
                            didSet {
                                atScreenCountSum = countSum(atScreenCountDefault, atScreenCountIchimi, atScreenCountKa, atScreenCountKichi, atScreenCountRyo, atScreenCountYu, atScreenCountKiwami)
                            }
                        }
                            @AppStorage("lupinAtScreenCountKiwami") var atScreenCountKiwami = 0 {
                                didSet {
                                    atScreenCountSum = countSum(atScreenCountDefault, atScreenCountIchimi, atScreenCountKa, atScreenCountKichi, atScreenCountRyo, atScreenCountYu, atScreenCountKiwami)
                                }
                            }
    @AppStorage("lupinAtScreenCountSum") var atScreenCountSum = 0
    
    func resetAtScreen() {
        atScreenCurrentKeyword = ""
        atScreenCountDefault = 0
        atScreenCountIchimi = 0
        atScreenCountKa = 0
        atScreenCountKichi = 0
        atScreenCountRyo = 0
        atScreenCountYu = 0
        atScreenCountKiwami = 0
        minusCheck = false
    }
    
    // /////////////////////////
    // 共通
    // /////////////////////////
    @AppStorage("lupinMinusCheck") var minusCheck: Bool = false
    @AppStorage("lupinSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetHistory()
        resetBonusVoice()
        resetAtVoice()
        resetAtScreen()
    }
}

// //// メモリー1
class LupinMemory1: ObservableObject {
    @AppStorage("lupinGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("lupinBonusArrayKeyMemory1") var bonusArrayData: Data?
    @AppStorage("lupinTriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("lupinAtHitArrayKeyMemory1") var atHitArrayData: Data?
    @AppStorage("lupinCherryCountAllMemory1") var cherryCountAll = 0
    @AppStorage("lupinCherryCountHitMemory1") var cherryCountHit = 0
    @AppStorage("lupinCzCountAllMemory1") var czCountAll = 0
    @AppStorage("lupinCzCountHitMemory1") var czCountHit = 0
    @AppStorage("lupinBonusCountMemory1") var bonusCount = 0
    @AppStorage("lupinAtCountMemory1") var atCount = 0
    @AppStorage("lupinBonusCharaCountLupinMemory1") var bonusCharaCountLupin = 0
    @AppStorage("lupinBonusCharaCountJigenMemory1") var bonusCharaCountJigen = 0
    @AppStorage("lupinBonusCharaCountGoemonMemory1") var bonusCharaCountGoemon = 0
    @AppStorage("lupinBonusCharaCountFujikoMemory1") var bonusCharaCountFujiko = 0
    @AppStorage("lupinBonusCharaCountSumMemory1") var bonusCharaCountSum = 0
    @AppStorage("lupinPlayGameSumMemory1") var playGameSum = 0
    @AppStorage("lupinBonusVoiceCountDefaultMemory1") var bonusVoiceCountDefault = 0
    @AppStorage("lupinBonusVoiceCountHighSisaJakuMemory1") var bonusVoiceCountHighSisaJaku = 0
    @AppStorage("lupinBonusVoiceCountHighSisaKyoMemory1") var bonusVoiceCountHighSisaKyo = 0
    @AppStorage("lupinBonusVoiceCountOver4Memory1") var bonusVoiceCountOver4 = 0
    @AppStorage("lupinBonusVoiceCount6kakuMemory1") var bonusVoiceCount6kaku = 0
    @AppStorage("lupinBonusVoiceCountSumMemory1") var bonusVoiceCountSum = 0
    @AppStorage("lupinAtVoiceCountDefaultMemory1") var atVoiceCountDefault = 0
    @AppStorage("lupinAtVoiceCountGusuMemory1") var atVoiceCountGusu = 0
    @AppStorage("lupinAtVoiceCount356SisaMemory1") var atVoiceCount356Sisa = 0
    @AppStorage("lupinAtVoiceCountOver2SisaMemory1") var atVoiceCountOver2Sisa = 0
    @AppStorage("lupinAtVoiceCountOver4SisaMemory1") var atVoiceCountOver4Sisa = 0
    @AppStorage("lupinAtVoiceCountHighSisaMemory1") var atVoiceCountHighSisa = 0
    @AppStorage("lupinAtVoiceCountSilverGoldMemory1") var atVoiceCountSilverGold = 0
    @AppStorage("lupinAtVoiceCountSumMemory1") var atVoiceCountSum = 0
    @AppStorage("lupinAtScreenCountDefaultMemory1") var atScreenCountDefault = 0
    @AppStorage("lupinAtScreenCountIchimiMemory1") var atScreenCountIchimi = 0
    @AppStorage("lupinAtScreenCountKaMemory1") var atScreenCountKa = 0
    @AppStorage("lupinAtScreenCountKichiMemory1") var atScreenCountKichi = 0
    @AppStorage("lupinAtScreenCountRyoMemory1") var atScreenCountRyo = 0
    @AppStorage("lupinAtScreenCountYuMemory1") var atScreenCountYu = 0
    @AppStorage("lupinAtScreenCountKiwamiMemory1") var atScreenCountKiwami = 0
    @AppStorage("lupinAtScreenCountSumMemory1") var atScreenCountSum = 0
    @AppStorage("lupinMemoMemory1") var memo = ""
    @AppStorage("lupinDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class LupinMemory2: ObservableObject {
    @AppStorage("lupinGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("lupinBonusArrayKeyMemory2") var bonusArrayData: Data?
    @AppStorage("lupinTriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("lupinAtHitArrayKeyMemory2") var atHitArrayData: Data?
    @AppStorage("lupinCherryCountAllMemory2") var cherryCountAll = 0
    @AppStorage("lupinCherryCountHitMemory2") var cherryCountHit = 0
    @AppStorage("lupinCzCountAllMemory2") var czCountAll = 0
    @AppStorage("lupinCzCountHitMemory2") var czCountHit = 0
    @AppStorage("lupinBonusCountMemory2") var bonusCount = 0
    @AppStorage("lupinAtCountMemory2") var atCount = 0
    @AppStorage("lupinBonusCharaCountLupinMemory2") var bonusCharaCountLupin = 0
    @AppStorage("lupinBonusCharaCountJigenMemory2") var bonusCharaCountJigen = 0
    @AppStorage("lupinBonusCharaCountGoemonMemory2") var bonusCharaCountGoemon = 0
    @AppStorage("lupinBonusCharaCountFujikoMemory2") var bonusCharaCountFujiko = 0
    @AppStorage("lupinBonusCharaCountSumMemory2") var bonusCharaCountSum = 0
    @AppStorage("lupinPlayGameSumMemory2") var playGameSum = 0
    @AppStorage("lupinBonusVoiceCountDefaultMemory2") var bonusVoiceCountDefault = 0
    @AppStorage("lupinBonusVoiceCountHighSisaJakuMemory2") var bonusVoiceCountHighSisaJaku = 0
    @AppStorage("lupinBonusVoiceCountHighSisaKyoMemory2") var bonusVoiceCountHighSisaKyo = 0
    @AppStorage("lupinBonusVoiceCountOver4Memory2") var bonusVoiceCountOver4 = 0
    @AppStorage("lupinBonusVoiceCount6kakuMemory2") var bonusVoiceCount6kaku = 0
    @AppStorage("lupinBonusVoiceCountSumMemory2") var bonusVoiceCountSum = 0
    @AppStorage("lupinAtVoiceCountDefaultMemory2") var atVoiceCountDefault = 0
    @AppStorage("lupinAtVoiceCountGusuMemory2") var atVoiceCountGusu = 0
    @AppStorage("lupinAtVoiceCount356SisaMemory2") var atVoiceCount356Sisa = 0
    @AppStorage("lupinAtVoiceCountOver2SisaMemory2") var atVoiceCountOver2Sisa = 0
    @AppStorage("lupinAtVoiceCountOver4SisaMemory2") var atVoiceCountOver4Sisa = 0
    @AppStorage("lupinAtVoiceCountHighSisaMemory2") var atVoiceCountHighSisa = 0
    @AppStorage("lupinAtVoiceCountSilverGoldMemory2") var atVoiceCountSilverGold = 0
    @AppStorage("lupinAtVoiceCountSumMemory2") var atVoiceCountSum = 0
    @AppStorage("lupinAtScreenCountDefaultMemory2") var atScreenCountDefault = 0
    @AppStorage("lupinAtScreenCountIchimiMemory2") var atScreenCountIchimi = 0
    @AppStorage("lupinAtScreenCountKaMemory2") var atScreenCountKa = 0
    @AppStorage("lupinAtScreenCountKichiMemory2") var atScreenCountKichi = 0
    @AppStorage("lupinAtScreenCountRyoMemory2") var atScreenCountRyo = 0
    @AppStorage("lupinAtScreenCountYuMemory2") var atScreenCountYu = 0
    @AppStorage("lupinAtScreenCountKiwamiMemory2") var atScreenCountKiwami = 0
    @AppStorage("lupinAtScreenCountSumMemory2") var atScreenCountSum = 0
    @AppStorage("lupinMemoMemory2") var memo = ""
    @AppStorage("lupinDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class LupinMemory3: ObservableObject {
    @AppStorage("lupinGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("lupinBonusArrayKeyMemory3") var bonusArrayData: Data?
    @AppStorage("lupinTriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("lupinAtHitArrayKeyMemory3") var atHitArrayData: Data?
    @AppStorage("lupinCherryCountAllMemory3") var cherryCountAll = 0
    @AppStorage("lupinCherryCountHitMemory3") var cherryCountHit = 0
    @AppStorage("lupinCzCountAllMemory3") var czCountAll = 0
    @AppStorage("lupinCzCountHitMemory3") var czCountHit = 0
    @AppStorage("lupinBonusCountMemory3") var bonusCount = 0
    @AppStorage("lupinAtCountMemory3") var atCount = 0
    @AppStorage("lupinBonusCharaCountLupinMemory3") var bonusCharaCountLupin = 0
    @AppStorage("lupinBonusCharaCountJigenMemory3") var bonusCharaCountJigen = 0
    @AppStorage("lupinBonusCharaCountGoemonMemory3") var bonusCharaCountGoemon = 0
    @AppStorage("lupinBonusCharaCountFujikoMemory3") var bonusCharaCountFujiko = 0
    @AppStorage("lupinBonusCharaCountSumMemory3") var bonusCharaCountSum = 0
    @AppStorage("lupinPlayGameSumMemory3") var playGameSum = 0
    @AppStorage("lupinBonusVoiceCountDefaultMemory3") var bonusVoiceCountDefault = 0
    @AppStorage("lupinBonusVoiceCountHighSisaJakuMemory3") var bonusVoiceCountHighSisaJaku = 0
    @AppStorage("lupinBonusVoiceCountHighSisaKyoMemory3") var bonusVoiceCountHighSisaKyo = 0
    @AppStorage("lupinBonusVoiceCountOver4Memory3") var bonusVoiceCountOver4 = 0
    @AppStorage("lupinBonusVoiceCount6kakuMemory3") var bonusVoiceCount6kaku = 0
    @AppStorage("lupinBonusVoiceCountSumMemory3") var bonusVoiceCountSum = 0
    @AppStorage("lupinAtVoiceCountDefaultMemory3") var atVoiceCountDefault = 0
    @AppStorage("lupinAtVoiceCountGusuMemory3") var atVoiceCountGusu = 0
    @AppStorage("lupinAtVoiceCount356SisaMemory3") var atVoiceCount356Sisa = 0
    @AppStorage("lupinAtVoiceCountOver2SisaMemory3") var atVoiceCountOver2Sisa = 0
    @AppStorage("lupinAtVoiceCountOver4SisaMemory3") var atVoiceCountOver4Sisa = 0
    @AppStorage("lupinAtVoiceCountHighSisaMemory3") var atVoiceCountHighSisa = 0
    @AppStorage("lupinAtVoiceCountSilverGoldMemory3") var atVoiceCountSilverGold = 0
    @AppStorage("lupinAtVoiceCountSumMemory3") var atVoiceCountSum = 0
    @AppStorage("lupinAtScreenCountDefaultMemory3") var atScreenCountDefault = 0
    @AppStorage("lupinAtScreenCountIchimiMemory3") var atScreenCountIchimi = 0
    @AppStorage("lupinAtScreenCountKaMemory3") var atScreenCountKa = 0
    @AppStorage("lupinAtScreenCountKichiMemory3") var atScreenCountKichi = 0
    @AppStorage("lupinAtScreenCountRyoMemory3") var atScreenCountRyo = 0
    @AppStorage("lupinAtScreenCountYuMemory3") var atScreenCountYu = 0
    @AppStorage("lupinAtScreenCountKiwamiMemory3") var atScreenCountKiwami = 0
    @AppStorage("lupinAtScreenCountSumMemory3") var atScreenCountSum = 0
    @AppStorage("lupinMemoMemory3") var memo = ""
    @AppStorage("lupinDateMemory3") var dateDouble = 0.0
}


struct lupinViewTop: View {
//    @ObservedObject var lupin = Lupin()
    @StateObject var lupin = Lupin()
    @State var isShowAlert: Bool = false
    @StateObject var lupinMemory1 = LupinMemory1()
    @StateObject var lupinMemory2 = LupinMemory2()
    @StateObject var lupinMemory3 = LupinMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 初当り履歴
                    NavigationLink(destination: lupinViewHistory(lupin: lupin)) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "初当り履歴"
                        )
                    }
                    // ハルルナPUSH
                    NavigationLink(destination: lupinViewHaruruna()) {
                        unitLabelMenu(
                            imageSystemName: "button.horizontal.top.press",
                            textBody: "ハルルナPUSH"
                        )
                    }
                    // シングル揃いボーナス後のボイス
                    NavigationLink(destination: lupinSingleBonusVoice(lupin: lupin)) {
                        unitLabelMenu(
                            imageSystemName: "message",
                            textBody: "AT非当選ボーナス終了後のボイス"
                        )
                    }
                    // ATラウンド開始画面
                    NavigationLink(destination: lupinViewRoundScreen()) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle",
                            textBody: "ラウンド開始画面"
                        )
                    }
                    // AT終了時の画面
                    NavigationLink(destination: lupinViewAtScreen(lupin: lupin)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle",
                            textBody: "AT終了画面"
                        )
                    }
                    // AT終了後のボイス
                    NavigationLink(destination: lupinViewAtVoice(lupin: lupin)) {
                        unitLabelMenu(
                            imageSystemName: "text.bubble",
                            textBody: "AT終了後のメニュー内セリフ"
                        )
                    }
                    // 隠れ凪
                    NavigationLink(destination: commonViewKakureNagi()) {
                        unitLabelMenu(imageSystemName: "bubble", textBody: "隠れ凪")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "ルパン3世 大航海者の秘宝", titleFont: .title2)
                }
                // 設定推測グラフ
                NavigationLink(destination: lupinView95Ci(lupin: lupin)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
//                .popoverTip(tipVer16095CiAdd())
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4689")
//                    .popoverTip(tipVer220AddLink())
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(lupinSubViewLoadMemory(
                        lupin: lupin,
                        lupinMemory1: lupinMemory1,
                        lupinMemory2: lupinMemory2,
                        lupinMemory3: lupinMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(lupinSubViewSaveMemory(
                        lupin: lupin,
                        lupinMemory1: lupinMemory1,
                        lupinMemory2: lupinMemory2,
                        lupinMemory3: lupinMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: lupin.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct lupinSubViewSaveMemory: View {
    @ObservedObject var lupin: Lupin
    @ObservedObject var lupinMemory1: LupinMemory1
    @ObservedObject var lupinMemory2: LupinMemory2
    @ObservedObject var lupinMemory3: LupinMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ルパン3世 大航海者の秘宝",
            selectedMemory: $lupin.selectedMemory,
            memoMemory1: $lupinMemory1.memo,
            dateDoubleMemory1: $lupinMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $lupinMemory2.memo,
            dateDoubleMemory2: $lupinMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $lupinMemory3.memo,
            dateDoubleMemory3: $lupinMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        lupinMemory1.gameArrayData = lupin.gameArrayData
        lupinMemory1.bonusArrayData = lupin.bonusArrayData
        lupinMemory1.triggerArrayData = lupin.triggerArrayData
        lupinMemory1.atHitArrayData = lupin.atHitArrayData
        lupinMemory1.cherryCountAll = lupin.cherryCountAll
        lupinMemory1.cherryCountHit = lupin.cherryCountHit
        lupinMemory1.czCountAll = lupin.czCountAll
        lupinMemory1.czCountHit = lupin.czCountHit
        lupinMemory1.bonusCount = lupin.bonusCount
        lupinMemory1.atCount = lupin.atCount
        lupinMemory1.bonusCharaCountLupin = lupin.bonusCharaCountLupin
        lupinMemory1.bonusCharaCountJigen = lupin.bonusCharaCountJigen
        lupinMemory1.bonusCharaCountGoemon = lupin.bonusCharaCountGoemon
        lupinMemory1.bonusCharaCountFujiko = lupin.bonusCharaCountFujiko
        lupinMemory1.bonusCharaCountSum = lupin.bonusCharaCountSum
        lupinMemory1.playGameSum = lupin.playGameSum
        lupinMemory1.bonusVoiceCountDefault = lupin.bonusVoiceCountDefault
        lupinMemory1.bonusVoiceCountHighSisaJaku = lupin.bonusVoiceCountHighSisaJaku
        lupinMemory1.bonusVoiceCountHighSisaKyo = lupin.bonusVoiceCountHighSisaKyo
        lupinMemory1.bonusVoiceCountOver4 = lupin.bonusVoiceCountOver4
        lupinMemory1.bonusVoiceCount6kaku = lupin.bonusVoiceCount6kaku
        lupinMemory1.bonusVoiceCountSum = lupin.bonusVoiceCountSum
        lupinMemory1.atVoiceCountDefault = lupin.atVoiceCountDefault
        lupinMemory1.atVoiceCountGusu = lupin.atVoiceCountGusu
        lupinMemory1.atVoiceCount356Sisa = lupin.atVoiceCount356Sisa
        lupinMemory1.atVoiceCountOver2Sisa = lupin.atVoiceCountOver2Sisa
        lupinMemory1.atVoiceCountOver4Sisa = lupin.atVoiceCountOver4Sisa
        lupinMemory1.atVoiceCountHighSisa = lupin.atVoiceCountHighSisa
        lupinMemory1.atVoiceCountSilverGold = lupin.atVoiceCountSilverGold
        lupinMemory1.atVoiceCountSum = lupin.atVoiceCountSum
        lupinMemory1.atScreenCountDefault = lupin.atScreenCountDefault
        lupinMemory1.atScreenCountIchimi = lupin.atScreenCountIchimi
        lupinMemory1.atScreenCountKa = lupin.atScreenCountKa
        lupinMemory1.atScreenCountKichi = lupin.atScreenCountKichi
        lupinMemory1.atScreenCountRyo = lupin.atScreenCountRyo
        lupinMemory1.atScreenCountYu = lupin.atScreenCountYu
        lupinMemory1.atScreenCountKiwami = lupin.atScreenCountKiwami
        lupinMemory1.atScreenCountSum = lupin.atScreenCountSum
    }
    func saveMemory2() {
        lupinMemory2.gameArrayData = lupin.gameArrayData
        lupinMemory2.bonusArrayData = lupin.bonusArrayData
        lupinMemory2.triggerArrayData = lupin.triggerArrayData
        lupinMemory2.atHitArrayData = lupin.atHitArrayData
        lupinMemory2.cherryCountAll = lupin.cherryCountAll
        lupinMemory2.cherryCountHit = lupin.cherryCountHit
        lupinMemory2.czCountAll = lupin.czCountAll
        lupinMemory2.czCountHit = lupin.czCountHit
        lupinMemory2.bonusCount = lupin.bonusCount
        lupinMemory2.atCount = lupin.atCount
        lupinMemory2.bonusCharaCountLupin = lupin.bonusCharaCountLupin
        lupinMemory2.bonusCharaCountJigen = lupin.bonusCharaCountJigen
        lupinMemory2.bonusCharaCountGoemon = lupin.bonusCharaCountGoemon
        lupinMemory2.bonusCharaCountFujiko = lupin.bonusCharaCountFujiko
        lupinMemory2.bonusCharaCountSum = lupin.bonusCharaCountSum
        lupinMemory2.playGameSum = lupin.playGameSum
        lupinMemory2.bonusVoiceCountDefault = lupin.bonusVoiceCountDefault
        lupinMemory2.bonusVoiceCountHighSisaJaku = lupin.bonusVoiceCountHighSisaJaku
        lupinMemory2.bonusVoiceCountHighSisaKyo = lupin.bonusVoiceCountHighSisaKyo
        lupinMemory2.bonusVoiceCountOver4 = lupin.bonusVoiceCountOver4
        lupinMemory2.bonusVoiceCount6kaku = lupin.bonusVoiceCount6kaku
        lupinMemory2.bonusVoiceCountSum = lupin.bonusVoiceCountSum
        lupinMemory2.atVoiceCountDefault = lupin.atVoiceCountDefault
        lupinMemory2.atVoiceCountGusu = lupin.atVoiceCountGusu
        lupinMemory2.atVoiceCount356Sisa = lupin.atVoiceCount356Sisa
        lupinMemory2.atVoiceCountOver2Sisa = lupin.atVoiceCountOver2Sisa
        lupinMemory2.atVoiceCountOver4Sisa = lupin.atVoiceCountOver4Sisa
        lupinMemory2.atVoiceCountHighSisa = lupin.atVoiceCountHighSisa
        lupinMemory2.atVoiceCountSilverGold = lupin.atVoiceCountSilverGold
        lupinMemory2.atVoiceCountSum = lupin.atVoiceCountSum
        lupinMemory2.atScreenCountDefault = lupin.atScreenCountDefault
        lupinMemory2.atScreenCountIchimi = lupin.atScreenCountIchimi
        lupinMemory2.atScreenCountKa = lupin.atScreenCountKa
        lupinMemory2.atScreenCountKichi = lupin.atScreenCountKichi
        lupinMemory2.atScreenCountRyo = lupin.atScreenCountRyo
        lupinMemory2.atScreenCountYu = lupin.atScreenCountYu
        lupinMemory2.atScreenCountKiwami = lupin.atScreenCountKiwami
        lupinMemory2.atScreenCountSum = lupin.atScreenCountSum
    }
    func saveMemory3() {
        lupinMemory3.gameArrayData = lupin.gameArrayData
        lupinMemory3.bonusArrayData = lupin.bonusArrayData
        lupinMemory3.triggerArrayData = lupin.triggerArrayData
        lupinMemory3.atHitArrayData = lupin.atHitArrayData
        lupinMemory3.cherryCountAll = lupin.cherryCountAll
        lupinMemory3.cherryCountHit = lupin.cherryCountHit
        lupinMemory3.czCountAll = lupin.czCountAll
        lupinMemory3.czCountHit = lupin.czCountHit
        lupinMemory3.bonusCount = lupin.bonusCount
        lupinMemory3.atCount = lupin.atCount
        lupinMemory3.bonusCharaCountLupin = lupin.bonusCharaCountLupin
        lupinMemory3.bonusCharaCountJigen = lupin.bonusCharaCountJigen
        lupinMemory3.bonusCharaCountGoemon = lupin.bonusCharaCountGoemon
        lupinMemory3.bonusCharaCountFujiko = lupin.bonusCharaCountFujiko
        lupinMemory3.bonusCharaCountSum = lupin.bonusCharaCountSum
        lupinMemory3.playGameSum = lupin.playGameSum
        lupinMemory3.bonusVoiceCountDefault = lupin.bonusVoiceCountDefault
        lupinMemory3.bonusVoiceCountHighSisaJaku = lupin.bonusVoiceCountHighSisaJaku
        lupinMemory3.bonusVoiceCountHighSisaKyo = lupin.bonusVoiceCountHighSisaKyo
        lupinMemory3.bonusVoiceCountOver4 = lupin.bonusVoiceCountOver4
        lupinMemory3.bonusVoiceCount6kaku = lupin.bonusVoiceCount6kaku
        lupinMemory3.bonusVoiceCountSum = lupin.bonusVoiceCountSum
        lupinMemory3.atVoiceCountDefault = lupin.atVoiceCountDefault
        lupinMemory3.atVoiceCountGusu = lupin.atVoiceCountGusu
        lupinMemory3.atVoiceCount356Sisa = lupin.atVoiceCount356Sisa
        lupinMemory3.atVoiceCountOver2Sisa = lupin.atVoiceCountOver2Sisa
        lupinMemory3.atVoiceCountOver4Sisa = lupin.atVoiceCountOver4Sisa
        lupinMemory3.atVoiceCountHighSisa = lupin.atVoiceCountHighSisa
        lupinMemory3.atVoiceCountSilverGold = lupin.atVoiceCountSilverGold
        lupinMemory3.atVoiceCountSum = lupin.atVoiceCountSum
        lupinMemory3.atScreenCountDefault = lupin.atScreenCountDefault
        lupinMemory3.atScreenCountIchimi = lupin.atScreenCountIchimi
        lupinMemory3.atScreenCountKa = lupin.atScreenCountKa
        lupinMemory3.atScreenCountKichi = lupin.atScreenCountKichi
        lupinMemory3.atScreenCountRyo = lupin.atScreenCountRyo
        lupinMemory3.atScreenCountYu = lupin.atScreenCountYu
        lupinMemory3.atScreenCountKiwami = lupin.atScreenCountKiwami
        lupinMemory3.atScreenCountSum = lupin.atScreenCountSum
    }
}

// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct lupinSubViewLoadMemory: View {
    @ObservedObject var lupin: Lupin
    @ObservedObject var lupinMemory1: LupinMemory1
    @ObservedObject var lupinMemory2: LupinMemory2
    @ObservedObject var lupinMemory3: LupinMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ルパン3世 大航海者の秘宝",
            selectedMemory: $lupin.selectedMemory,
            memoMemory1: lupinMemory1.memo,
            dateDoubleMemory1: lupinMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: lupinMemory2.memo,
            dateDoubleMemory2: lupinMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: lupinMemory3.memo,
            dateDoubleMemory3: lupinMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        let memoryGameArray = decodeIntArray(from: lupinMemory1.gameArrayData)
        saveArray(memoryGameArray, forKey: lupin.gameArrayKey)
        let memoryBonusArray = decodeStringArray(from: lupinMemory1.bonusArrayData)
        saveArray(memoryBonusArray, forKey: lupin.bonusArrayKey)
        let memoryTriggerArray = decodeStringArray(from: lupinMemory1.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: lupin.triggerArrayKey)
        let memoryAtHitArray = decodeStringArray(from: lupinMemory1.atHitArrayData)
        saveArray(memoryAtHitArray, forKey: lupin.atHitArrayKey)
//        lupin.gameArrayData = lupinMemory1.gameArrayData
//        lupin.bonusArrayData = lupinMemory1.bonusArrayData
//        lupin.triggerArrayData = lupinMemory1.triggerArrayData
//        lupin.atHitArrayData = lupinMemory1.atHitArrayData
        lupin.cherryCountAll = lupinMemory1.cherryCountAll
        lupin.cherryCountHit = lupinMemory1.cherryCountHit
        lupin.czCountAll = lupinMemory1.czCountAll
        lupin.czCountHit = lupinMemory1.czCountHit
        lupin.bonusCount = lupinMemory1.bonusCount
        lupin.atCount = lupinMemory1.atCount
        lupin.bonusCharaCountLupin = lupinMemory1.bonusCharaCountLupin
        lupin.bonusCharaCountJigen = lupinMemory1.bonusCharaCountJigen
        lupin.bonusCharaCountGoemon = lupinMemory1.bonusCharaCountGoemon
        lupin.bonusCharaCountFujiko = lupinMemory1.bonusCharaCountFujiko
        lupin.bonusCharaCountSum = lupinMemory1.bonusCharaCountSum
        lupin.playGameSum = lupinMemory1.playGameSum
        lupin.bonusVoiceCountDefault = lupinMemory1.bonusVoiceCountDefault
        lupin.bonusVoiceCountHighSisaJaku = lupinMemory1.bonusVoiceCountHighSisaJaku
        lupin.bonusVoiceCountHighSisaKyo = lupinMemory1.bonusVoiceCountHighSisaKyo
        lupin.bonusVoiceCountOver4 = lupinMemory1.bonusVoiceCountOver4
        lupin.bonusVoiceCount6kaku = lupinMemory1.bonusVoiceCount6kaku
        lupin.bonusVoiceCountSum = lupinMemory1.bonusVoiceCountSum
        lupin.atVoiceCountDefault = lupinMemory1.atVoiceCountDefault
        lupin.atVoiceCountGusu = lupinMemory1.atVoiceCountGusu
        lupin.atVoiceCount356Sisa = lupinMemory1.atVoiceCount356Sisa
        lupin.atVoiceCountOver2Sisa = lupinMemory1.atVoiceCountOver2Sisa
        lupin.atVoiceCountOver4Sisa = lupinMemory1.atVoiceCountOver4Sisa
        lupin.atVoiceCountHighSisa = lupinMemory1.atVoiceCountHighSisa
        lupin.atVoiceCountSilverGold = lupinMemory1.atVoiceCountSilverGold
        lupin.atVoiceCountSum = lupinMemory1.atVoiceCountSum
        lupin.atScreenCountDefault = lupinMemory1.atScreenCountDefault
        lupin.atScreenCountIchimi = lupinMemory1.atScreenCountIchimi
        lupin.atScreenCountKa = lupinMemory1.atScreenCountKa
        lupin.atScreenCountKichi = lupinMemory1.atScreenCountKichi
        lupin.atScreenCountRyo = lupinMemory1.atScreenCountRyo
        lupin.atScreenCountYu = lupinMemory1.atScreenCountYu
        lupin.atScreenCountKiwami = lupinMemory1.atScreenCountKiwami
        lupin.atScreenCountSum = lupinMemory1.atScreenCountSum
    }
    func loadMemory2() {
        let memoryGameArray = decodeIntArray(from: lupinMemory2.gameArrayData)
        saveArray(memoryGameArray, forKey: lupin.gameArrayKey)
        let memoryBonusArray = decodeStringArray(from: lupinMemory2.bonusArrayData)
        saveArray(memoryBonusArray, forKey: lupin.bonusArrayKey)
        let memoryTriggerArray = decodeStringArray(from: lupinMemory2.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: lupin.triggerArrayKey)
        let memoryAtHitArray = decodeStringArray(from: lupinMemory2.atHitArrayData)
        saveArray(memoryAtHitArray, forKey: lupin.atHitArrayKey)
//        lupin.gameArrayData = lupinMemory2.gameArrayData
//        lupin.bonusArrayData = lupinMemory2.bonusArrayData
//        lupin.triggerArrayData = lupinMemory2.triggerArrayData
//        lupin.atHitArrayData = lupinMemory2.atHitArrayData
        lupin.cherryCountAll = lupinMemory2.cherryCountAll
        lupin.cherryCountHit = lupinMemory2.cherryCountHit
        lupin.czCountAll = lupinMemory2.czCountAll
        lupin.czCountHit = lupinMemory2.czCountHit
        lupin.bonusCount = lupinMemory2.bonusCount
        lupin.atCount = lupinMemory2.atCount
        lupin.bonusCharaCountLupin = lupinMemory2.bonusCharaCountLupin
        lupin.bonusCharaCountJigen = lupinMemory2.bonusCharaCountJigen
        lupin.bonusCharaCountGoemon = lupinMemory2.bonusCharaCountGoemon
        lupin.bonusCharaCountFujiko = lupinMemory2.bonusCharaCountFujiko
        lupin.bonusCharaCountSum = lupinMemory2.bonusCharaCountSum
        lupin.playGameSum = lupinMemory2.playGameSum
        lupin.bonusVoiceCountDefault = lupinMemory2.bonusVoiceCountDefault
        lupin.bonusVoiceCountHighSisaJaku = lupinMemory2.bonusVoiceCountHighSisaJaku
        lupin.bonusVoiceCountHighSisaKyo = lupinMemory2.bonusVoiceCountHighSisaKyo
        lupin.bonusVoiceCountOver4 = lupinMemory2.bonusVoiceCountOver4
        lupin.bonusVoiceCount6kaku = lupinMemory2.bonusVoiceCount6kaku
        lupin.bonusVoiceCountSum = lupinMemory2.bonusVoiceCountSum
        lupin.atVoiceCountDefault = lupinMemory2.atVoiceCountDefault
        lupin.atVoiceCountGusu = lupinMemory2.atVoiceCountGusu
        lupin.atVoiceCount356Sisa = lupinMemory2.atVoiceCount356Sisa
        lupin.atVoiceCountOver2Sisa = lupinMemory2.atVoiceCountOver2Sisa
        lupin.atVoiceCountOver4Sisa = lupinMemory2.atVoiceCountOver4Sisa
        lupin.atVoiceCountHighSisa = lupinMemory2.atVoiceCountHighSisa
        lupin.atVoiceCountSilverGold = lupinMemory2.atVoiceCountSilverGold
        lupin.atVoiceCountSum = lupinMemory2.atVoiceCountSum
        lupin.atScreenCountDefault = lupinMemory2.atScreenCountDefault
        lupin.atScreenCountIchimi = lupinMemory2.atScreenCountIchimi
        lupin.atScreenCountKa = lupinMemory2.atScreenCountKa
        lupin.atScreenCountKichi = lupinMemory2.atScreenCountKichi
        lupin.atScreenCountRyo = lupinMemory2.atScreenCountRyo
        lupin.atScreenCountYu = lupinMemory2.atScreenCountYu
        lupin.atScreenCountKiwami = lupinMemory2.atScreenCountKiwami
        lupin.atScreenCountSum = lupinMemory2.atScreenCountSum
    }
    func loadMemory3() {
        let memoryGameArray = decodeIntArray(from: lupinMemory3.gameArrayData)
        saveArray(memoryGameArray, forKey: lupin.gameArrayKey)
        let memoryBonusArray = decodeStringArray(from: lupinMemory3.bonusArrayData)
        saveArray(memoryBonusArray, forKey: lupin.bonusArrayKey)
        let memoryTriggerArray = decodeStringArray(from: lupinMemory3.triggerArrayData)
        saveArray(memoryTriggerArray, forKey: lupin.triggerArrayKey)
        let memoryAtHitArray = decodeStringArray(from: lupinMemory3.atHitArrayData)
        saveArray(memoryAtHitArray, forKey: lupin.atHitArrayKey)
//        lupin.gameArrayData = lupinMemory3.gameArrayData
//        lupin.bonusArrayData = lupinMemory3.bonusArrayData
//        lupin.triggerArrayData = lupinMemory3.triggerArrayData
//        lupin.atHitArrayData = lupinMemory3.atHitArrayData
        lupin.cherryCountAll = lupinMemory3.cherryCountAll
        lupin.cherryCountHit = lupinMemory3.cherryCountHit
        lupin.czCountAll = lupinMemory3.czCountAll
        lupin.czCountHit = lupinMemory3.czCountHit
        lupin.bonusCount = lupinMemory3.bonusCount
        lupin.atCount = lupinMemory3.atCount
        lupin.bonusCharaCountLupin = lupinMemory3.bonusCharaCountLupin
        lupin.bonusCharaCountJigen = lupinMemory3.bonusCharaCountJigen
        lupin.bonusCharaCountGoemon = lupinMemory3.bonusCharaCountGoemon
        lupin.bonusCharaCountFujiko = lupinMemory3.bonusCharaCountFujiko
        lupin.bonusCharaCountSum = lupinMemory3.bonusCharaCountSum
        lupin.playGameSum = lupinMemory3.playGameSum
        lupin.bonusVoiceCountDefault = lupinMemory3.bonusVoiceCountDefault
        lupin.bonusVoiceCountHighSisaJaku = lupinMemory3.bonusVoiceCountHighSisaJaku
        lupin.bonusVoiceCountHighSisaKyo = lupinMemory3.bonusVoiceCountHighSisaKyo
        lupin.bonusVoiceCountOver4 = lupinMemory3.bonusVoiceCountOver4
        lupin.bonusVoiceCount6kaku = lupinMemory3.bonusVoiceCount6kaku
        lupin.bonusVoiceCountSum = lupinMemory3.bonusVoiceCountSum
        lupin.atVoiceCountDefault = lupinMemory3.atVoiceCountDefault
        lupin.atVoiceCountGusu = lupinMemory3.atVoiceCountGusu
        lupin.atVoiceCount356Sisa = lupinMemory3.atVoiceCount356Sisa
        lupin.atVoiceCountOver2Sisa = lupinMemory3.atVoiceCountOver2Sisa
        lupin.atVoiceCountOver4Sisa = lupinMemory3.atVoiceCountOver4Sisa
        lupin.atVoiceCountHighSisa = lupinMemory3.atVoiceCountHighSisa
        lupin.atVoiceCountSilverGold = lupinMemory3.atVoiceCountSilverGold
        lupin.atVoiceCountSum = lupinMemory3.atVoiceCountSum
        lupin.atScreenCountDefault = lupinMemory3.atScreenCountDefault
        lupin.atScreenCountIchimi = lupinMemory3.atScreenCountIchimi
        lupin.atScreenCountKa = lupinMemory3.atScreenCountKa
        lupin.atScreenCountKichi = lupinMemory3.atScreenCountKichi
        lupin.atScreenCountRyo = lupinMemory3.atScreenCountRyo
        lupin.atScreenCountYu = lupinMemory3.atScreenCountYu
        lupin.atScreenCountKiwami = lupinMemory3.atScreenCountKiwami
        lupin.atScreenCountSum = lupinMemory3.atScreenCountSum
    }
}


#Preview {
    lupinViewTop()
}
