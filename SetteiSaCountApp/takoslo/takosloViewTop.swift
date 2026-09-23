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

    }
    func saveMemory2() {

    }
    func saveMemory3() {

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

    }
    func loadMemory2() {

    }
    func loadMemory3() {

    }
}

#Preview {
    takosloViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
