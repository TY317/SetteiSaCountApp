//
//  hokutoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/01.
//

import SwiftUI
import TipKit


// ///////////////////
// 変数
// ///////////////////
class Hokuto: ObservableObject {
    // ///////////////////
    // 通常時子役
    // ///////////////////
    @AppStorage("hokutoNormalBellNanameCount") var normalBellNanameCount = 0 {
        didSet {
            normalBellCountSum = countSum(normalBellNanameCount, normalBellHorizontalCount)
        }
    }
    @AppStorage("hokutoNormalBellHorizontalCount") var normalBellHorizontalCount = 0 {
        didSet {
            normalBellCountSum = countSum(normalBellNanameCount, normalBellHorizontalCount)
        }
    }
    @AppStorage("hokutoNormalBellCountSum") var normalBellCountSum = 0
    @AppStorage("hokutoNormalStartGame") var normalStartGame = 0 {
        didSet {
            let games = normalCurrentGame - normalStartGame
            normalPlayGame = games > 0 ? games : 0
        }
    }
    @AppStorage("hokutoNormalCurrentGame") var normalCurrentGame = 0 {
        didSet {
            let games = normalCurrentGame - normalStartGame
            normalPlayGame = games > 0 ? games : 0
        }
    }
    @AppStorage("hokutoNormalPlayGame") var normalPlayGame = 0
    
    
    func resetNormalKoyaku() {
        normalBellNanameCount = 0
        normalBellHorizontalCount = 0
        normalStartGame = 0
        normalCurrentGame = 0
        minusCheck = false
    }
    
    
    // ////////////////////
    // バトルボーナス初当たり履歴
    // ////////////////////
    // 選択肢の設定
    @Published var selectListMode = ["天国", "通常以上", "通常", "通常以下", "地獄"]
    @Published var selectListTrigger = ["強スイカ", "弱スイカ", "中チェ", "角チェ", "チャンス目", "確定役", "天井", "即前兆", "謎"]
    // 選択結果の設定
    @Published var inputGame = 0
    @Published var selectedMode = "通常"
    @Published var selectedTrigger = "中チェ"
    // //// 配列の設定
    // ゲーム数配列
    let hokutoGameArrayKey = "hokutoGameArrayKey"
    @AppStorage("hokutoGameArrayKey") var gameArrayData: Data?
    // モード配列
    let hokutoModeArrayKey = "hokutoModeArrayKey"
    @AppStorage("hokutoModeArrayKey") var modeArrayData: Data?
    // 当選契機配列
    let hokutoTriggerArrayKey = "hokutoTriggerArrayKey"
    @AppStorage("hokutoTriggerArrayKey") var triggerArrayData: Data?
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: hokutoGameArrayKey)
        arrayStringRemoveLast(arrayData: modeArrayData, key: hokutoModeArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: hokutoTriggerArrayKey)
        bbHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        bbGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedMode = "通常"
        selectedTrigger = "中チェ"
    }
    
    // データ追加
    func addDataHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: hokutoGameArrayKey)
        arrayStringAddData(arrayData: modeArrayData, addData: selectedMode, key: hokutoModeArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedTrigger, key: hokutoTriggerArrayKey)
        bbHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        bbGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedMode = "通常"
        selectedTrigger = "中チェ"
    }
    
    // 初当たり回数の取得
    @AppStorage("hokutoBbHitCount") var bbHitCount = 0
    
    // 配列内のデータ合計ゲーム数の取得
    @AppStorage("hokutoBbGameSum") var bbGameSum = 0
    
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: hokutoGameArrayKey)
        arrayStringRemoveAll(arrayData: modeArrayData, key: hokutoModeArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: hokutoTriggerArrayKey)
        bbHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        bbGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        inputGame = 0
        selectedMode = "通常"
        selectedTrigger = "中チェ"
        minusCheck = false
    }
    
    // ////////////////////
    // バトルボーナス中のベル
    // ////////////////////
    @AppStorage("hokutoBbBellNanameCount") var bbBellNanameCount = 0 {
        didSet {
            bbBellCountSum = countSum(bbBellNanameCount, bbBellHorizontalCount)
        }
    }
    @AppStorage("hokutoBbBellHorizontalCount") var bbBellHorizontalCount = 0 {
        didSet {
            bbBellCountSum = countSum(bbBellNanameCount, bbBellHorizontalCount)
        }
    }
    @AppStorage("hokutoBbBellCountSum") var bbBellCountSum = 0
    @AppStorage("hokutoBbStartSet") var bbStartSet = 0 {
        didSet {
            let game = (bbCurrentSet - bbStartSet) * 30
            bbPlayGame = game > 0 ? game : 0
        }
    }
    @AppStorage("hokutoBbCurrentSet") var bbCurrentSet = 0 {
        didSet {
            let game = (bbCurrentSet - bbStartSet) * 30
            bbPlayGame = game > 0 ? game : 0
        }
    }
    @AppStorage("hokutoBbPlayGame") var bbPlayGame = 0
    
    func resetBbBell() {
        bbBellNanameCount = 0
        bbBellHorizontalCount = 0
        bbStartSet = 0
        bbCurrentSet = 0
        minusCheck = false
    }
    
    // ///////////////////
    // ボイス
    // ///////////////////
    @Published var selectListVoice = ["ケン、会いたかった", "おいおい、置いてかないでくれよ", "お前が思っているほど北斗神拳は無敵ではない", "退かぬ！媚びぬ！省みぬ！", "ケンシロウ、俺の名を言ってみろ！", "ふむ、この秘孔ではないらしい", "戦うのが北斗神拳伝承者としての宿命だ！", "待ち続けるのが私の宿命。そしてケンとの約束"]
    @AppStorage("hokutoSelectedVoice") var selectedVoice = "おいおい、置いてかないでくれよ"
