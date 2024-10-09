//
//  kabaneriViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/29.
//

import SwiftUI
import TipKit


// ///////////////////////
// 変数
// ///////////////////////
class Kabaneri: ObservableObject {
    // //////////////////
    // チャンス目発光率
    // //////////////////
    @AppStorage("kabaneriChanceWithoutFlushCount") var chanceWithoutFlushCount = 0 {
        didSet {
            chanceCountSum = countSum(chanceWithoutFlushCount, chanceWithFlushCount)
        }
    }
    @AppStorage("kabaneriChanceWithFlushCount") var chanceWithFlushCount = 0 {
        didSet {
            chanceCountSum = countSum(chanceWithoutFlushCount, chanceWithFlushCount)
        }
    }
    @AppStorage("kabaneriChanceCountSum") var chanceCountSum = 0
    // 共通ベル
    @AppStorage("kabaneriBellCount") var bellCount = 0
    @AppStorage("kabaneriStartGame") var startGame = 0 {
        didSet {
            let games = currentGame - startGame
            playGame = games > 0 ? games : 0
        }
    }
        @AppStorage("kabaneriCurrentGame") var currentGame = 0 {
            didSet {
                let games = currentGame - startGame
                playGame = games > 0 ? games : 0
            }
        }
    @AppStorage("kabaneriPlayGame") var playGame = 0
    
    func resetChance() {
        chanceWithoutFlushCount = 0
        chanceWithFlushCount = 0
        bellCount = 0
        startGame = 0
        currentGame = 0
        minusCheck = false
    }
    
