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
    // 共通
    // ////////////////////////
    @AppStorage("danvineMinusCheck") var minusCheck: Bool = false
    @AppStorage("danvineSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetHistory()
    }
}



struct danvineViewTop: View {
    @ObservedObject var danvine = Danvine()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 初当り履歴
                    NavigationLink(destination: danvineViewHistory()) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "ボーナス,ST初当り履歴")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "ダンバイン", titleFont: .title2)
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