//    @AppStorage("hokutoVoiceRinCount") var voiceRinCount = 0
//    @AppStorage("hokutoVoiceBattCount") var voiceBattCount = 0
    @AppStorage("hokutoVoiceDefaultCount") var voiceDefaultCount = 0 {
        didSet {
            voiceCountSum = countSum(voiceDefaultCount, voiceShinCount, voiceSauzaCount, voiceJagiCount, voiceAmibaCount, voiceKenCount, voiceYuriaCount)
        }
    }
        @AppStorage("hokutoVoiceShinCount") var voiceShinCount = 0 {
            didSet {
                voiceCountSum = countSum(voiceDefaultCount, voiceShinCount, voiceSauzaCount, voiceJagiCount, voiceAmibaCount, voiceKenCount, voiceYuriaCount)
            }
        }
            @AppStorage("hokutoVoiceSauzaCount") var voiceSauzaCount = 0 {
                didSet {
                    voiceCountSum = countSum(voiceDefaultCount, voiceShinCount, voiceSauzaCount, voiceJagiCount, voiceAmibaCount, voiceKenCount, voiceYuriaCount)
                }
            }
                @AppStorage("hokutoVoiceJagiCount") var voiceJagiCount = 0 {
                    didSet {
                        voiceCountSum = countSum(voiceDefaultCount, voiceShinCount, voiceSauzaCount, voiceJagiCount, voiceAmibaCount, voiceKenCount, voiceYuriaCount)
                    }
                }
                    @AppStorage("hokutoVoiceAmibaCount") var voiceAmibaCount = 0 {
                        didSet {
                            voiceCountSum = countSum(voiceDefaultCount, voiceShinCount, voiceSauzaCount, voiceJagiCount, voiceAmibaCount, voiceKenCount, voiceYuriaCount)
                        }
                    }
                        @AppStorage("hokutoVoiceKenCount") var voiceKenCount = 0 {
                            didSet {
                                voiceCountSum = countSum(voiceDefaultCount, voiceShinCount, voiceSauzaCount, voiceJagiCount, voiceAmibaCount, voiceKenCount, voiceYuriaCount)
                            }
                        }
                            @AppStorage("hokutoVoiceYuriaCount") var voiceYuriaCount = 0 {
                                didSet {
                                    voiceCountSum = countSum(voiceDefaultCount, voiceShinCount, voiceSauzaCount, voiceJagiCount, voiceAmibaCount, voiceKenCount, voiceYuriaCount)
                                }
                            }
    @AppStorage("hokutoVoiceCountSum") var voiceCountSum = 0
    
    func resetVoice() {
        voiceDefaultCount = 0
        voiceShinCount = 0
        voiceSauzaCount = 0
        voiceJagiCount = 0
        voiceAmibaCount = 0
        voiceKenCount = 0
        voiceYuriaCount = 0
        minusCheck = false
    }
    
    // ///////////////////
    // 共通
    // ///////////////////
    @AppStorage("hokutoMinusCheck") var minusCheck = false
    
    func resetAll() {
        resetNormalKoyaku()
        resetHistory()
        resetBbBell()
        resetVoice()
    }
}

struct hokutoViewTop: View {
    @ObservedObject var hokuto = Hokuto()
    @State var isShowAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時子役
                    NavigationLink(destination: hokutoViewNormalKoyaku()) {
                        unitLabelMenu(imageSystemName: "bell", textBody: "通常時小役")
//                        Image(systemName: "bell")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("通常時小役")
                    }
                    // モード示唆演出
//                    NavigationLink(destination: hokutoViewMode()) {
//                        Image(systemName: "homepod.2.fill")
//                            .foregroundColor(Color.gray)
////                            .font(.title3)
//                        Text("モード示唆演出")
//                    }
                    // バトルボーナス初当たり履歴
                    NavigationLink(destination: hokutoViewHistory()) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "バトルボーナス初当たり履歴")
//                        Image(systemName: "pencil.and.list.clipboard")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("バトルボーナス初当たり履歴")
                    }
                    // バトルボーナス中のベル
                    NavigationLink(destination: hokutoViewBbBell()) {
                        unitLabelMenu(imageSystemName: "bell.fill", textBody: "バトルボーナス中のベル")
//                        Image(systemName: "bell.fill")
//                            .foregroundColor(.gray)
//                            .font(.title2)
//                        Text("バトルボーナス中のベル")
                    }
                    // バトルボーナス後のボイス
                    NavigationLink(destination: hokutoViewVoice()) {
                        unitLabelMenu(imageSystemName: "message", textBody: "バトルボーナス後のボイス")
//                        Image(systemName: "message")
//                            .foregroundColor(.gray)
//                            .font(.title3)
//                        Text("バトルボーナス後のボイス")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "スマスロ北斗の拳")
                }
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButtonReset(isShowAlert: $isShowAlert, action: hokuto.resetAll, message: "この機種の全データをリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

#Preview {
    hokutoViewTop()
}
