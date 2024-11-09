//
//  bangdreamViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/06.
//

import SwiftUI
import TipKit

// ///////////////////////////
// 変数
// ///////////////////////////
class Bangdream: ObservableObject {
    // /////////////////////////
    // ST初当たり履歴
    // /////////////////////////
    // 選択肢の設定
    let selectListCycle = ["1周期", "2周期", "3周期", "4周期", "5周期", "6周期", "7周期", "8周期", "9周期", "10周期"]
    let selectListTrigger = ["周期", "直撃", "その他"]
    // 選択結果の設定
    @Published var selectedCycle: String = "1周期"
    @Published var selectedTrigger: String = "周期"
    @Published var selectedCycleNumber: Int = 1
    // //// 配列の設定
    // 周期配列
    let cycleArrayKey = "bangdreamCycleArrayKey"
    @AppStorage("bangdreamCycleArrayKey") var cycleArrayData: Data?
    // 当選契機配列
    let triggerArrayKey = "bangdreamTriggerArrayKey"
    @AppStorage("bangdreamTriggerArrayKey") var triggerArrayData: Data?
    // 消化周期数配列
    let cycleNumberArrayKey = "bangdreamCycleNumberArrayKey"
    @AppStorage("bangdreamCycleNumberArrayKey") var cycleNumberArrayData: Data?
    // //// ストーリーステージの消化数カウント用
    @AppStorage("bangdreamStoryCountSum") var storyCountSum: Int = 0
    @AppStorage("bangdreamCycleHitCountSum") var cycleHitCountSum: Int = 0
    @Published var cycleSum = 0
    @Published var chokugekiCountSum = 0
    
