//
//  godeaterViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/09.
//

import SwiftUI
import TipKit

// ////////////////////////
// 変数
// ////////////////////////
class Godeater: ObservableObject {
    // /////////////////////
    // AT,CZ当選履歴
    // /////////////////////
    // 選択肢の設定
    @Published var selectListBonus = ["AT", "CZ", "現在"]
    @Published var selectListAtTrigger = ["ゲーム数", "CZ", "直撃", "天井", "フリーズ", "その他"]
    @Published var selectListCzTrigger = ["強レア役", "弱レア役", "その他"]
    @Published var selectListNowTrigger = [""]
    // 選択結果の設定
    @Published var inputGame = 0
    @Published var selectedBonus = "AT"
    @Published var selectedAtTrigger = "CZ"
    @Published var selectedCzTrigger = "強レア役"
    @Published var selectedNowTrigger = ""
    // //// 配列の設定
    // 当選ゲーム数配列
    let gameArrayKey = "godeaterGameArrayKey"
    @AppStorage("godeaterGameArrayKey") var gameArrayData: Data?
    // ボーナス種類配列
    let bonusArrayKey = "godeaterBonusArrayKey"
    @AppStorage("godeaterBonusArrayKey") var bonusArrayData: Data?
    // 当選契機配列
    let triggerArrayKey = "godeaterTriggerArrayKey"
    @AppStorage("godeaterTriggerArrayKey") var triggerArrayData: Data?
    
