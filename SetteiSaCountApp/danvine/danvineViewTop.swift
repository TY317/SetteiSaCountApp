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
                            imageSystemName: "trophy",
                            textBody: "サミートロフィー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "ダンバイン", titleFont: .title2)
                }
                // 設定推測グラフ
                NavigationLink(destination: danvineView95Ci()) {
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
//                    unitButtonLoadMemory(loadView: AnyView(lupinSubViewLoadMemory()))
                    // データ保存
//                    unitButtonSaveMemory(saveView: AnyView(lupinSubViewSaveMemory()))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: danvine.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

#Preview {
    danvineViewTop()
}
