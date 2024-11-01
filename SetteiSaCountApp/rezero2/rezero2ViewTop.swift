//
//  rezero2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/26.
//

import SwiftUI
import TipKit


// ///////////////////////////
// 変数
// ///////////////////////////
class Rezero2: ObservableObject {
    // //////////////////////////
    // チキチキ雪合戦
    // //////////////////////////
    @AppStorage("rezero2SnowballCountSingle") var snowballCountSingle = 0 {
        didSet {
            snowballCountSum = countSum(snowballCountSingle, snowballCountMultiple)
        }
    }
        @AppStorage("rezero2SnowballCountMultiple") var snowballCountMultiple = 0 {
            didSet {
                snowballCountSum = countSum(snowballCountSingle, snowballCountMultiple)
            }
        }
    @AppStorage("rezero2SnowballCountSum") var snowballCountSum = 0
    
    func resetSnowball() {
        snowballCountSingle = 0
        snowballCountMultiple = 0
        minusCheck = false
    }
    
    // //////////////////////////
    // 初当たり履歴
    // //////////////////////////
    // 選択肢の設定
    @Published var selectListPtZone = ["100未満", "100台", "200台", "300台", "400台", "500台", "600台", "700台", "800台", "900台", "1000台", "1100台", "1200台", "1300台", "1400台"]
    @Published var selectListTrigger = ["規定Pt", "引き戻し", "雪合戦", "直撃", "天井", "その他"]
    // 選択結果の設定
    @Published var inputGame = 0
    @Published var selectedPt = "200台"
    @Published var selectedTrigger = "規定Pt"
    // //// 配列の設定
    // ゲーム数配列
    let gameArrayKey = "rezero2GameArrayKey"
    @AppStorage("rezero2GameArrayKey") var gameArrayData: Data?
    // Ptゾーン配列
    let ptZoneArrayKey = "rezero2PtZoneArrayKey"
    @AppStorage("rezero2PtZoneArrayKey") var ptZoneArrayData: Data?
    // 当選契機配列
    let triggerArrayKey = "rezero2TriggerArrayKey"
    @AppStorage("rezero2TriggerArrayKey") var triggerArrayData: Data?
    // //// 結果集計用
    @AppStorage("rezero2AtHitCount") var atHitCount = 0
    @AppStorage("rezero2PlayGameSum") var playGameSum = 0
    @AppStorage("rezero2ComebackCount") var comebackCount = 0
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: ptZoneArrayData, key: ptZoneArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        atHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        comebackCount = arrayStringDataCount(arrayData: triggerArrayData, countString: "引き戻し")
        inputGame = 0
        selectedPt = "200台"
        selectedTrigger = "規定Pt"
    }
    
    // データ追加
    func addDataHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: ptZoneArrayData, addData: selectedPt, key: ptZoneArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedTrigger, key: triggerArrayKey)
        atHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        comebackCount = arrayStringDataCount(arrayData: triggerArrayData, countString: "引き戻し")
        inputGame = 0
        selectedPt = "200台"
        selectedTrigger = "規定Pt"
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: ptZoneArrayData, key: ptZoneArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        atHitCount = arrayIntAllDataCount(arrayData: gameArrayData)
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
        comebackCount = arrayStringDataCount(arrayData: triggerArrayData, countString: "引き戻し")
        inputGame = 0
        selectedPt = "200台"
        selectedTrigger = "規定Pt"
        minusCheck = false
    }
    
    // //////////////////////////
    // 共通
    // //////////////////////////
    @AppStorage("rezero2MinusCheck") var minusCheck: Bool = false
    @AppStorage("rezero2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetSnowball()
    }
}

struct rezero2ViewTop: View {
    @ObservedObject var rezero2 = Rezero2()
    @State var isShowAlert: Bool = false
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 菜月家の時計での示唆
                    NavigationLink(destination: rezero2ViewWatch()) {
                        unitLabelMenu(imageSystemName: "watch.analog", textBody: "菜月家ステージでの時計演出")
                    }
                    // チキチキ雪合戦
                    NavigationLink(destination: rezero2ViewSnowball()) {
                        unitLabelMenu(imageSystemName: "snowflake", textBody: "チキチキ雪合戦")
                    }
                    // 初当たり履歴
                    NavigationLink(destination: rezero2ViewHistory()) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "AT初当たり履歴")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "Re:ゼロ season2")
                }
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    
                    // データ保存
                    
                }
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: rezero2.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

#Preview {
    rezero2ViewTop()
}