    // 集計結果の変数
    @AppStorage("godeaterAtHitCount") var atHitCount = 0    // AT当選回数
    @AppStorage("godeaterCzHitCount") var czHitCount = 0    // CZ当選回数
    @AppStorage("godeaterPlayGame") var playGame = 0     // ゲーム数合計
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: bonusArrayData, key: bonusArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        atHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "AT")
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        playGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: bonusArrayData, resetWord: "AT")
        inputGame = 0
        selectedBonus = "AT"
        selectedAtTrigger = "CZ"
        selectedCzTrigger = "強レア役"
        selectedNowTrigger = ""
    }
    
    // データ追加 AT
    func addDataHistoryAT() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedAtTrigger, key: triggerArrayKey)
        atHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "AT")
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        playGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: bonusArrayData, resetWord: "AT")
        inputGame = 0
        selectedBonus = "AT"
        selectedAtTrigger = "CZ"
        selectedCzTrigger = "強レア役"
        selectedNowTrigger = ""
    }
    
    // データ追加 CZ
    func addDataHistoryCZ() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedCzTrigger, key: triggerArrayKey)
        atHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "AT")
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        playGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: bonusArrayData, resetWord: "AT")
        inputGame = 0
        selectedBonus = "AT"
        selectedAtTrigger = "CZ"
        selectedCzTrigger = "強レア役"
        selectedNowTrigger = ""
    }
    
    // データ追加 現在
    func addDataHistoryNow() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedNowTrigger, key: triggerArrayKey)
        atHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "AT")
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        playGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: bonusArrayData, resetWord: "AT")
        inputGame = 0
        selectedBonus = "AT"
        selectedAtTrigger = "CZ"
        selectedCzTrigger = "強レア役"
        selectedNowTrigger = ""
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: bonusArrayData, key: bonusArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        atHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "AT")
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        playGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: bonusArrayData, resetWord: "AT")
        inputGame = 0
        selectedBonus = "AT"
        selectedAtTrigger = "CZ"
        selectedCzTrigger = "強レア役"
        selectedNowTrigger = ""
        minusCheck = false
    }
    
    // //////////////////////
    // ストーリーパート後のボイス
    // //////////////////////
    @Published var selectListVoice = ["一緒にバガラリー見ようぜ！", "側面、後方ともにクリアです！", "私もお役に立てることがあるはずです！", "私は私のやるべきことをしなくちゃね", "思い出ってのは、悪いことばかりでもないんだな", "あなたはそのアラガミを殺せますか？", "信じられる仲間がいるから、俺たちは戦えるんだ！", "私、大きくなったらアラガミのいない世界を作る！", "いつでも、お前の背中は預かってやるからな", "いただきまーす"]
    @AppStorage("godeaterSelectedVoice") var selectedVoice = "側面、後方ともにクリアです！"
    @AppStorage("godeaterVoiceDefaultCount") var voiceDefaultCount = 0 {
        didSet {
            voiceCountSum = countSum(voiceDefaultCount, voiceHibariCount, voiceSakuyaCount, voiceSomaCount, voiceRenCount, voiceYuCount, voiceErinaCount, voiceRindoCount, voiceShioCount)
        }
    }
        @AppStorage("godeaterVoiceRindoCount") var voiceRindoCount = 0 {
            didSet {
                voiceCountSum = countSum(voiceDefaultCount, voiceHibariCount, voiceSakuyaCount, voiceSomaCount, voiceRenCount, voiceYuCount, voiceErinaCount, voiceRindoCount, voiceShioCount)
            }
        }
            @AppStorage("godeaterVoiceHibariCount") var voiceHibariCount = 0 {
                didSet {
                    voiceCountSum = countSum(voiceDefaultCount, voiceHibariCount, voiceSakuyaCount, voiceSomaCount, voiceRenCount, voiceYuCount, voiceErinaCount, voiceRindoCount, voiceShioCount)
                }
            }
                @AppStorage("godeaterVoiceSakuyaCount") var voiceSakuyaCount = 0 {
                    didSet {
                        voiceCountSum = countSum(voiceDefaultCount, voiceHibariCount, voiceSakuyaCount, voiceSomaCount, voiceRenCount, voiceYuCount, voiceErinaCount, voiceRindoCount, voiceShioCount)
                    }
                }
                    @AppStorage("godeaterVoiceSomaCount") var voiceSomaCount = 0 {
                        didSet {
                            voiceCountSum = countSum(voiceDefaultCount, voiceHibariCount, voiceSakuyaCount, voiceSomaCount, voiceRenCount, voiceYuCount, voiceErinaCount, voiceRindoCount, voiceShioCount)
                        }
                    }
                        @AppStorage("godeaterVoiceRenCount") var voiceRenCount = 0 {
                            didSet {
                                voiceCountSum = countSum(voiceDefaultCount, voiceHibariCount, voiceSakuyaCount, voiceSomaCount, voiceRenCount, voiceYuCount, voiceErinaCount, voiceRindoCount, voiceShioCount)
                            }
                        }
                            @AppStorage("godeaterVoiceYuCount") var voiceYuCount = 0 {
                                didSet {
                                    voiceCountSum = countSum(voiceDefaultCount, voiceHibariCount, voiceSakuyaCount, voiceSomaCount, voiceRenCount, voiceYuCount, voiceErinaCount, voiceRindoCount, voiceShioCount)
                                }
                            }
                                @AppStorage("godeaterVoiceErinaCount") var voiceErinaCount = 0 {
                                    didSet {
                                        voiceCountSum = countSum(voiceDefaultCount, voiceHibariCount, voiceSakuyaCount, voiceSomaCount, voiceRenCount, voiceYuCount, voiceErinaCount, voiceRindoCount, voiceShioCount)
                                    }
                                }
                                    @AppStorage("godeaterVoiceShioCount") var voiceShioCount = 0 {
                                        didSet {
                                            voiceCountSum = countSum(voiceDefaultCount, voiceHibariCount, voiceSakuyaCount, voiceSomaCount, voiceRenCount, voiceYuCount, voiceErinaCount, voiceRindoCount, voiceShioCount)
                                        }
                                    }
    @AppStorage("godeaterVoiceCountSum") var voiceCountSum = 0
    
    func resetVoice() {
        selectedVoice = "側面、後方ともにクリアです！"
        voiceDefaultCount = 0
        voiceRindoCount = 0
        voiceHibariCount = 0
        voiceSakuyaCount = 0
        voiceSomaCount = 0
        voiceRenCount = 0
        voiceYuCount = 0
        voiceErinaCount = 0
        voiceShioCount = 0
        minusCheck = false
    }
    
    // //////////////////////
    // AT終了後の画面
    // //////////////////////
    @AppStorage("godeaterScreenCurrentKeyword") var screenCurrentKeyword = ""
    @Published var screenKeywordNone = "キャラなし"
    @Published var screenKeywordKota = "コウタ"
    @Published var screenKeywordArisa = "アリサ"
    @Published var screenKeywordYu = "ユウ"
    @Published var screenKeywordSoma = "ソーマ"
    @Published var screenKeywordSakuya = "サクヤ"
    @Published var screenKeywordRindo = "リンドウ"
    @Published var screenKeywordShio = "シオ"
    @Published var screenKeywordCafe = "カフェ"
    @Published var screenKeywordAll = "キャラ集合"
    @Published var screenKeywordMinichara = "ミニキャラ"
    
    @AppStorage("godeaterScreenCountNone") var screenCountNone = 0 {
        didSet {
            screenCountSum = countSum(screenCountNone, screenCountKota, screenCountArisa, screenCountYu, screenCountSoma, screenCountSakuya, screenCountRindo, screenCountShio, screenCountCafe, screenCountAll, screenCountMinichara)
        }
    }
        @AppStorage("godeaterScreenCountKota") var screenCountKota = 0 {
            didSet {
                screenCountSum = countSum(screenCountNone, screenCountKota, screenCountArisa, screenCountYu, screenCountSoma, screenCountSakuya, screenCountRindo, screenCountShio, screenCountCafe, screenCountAll, screenCountMinichara)
            }
        }
            @AppStorage("godeaterScreenCountArisa") var screenCountArisa = 0 {
                didSet {
                    screenCountSum = countSum(screenCountNone, screenCountKota, screenCountArisa, screenCountYu, screenCountSoma, screenCountSakuya, screenCountRindo, screenCountShio, screenCountCafe, screenCountAll, screenCountMinichara)
                }
            }
                @AppStorage("godeaterScreenCountYu") var screenCountYu = 0 {
                    didSet {
                        screenCountSum = countSum(screenCountNone, screenCountKota, screenCountArisa, screenCountYu, screenCountSoma, screenCountSakuya, screenCountRindo, screenCountShio, screenCountCafe, screenCountAll, screenCountMinichara)
                    }
                }
                    @AppStorage("godeaterScreenCountSome") var screenCountSoma = 0 {
                        didSet {
                            screenCountSum = countSum(screenCountNone, screenCountKota, screenCountArisa, screenCountYu, screenCountSoma, screenCountSakuya, screenCountRindo, screenCountShio, screenCountCafe, screenCountAll, screenCountMinichara)
                        }
                    }
                        @AppStorage("godeaterScreenCountSakuya") var screenCountSakuya = 0 {
                            didSet {
                                screenCountSum = countSum(screenCountNone, screenCountKota, screenCountArisa, screenCountYu, screenCountSoma, screenCountSakuya, screenCountRindo, screenCountShio, screenCountCafe, screenCountAll, screenCountMinichara)
                            }
                        }
                            @AppStorage("godeaterScreenCountRindo") var screenCountRindo = 0 {
                                didSet {
                                    screenCountSum = countSum(screenCountNone, screenCountKota, screenCountArisa, screenCountYu, screenCountSoma, screenCountSakuya, screenCountRindo, screenCountShio, screenCountCafe, screenCountAll, screenCountMinichara)
                                }
                            }
                                @AppStorage("godeaterScreenCountShio") var screenCountShio = 0 {
                                    didSet {
                                        screenCountSum = countSum(screenCountNone, screenCountKota, screenCountArisa, screenCountYu, screenCountSoma, screenCountSakuya, screenCountRindo, screenCountShio, screenCountCafe, screenCountAll, screenCountMinichara)
                                    }
                                }
                                    @AppStorage("godeaterScreenCountCafe") var screenCountCafe = 0 {
                                        didSet {
                                            screenCountSum = countSum(screenCountNone, screenCountKota, screenCountArisa, screenCountYu, screenCountSoma, screenCountSakuya, screenCountRindo, screenCountShio, screenCountCafe, screenCountAll, screenCountMinichara)
                                        }
                                    }
                                        @AppStorage("godeaterScreenCountAll") var screenCountAll = 0 {
                                            didSet {
                                                screenCountSum = countSum(screenCountNone, screenCountKota, screenCountArisa, screenCountYu, screenCountSoma, screenCountSakuya, screenCountRindo, screenCountShio, screenCountCafe, screenCountAll, screenCountMinichara)
                                            }
                                        }
                                            @AppStorage("godeaterScreenCountMinichara") var screenCountMinichara = 0 {
                                                didSet {
                                                    screenCountSum = countSum(screenCountNone, screenCountKota, screenCountArisa, screenCountYu, screenCountSoma, screenCountSakuya, screenCountRindo, screenCountShio, screenCountCafe, screenCountAll, screenCountMinichara)
                                                }
                                            }
    @AppStorage("godeaterScreenCountSum") var screenCountSum = 0
    
    func resetScreen() {
        screenCurrentKeyword = ""
        screenCountNone = 0
        screenCountKota = 0
        screenCountArisa = 0
        screenCountYu = 0
        screenCountSoma = 0
        screenCountSakuya = 0
        screenCountRindo = 0
        screenCountShio = 0
        screenCountCafe = 0
        screenCountAll = 0
        screenCountMinichara = 0
        minusCheck = false
    }
    
    // /////////////////////
    // 共通
    // /////////////////////
    @AppStorage("godeaterMinusCheck") var minusCheck = false
    
    func resetAll() {
        resetHistory()
        resetVoice()
        resetScreen()
    }
}

struct godeaterViewTop: View {
    @ObservedObject var godeater = Godeater()
    @State var isShowAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // AT,CZ当選履歴
                    NavigationLink(destination: godeaterViewHistory()) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "AT,CZ 当選履歴")
                    }
                    // ストーリーパート後のボイス
                    NavigationLink(destination: godeaterViewVoice()) {
                        unitLabelMenu(imageSystemName: "message", textBody: "ストーリーパート後のボイス")
                    }
                    // AT終了画面
                    NavigationLink(destination: godeaterViewScreen()) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "AT終了画面")
                    }
                    // エンディング
                    NavigationLink(destination: godeaterViewEnding()) {
                        unitLabelMenu(imageSystemName: "flag.checkered", textBody: "エンディング")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "ゴッドイーター リザレクション", titleFont: .title2)
                }
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButtonReset(isShowAlert: $isShowAlert, action: godeater.resetAll, message: "この機種の全データをリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

#Preview {
    godeaterViewTop()
}
