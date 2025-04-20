//
//  yoshimuneViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/16.
//

import SwiftUI

struct yoshimuneViewTop: View {
    @ObservedObject var ver280: Ver280
//    @StateObject var ver280 = Ver280()
    @StateObject var yoshimune = Yoshimune()
//    @State var yoshimune = Yoshimune()
//    @State private var reloadID = UUID() // <- これが再生成トリガー
//    @EnvironmentObject var yoshimune: Yoshimune
    @State var isShowAlert: Bool = false
    @StateObject var yoshimuneMemory1 = YoshimuneMemory1()
    @StateObject var yoshimuneMemory2 = YoshimuneMemory2()
    @StateObject var yoshimuneMemory3 = YoshimuneMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: yoshimuneViewNormal()) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // 初当り履歴
//                    NavigationLink(destination: yoshimuneViewHistory(yoshimune: yoshimune)) {
                    NavigationLink(destination: yoshimuneViewHistory()) {
                        unitLabelMenu(
                            imageSystemName: "pencil.and.list.clipboard",
                            textBody: "ボーナス初当り履歴"
                        )
                    }
                    // ボーナス終了画面
                    NavigationLink(destination: yoshimuneViewScreen(yoshimune: yoshimune)) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "吉宗")
                }
                
                // 設定推測グラフ
                NavigationLink(destination: yoshimuneView95Ci(yoshimune: yoshimune)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4778")
                    .popoverTip(tipVer220AddLink())
            }
        }
