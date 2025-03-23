//
//  danvineViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/08.
//

import SwiftUI
import TipKit


// /////////////////////////
// 変数
// /////////////////////////
class Danvine: ObservableObject {
    // ////////////////////////
    // 履歴
    // ////////////////////////
    // 選択肢の設定
    let selectListBonus = [
        "フェラリオ",
        "オーラ",
        "ハイパー"
    ]
    let selectListTrigger = [
        "ミッション",
        "アタック",
        "規定Pt",
        "直撃",
        "2Gバトル",
        "天井",
        "フリーズ",
        "その他"
    ]
    let selectListStHit = [
        "当選",
        "ハズレ"
    ]
    let selectListStHitOraHyper = [
        "当選"
    ]
    // 選択結果の設定
    @Published var inputGame = 0
    @Published var selectedBonus = "オーラ"
    @Published var selectedTrigger = "ミッション"
    @Published var selectedStHit = "当選"
    // //// 配列の設定
    // ゲーム数配列
    let gameArrayKey = "danvineGameArrayKey"
    @AppStorage("danvineGameArrayKey") var gameArrayData: Data?
    // ボーナス種類配列
    let bonusArrayKey = "danvineBonusArrayKey"
    @AppStorage("danvineBonusArrayKey") var bonusArrayData: Data?
    // 当選契機配列
    let triggerArrayKey = "danvineTriggerArrayKey"
    @AppStorage("danvineTriggerArrayKey") var triggerArrayData: Data?
    // ST当否配列
    let stHitArrayKey = "danvineStHitArrayKey"
    @AppStorage("danvineStHitArrayKey") var stHitArrayData: Data?
    // //// 結果集計
    @AppStorage("danvinePlayGameSum") var playGameSum = 0
    @AppStorage("danvineBonusCount") var bonusCount = 0
    @AppStorage("danvineStCount") var stCount = 0
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: bonusArrayData, key: bonusArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveLast(arrayData: stHitArrayData, key: stHitArrayKey)
        bonusCount = arrayIntAllDataCount(arrayData: gameArrayData)
        stCount = arrayStringDataCount(arrayData: stHitArrayData, countString: selectListStHit[0])
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedBonus = "オーラ"
        selectedTrigger = "ミッション"
        selectedStHit = "当選"
    }
    // データ追加
    func addDataHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedTrigger, key: triggerArrayKey)
        arrayStringAddData(arrayData: stHitArrayData, addData: selectedStHit, key: stHitArrayKey)
        bonusCount = arrayIntAllDataCount(arrayData: gameArrayData)
        stCount = arrayStringDataCount(arrayData: stHitArrayData, countString: selectListStHit[0])
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedBonus = "オーラ"
        selectedTrigger = "ミッション"
        selectedStHit = "当選"
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: bonusArrayData, key: bonusArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveAll(arrayData: stHitArrayData, key: stHitArrayKey)
        bonusCount = arrayIntAllDataCount(arrayData: gameArrayData)
        stCount = arrayStringDataCount(arrayData: stHitArrayData, countString: selectListStHit[0])
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedBonus = "オーラ"
        selectedTrigger = "ミッション"
        selectedStHit = "当選"
        minusCheck = false
    }
    
    // ////////////////////////
    // アタックモード
    // ////////////////////////
    @AppStorage("danvineAttackHazure3CountAll") var hazure3CountAll = 0
    @AppStorage("danvineAttackHazure3CountWin") var hazure3CountWin = 0
    
    
    func resetAttack() {
        hazure3CountAll = 0
        hazure3CountWin = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // ST中
    // ////////////////////////
    @AppStorage("danvineChamLampCountWhitBlue") var chamLampCountWhitBlue = 0 {
        didSet {
            chamLampCountSum = countSum(chamLampCountWhitBlue, chamLampCountYellow, chamLampCountGreen, chamLampCountRed)
        }
    }
        @AppStorage("danvineChamLampCountYellow") var chamLampCountYellow = 0 {
            didSet {
                chamLampCountSum = countSum(chamLampCountWhitBlue, chamLampCountYellow, chamLampCountGreen, chamLampCountRed)
            }
        }
            @AppStorage("danvineChamLampCountGreen") var chamLampCountGreen = 0 {
                didSet {
                    chamLampCountSum = countSum(chamLampCountWhitBlue, chamLampCountYellow, chamLampCountGreen, chamLampCountRed)
                }
            }
                @AppStorage("danvineChamLampCountRed") var chamLampCountRed = 0 {
                    didSet {
                        chamLampCountSum = countSum(chamLampCountWhitBlue, chamLampCountYellow, chamLampCountGreen, chamLampCountRed)
                    }
                }
    @AppStorage("danvineChamLampCountSum") var chamLampCountSum = 0
    @AppStorage("danvineAuraAttackCountNone") var auraAttackCountNone = 0 {
        didSet {
            auraAttackCountSum = countSum(auraAttackCountNone, auraAttackCountWin)
        }
    }
        @AppStorage("danvineAuraAttackCountWin") var auraAttackCountWin = 0 {
            didSet {
                auraAttackCountSum = countSum(auraAttackCountNone, auraAttackCountWin)
            }
        }
    @AppStorage("danvineAuraAttackCountSum") var auraAttackCountSum = 0
    
    func resetSt() {
        chamLampCountWhitBlue = 0
        chamLampCountYellow = 0
        chamLampCountGreen = 0
        chamLampCountRed = 0
        auraAttackCountNone = 0
        auraAttackCountWin = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // ST終了ボイス
    // ////////////////////////
    @Published var selectListVoice = [
        "俺は負けない！",
        "フェラリオだって、品性は身につけなくちゃ",
        "ダンバインで、蹴散らしてみせなさい",
        "来ます！悪しきオーラ力",
        "私が受けた屈辱、この恨み、貴様にわかるか！？ショウ！",
        "俺は人は殺さない！その怨念を殺す！",
        "私が欲しいのはLike me じゃないわ、Love me よ",
        "人々よ！バイストンウェルに帰還します",
        "乾杯といくかい？",
        "落ちろよーーー",
        "と言われてもなぁ"
    ]
    @AppStorage("danvineSelectedVoice") var selectedVoice = "俺は負けない！"
    @AppStorage("danvineVoiceCountDefault") var voiceCountDefault = 0 {
        didSet {
            voiceCountSum = countSum(voiceCountDefault, voiceCountHighJaku, voiceCountHighChu, voiceCountHighKyo, voiceCountOver4, voiceCountOver6, voiceCountComeBack)
        }
    }
        @AppStorage("danvineVoiceCountHighJaku") var voiceCountHighJaku = 0 {
            didSet {
                voiceCountSum = countSum(voiceCountDefault, voiceCountHighJaku, voiceCountHighChu, voiceCountHighKyo, voiceCountOver4, voiceCountOver6, voiceCountComeBack)
            }
        }
            @AppStorage("danvineVoiceCountHighChu") var voiceCountHighChu = 0 {
                didSet {
                    voiceCountSum = countSum(voiceCountDefault, voiceCountHighJaku, voiceCountHighChu, voiceCountHighKyo, voiceCountOver4, voiceCountOver6, voiceCountComeBack)
                }
            }
                @AppStorage("danvineVoiceCountHighKyo") var voiceCountHighKyo = 0 {
                    didSet {
                        voiceCountSum = countSum(voiceCountDefault, voiceCountHighJaku, voiceCountHighChu, voiceCountHighKyo, voiceCountOver4, voiceCountOver6, voiceCountComeBack)
                    }
                }
                    @AppStorage("danvineVoiceCountOver4") var voiceCountOver4 = 0 {
                        didSet {
                            voiceCountSum = countSum(voiceCountDefault, voiceCountHighJaku, voiceCountHighChu, voiceCountHighKyo, voiceCountOver4, voiceCountOver6, voiceCountComeBack)
                        }
                    }
                        @AppStorage("danvineVoiceCountOver6") var voiceCountOver6 = 0 {
                            didSet {
                                voiceCountSum = countSum(voiceCountDefault, voiceCountHighJaku, voiceCountHighChu, voiceCountHighKyo, voiceCountOver4, voiceCountOver6, voiceCountComeBack)
                            }
                        }
                            @AppStorage("danvineVoiceCountComeBack") var voiceCountComeBack = 0 {
                                didSet {
                                    voiceCountSum = countSum(voiceCountDefault, voiceCountHighJaku, voiceCountHighChu, voiceCountHighKyo, voiceCountOver4, voiceCountOver6, voiceCountComeBack)
                                }
                            }
    @AppStorage("danvineVoiceCountSum") var voiceCountSum = 0
    
    func resetVoice() {
        voiceCountDefault = 0
        voiceCountHighJaku = 0
        voiceCountHighChu = 0
        voiceCountHighKyo = 0
        voiceCountOver4 = 0
        voiceCountOver6 = 0
        voiceCountComeBack = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 規定Pt
    // ////////////////////////
    @AppStorage("danvinePtCountNot11") var ptCountNot11 = 0 {
        didSet {
            ptCountSum = countSum(ptCountNot11, ptCount11)
        }
    }
        @AppStorage("danvinePtCount11") var ptCount11 = 0 {
            didSet {
                ptCountSum = countSum(ptCountNot11, ptCount11)
            }
        }
    @AppStorage("danvinePtCountSum") var ptCountSum = 0
    
    func resetPt() {
        ptCountNot11 = 0
        ptCount11 = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("danvineMinusCheck") var minusCheck: Bool = false
    @AppStorage("danvineSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetHistory()
        resetAttack()
        resetSt()
        resetVoice()
        resetPt()
    }
}

// //// メモリー1
class DanvineMemory1: ObservableObject {
    @AppStorage("danvineGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("danvineBonusArrayKeyMemory1") var bonusArrayData: Data?
    @AppStorage("danvineTriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("danvineStHitArrayKeyMemory1") var stHitArrayData: Data?
    @AppStorage("danvinePlayGameSumMemory1") var playGameSum = 0
    @AppStorage("danvineBonusCountMemory1") var bonusCount = 0
    @AppStorage("danvineStCountMemory1") var stCount = 0
    @AppStorage("danvineAttackHazure3CountAllMemory1") var hazure3CountAll = 0
    @AppStorage("danvineAttackHazure3CountWinMemory1") var hazure3CountWin = 0
    @AppStorage("danvineChamLampCountWhitBlueMemory1") var chamLampCountWhitBlue = 0
    @AppStorage("danvineChamLampCountYellowMemory1") var chamLampCountYellow = 0
    @AppStorage("danvineChamLampCountGreenMemory1") var chamLampCountGreen = 0
    @AppStorage("danvineChamLampCountRedMemory1") var chamLampCountRed = 0
    @AppStorage("danvineAuraAttackCountNoneMemory1") var auraAttackCountNone = 0
    @AppStorage("danvineAuraAttackCountWinMemory1") var auraAttackCountWin = 0
    @AppStorage("danvineAuraAttackCountSumMemory1") var auraAttackCountSum = 0
    @AppStorage("danvineVoiceCountDefaultMemory1") var voiceCountDefault = 0
    @AppStorage("danvineVoiceCountHighJakuMemory1") var voiceCountHighJaku = 0
    @AppStorage("danvineVoiceCountHighChuMemory1") var voiceCountHighChu = 0
    @AppStorage("danvineVoiceCountHighKyoMemory1") var voiceCountHighKyo = 0
    @AppStorage("danvineVoiceCountOver4Memory1") var voiceCountOver4 = 0
    @AppStorage("danvineVoiceCountOver6Memory1") var voiceCountOver6 = 0
    @AppStorage("danvineVoiceCountComeBackMemory1") var voiceCountComeBack = 0
    @AppStorage("danvineVoiceCountSumMemory1") var voiceCountSum = 0
    @AppStorage("danvinePtCountNot11Memory1") var ptCountNot11 = 0
    @AppStorage("danvinePtCount11Memory1") var ptCount11 = 0
    @AppStorage("danvinePtCountSumMemory1") var ptCountSum = 0
    @AppStorage("danvineMemoMemory1") var memo = ""
    @AppStorage("danvineDateMemory1") var dateDouble = 0.0
}


// //// メモリー2
class DanvineMemory2: ObservableObject {
    @AppStorage("danvineGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("danvineBonusArrayKeyMemory2") var bonusArrayData: Data?
    @AppStorage("danvineTriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("danvineStHitArrayKeyMemory2") var stHitArrayData: Data?
    @AppStorage("danvinePlayGameSumMemory2") var playGameSum = 0
    @AppStorage("danvineBonusCountMemory2") var bonusCount = 0
    @AppStorage("danvineStCountMemory2") var stCount = 0
    @AppStorage("danvineAttackHazure3CountAllMemory2") var hazure3CountAll = 0
    @AppStorage("danvineAttackHazure3CountWinMemory2") var hazure3CountWin = 0
    @AppStorage("danvineChamLampCountWhitBlueMemory2") var chamLampCountWhitBlue = 0
    @AppStorage("danvineChamLampCountYellowMemory2") var chamLampCountYellow = 0
    @AppStorage("danvineChamLampCountGreenMemory2") var chamLampCountGreen = 0
    @AppStorage("danvineChamLampCountRedMemory2") var chamLampCountRed = 0
    @AppStorage("danvineAuraAttackCountNoneMemory2") var auraAttackCountNone = 0
    @AppStorage("danvineAuraAttackCountWinMemory2") var auraAttackCountWin = 0
    @AppStorage("danvineAuraAttackCountSumMemory2") var auraAttackCountSum = 0
    @AppStorage("danvineVoiceCountDefaultMemory2") var voiceCountDefault = 0
    @AppStorage("danvineVoiceCountHighJakuMemory2") var voiceCountHighJaku = 0
    @AppStorage("danvineVoiceCountHighChuMemory2") var voiceCountHighChu = 0
    @AppStorage("danvineVoiceCountHighKyoMemory2") var voiceCountHighKyo = 0
    @AppStorage("danvineVoiceCountOver4Memory2") var voiceCountOver4 = 0
    @AppStorage("danvineVoiceCountOver6Memory2") var voiceCountOver6 = 0
    @AppStorage("danvineVoiceCountComeBackMemory2") var voiceCountComeBack = 0
    @AppStorage("danvineVoiceCountSumMemory2") var voiceCountSum = 0
    @AppStorage("danvinePtCountNot11Memory2") var ptCountNot11 = 0
    @AppStorage("danvinePtCount11Memory2") var ptCount11 = 0
    @AppStorage("danvinePtCountSumMemory2") var ptCountSum = 0
    @AppStorage("danvineMemoMemory2") var memo = ""
    @AppStorage("danvineDateMemory2") var dateDouble = 0.0
}


// //// メモリー3
class DanvineMemory3: ObservableObject {
    @AppStorage("danvineGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("danvineBonusArrayKeyMemory3") var bonusArrayData: Data?
    @AppStorage("danvineTriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("danvineStHitArrayKeyMemory3") var stHitArrayData: Data?
    @AppStorage("danvinePlayGameSumMemory3") var playGameSum = 0
    @AppStorage("danvineBonusCountMemory3") var bonusCount = 0
    @AppStorage("danvineStCountMemory3") var stCount = 0
    @AppStorage("danvineAttackHazure3CountAllMemory3") var hazure3CountAll = 0
    @AppStorage("danvineAttackHazure3CountWinMemory3") var hazure3CountWin = 0
    @AppStorage("danvineChamLampCountWhitBlueMemory3") var chamLampCountWhitBlue = 0
    @AppStorage("danvineChamLampCountYellowMemory3") var chamLampCountYellow = 0
    @AppStorage("danvineChamLampCountGreenMemory3") var chamLampCountGreen = 0
    @AppStorage("danvineChamLampCountRedMemory3") var chamLampCountRed = 0
    @AppStorage("danvineAuraAttackCountNoneMemory3") var auraAttackCountNone = 0
    @AppStorage("danvineAuraAttackCountWinMemory3") var auraAttackCountWin = 0
    @AppStorage("danvineAuraAttackCountSumMemory3") var auraAttackCountSum = 0
    @AppStorage("danvineVoiceCountDefaultMemory3") var voiceCountDefault = 0
    @AppStorage("danvineVoiceCountHighJakuMemory3") var voiceCountHighJaku = 0
    @AppStorage("danvineVoiceCountHighChuMemory3") var voiceCountHighChu = 0
    @AppStorage("danvineVoiceCountHighKyoMemory3") var voiceCountHighKyo = 0
    @AppStorage("danvineVoiceCountOver4Memory3") var voiceCountOver4 = 0
    @AppStorage("danvineVoiceCountOver6Memory3") var voiceCountOver6 = 0
    @AppStorage("danvineVoiceCountComeBackMemory3") var voiceCountComeBack = 0
    @AppStorage("danvineVoiceCountSumMemory3") var voiceCountSum = 0
    @AppStorage("danvinePtCountNot11Memory3") var ptCountNot11 = 0
    @AppStorage("danvinePtCount11Memory3") var ptCount11 = 0
    @AppStorage("danvinePtCountSumMemory3") var ptCountSum = 0
    @AppStorage("danvineMemoMemory3") var memo = ""
    @AppStorage("danvineDateMemory3") var dateDouble = 0.0
}


struct danvineViewTop: View {
    @ObservedObject var danvine = Danvine()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時演出、モード
                    NavigationLink(destination: danvineViewNormalMode()) {
                        unitLabelMenu(
                            imageSystemName: "square.3.layers.3d",
                            textBody: "通常時演出、モード")
                    }
                    // 規定ポイント
                    NavigationLink(destination: danvineViewPt()) {
                        unitLabelMenu(
                            imageSystemName: "11.circle",
                            textBody: "規定ポイント"
                        )
                    }
                    // アタックモード
                    NavigationLink(destination: danvineViewAttack()) {
                        unitLabelMenu(
                            imageSystemName: "figure.martial.arts",
                            textBody: "アタックモード"
                        )
                    }
                    // 初当り履歴
                    NavigationLink(destination: danvineViewHistory()) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "ボーナス,ST初当り履歴"
                        )
                    }
                    // ST中
                    NavigationLink(destination: danvineViewSt()) {
                        unitLabelMenu(
                            imageSystemName: "party.popper",
                            textBody: "ST中"
                        )
                    }
                    // ST終了ボイス
                    NavigationLink(destination: danvineViewVoice()) {
                        unitLabelMenu(
                            imageSystemName: "message",
                            textBody: "ST終了ボイス"
                        )
                    }
                    // サミートロフィー
                    NavigationLink(destination: commonViewSammyTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "サミートロフィー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "ダンバイン")
                }
                // 設定推測グラフ
                NavigationLink(destination: danvineView95Ci(selection: 3)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4681")
                    .popoverTip(tipVer220AddLink())
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(danvineSubViewLoadMemory()))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(danvineSubViewSaveMemory()))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: danvine.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct danvineSubViewSaveMemory: View {
    @ObservedObject var danvine = Danvine()
    @ObservedObject var danvineMemory1 = DanvineMemory1()
    @ObservedObject var danvineMemory2 = DanvineMemory2()
    @ObservedObject var danvineMemory3 = DanvineMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ダンバイン",
            selectedMemory: $danvine.selectedMemory,
            memoMemory1: $danvineMemory1.memo,
            dateDoubleMemory1: $danvineMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $danvineMemory2.memo,
            dateDoubleMemory2: $danvineMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $danvineMemory3.memo,
            dateDoubleMemory3: $danvineMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        danvineMemory1.gameArrayData = danvine.gameArrayData
        danvineMemory1.bonusArrayData = danvine.bonusArrayData
        danvineMemory1.triggerArrayData = danvine.triggerArrayData
        danvineMemory1.stHitArrayData = danvine.stHitArrayData
        danvineMemory1.playGameSum = danvine.playGameSum
        danvineMemory1.bonusCount = danvine.bonusCount
        danvineMemory1.stCount = danvine.stCount
        danvineMemory1.hazure3CountAll = danvine.hazure3CountAll
        danvineMemory1.hazure3CountWin = danvine.hazure3CountWin
        danvineMemory1.chamLampCountWhitBlue = danvine.chamLampCountWhitBlue
        danvineMemory1.chamLampCountYellow = danvine.chamLampCountYellow
        danvineMemory1.chamLampCountGreen = danvine.chamLampCountGreen
        danvineMemory1.chamLampCountRed = danvine.chamLampCountRed
        danvineMemory1.auraAttackCountNone = danvine.auraAttackCountNone
        danvineMemory1.auraAttackCountWin = danvine.auraAttackCountWin
        danvineMemory1.auraAttackCountSum = danvine.auraAttackCountSum
        danvineMemory1.voiceCountDefault = danvine.voiceCountDefault
        danvineMemory1.voiceCountHighJaku = danvine.voiceCountHighJaku
        danvineMemory1.voiceCountHighChu = danvine.voiceCountHighChu
        danvineMemory1.voiceCountHighKyo = danvine.voiceCountHighKyo
        danvineMemory1.voiceCountOver4 = danvine.voiceCountOver4
        danvineMemory1.voiceCountOver6 = danvine.voiceCountOver6
        danvineMemory1.voiceCountComeBack = danvine.voiceCountComeBack
        danvineMemory1.voiceCountSum = danvine.voiceCountSum
        danvineMemory1.ptCountNot11 = danvine.ptCountNot11
        danvineMemory1.ptCount11 = danvine.ptCount11
        danvineMemory1.ptCountSum = danvine.ptCountSum
    }
    func saveMemory2() {
        danvineMemory2.gameArrayData = danvine.gameArrayData
        danvineMemory2.bonusArrayData = danvine.bonusArrayData
        danvineMemory2.triggerArrayData = danvine.triggerArrayData
        danvineMemory2.stHitArrayData = danvine.stHitArrayData
        danvineMemory2.playGameSum = danvine.playGameSum
        danvineMemory2.bonusCount = danvine.bonusCount
        danvineMemory2.stCount = danvine.stCount
        danvineMemory2.hazure3CountAll = danvine.hazure3CountAll
        danvineMemory2.hazure3CountWin = danvine.hazure3CountWin
        danvineMemory2.chamLampCountWhitBlue = danvine.chamLampCountWhitBlue
        danvineMemory2.chamLampCountYellow = danvine.chamLampCountYellow
        danvineMemory2.chamLampCountGreen = danvine.chamLampCountGreen
        danvineMemory2.chamLampCountRed = danvine.chamLampCountRed
        danvineMemory2.auraAttackCountNone = danvine.auraAttackCountNone
        danvineMemory2.auraAttackCountWin = danvine.auraAttackCountWin
        danvineMemory2.auraAttackCountSum = danvine.auraAttackCountSum
        danvineMemory2.voiceCountDefault = danvine.voiceCountDefault
        danvineMemory2.voiceCountHighJaku = danvine.voiceCountHighJaku
        danvineMemory2.voiceCountHighChu = danvine.voiceCountHighChu
        danvineMemory2.voiceCountHighKyo = danvine.voiceCountHighKyo
        danvineMemory2.voiceCountOver4 = danvine.voiceCountOver4
        danvineMemory2.voiceCountOver6 = danvine.voiceCountOver6
        danvineMemory2.voiceCountComeBack = danvine.voiceCountComeBack
        danvineMemory2.voiceCountSum = danvine.voiceCountSum
        danvineMemory2.ptCountNot11 = danvine.ptCountNot11
        danvineMemory2.ptCount11 = danvine.ptCount11
        danvineMemory2.ptCountSum = danvine.ptCountSum
    }
    func saveMemory3() {
        danvineMemory3.gameArrayData = danvine.gameArrayData
        danvineMemory3.bonusArrayData = danvine.bonusArrayData
        danvineMemory3.triggerArrayData = danvine.triggerArrayData
        danvineMemory3.stHitArrayData = danvine.stHitArrayData
        danvineMemory3.playGameSum = danvine.playGameSum
        danvineMemory3.bonusCount = danvine.bonusCount
        danvineMemory3.stCount = danvine.stCount
        danvineMemory3.hazure3CountAll = danvine.hazure3CountAll
        danvineMemory3.hazure3CountWin = danvine.hazure3CountWin
        danvineMemory3.chamLampCountWhitBlue = danvine.chamLampCountWhitBlue
        danvineMemory3.chamLampCountYellow = danvine.chamLampCountYellow
        danvineMemory3.chamLampCountGreen = danvine.chamLampCountGreen
        danvineMemory3.chamLampCountRed = danvine.chamLampCountRed
        danvineMemory3.auraAttackCountNone = danvine.auraAttackCountNone
        danvineMemory3.auraAttackCountWin = danvine.auraAttackCountWin
        danvineMemory3.auraAttackCountSum = danvine.auraAttackCountSum
        danvineMemory3.voiceCountDefault = danvine.voiceCountDefault
        danvineMemory3.voiceCountHighJaku = danvine.voiceCountHighJaku
        danvineMemory3.voiceCountHighChu = danvine.voiceCountHighChu
        danvineMemory3.voiceCountHighKyo = danvine.voiceCountHighKyo
        danvineMemory3.voiceCountOver4 = danvine.voiceCountOver4
        danvineMemory3.voiceCountOver6 = danvine.voiceCountOver6
        danvineMemory3.voiceCountComeBack = danvine.voiceCountComeBack
        danvineMemory3.voiceCountSum = danvine.voiceCountSum
        danvineMemory3.ptCountNot11 = danvine.ptCountNot11
        danvineMemory3.ptCount11 = danvine.ptCount11
        danvineMemory3.ptCountSum = danvine.ptCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct danvineSubViewLoadMemory: View {
    @ObservedObject var danvine = Danvine()
    @ObservedObject var danvineMemory1 = DanvineMemory1()
    @ObservedObject var danvineMemory2 = DanvineMemory2()
    @ObservedObject var danvineMemory3 = DanvineMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ダンバイン",
            selectedMemory: $danvine.selectedMemory,
            memoMemory1: danvineMemory1.memo,
            dateDoubleMemory1: danvineMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: danvineMemory2.memo,
            dateDoubleMemory2: danvineMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: danvineMemory3.memo,
            dateDoubleMemory3: danvineMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        danvine.gameArrayData = danvineMemory1.gameArrayData
        danvine.bonusArrayData = danvineMemory1.bonusArrayData
        danvine.triggerArrayData = danvineMemory1.triggerArrayData
        danvine.stHitArrayData = danvineMemory1.stHitArrayData
        danvine.playGameSum = danvineMemory1.playGameSum
        danvine.bonusCount = danvineMemory1.bonusCount
        danvine.stCount = danvineMemory1.stCount
        danvine.hazure3CountAll = danvineMemory1.hazure3CountAll
        danvine.hazure3CountWin = danvineMemory1.hazure3CountWin
        danvine.chamLampCountWhitBlue = danvineMemory1.chamLampCountWhitBlue
        danvine.chamLampCountYellow = danvineMemory1.chamLampCountYellow
        danvine.chamLampCountGreen = danvineMemory1.chamLampCountGreen
        danvine.chamLampCountRed = danvineMemory1.chamLampCountRed
        danvine.auraAttackCountNone = danvineMemory1.auraAttackCountNone
        danvine.auraAttackCountWin = danvineMemory1.auraAttackCountWin
        danvine.auraAttackCountSum = danvineMemory1.auraAttackCountSum
        danvine.voiceCountDefault = danvineMemory1.voiceCountDefault
        danvine.voiceCountHighJaku = danvineMemory1.voiceCountHighJaku
        danvine.voiceCountHighChu = danvineMemory1.voiceCountHighChu
        danvine.voiceCountHighKyo = danvineMemory1.voiceCountHighKyo
        danvine.voiceCountOver4 = danvineMemory1.voiceCountOver4
        danvine.voiceCountOver6 = danvineMemory1.voiceCountOver6
        danvine.voiceCountComeBack = danvineMemory1.voiceCountComeBack
        danvine.voiceCountSum = danvineMemory1.voiceCountSum
        danvine.ptCountNot11 = danvineMemory1.ptCountNot11
        danvine.ptCount11 = danvineMemory1.ptCount11
        danvine.ptCountSum = danvineMemory1.ptCountSum
    }
    func loadMemory2() {
        danvine.gameArrayData = danvineMemory2.gameArrayData
        danvine.bonusArrayData = danvineMemory2.bonusArrayData
        danvine.triggerArrayData = danvineMemory2.triggerArrayData
        danvine.stHitArrayData = danvineMemory2.stHitArrayData
        danvine.playGameSum = danvineMemory2.playGameSum
        danvine.bonusCount = danvineMemory2.bonusCount
        danvine.stCount = danvineMemory2.stCount
        danvine.hazure3CountAll = danvineMemory2.hazure3CountAll
        danvine.hazure3CountWin = danvineMemory2.hazure3CountWin
        danvine.chamLampCountWhitBlue = danvineMemory2.chamLampCountWhitBlue
        danvine.chamLampCountYellow = danvineMemory2.chamLampCountYellow
        danvine.chamLampCountGreen = danvineMemory2.chamLampCountGreen
        danvine.chamLampCountRed = danvineMemory2.chamLampCountRed
        danvine.auraAttackCountNone = danvineMemory2.auraAttackCountNone
        danvine.auraAttackCountWin = danvineMemory2.auraAttackCountWin
        danvine.auraAttackCountSum = danvineMemory2.auraAttackCountSum
        danvine.voiceCountDefault = danvineMemory2.voiceCountDefault
        danvine.voiceCountHighJaku = danvineMemory2.voiceCountHighJaku
        danvine.voiceCountHighChu = danvineMemory2.voiceCountHighChu
        danvine.voiceCountHighKyo = danvineMemory2.voiceCountHighKyo
        danvine.voiceCountOver4 = danvineMemory2.voiceCountOver4
        danvine.voiceCountOver6 = danvineMemory2.voiceCountOver6
        danvine.voiceCountComeBack = danvineMemory2.voiceCountComeBack
        danvine.voiceCountSum = danvineMemory2.voiceCountSum
        danvine.ptCountNot11 = danvineMemory2.ptCountNot11
        danvine.ptCount11 = danvineMemory2.ptCount11
        danvine.ptCountSum = danvineMemory2.ptCountSum
    }
    func loadMemory3() {
        danvine.gameArrayData = danvineMemory3.gameArrayData
        danvine.bonusArrayData = danvineMemory3.bonusArrayData
        danvine.triggerArrayData = danvineMemory3.triggerArrayData
        danvine.stHitArrayData = danvineMemory3.stHitArrayData
        danvine.playGameSum = danvineMemory3.playGameSum
        danvine.bonusCount = danvineMemory3.bonusCount
        danvine.stCount = danvineMemory3.stCount
        danvine.hazure3CountAll = danvineMemory3.hazure3CountAll
        danvine.hazure3CountWin = danvineMemory3.hazure3CountWin
        danvine.chamLampCountWhitBlue = danvineMemory3.chamLampCountWhitBlue
        danvine.chamLampCountYellow = danvineMemory3.chamLampCountYellow
        danvine.chamLampCountGreen = danvineMemory3.chamLampCountGreen
        danvine.chamLampCountRed = danvineMemory3.chamLampCountRed
        danvine.auraAttackCountNone = danvineMemory3.auraAttackCountNone
        danvine.auraAttackCountWin = danvineMemory3.auraAttackCountWin
        danvine.auraAttackCountSum = danvineMemory3.auraAttackCountSum
        danvine.voiceCountDefault = danvineMemory3.voiceCountDefault
        danvine.voiceCountHighJaku = danvineMemory3.voiceCountHighJaku
        danvine.voiceCountHighChu = danvineMemory3.voiceCountHighChu
        danvine.voiceCountHighKyo = danvineMemory3.voiceCountHighKyo
        danvine.voiceCountOver4 = danvineMemory3.voiceCountOver4
        danvine.voiceCountOver6 = danvineMemory3.voiceCountOver6
        danvine.voiceCountComeBack = danvineMemory3.voiceCountComeBack
        danvine.voiceCountSum = danvineMemory3.voiceCountSum
        danvine.ptCountNot11 = danvineMemory3.ptCountNot11
        danvine.ptCount11 = danvineMemory3.ptCount11
        danvine.ptCountSum = danvineMemory3.ptCountSum
    }
}


#Preview {
    danvineViewTop()
}
