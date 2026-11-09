//
//  ggoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ggoViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var ggo = Ggo()
    @State var isShowAlert: Bool = false
    @StateObject var ggoMemory1 = GgoMemory1()
    @StateObject var ggoMemory2 = GgoMemory2()
    @StateObject var ggoMemory3 = GgoMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ぱちログの利用を前提としています\n遊技前にぱちログを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: ggo.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: ggoViewNormal(
                        ggo: ggo,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.ggoMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: ggoViewFirstHit(
                        ggo: ggo,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.ggoMenuFirstHitBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewTamachanTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "玉ちゃんトロフィー"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: ggo.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: ggoView95Ci(
                    ggo: ggo,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
//                NavigationLink(destination: ggoViewBayes(
//                    ggo: ggo,
//                )) {
//                    unitLabelMenu(
//                        imageSystemName: "gauge.open.with.lines.needle.33percent",
//                        textBody: "設定期待値",
//                        badgeStatus: common.ggoMenuBayesBadge
//                    )
//                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5073")

                // コピーライト
                unitSectionCopyright {
                    Text("©2023時雨沢恵一/KADOKAWA/GGO2 Project")
                    Text("©KYORAKU")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5073")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ggo.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(ggoSubViewLoadMemory(
                    ggo: ggo,
                    ggoMemory1: ggoMemory1,
                    ggoMemory2: ggoMemory2,
                    ggoMemory3: ggoMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(ggoSubViewSaveMemory(
                    ggo: ggo,
                    ggoMemory1: ggoMemory1,
                    ggoMemory2: ggoMemory2,
                    ggoMemory3: ggoMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: ggo.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct ggoSubViewSaveMemory: View {
    @ObservedObject var ggo: Ggo
    @ObservedObject var ggoMemory1: GgoMemory1
    @ObservedObject var ggoMemory2: GgoMemory2
    @ObservedObject var ggoMemory3: GgoMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: ggo.machineName,
            selectedMemory: $ggo.selectedMemory,
            memoMemory1: $ggoMemory1.memo,
            dateDoubleMemory1: $ggoMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $ggoMemory2.memo,
            dateDoubleMemory2: $ggoMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $ggoMemory3.memo,
            dateDoubleMemory3: $ggoMemory3.dateDouble,
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
struct ggoSubViewLoadMemory: View {
    @ObservedObject var ggo: Ggo
    @ObservedObject var ggoMemory1: GgoMemory1
    @ObservedObject var ggoMemory2: GgoMemory2
    @ObservedObject var ggoMemory3: GgoMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: ggo.machineName,
            selectedMemory: $ggo.selectedMemory,
            memoMemory1: ggoMemory1.memo,
            dateDoubleMemory1: ggoMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: ggoMemory2.memo,
            dateDoubleMemory2: ggoMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: ggoMemory3.memo,
            dateDoubleMemory3: ggoMemory3.dateDouble,
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
    ggoViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