//        .id(reloadID) // <- これで NavigationStack 全体を再読み込みできる
        .onAppear {
            if ver280.yoshimuneMachineIconBadgeStatus != "none" {
                ver280.yoshimuneMachineIconBadgeStatus = "none"
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                HStack {
                    // データ読み出し
                    unitButtonLoadMemory(loadView: AnyView(yoshimuneSubViewLoadMemory(
                        yoshimune: yoshimune,
                        yoshimuneMemory1: yoshimuneMemory1,
                        yoshimuneMemory2: yoshimuneMemory2,
                        yoshimuneMemory3: yoshimuneMemory3
                    )))
                    // データ保存
                    unitButtonSaveMemory(saveView: AnyView(yoshimuneSubViewSaveMemory(
                        yoshimune: yoshimune,
                        yoshimuneMemory1: yoshimuneMemory1,
                        yoshimuneMemory2: yoshimuneMemory2,
                        yoshimuneMemory3: yoshimuneMemory3
                    )))
                }
                .popoverTip(tipUnitButtonMemory())
                // データリセット
                unitButtonReset(isShowAlert: $isShowAlert, action: yoshimune.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct yoshimuneSubViewSaveMemory: View {
    @ObservedObject var yoshimune: Yoshimune
    @ObservedObject var yoshimuneMemory1: YoshimuneMemory1
    @ObservedObject var yoshimuneMemory2: YoshimuneMemory2
    @ObservedObject var yoshimuneMemory3: YoshimuneMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "吉宗",
            selectedMemory: $yoshimune.selectedMemory,
            memoMemory1: $yoshimuneMemory1.memo,
            dateDoubleMemory1: $yoshimuneMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $yoshimuneMemory2.memo,
            dateDoubleMemory2: $yoshimuneMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $yoshimuneMemory3.memo,
            dateDoubleMemory3: $yoshimuneMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        yoshimuneMemory1.realGameInput = yoshimune.realGameInput
        yoshimuneMemory1.displayGameInput = yoshimune.displayGameInput
        yoshimuneMemory1.selectedBonusKind = yoshimune.selectedBonusKind
        yoshimuneMemory1.selectedTrigger = yoshimune.selectedTrigger
        yoshimuneMemory1.realGameTotal = yoshimune.realGameTotal
        yoshimuneMemory1.bonusCountBig = yoshimune.bonusCountBig
        yoshimuneMemory1.bonusCountReg = yoshimune.bonusCountReg
        yoshimuneMemory1.bonusCountSum = yoshimune.bonusCountSum
        yoshimuneMemory1.realGameArrayData = yoshimune.realGameArrayData
        yoshimuneMemory1.displayGameArrayData = yoshimune.displayGameArrayData
        yoshimuneMemory1.bonusKindArrayData = yoshimune.bonusKindArrayData
        yoshimuneMemory1.triggerArrayData = yoshimune.triggerArrayData
        yoshimuneMemory1.hanafudaCountDefault = yoshimune.hanafudaCountDefault
        yoshimuneMemory1.hanafudaCountHighJaku = yoshimune.hanafudaCountHighJaku
        yoshimuneMemory1.hanafudaCountHighKyo = yoshimune.hanafudaCountHighKyo
        yoshimuneMemory1.hanafudaCount2Over = yoshimune.hanafudaCount2Over
        yoshimuneMemory1.hanafudaCount3Over = yoshimune.hanafudaCount3Over
        yoshimuneMemory1.hanafudaCount4Over = yoshimune.hanafudaCount4Over
        yoshimuneMemory1.hanafudaCount5Over = yoshimune.hanafudaCount5Over
        yoshimuneMemory1.hanafudaCount6Over = yoshimune.hanafudaCount6Over
        yoshimuneMemory1.hanafudaCountSum = yoshimune.hanafudaCountSum
    }
    func saveMemory2() {
        yoshimuneMemory2.realGameInput = yoshimune.realGameInput
        yoshimuneMemory2.displayGameInput = yoshimune.displayGameInput
        yoshimuneMemory2.selectedBonusKind = yoshimune.selectedBonusKind
        yoshimuneMemory2.selectedTrigger = yoshimune.selectedTrigger
        yoshimuneMemory2.realGameTotal = yoshimune.realGameTotal
        yoshimuneMemory2.bonusCountBig = yoshimune.bonusCountBig
        yoshimuneMemory2.bonusCountReg = yoshimune.bonusCountReg
        yoshimuneMemory2.bonusCountSum = yoshimune.bonusCountSum
        yoshimuneMemory2.realGameArrayData = yoshimune.realGameArrayData
        yoshimuneMemory2.displayGameArrayData = yoshimune.displayGameArrayData
        yoshimuneMemory2.bonusKindArrayData = yoshimune.bonusKindArrayData
        yoshimuneMemory2.triggerArrayData = yoshimune.triggerArrayData
        yoshimuneMemory2.hanafudaCountDefault = yoshimune.hanafudaCountDefault
        yoshimuneMemory2.hanafudaCountHighJaku = yoshimune.hanafudaCountHighJaku
        yoshimuneMemory2.hanafudaCountHighKyo = yoshimune.hanafudaCountHighKyo
        yoshimuneMemory2.hanafudaCount2Over = yoshimune.hanafudaCount2Over
        yoshimuneMemory2.hanafudaCount3Over = yoshimune.hanafudaCount3Over
        yoshimuneMemory2.hanafudaCount4Over = yoshimune.hanafudaCount4Over
        yoshimuneMemory2.hanafudaCount5Over = yoshimune.hanafudaCount5Over
        yoshimuneMemory2.hanafudaCount6Over = yoshimune.hanafudaCount6Over
        yoshimuneMemory2.hanafudaCountSum = yoshimune.hanafudaCountSum
    }
    func saveMemory3() {
        yoshimuneMemory3.realGameInput = yoshimune.realGameInput
        yoshimuneMemory3.displayGameInput = yoshimune.displayGameInput
        yoshimuneMemory3.selectedBonusKind = yoshimune.selectedBonusKind
        yoshimuneMemory3.selectedTrigger = yoshimune.selectedTrigger
        yoshimuneMemory3.realGameTotal = yoshimune.realGameTotal
        yoshimuneMemory3.bonusCountBig = yoshimune.bonusCountBig
        yoshimuneMemory3.bonusCountReg = yoshimune.bonusCountReg
        yoshimuneMemory3.bonusCountSum = yoshimune.bonusCountSum
        yoshimuneMemory3.realGameArrayData = yoshimune.realGameArrayData
        yoshimuneMemory3.displayGameArrayData = yoshimune.displayGameArrayData
        yoshimuneMemory3.bonusKindArrayData = yoshimune.bonusKindArrayData
        yoshimuneMemory3.triggerArrayData = yoshimune.triggerArrayData
        yoshimuneMemory3.hanafudaCountDefault = yoshimune.hanafudaCountDefault
        yoshimuneMemory3.hanafudaCountHighJaku = yoshimune.hanafudaCountHighJaku
        yoshimuneMemory3.hanafudaCountHighKyo = yoshimune.hanafudaCountHighKyo
        yoshimuneMemory3.hanafudaCount2Over = yoshimune.hanafudaCount2Over
        yoshimuneMemory3.hanafudaCount3Over = yoshimune.hanafudaCount3Over
        yoshimuneMemory3.hanafudaCount4Over = yoshimune.hanafudaCount4Over
        yoshimuneMemory3.hanafudaCount5Over = yoshimune.hanafudaCount5Over
        yoshimuneMemory3.hanafudaCount6Over = yoshimune.hanafudaCount6Over
        yoshimuneMemory3.hanafudaCountSum = yoshimune.hanafudaCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct yoshimuneSubViewLoadMemory: View {
    @ObservedObject var yoshimune: Yoshimune
    @ObservedObject var yoshimuneMemory1: YoshimuneMemory1
    @ObservedObject var yoshimuneMemory2: YoshimuneMemory2
    @ObservedObject var yoshimuneMemory3: YoshimuneMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "吉宗",
            selectedMemory: $yoshimune.selectedMemory,
            memoMemory1: yoshimuneMemory1.memo,
            dateDoubleMemory1: yoshimuneMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: yoshimuneMemory2.memo,
            dateDoubleMemory2: yoshimuneMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: yoshimuneMemory3.memo,
            dateDoubleMemory3: yoshimuneMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        yoshimune.realGameInput = yoshimuneMemory1.realGameInput
        yoshimune.displayGameInput = yoshimuneMemory1.displayGameInput
        yoshimune.selectedBonusKind = yoshimuneMemory1.selectedBonusKind
        yoshimune.selectedTrigger = yoshimuneMemory1.selectedTrigger
        yoshimune.realGameTotal = yoshimuneMemory1.realGameTotal
        yoshimune.bonusCountBig = yoshimuneMemory1.bonusCountBig
        yoshimune.bonusCountReg = yoshimuneMemory1.bonusCountReg
        yoshimune.bonusCountSum = yoshimuneMemory1.bonusCountSum
        yoshimune.realGameArrayData = yoshimuneMemory1.realGameArrayData
        yoshimune.displayGameArrayData = yoshimuneMemory1.displayGameArrayData
        yoshimune.bonusKindArrayData = yoshimuneMemory1.bonusKindArrayData
        yoshimune.triggerArrayData = yoshimuneMemory1.triggerArrayData
        yoshimune.hanafudaCountDefault = yoshimuneMemory1.hanafudaCountDefault
        yoshimune.hanafudaCountHighJaku = yoshimuneMemory1.hanafudaCountHighJaku
        yoshimune.hanafudaCountHighKyo = yoshimuneMemory1.hanafudaCountHighKyo
        yoshimune.hanafudaCount2Over = yoshimuneMemory1.hanafudaCount2Over
        yoshimune.hanafudaCount3Over = yoshimuneMemory1.hanafudaCount3Over
        yoshimune.hanafudaCount4Over = yoshimuneMemory1.hanafudaCount4Over
        yoshimune.hanafudaCount5Over = yoshimuneMemory1.hanafudaCount5Over
        yoshimune.hanafudaCount6Over = yoshimuneMemory1.hanafudaCount6Over
        yoshimune.hanafudaCountSum = yoshimuneMemory1.hanafudaCountSum
    }
    func loadMemory2() {
        yoshimune.realGameInput = yoshimuneMemory2.realGameInput
        yoshimune.displayGameInput = yoshimuneMemory2.displayGameInput
        yoshimune.selectedBonusKind = yoshimuneMemory2.selectedBonusKind
        yoshimune.selectedTrigger = yoshimuneMemory2.selectedTrigger
        yoshimune.realGameTotal = yoshimuneMemory2.realGameTotal
        yoshimune.bonusCountBig = yoshimuneMemory2.bonusCountBig
        yoshimune.bonusCountReg = yoshimuneMemory2.bonusCountReg
        yoshimune.bonusCountSum = yoshimuneMemory2.bonusCountSum
        yoshimune.realGameArrayData = yoshimuneMemory2.realGameArrayData
        yoshimune.displayGameArrayData = yoshimuneMemory2.displayGameArrayData
        yoshimune.bonusKindArrayData = yoshimuneMemory2.bonusKindArrayData
        yoshimune.triggerArrayData = yoshimuneMemory2.triggerArrayData
        yoshimune.hanafudaCountDefault = yoshimuneMemory2.hanafudaCountDefault
        yoshimune.hanafudaCountHighJaku = yoshimuneMemory2.hanafudaCountHighJaku
        yoshimune.hanafudaCountHighKyo = yoshimuneMemory2.hanafudaCountHighKyo
        yoshimune.hanafudaCount2Over = yoshimuneMemory2.hanafudaCount2Over
        yoshimune.hanafudaCount3Over = yoshimuneMemory2.hanafudaCount3Over
        yoshimune.hanafudaCount4Over = yoshimuneMemory2.hanafudaCount4Over
        yoshimune.hanafudaCount5Over = yoshimuneMemory2.hanafudaCount5Over
        yoshimune.hanafudaCount6Over = yoshimuneMemory2.hanafudaCount6Over
        yoshimune.hanafudaCountSum = yoshimuneMemory2.hanafudaCountSum
    }
    func loadMemory3() {
        yoshimune.realGameInput = yoshimuneMemory3.realGameInput
        yoshimune.displayGameInput = yoshimuneMemory3.displayGameInput
        yoshimune.selectedBonusKind = yoshimuneMemory3.selectedBonusKind
        yoshimune.selectedTrigger = yoshimuneMemory3.selectedTrigger
        yoshimune.realGameTotal = yoshimuneMemory3.realGameTotal
        yoshimune.bonusCountBig = yoshimuneMemory3.bonusCountBig
        yoshimune.bonusCountReg = yoshimuneMemory3.bonusCountReg
        yoshimune.bonusCountSum = yoshimuneMemory3.bonusCountSum
        yoshimune.realGameArrayData = yoshimuneMemory3.realGameArrayData
        yoshimune.displayGameArrayData = yoshimuneMemory3.displayGameArrayData
        yoshimune.bonusKindArrayData = yoshimuneMemory3.bonusKindArrayData
        yoshimune.triggerArrayData = yoshimuneMemory3.triggerArrayData
        yoshimune.hanafudaCountDefault = yoshimuneMemory3.hanafudaCountDefault
        yoshimune.hanafudaCountHighJaku = yoshimuneMemory3.hanafudaCountHighJaku
        yoshimune.hanafudaCountHighKyo = yoshimuneMemory3.hanafudaCountHighKyo
        yoshimune.hanafudaCount2Over = yoshimuneMemory3.hanafudaCount2Over
        yoshimune.hanafudaCount3Over = yoshimuneMemory3.hanafudaCount3Over
        yoshimune.hanafudaCount4Over = yoshimuneMemory3.hanafudaCount4Over
        yoshimune.hanafudaCount5Over = yoshimuneMemory3.hanafudaCount5Over
        yoshimune.hanafudaCount6Over = yoshimuneMemory3.hanafudaCount6Over
        yoshimune.hanafudaCountSum = yoshimuneMemory3.hanafudaCountSum
    }
}

#Preview {
    yoshimuneViewTop(ver280: Ver280())
}
