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
    @AppStorage("godeaterSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetHistory()
        resetVoice()
        resetScreen()
    }
}


// //// メモリー1
class GodeaterMemory1: ObservableObject {
    @AppStorage("godeaterGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("godeaterBonusArrayKeyMemory1") var bonusArrayData: Data?
    @AppStorage("godeaterTriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("godeaterAtHitCountMemory1") var atHitCount = 0
    @AppStorage("godeaterCzHitCountMemory1") var czHitCount = 0
    @AppStorage("godeaterPlayGameMemory1") var playGame = 0
    @AppStorage("godeaterVoiceDefaultCountMemory1") var voiceDefaultCount = 0
    @AppStorage("godeaterVoiceRindoCountMemory1") var voiceRindoCount = 0
    @AppStorage("godeaterVoiceHibariCountMemory1") var voiceHibariCount = 0
    @AppStorage("godeaterVoiceSakuyaCountMemory1") var voiceSakuyaCount = 0
    @AppStorage("godeaterVoiceSomaCountMemory1") var voiceSomaCount = 0
    @AppStorage("godeaterVoiceRenCountMemory1") var voiceRenCount = 0
    @AppStorage("godeaterVoiceYuCountMemory1") var voiceYuCount = 0
    @AppStorage("godeaterVoiceErinaCountMemory1") var voiceErinaCount = 0
    @AppStorage("godeaterVoiceShioCountMemory1") var voiceShioCount = 0
    @AppStorage("godeaterVoiceCountSumMemory1") var voiceCountSum = 0
    @AppStorage("godeaterScreenCountNoneMemory1") var screenCountNone = 0
    @AppStorage("godeaterScreenCountKotaMemory1") var screenCountKota = 0
    @AppStorage("godeaterScreenCountArisaMemory1") var screenCountArisa = 0
    @AppStorage("godeaterScreenCountYuMemory1") var screenCountYu = 0
    @AppStorage("godeaterScreenCountSomeMemory1") var screenCountSoma = 0
    @AppStorage("godeaterScreenCountSakuyaMemory1") var screenCountSakuya = 0
    @AppStorage("godeaterScreenCountRindoMemory1") var screenCountRindo = 0
    @AppStorage("godeaterScreenCountShioMemory1") var screenCountShio = 0
    @AppStorage("godeaterScreenCountCafeMemory1") var screenCountCafe = 0
    @AppStorage("godeaterScreenCountAllMemory1") var screenCountAll = 0
    @AppStorage("godeaterScreenCountMinicharaMemory1") var screenCountMinichara = 0
    @AppStorage("godeaterScreenCountSumMemory1") var screenCountSum = 0
    @AppStorage("godeaterMemoMemory1") var memo = ""
    @AppStorage("godeaterDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class GodeaterMemory2: ObservableObject {
    @AppStorage("godeaterGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("godeaterBonusArrayKeyMemory2") var bonusArrayData: Data?
    @AppStorage("godeaterTriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("godeaterAtHitCountMemory2") var atHitCount = 0
    @AppStorage("godeaterCzHitCountMemory2") var czHitCount = 0
    @AppStorage("godeaterPlayGameMemory2") var playGame = 0
    @AppStorage("godeaterVoiceDefaultCountMemory2") var voiceDefaultCount = 0
    @AppStorage("godeaterVoiceRindoCountMemory2") var voiceRindoCount = 0
    @AppStorage("godeaterVoiceHibariCountMemory2") var voiceHibariCount = 0
    @AppStorage("godeaterVoiceSakuyaCountMemory2") var voiceSakuyaCount = 0
    @AppStorage("godeaterVoiceSomaCountMemory2") var voiceSomaCount = 0
    @AppStorage("godeaterVoiceRenCountMemory2") var voiceRenCount = 0
    @AppStorage("godeaterVoiceYuCountMemory2") var voiceYuCount = 0
    @AppStorage("godeaterVoiceErinaCountMemory2") var voiceErinaCount = 0
    @AppStorage("godeaterVoiceShioCountMemory2") var voiceShioCount = 0
    @AppStorage("godeaterVoiceCountSumMemory2") var voiceCountSum = 0
    @AppStorage("godeaterScreenCountNoneMemory2") var screenCountNone = 0
    @AppStorage("godeaterScreenCountKotaMemory2") var screenCountKota = 0
    @AppStorage("godeaterScreenCountArisaMemory2") var screenCountArisa = 0
    @AppStorage("godeaterScreenCountYuMemory2") var screenCountYu = 0
    @AppStorage("godeaterScreenCountSomeMemory2") var screenCountSoma = 0
    @AppStorage("godeaterScreenCountSakuyaMemory2") var screenCountSakuya = 0
    @AppStorage("godeaterScreenCountRindoMemory2") var screenCountRindo = 0
    @AppStorage("godeaterScreenCountShioMemory2") var screenCountShio = 0
    @AppStorage("godeaterScreenCountCafeMemory2") var screenCountCafe = 0
    @AppStorage("godeaterScreenCountAllMemory2") var screenCountAll = 0
    @AppStorage("godeaterScreenCountMinicharaMemory2") var screenCountMinichara = 0
    @AppStorage("godeaterScreenCountSumMemory2") var screenCountSum = 0
    @AppStorage("godeaterMemoMemory2") var memo = ""
    @AppStorage("godeaterDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class GodeaterMemory3: ObservableObject {
    @AppStorage("godeaterGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("godeaterBonusArrayKeyMemory3") var bonusArrayData: Data?
    @AppStorage("godeaterTriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("godeaterAtHitCountMemory3") var atHitCount = 0
    @AppStorage("godeaterCzHitCountMemory3") var czHitCount = 0
    @AppStorage("godeaterPlayGameMemory3") var playGame = 0
    @AppStorage("godeaterVoiceDefaultCountMemory3") var voiceDefaultCount = 0
    @AppStorage("godeaterVoiceRindoCountMemory3") var voiceRindoCount = 0
    @AppStorage("godeaterVoiceHibariCountMemory3") var voiceHibariCount = 0
    @AppStorage("godeaterVoiceSakuyaCountMemory3") var voiceSakuyaCount = 0
    @AppStorage("godeaterVoiceSomaCountMemory3") var voiceSomaCount = 0
    @AppStorage("godeaterVoiceRenCountMemory3") var voiceRenCount = 0
    @AppStorage("godeaterVoiceYuCountMemory3") var voiceYuCount = 0
    @AppStorage("godeaterVoiceErinaCountMemory3") var voiceErinaCount = 0
    @AppStorage("godeaterVoiceShioCountMemory3") var voiceShioCount = 0
    @AppStorage("godeaterVoiceCountSumMemory3") var voiceCountSum = 0
    @AppStorage("godeaterScreenCountNoneMemory3") var screenCountNone = 0
    @AppStorage("godeaterScreenCountKotaMemory3") var screenCountKota = 0
    @AppStorage("godeaterScreenCountArisaMemory3") var screenCountArisa = 0
    @AppStorage("godeaterScreenCountYuMemory3") var screenCountYu = 0
    @AppStorage("godeaterScreenCountSomeMemory3") var screenCountSoma = 0
    @AppStorage("godeaterScreenCountSakuyaMemory3") var screenCountSakuya = 0
    @AppStorage("godeaterScreenCountRindoMemory3") var screenCountRindo = 0
    @AppStorage("godeaterScreenCountShioMemory3") var screenCountShio = 0
    @AppStorage("godeaterScreenCountCafeMemory3") var screenCountCafe = 0
    @AppStorage("godeaterScreenCountAllMemory3") var screenCountAll = 0
    @AppStorage("godeaterScreenCountMinicharaMemory3") var screenCountMinichara = 0
    @AppStorage("godeaterScreenCountSumMemory3") var screenCountSum = 0
    @AppStorage("godeaterMemoMemory3") var memo = ""
    @AppStorage("godeaterDateMemory3") var dateDouble = 0.0
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
                HStack {
                    HStack {
                        // //// データ読み出し
                        unitButtonLoadMemory(loadView: AnyView(godeaterViewLoadMemory()))
                        // //// データ保存
                        unitButtonSaveMemory(saveView: AnyView(godeaterViewSaveMemory()))
                    }
                    .popoverTip(tipUnitButtonMemory())
                    unitButtonReset(isShowAlert: $isShowAlert, action: godeater.resetAll, message: "この機種の全データをリセットします")
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct godeaterViewSaveMemory: View {
    @ObservedObject var godeater = Godeater()
    @ObservedObject var godeaterMemory1 = GodeaterMemory1()
    @ObservedObject var godeaterMemory2 = GodeaterMemory2()
    @ObservedObject var godeaterMemory3 = GodeaterMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ゴッドイーター リザレクション",
            selectedMemory: $godeater.selectedMemory,
            memoMemory1: $godeaterMemory1.memo,
            dateDoubleMemory1: $godeaterMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $godeaterMemory2.memo,
            dateDoubleMemory2: $godeaterMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $godeaterMemory3.memo,
            dateDoubleMemory3: $godeaterMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        godeaterMemory1.gameArrayData = godeater.gameArrayData
        godeaterMemory1.bonusArrayData = godeater.bonusArrayData
        godeaterMemory1.triggerArrayData = godeater.triggerArrayData
        godeaterMemory1.atHitCount = godeater.atHitCount
        godeaterMemory1.czHitCount = godeater.czHitCount
        godeaterMemory1.playGame = godeater.playGame
        godeaterMemory1.voiceDefaultCount = godeater.voiceDefaultCount
        godeaterMemory1.voiceRindoCount = godeater.voiceRindoCount
        godeaterMemory1.voiceHibariCount = godeater.voiceHibariCount
        godeaterMemory1.voiceSakuyaCount = godeater.voiceSakuyaCount
        godeaterMemory1.voiceSomaCount = godeater.voiceSomaCount
        godeaterMemory1.voiceRenCount = godeater.voiceRenCount
        godeaterMemory1.voiceYuCount = godeater.voiceYuCount
        godeaterMemory1.voiceErinaCount = godeater.voiceErinaCount
        godeaterMemory1.voiceShioCount = godeater.voiceShioCount
        godeaterMemory1.voiceCountSum = godeater.voiceCountSum
        godeaterMemory1.screenCountNone = godeater.screenCountNone
        godeaterMemory1.screenCountKota = godeater.screenCountKota
        godeaterMemory1.screenCountArisa = godeater.screenCountArisa
        godeaterMemory1.screenCountYu = godeater.screenCountYu
        godeaterMemory1.screenCountSoma = godeater.screenCountSoma
        godeaterMemory1.screenCountSakuya = godeater.screenCountSakuya
        godeaterMemory1.screenCountRindo = godeater.screenCountRindo
        godeaterMemory1.screenCountShio = godeater.screenCountShio
        godeaterMemory1.screenCountCafe = godeater.screenCountCafe
        godeaterMemory1.screenCountAll = godeater.screenCountAll
        godeaterMemory1.screenCountMinichara = godeater.screenCountMinichara
        godeaterMemory1.screenCountSum = godeater.screenCountSum
    }
    func saveMemory2() {
        godeaterMemory2.gameArrayData = godeater.gameArrayData
        godeaterMemory2.bonusArrayData = godeater.bonusArrayData
        godeaterMemory2.triggerArrayData = godeater.triggerArrayData
        godeaterMemory2.atHitCount = godeater.atHitCount
        godeaterMemory2.czHitCount = godeater.czHitCount
        godeaterMemory2.playGame = godeater.playGame
        godeaterMemory2.voiceDefaultCount = godeater.voiceDefaultCount
        godeaterMemory2.voiceRindoCount = godeater.voiceRindoCount
        godeaterMemory2.voiceHibariCount = godeater.voiceHibariCount
        godeaterMemory2.voiceSakuyaCount = godeater.voiceSakuyaCount
        godeaterMemory2.voiceSomaCount = godeater.voiceSomaCount
        godeaterMemory2.voiceRenCount = godeater.voiceRenCount
        godeaterMemory2.voiceYuCount = godeater.voiceYuCount
        godeaterMemory2.voiceErinaCount = godeater.voiceErinaCount
        godeaterMemory2.voiceShioCount = godeater.voiceShioCount
        godeaterMemory2.voiceCountSum = godeater.voiceCountSum
        godeaterMemory2.screenCountNone = godeater.screenCountNone
        godeaterMemory2.screenCountKota = godeater.screenCountKota
        godeaterMemory2.screenCountArisa = godeater.screenCountArisa
        godeaterMemory2.screenCountYu = godeater.screenCountYu
        godeaterMemory2.screenCountSoma = godeater.screenCountSoma
        godeaterMemory2.screenCountSakuya = godeater.screenCountSakuya
        godeaterMemory2.screenCountRindo = godeater.screenCountRindo
        godeaterMemory2.screenCountShio = godeater.screenCountShio
        godeaterMemory2.screenCountCafe = godeater.screenCountCafe
        godeaterMemory2.screenCountAll = godeater.screenCountAll
        godeaterMemory2.screenCountMinichara = godeater.screenCountMinichara
        godeaterMemory2.screenCountSum = godeater.screenCountSum
    }
    func saveMemory3() {
        godeaterMemory3.gameArrayData = godeater.gameArrayData
        godeaterMemory3.bonusArrayData = godeater.bonusArrayData
        godeaterMemory3.triggerArrayData = godeater.triggerArrayData
        godeaterMemory3.atHitCount = godeater.atHitCount
        godeaterMemory3.czHitCount = godeater.czHitCount
        godeaterMemory3.playGame = godeater.playGame
        godeaterMemory3.voiceDefaultCount = godeater.voiceDefaultCount
        godeaterMemory3.voiceRindoCount = godeater.voiceRindoCount
        godeaterMemory3.voiceHibariCount = godeater.voiceHibariCount
        godeaterMemory3.voiceSakuyaCount = godeater.voiceSakuyaCount
        godeaterMemory3.voiceSomaCount = godeater.voiceSomaCount
        godeaterMemory3.voiceRenCount = godeater.voiceRenCount
        godeaterMemory3.voiceYuCount = godeater.voiceYuCount
        godeaterMemory3.voiceErinaCount = godeater.voiceErinaCount
        godeaterMemory3.voiceShioCount = godeater.voiceShioCount
        godeaterMemory3.voiceCountSum = godeater.voiceCountSum
        godeaterMemory3.screenCountNone = godeater.screenCountNone
        godeaterMemory3.screenCountKota = godeater.screenCountKota
        godeaterMemory3.screenCountArisa = godeater.screenCountArisa
        godeaterMemory3.screenCountYu = godeater.screenCountYu
        godeaterMemory3.screenCountSoma = godeater.screenCountSoma
        godeaterMemory3.screenCountSakuya = godeater.screenCountSakuya
        godeaterMemory3.screenCountRindo = godeater.screenCountRindo
        godeaterMemory3.screenCountShio = godeater.screenCountShio
        godeaterMemory3.screenCountCafe = godeater.screenCountCafe
        godeaterMemory3.screenCountAll = godeater.screenCountAll
        godeaterMemory3.screenCountMinichara = godeater.screenCountMinichara
        godeaterMemory3.screenCountSum = godeater.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct godeaterViewLoadMemory: View {
    @ObservedObject var godeater = Godeater()
    @ObservedObject var godeaterMemory1 = GodeaterMemory1()
    @ObservedObject var godeaterMemory2 = GodeaterMemory2()
    @ObservedObject var godeaterMemory3 = GodeaterMemory3()
    @State var isShowLoadAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ゴッドイーター レザレクション",
            selectedMemory: $godeater.selectedMemory,
            memoMemory1: godeaterMemory1.memo,
            dateDoubleMemory1: godeaterMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: godeaterMemory2.memo,
            dateDoubleMemory2: godeaterMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: godeaterMemory3.memo,
            dateDoubleMemory3: godeaterMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        godeater.gameArrayData = godeaterMemory1.gameArrayData
        godeater.bonusArrayData = godeaterMemory1.bonusArrayData
        godeater.triggerArrayData = godeaterMemory1.triggerArrayData
        godeater.atHitCount = godeaterMemory1.atHitCount
        godeater.czHitCount = godeaterMemory1.czHitCount
        godeater.playGame = godeaterMemory1.playGame
        godeater.voiceDefaultCount = godeaterMemory1.voiceDefaultCount
        godeater.voiceRindoCount = godeaterMemory1.voiceRindoCount
        godeater.voiceHibariCount = godeaterMemory1.voiceHibariCount
        godeater.voiceSakuyaCount = godeaterMemory1.voiceSakuyaCount
        godeater.voiceSomaCount = godeaterMemory1.voiceSomaCount
        godeater.voiceRenCount = godeaterMemory1.voiceRenCount
        godeater.voiceYuCount = godeaterMemory1.voiceYuCount
        godeater.voiceErinaCount = godeaterMemory1.voiceErinaCount
        godeater.voiceShioCount = godeaterMemory1.voiceShioCount
        godeater.voiceCountSum = godeaterMemory1.voiceCountSum
        godeater.screenCountNone = godeaterMemory1.screenCountNone
        godeater.screenCountKota = godeaterMemory1.screenCountKota
        godeater.screenCountArisa = godeaterMemory1.screenCountArisa
        godeater.screenCountYu = godeaterMemory1.screenCountYu
        godeater.screenCountSoma = godeaterMemory1.screenCountSoma
        godeater.screenCountSakuya = godeaterMemory1.screenCountSakuya
        godeater.screenCountRindo = godeaterMemory1.screenCountRindo
        godeater.screenCountShio = godeaterMemory1.screenCountShio
        godeater.screenCountCafe = godeaterMemory1.screenCountCafe
        godeater.screenCountAll = godeaterMemory1.screenCountAll
        godeater.screenCountMinichara = godeaterMemory1.screenCountMinichara
        godeater.screenCountSum = godeaterMemory1.screenCountSum
    }
    func loadMemory2() {
        godeater.gameArrayData = godeaterMemory2.gameArrayData
        godeater.bonusArrayData = godeaterMemory2.bonusArrayData
        godeater.triggerArrayData = godeaterMemory2.triggerArrayData
        godeater.atHitCount = godeaterMemory2.atHitCount
        godeater.czHitCount = godeaterMemory2.czHitCount
        godeater.playGame = godeaterMemory2.playGame
        godeater.voiceDefaultCount = godeaterMemory2.voiceDefaultCount
        godeater.voiceRindoCount = godeaterMemory2.voiceRindoCount
        godeater.voiceHibariCount = godeaterMemory2.voiceHibariCount
        godeater.voiceSakuyaCount = godeaterMemory2.voiceSakuyaCount
        godeater.voiceSomaCount = godeaterMemory2.voiceSomaCount
        godeater.voiceRenCount = godeaterMemory2.voiceRenCount
        godeater.voiceYuCount = godeaterMemory2.voiceYuCount
        godeater.voiceErinaCount = godeaterMemory2.voiceErinaCount
        godeater.voiceShioCount = godeaterMemory2.voiceShioCount
        godeater.voiceCountSum = godeaterMemory2.voiceCountSum
        godeater.screenCountNone = godeaterMemory2.screenCountNone
        godeater.screenCountKota = godeaterMemory2.screenCountKota
        godeater.screenCountArisa = godeaterMemory2.screenCountArisa
        godeater.screenCountYu = godeaterMemory2.screenCountYu
        godeater.screenCountSoma = godeaterMemory2.screenCountSoma
        godeater.screenCountSakuya = godeaterMemory2.screenCountSakuya
        godeater.screenCountRindo = godeaterMemory2.screenCountRindo
        godeater.screenCountShio = godeaterMemory2.screenCountShio
        godeater.screenCountCafe = godeaterMemory2.screenCountCafe
        godeater.screenCountAll = godeaterMemory2.screenCountAll
        godeater.screenCountMinichara = godeaterMemory2.screenCountMinichara
        godeater.screenCountSum = godeaterMemory2.screenCountSum
    }
    func loadMemory3() {
        godeater.gameArrayData = godeaterMemory3.gameArrayData
        godeater.bonusArrayData = godeaterMemory3.bonusArrayData
        godeater.triggerArrayData = godeaterMemory3.triggerArrayData
        godeater.atHitCount = godeaterMemory3.atHitCount
        godeater.czHitCount = godeaterMemory3.czHitCount
        godeater.playGame = godeaterMemory3.playGame
        godeater.voiceDefaultCount = godeaterMemory3.voiceDefaultCount
        godeater.voiceRindoCount = godeaterMemory3.voiceRindoCount
        godeater.voiceHibariCount = godeaterMemory3.voiceHibariCount
        godeater.voiceSakuyaCount = godeaterMemory3.voiceSakuyaCount
        godeater.voiceSomaCount = godeaterMemory3.voiceSomaCount
        godeater.voiceRenCount = godeaterMemory3.voiceRenCount
        godeater.voiceYuCount = godeaterMemory3.voiceYuCount
        godeater.voiceErinaCount = godeaterMemory3.voiceErinaCount
        godeater.voiceShioCount = godeaterMemory3.voiceShioCount
        godeater.voiceCountSum = godeaterMemory3.voiceCountSum
        godeater.screenCountNone = godeaterMemory3.screenCountNone
        godeater.screenCountKota = godeaterMemory3.screenCountKota
        godeater.screenCountArisa = godeaterMemory3.screenCountArisa
        godeater.screenCountYu = godeaterMemory3.screenCountYu
        godeater.screenCountSoma = godeaterMemory3.screenCountSoma
        godeater.screenCountSakuya = godeaterMemory3.screenCountSakuya
        godeater.screenCountRindo = godeaterMemory3.screenCountRindo
        godeater.screenCountShio = godeaterMemory3.screenCountShio
        godeater.screenCountCafe = godeaterMemory3.screenCountCafe
        godeater.screenCountAll = godeaterMemory3.screenCountAll
        godeater.screenCountMinichara = godeaterMemory3.screenCountMinichara
        godeater.screenCountSum = godeaterMemory3.screenCountSum
    }
}

#Preview {
    godeaterViewTop()
}