    // ////////////////////
    // 当選履歴
    // ////////////////////
    // 選択肢の設定
    @Published var selectListBonus = ["CZ", "駿城", "エピボ", "現在"]
    @Published var selectListCzTrigger = ["-"]
    @Published var selectListCzType = ["無名", "生駒", "美馬"]
    @Published var selectListBonusTrigger = ["ゲーム数", "CZ", "天井", "その他"]
    @Published var selectListHayajiroStHit = ["ST当選", "STなし"]
    @Published var selectListEpiboStHit = ["ST当選"]
    @Published var selectListCurrentTrigger = ["-"]
    @Published var selectListCurrentRemarks = ["-"]
    // 選択結果の設定
    @Published var inputGame = 0
    @Published var selectedBonus = "CZ"
    @Published var selectedCzTrigger = "-"
    @Published var selectedCzType = "生駒"
    @Published var selectedBonusTrigger = "CZ"
    @Published var selectedHayajiroStHit = "STなし"
    @Published var selectedEpiboStHit = "ST当選"
    @Published var selectedCurrentTrigger = "-"
    @Published var selectedCurrentRemarks = "-"
    // //// 配列の設定
    // 当選ゲーム数配列
    let gameArrayKey = "kabaneriGameArrayKey"
    @AppStorage("kabaneriGameArrayKey") var gameArrayData: Data?
    // ボーナス種類配列
    let bonusArrayKey = "kabaneriBonusArrayKey"
    @AppStorage("kabaneriBonusArrayKey") var bonusArrayData: Data?
    // 当選契機配列
    let triggerArrayKey = "kabaneriTriggerArrayKey"
    @AppStorage("kabaneriTriggerArrayKey") var triggerArrayData: Data?
    // 備考配列
    let remarksArrayKey = "kabaneriRemarksArrayKey"
    @AppStorage("kabaneriRemarksArrayKey") var remarksArrayData: Data?
    // 集計結果の変数設定
    @AppStorage("kabaneriCzHitCount") var czHitCount = 0
    @AppStorage("kabaneriHistoryPlayGame") var historyPlayGame = 0
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: bonusArrayData, key: bonusArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveLast(arrayData: remarksArrayData, key: remarksArrayKey)
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        historyPlayGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: remarksArrayData, resetWord: "ST当選")
        inputGame = 0
        selectedBonus = "CZ"
        selectedCzTrigger = "-"
        selectedCzType = "生駒"
        selectedBonusTrigger = "CZ"
        selectedHayajiroStHit = "STなし"
        selectedEpiboStHit = "ST当選"
        selectedCurrentTrigger = "-"
        selectedCurrentRemarks = "-"
    }
    
    // データ追加 CZ
    func addDataHistoryCz() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedCzTrigger, key: triggerArrayKey)
        arrayStringAddData(arrayData: remarksArrayData, addData: selectedCzType, key: remarksArrayKey)
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        historyPlayGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: remarksArrayData, resetWord: "ST当選")
        inputGame = 0
        selectedBonus = "CZ"
        selectedCzTrigger = "-"
        selectedCzType = "生駒"
        selectedBonusTrigger = "CZ"
        selectedHayajiroStHit = "STなし"
        selectedEpiboStHit = "ST当選"
        selectedCurrentTrigger = "-"
        selectedCurrentRemarks = "-"
    }
    
    // データ追加 駿城
    func addDataHistoryHayajiro() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedBonusTrigger, key: triggerArrayKey)
        arrayStringAddData(arrayData: remarksArrayData, addData: selectedHayajiroStHit, key: remarksArrayKey)
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        historyPlayGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: remarksArrayData, resetWord: "ST当選")
        inputGame = 0
        selectedBonus = "CZ"
        selectedCzTrigger = "-"
        selectedCzType = "生駒"
        selectedBonusTrigger = "CZ"
        selectedHayajiroStHit = "STなし"
        selectedEpiboStHit = "ST当選"
        selectedCurrentTrigger = "-"
        selectedCurrentRemarks = "-"
    }
    
    // データ追加 エピボ
    func addDataHistoryEpibo() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedBonusTrigger, key: triggerArrayKey)
        arrayStringAddData(arrayData: remarksArrayData, addData: selectedEpiboStHit, key: remarksArrayKey)
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        historyPlayGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: remarksArrayData, resetWord: "ST当選")
        inputGame = 0
        selectedBonus = "CZ"
        selectedCzTrigger = "-"
        selectedCzType = "生駒"
        selectedBonusTrigger = "CZ"
        selectedHayajiroStHit = "STなし"
        selectedEpiboStHit = "ST当選"
        selectedCurrentTrigger = "-"
        selectedCurrentRemarks = "-"
    }
    
    // データ追加 現在
    func addDataHistoryCurrent() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedCurrentTrigger, key: triggerArrayKey)
        arrayStringAddData(arrayData: remarksArrayData, addData: selectedCurrentRemarks, key: remarksArrayKey)
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        historyPlayGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: remarksArrayData, resetWord: "ST当選")
        inputGame = 0
        selectedBonus = "CZ"
        selectedCzTrigger = "-"
        selectedCzType = "生駒"
        selectedBonusTrigger = "CZ"
        selectedHayajiroStHit = "STなし"
        selectedEpiboStHit = "ST当選"
        selectedCurrentTrigger = "-"
        selectedCurrentRemarks = "-"
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: bonusArrayData, key: bonusArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveAll(arrayData: remarksArrayData, key: remarksArrayKey)
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        historyPlayGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: remarksArrayData, resetWord: "ST当選")
        inputGame = 0
        selectedBonus = "CZ"
        selectedCzTrigger = "-"
        selectedCzType = "生駒"
        selectedBonusTrigger = "CZ"
        selectedHayajiroStHit = "STなし"
        selectedEpiboStHit = "ST当選"
        selectedCurrentTrigger = "-"
        selectedCurrentRemarks = "-"
    }
    
    // ////////////////////
    // 規定ゲーム数での当選
    // ////////////////////
    // ピッカー用
