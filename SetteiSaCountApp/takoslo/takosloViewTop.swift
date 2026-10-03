//
//  takosloViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct takosloViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var takoslo = Takoslo()
    @State var isShowAlert: Bool = false
    @StateObject var takosloMemory1 = TakosloMemory1()
    @StateObject var takosloMemory2 = TakosloMemory2()
    @StateObject var takosloMemory3 = TakosloMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ユニメモの利用を前提としています\n遊技前にユニメモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: takoslo.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: takosloViewNormal(
                        takoslo: takoslo,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.takosloMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: takosloViewFirstHit(
                        takoslo: takoslo,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.takosloMenuFirstHitBadge,
                        )
                    }

                    // BT中
                    NavigationLink(destination: takosloViewDuringBt(
                        takoslo: takoslo,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "b.circle.fill",
                            textBody: "BT中",
                            badgeStatus: common.takosloMenuDuringBtBadge,
                        )
                    }

                    // BIG終了画面
                    NavigationLink(destination: takosloViewScreen(
                        takoslo: takoslo,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "BIG終了画面",
                            badgeStatus: common.takosloMenuScreenBadge,
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: takoslo.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: takosloView95Ci(
                    takoslo: takoslo,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: takosloViewBayes(
                    takoslo: takoslo,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.takosloMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5049")

                // コピーライト
                unitSectionCopyright {
                    Text("©UNIVERSAL ENTERTAINMENT")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5049")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: takoslo.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(takosloSubViewLoadMemory(
                    takoslo: takoslo,
                    takosloMemory1: takosloMemory1,
                    takosloMemory2: takosloMemory2,
                    takosloMemory3: takosloMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(takosloSubViewSaveMemory(
                    takoslo: takoslo,
                    takosloMemory1: takosloMemory1,
                    takosloMemory2: takosloMemory2,
                    takosloMemory3: takosloMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: takoslo.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct takosloSubViewSaveMemory: View {
    @ObservedObject var takoslo: Takoslo
    @ObservedObject var takosloMemory1: TakosloMemory1
    @ObservedObject var takosloMemory2: TakosloMemory2
    @ObservedObject var takosloMemory3: TakosloMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: takoslo.machineName,
            selectedMemory: $takoslo.selectedMemory,
            memoMemory1: $takosloMemory1.memo,
            dateDoubleMemory1: $takosloMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $takosloMemory2.memo,
            dateDoubleMemory2: $takosloMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $takosloMemory3.memo,
            dateDoubleMemory3: $takosloMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        takosloMemory1.koyakuCountPlum = takoslo.koyakuCountPlum
        takosloMemory1.koyakuCountSuika = takoslo.koyakuCountSuika
        takosloMemory1.koyakuCountCherry = takoslo.koyakuCountCherry
        takosloMemory1.koyakuDetailCountSuikaA = takoslo.koyakuDetailCountSuikaA
        takosloMemory1.koyakuDetailCountSuikaB = takoslo.koyakuDetailCountSuikaB
        takosloMemory1.koyakuDetailCountCherryB = takoslo.koyakuDetailCountCherryB
        takosloMemory1.koyakuDetailCountCherryC = takoslo.koyakuDetailCountCherryC
        takosloMemory1.gameNumberStart = takoslo.gameNumberStart
        takosloMemory1.gameNumberCurrent = takoslo.gameNumberCurrent
        takosloMemory1.gameNumberPlay = takoslo.gameNumberPlay
        takosloMemory1.normalGame = takoslo.normalGame
        takosloMemory1.firstHitCountBig = takoslo.firstHitCountBig
        takosloMemory1.firstHitCountReg = takoslo.firstHitCountReg
        takosloMemory1.screenCount1 = takoslo.screenCount1
        takosloMemory1.screenCount2 = takoslo.screenCount2
        takosloMemory1.screenCountSum = takoslo.screenCountSum
    }
    func saveMemory2() {
        takosloMemory2.koyakuCountPlum = takoslo.koyakuCountPlum
        takosloMemory2.koyakuCountSuika = takoslo.koyakuCountSuika
        takosloMemory2.koyakuCountCherry = takoslo.koyakuCountCherry
        takosloMemory2.koyakuDetailCountSuikaA = takoslo.koyakuDetailCountSuikaA
        takosloMemory2.koyakuDetailCountSuikaB = takoslo.koyakuDetailCountSuikaB
        takosloMemory2.koyakuDetailCountCherryB = takoslo.koyakuDetailCountCherryB
        takosloMemory2.koyakuDetailCountCherryC = takoslo.koyakuDetailCountCherryC
        takosloMemory2.gameNumberStart = takoslo.gameNumberStart
        takosloMemory2.gameNumberCurrent = takoslo.gameNumberCurrent
        takosloMemory2.gameNumberPlay = takoslo.gameNumberPlay
        takosloMemory2.normalGame = takoslo.normalGame
        takosloMemory2.firstHitCountBig = takoslo.firstHitCountBig
        takosloMemory2.firstHitCountReg = takoslo.firstHitCountReg
        takosloMemory2.screenCount1 = takoslo.screenCount1
        takosloMemory2.screenCount2 = takoslo.screenCount2
        takosloMemory2.screenCountSum = takoslo.screenCountSum
    }
    func saveMemory3() {
        takosloMemory3.koyakuCountPlum = takoslo.koyakuCountPlum
        takosloMemory3.koyakuCountSuika = takoslo.koyakuCountSuika
        takosloMemory3.koyakuCountCherry = takoslo.koyakuCountCherry
        takosloMemory3.koyakuDetailCountSuikaA = takoslo.koyakuDetailCountSuikaA
        takosloMemory3.koyakuDetailCountSuikaB = takoslo.koyakuDetailCountSuikaB
        takosloMemory3.koyakuDetailCountCherryB = takoslo.koyakuDetailCountCherryB
        takosloMemory3.koyakuDetailCountCherryC = takoslo.koyakuDetailCountCherryC
        takosloMemory3.gameNumberStart = takoslo.gameNumberStart
        takosloMemory3.gameNumberCurrent = takoslo.gameNumberCurrent
        takosloMemory3.gameNumberPlay = takoslo.gameNumberPlay
        takosloMemory3.normalGame = takoslo.normalGame
        takosloMemory3.firstHitCountBig = takoslo.firstHitCountBig
        takosloMemory3.firstHitCountReg = takoslo.firstHitCountReg
        takosloMemory3.screenCount1 = takoslo.screenCount1
        takosloMemory3.screenCount2 = takoslo.screenCount2
        takosloMemory3.screenCountSum = takoslo.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct takosloSubViewLoadMemory: View {
    @ObservedObject var takoslo: Takoslo
    @ObservedObject var takosloMemory1: TakosloMemory1
    @ObservedObject var takosloMemory2: TakosloMemory2
    @ObservedObject var takosloMemory3: TakosloMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: takoslo.machineName,
            selectedMemory: $takoslo.selectedMemory,
            memoMemory1: takosloMemory1.memo,
            dateDoubleMemory1: takosloMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: takosloMemory2.memo,
            dateDoubleMemory2: takosloMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: takosloMemory3.memo,
            dateDoubleMemory3: takosloMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        takoslo.koyakuCountPlum = takosloMemory1.koyakuCountPlum
        takoslo.koyakuCountSuika = takosloMemory1.koyakuCountSuika
        takoslo.koyakuCountCherry = takosloMemory1.koyakuCountCherry
        takoslo.koyakuDetailCountSuikaA = takosloMemory1.koyakuDetailCountSuikaA
        takoslo.koyakuDetailCountSuikaB = takosloMemory1.koyakuDetailCountSuikaB
        takoslo.koyakuDetailCountCherryB = takosloMemory1.koyakuDetailCountCherryB
        takoslo.koyakuDetailCountCherryC = takosloMemory1.koyakuDetailCountCherryC
        takoslo.gameNumberStart = takosloMemory1.gameNumberStart
        takoslo.gameNumberCurrent = takosloMemory1.gameNumberCurrent
        takoslo.gameNumberPlay = takosloMemory1.gameNumberPlay
        takoslo.normalGame = takosloMemory1.normalGame
        takoslo.firstHitCountBig = takosloMemory1.firstHitCountBig
        takoslo.firstHitCountReg = takosloMemory1.firstHitCountReg
        takoslo.screenCount1 = takosloMemory1.screenCount1
        takoslo.screenCount2 = takosloMemory1.screenCount2
        takoslo.screenCountSum = takosloMemory1.screenCountSum
    }
    func loadMemory2() {
        takoslo.koyakuCountPlum = takosloMemory2.koyakuCountPlum
        takoslo.koyakuCountSuika = takosloMemory2.koyakuCountSuika
        takoslo.koyakuCountCherry = takosloMemory2.koyakuCountCherry
        takoslo.koyakuDetailCountSuikaA = takosloMemory2.koyakuDetailCountSuikaA
        takoslo.koyakuDetailCountSuikaB = takosloMemory2.koyakuDetailCountSuikaB
        takoslo.koyakuDetailCountCherryB = takosloMemory2.koyakuDetailCountCherryB
        takoslo.koyakuDetailCountCherryC = takosloMemory2.koyakuDetailCountCherryC
        takoslo.gameNumberStart = takosloMemory2.gameNumberStart
        takoslo.gameNumberCurrent = takosloMemory2.gameNumberCurrent
        takoslo.gameNumberPlay = takosloMemory2.gameNumberPlay
        takoslo.normalGame = takosloMemory2.normalGame
        takoslo.firstHitCountBig = takosloMemory2.firstHitCountBig
        takoslo.firstHitCountReg = takosloMemory2.firstHitCountReg
        takoslo.screenCount1 = takosloMemory2.screenCount1
        takoslo.screenCount2 = takosloMemory2.screenCount2
        takoslo.screenCountSum = takosloMemory2.screenCountSum
    }
    func loadMemory3() {
        takoslo.koyakuCountPlum = takosloMemory3.koyakuCountPlum
        takoslo.koyakuCountSuika = takosloMemory3.koyakuCountSuika
        takoslo.koyakuCountCherry = takosloMemory3.koyakuCountCherry
        takoslo.koyakuDetailCountSuikaA = takosloMemory3.koyakuDetailCountSuikaA
        takoslo.koyakuDetailCountSuikaB = takosloMemory3.koyakuDetailCountSuikaB
        takoslo.koyakuDetailCountCherryB = takosloMemory3.koyakuDetailCountCherryB
        takoslo.koyakuDetailCountCherryC = takosloMemory3.koyakuDetailCountCherryC
        takoslo.gameNumberStart = takosloMemory3.gameNumberStart
        takoslo.gameNumberCurrent = takosloMemory3.gameNumberCurrent
        takoslo.gameNumberPlay = takosloMemory3.gameNumberPlay
        takoslo.normalGame = takosloMemory3.normalGame
        takoslo.firstHitCountBig = takosloMemory3.firstHitCountBig
        takoslo.firstHitCountReg = takosloMemory3.firstHitCountReg
        takoslo.screenCount1 = takosloMemory3.screenCount1
        takoslo.screenCount2 = takosloMemory3.screenCount2
        takoslo.screenCountSum = takosloMemory3.screenCountSum
    }
}

#Preview {
    takosloViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