    // 1行削除
    func removeLastHistory() {
        arrayStringRemoveLast(arrayData: cycleArrayData, key: cycleArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayIntRemoveLast(arrayData: cycleNumberArrayData, key: cycleNumberArrayKey)
        cycleSum = arrayIntAllDataSum(arrayData: cycleNumberArrayData)
        chokugekiCountSum = arrayStringDataCount(arrayData: triggerArrayData, countString: "直撃")
        storyCountSum = (cycleSum - chokugekiCountSum) > 0 ? (cycleSum - chokugekiCountSum) : 0
        cycleHitCountSum = arrayStringDataCount(arrayData: triggerArrayData, countString: "周期")
        selectedCycle = "1周期"
        selectedTrigger = "周期"
        selectedCycleNumber = 1
    }
    
    // データ追加
    func addDataHistory() {
        arrayStringAddData(arrayData: cycleArrayData, addData: selectedCycle, key: cycleArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedTrigger, key: triggerArrayKey)
        // ストーリーステージの消化数を変数に代入
        if selectedCycle == selectListCycle[1] {
            selectedCycleNumber = 2
        } else if selectedCycle == selectListCycle[2] {
            selectedCycleNumber = 3
        } else if selectedCycle == selectListCycle[3] {
            selectedCycleNumber = 4
        } else if selectedCycle == selectListCycle[4] {
            selectedCycleNumber = 5
        } else if selectedCycle == selectListCycle[5] {
            selectedCycleNumber = 6
        } else if selectedCycle == selectListCycle[6] {
            selectedCycleNumber = 7
        } else if selectedCycle == selectListCycle[7] {
            selectedCycleNumber = 8
        } else if selectedCycle == selectListCycle[8] {
            selectedCycleNumber = 9
        } else if selectedCycle == selectListCycle[9] {
            selectedCycleNumber = 10
        } else {
            selectedCycleNumber = 1
        }
        arrayIntAddData(arrayData: cycleNumberArrayData, addData: selectedCycleNumber, key: cycleNumberArrayKey)
        cycleSum = arrayIntAllDataSum(arrayData: cycleNumberArrayData)
        chokugekiCountSum = arrayStringDataCount(arrayData: triggerArrayData, countString: "直撃")
        storyCountSum = (cycleSum - chokugekiCountSum) > 0 ? (cycleSum - chokugekiCountSum) : 0
        cycleHitCountSum = arrayStringDataCount(arrayData: triggerArrayData, countString: "周期")
        selectedCycle = "1周期"
        selectedTrigger = "周期"
        selectedCycleNumber = 1
    }
    
    func resetHistory() {
        arrayStringRemoveAll(arrayData: cycleArrayData, key: cycleArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayIntRemoveAll(arrayData: cycleNumberArrayData, key: cycleNumberArrayKey)
        storyCountSum = 0
        cycleSum = 0
        chokugekiCountSum = 0
        cycleHitCountSum = 0
        selectedCycle = "1周期"
        selectedTrigger = "周期"
        selectedCycleNumber = 1
        minusCheck = false
    }
    
    // /////////////////////////
    // ST終了画面
    // /////////////////////////
    
    func resetScreen() {
        
    }
    
    // /////////////////////////
    // ピコアタック
    // /////////////////////////
    @AppStorage("bangdreamPicoAttackCountSingleWin") var picoAttackCountSingleWin = 0 {
        didSet {
            picoAttackCountSingleSum = countSum(picoAttackCountSingleWin, picoAttackCountSingleLose)
            picoAttackCountWinSum = countSum(picoAttackCountSingleWin, picoAttackCountMultiWin)
            picoAttackCountAllSum = picoAttackCountSingleSum + picoAttackCountMultiSum
        }
    }
        @AppStorage("bangdreamPicoAttackCountSingleLose") var picoAttackCountSingleLose = 0 {
            didSet {
                picoAttackCountSingleSum = countSum(picoAttackCountSingleWin, picoAttackCountSingleLose)
                picoAttackCountLoseSum = countSum(picoAttackCountSingleLose, picoAttackCountMultiLose)
                picoAttackCountAllSum = picoAttackCountSingleSum + picoAttackCountMultiSum
            }
        }
    @AppStorage("bangdreamPicoAttackCountSingleSum") var picoAttackCountSingleSum = 0
    @AppStorage("bangdreamPicoAttackCountMultiWin") var picoAttackCountMultiWin = 0 {
        didSet {
            picoAttackCountMultiSum = countSum(picoAttackCountMultiWin, picoAttackCountMultiLose)
            picoAttackCountWinSum = countSum(picoAttackCountSingleWin, picoAttackCountMultiWin)
            picoAttackCountAllSum = picoAttackCountSingleSum + picoAttackCountMultiSum
        }
    }
        @AppStorage("bangdreamPicoAttackCountMultiLose") var picoAttackCountMultiLose = 0 {
            didSet {
                picoAttackCountMultiSum = countSum(picoAttackCountMultiWin, picoAttackCountMultiLose)
                picoAttackCountLoseSum = countSum(picoAttackCountSingleLose, picoAttackCountMultiLose)
                picoAttackCountAllSum = picoAttackCountSingleSum + picoAttackCountMultiSum
            }
        }
    @AppStorage("bangdreamPicoAttackCountMultiSum") var picoAttackCountMultiSum = 0
    @AppStorage("bangdreamPicoAttackCountWinSum") var picoAttackCountWinSum = 0
    @AppStorage("bangdreamPicoAttackCountLoseSum") var picoAttackCountLoseSum = 0
    @AppStorage("bangdreamPicoAttackCountAllSum") var picoAttackCountAllSum = 0
    
    func resetPicoAttack() {
        picoAttackCountSingleWin = 0
        picoAttackCountSingleLose = 0
        picoAttackCountMultiWin = 0
        picoAttackCountMultiLose = 0
    }
    
    // /////////////////////////
    // 共通
    // /////////////////////////
    @AppStorage("bangdreamMinusCheck") var minusCheck: Bool = false
    @AppStorage("bangdreamSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetHistory()
        resetScreen()
        resetPicoAttack()
    }
}

struct bangdreamViewTop: View {
    @ObservedObject var bangdream = Bangdream()
    @State var isshowalert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // ST初当たり履歴
                    NavigationLink(destination: bangdreamViewHistory()) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "ST初当たり履歴")
                    }
                    // ST終了画面
                    NavigationLink(destination: bangdreamViewScreen()) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "ST終了画面")
                    }
                    // ピコアタック
                    NavigationLink(destination: bangdreamViewPicoAttack()) {
                        unitLabelMenu(imageSystemName: "figure.boxing", textBody: "ピコアタック")
                    }
                    // 隠れ凪
                    NavigationLink(destination: commonViewKakureNagi()) {
                        unitLabelMenu(imageSystemName: "bubble", textBody: "隠れ凪")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "バンドリ!")
                }
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    HStack {
                        // データ読出し
                        
                        // データ保存
                        
                    }
                    // データリセット
                    unitButtonReset(isShowAlert: $isshowalert, action: bangdream.resetAll, message: "この機種のデータを全てリセットします")
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    bangdreamViewTop()
}