//    @Published var bonusGameSelected = ""
//    @Published var bonusGameSelectList = ["100G", "250G", "450G", "650G"]
    // 100G
    @AppStorage("kabaneriBonus100LoseCount") var bonus100LoseCount = 0 {
        didSet {
            bonus100CountSum = countSum(bonus100LoseCount + bonus100WinCount)
        }
    }
        @AppStorage("kabaneriBonus100WinCount") var bonus100WinCount = 0 {
            didSet {
                bonus100CountSum = countSum(bonus100LoseCount + bonus100WinCount)
            }
        }
    @AppStorage("kabaneriBonus100CountSum") var bonus100CountSum = 0
    // 250G
    @AppStorage("kabaneriBonus250LoseCount") var bonus250LoseCount = 0 {
        didSet {
            bonus250CountSum = countSum(bonus250LoseCount + bonus250WinCount)
        }
    }
        @AppStorage("kabaneriBonus250WinCount") var bonus250WinCount = 0 {
            didSet {
                bonus250CountSum = countSum(bonus250LoseCount + bonus250WinCount)
            }
        }
    @AppStorage("kabaneriBonus250CountSum") var bonus250CountSum = 0
    // 450G
    @AppStorage("kabaneriBonus450LoseCount") var bonus450LoseCount = 0 {
        didSet {
            bonus450CountSum = countSum(bonus450LoseCount + bonus450WinCount)
        }
    }
        @AppStorage("kabaneriBonus450WinCount") var bonus450WinCount = 0 {
            didSet {
                bonus450CountSum = countSum(bonus450LoseCount + bonus450WinCount)
            }
        }
    @AppStorage("kabaneriBonus450CountSum") var bonus450CountSum = 0
    // 650G
    @AppStorage("kabaneriBonus650LoseCount") var bonus650LoseCount = 0 {
        didSet {
            bonus650CountSum = countSum(bonus650LoseCount + bonus650WinCount)
        }
    }
        @AppStorage("kabaneriBonus650WinCount") var bonus650WinCount = 0 {
            didSet {
                bonus650CountSum = countSum(bonus650LoseCount + bonus650WinCount)
            }
        }
    @AppStorage("kabaneriBonus650CountSum") var bonus650CountSum = 0
    
    func resetBonus() {
        bonus100LoseCount = 0
        bonus100WinCount = 0
        bonus250LoseCount = 0
        bonus250WinCount = 0
        bonus450LoseCount = 0
        bonus450WinCount = 0
        bonus650LoseCount = 0
        bonus650WinCount = 0
        minusCheck = false
        resetHistory()
    }
    
    // /////////////////
    // 無名CZ
    // /////////////////
    @AppStorage("kabaneriMumeiNaviNoneCount") var mumeiNaviNoneCount = 0 {
        didSet {
            mumeiNaviCountSum = countSum(mumeiNaviNoneCount, mumeiNaviCount)
        }
    }
        @AppStorage("kabaneriMumeiNaviCount") var mumeiNaviCount = 0 {
            didSet {
                mumeiNaviCountSum = countSum(mumeiNaviNoneCount, mumeiNaviCount)
            }
        }
    @AppStorage("kabaneriMumeiNaviCountSum") var mumeiNaviCountSum = 0
    // ３連撃
    @AppStorage("kabaneriMumei3renLoseCount") var mumei3renLoseCount = 0 {
        didSet {
            mumei3renCountSum = countSum(mumei3renLoseCount, mumei3renWinCount)
        }
    }
        @AppStorage("kabaneriMumei3renWinCount") var mumei3renWinCount = 0 {
            didSet {
                mumei3renCountSum = countSum(mumei3renLoseCount, mumei3renWinCount)
            }
        }
    @AppStorage("kabaneriMumei3renCountSum") var mumei3renCountSum = 0
    
    func resetMumei() {
        mumeiNaviNoneCount = 0
        mumeiNaviCount = 0
        mumei3renLoseCount = 0
        mumei3renWinCount = 0
    }
    
    // /////////////////
    // 生駒CZ
    // /////////////////
    // ライフ３
    @AppStorage("kabaneriIcomaLife3DamageCount") var icomaLife3DamageCount = 0 {
        didSet {
            icomaLife3CountSum = countSum(icomaLife3DamageCount, icomaLife3NoDamageCount)
        }
    }
        @AppStorage("kabaneriIcomaLife3NoDamageCount") var icomaLife3NoDamageCount = 0 {
            didSet {
                icomaLife3CountSum = countSum(icomaLife3DamageCount, icomaLife3NoDamageCount)
            }
        }
    @AppStorage("kabaneriIcomaLife3CountSum") var icomaLife3CountSum = 0
    // ライフ２
    @AppStorage("kabaneriIcomaLife2DamageCount") var icomaLife2DamageCount = 0 {
        didSet {
            icomaLife2CountSum = countSum(icomaLife2DamageCount, icomaLife2NoDamageCount)
        }
    }
        @AppStorage("kabaneriIcomaLife2NoDamageCount") var icomaLife2NoDamageCount = 0 {
            didSet {
                icomaLife2CountSum = countSum(icomaLife2DamageCount, icomaLife2NoDamageCount)
            }
        }
    @AppStorage("kabaneriIcomaLife2CountSum") var icomaLife2CountSum = 0
    // ライフ1
    @AppStorage("kabaneriIcomaLife1DamageCount") var icomaLife1DamageCount = 0 {
        didSet {
            icomaLife1CountSum = countSum(icomaLife1DamageCount, icomaLife1NoDamageCount)
        }
    }
        @AppStorage("kabaneriIcomaLife1NoDamageCount") var icomaLife1NoDamageCount = 0 {
            didSet {
                icomaLife1CountSum = countSum(icomaLife1DamageCount, icomaLife1NoDamageCount)
            }
        }
    @AppStorage("kabaneriIcomaLife1CountSum") var icomaLife1CountSum = 0
    
    func resetIcoma() {
        icomaLife3DamageCount = 0
        icomaLife3NoDamageCount = 0
        icomaLife2DamageCount = 0
        icomaLife2NoDamageCount = 0
        icomaLife1DamageCount = 0
        icomaLife1NoDamageCount = 0
        minusCheck = false
    }
    
    // //////////////////////
    // カバネリボーナス中の示唆
    // //////////////////////
    @AppStorage("kabaneriSexMaleCount") var sexMaleCount = 0 {
        didSet {
            sexCountSum = countSum(sexMaleCount, sexFemaleCount)
        }
    }
        @AppStorage("kabaneriSexFemaleCount") var sexFemaleCount = 0 {
            didSet {
                sexCountSum = countSum(sexMaleCount, sexFemaleCount)
            }
        }
    @AppStorage("kabaneriSexCountSum") var sexCountSum = 0
    
    
    func resetHintDuringBonus() {
        sexMaleCount = 0
        sexFemaleCount = 0
        minusCheck = false
    }
    
    // /////////////////
    // 共通
    // /////////////////
    @AppStorage("kabaneriMinusCheck") var minusCheck = false
    
    func resetAll() {
        resetChance()
        resetBonus()
        resetMumei()
        resetIcoma()
        resetHintDuringBonus()
        minusCheck = false
    }
    
}

struct kabaneriViewTop: View {
    @ObservedObject var kabaneri = Kabaneri()
    @State var isShowAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // チャンス目発光率
                    NavigationLink(destination: kabaneriViewChance()) {
                        unitLabelMenu(imageSystemName: "sun.min", textBody: "通常時子役")
//                        Image(systemName: "sun.min")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("通常時小役")
                    }
                    // CZ、ボーナス初当たり
                    NavigationLink(destination: kabaneriViewCzBonus()) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "CZ,ボーナス初当り履歴")
//                        Image(systemName: "scope")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("CZ,ボーナス初当たり")
                    }
                    // 無名CZ
                    NavigationLink(destination: kabaneriMumei()) {
                        unitLabelMenu(imageSystemName: "figure.kickboxing", textBody: "無名CZ")
//                        Image(systemName: "figure.kickboxing")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("無名CZ")
                    }
                    // 生駒CZ
                    NavigationLink(destination: kabaneriViewIkoma()) {
                        unitLabelMenu(imageSystemName: "circle.grid.2x1.left.filled", textBody: "生駒CZ")
//                        Image(systemName: "circle.grid.2x1.left.filled")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("生駒CZ")
                    }
                    // カバネリボーナス中の示唆
                    NavigationLink(destination: kabaneriViewHintDuringBonus()) {
                        unitLabelMenu(imageSystemName: "figure.dress.line.vertical.figure", textBody: "カバネリボーナス中の示唆")
//                        Image(systemName: "figure.dress.line.vertical.figure")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("カバネリボーナス中の示唆")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "甲鉄城のカバネリ")
                }
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButtonReset(isShowAlert: $isShowAlert, action: kabaneri.resetAll, message: "この機種のデータを全てリセットします")
            }
        }
    }
}

#Preview {
    kabaneriViewTop()
}
