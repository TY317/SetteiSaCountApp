//
//  ricoricoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ricoricoViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var ricorico = Ricorico()
    @State var isShowAlert: Bool = false
    @StateObject var ricoricoMemory1 = RicoricoMemory1()
    @StateObject var ricoricoMemory2 = RicoricoMemory2()
    @StateObject var ricoricoMemory3 = RicoricoMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("マイスロの利用を前提としています\n遊技前にマイスロを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: ricorico.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: ricoricoViewNormal(
                        ricorico: ricorico,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.ricoricoMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: ricoricoViewFirstHit(
                        ricorico: ricorico,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.ricoricoMenuFirstHitBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewSammyTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "サミートロフィー"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: ricorico.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: ricoricoView95Ci(
                    ricorico: ricorico,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: ricoricoViewBayes(
                    ricorico: ricorico,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.ricoricoMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5033")

                // コピーライト
                unitSectionCopyright {
                    Text("©Spider Lily／アニプレックス・ABCアニメーション・BS11")
                    Text("©Sammy")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5033")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ricorico.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(ricoricoSubViewLoadMemory(
                    ricorico: ricorico,
                    ricoricoMemory1: ricoricoMemory1,
                    ricoricoMemory2: ricoricoMemory2,
                    ricoricoMemory3: ricoricoMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(ricoricoSubViewSaveMemory(
                    ricorico: ricorico,
                    ricoricoMemory1: ricoricoMemory1,
                    ricoricoMemory2: ricoricoMemory2,
                    ricoricoMemory3: ricoricoMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: ricorico.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct ricoricoSubViewSaveMemory: View {
    @ObservedObject var ricorico: Ricorico
    @ObservedObject var ricoricoMemory1: RicoricoMemory1
    @ObservedObject var ricoricoMemory2: RicoricoMemory2
    @ObservedObject var ricoricoMemory3: RicoricoMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: ricorico.machineName,
            selectedMemory: $ricorico.selectedMemory,
            memoMemory1: $ricoricoMemory1.memo,
            dateDoubleMemory1: $ricoricoMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $ricoricoMemory2.memo,
            dateDoubleMemory2: $ricoricoMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $ricoricoMemory3.memo,
            dateDoubleMemory3: $ricoricoMemory3.dateDouble,
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
struct ricoricoSubViewLoadMemory: View {
    @ObservedObject var ricorico: Ricorico
    @ObservedObject var ricoricoMemory1: RicoricoMemory1
    @ObservedObject var ricoricoMemory2: RicoricoMemory2
    @ObservedObject var ricoricoMemory3: RicoricoMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: ricorico.machineName,
            selectedMemory: $ricorico.selectedMemory,
            memoMemory1: ricoricoMemory1.memo,
            dateDoubleMemory1: ricoricoMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: ricoricoMemory2.memo,
            dateDoubleMemory2: ricoricoMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: ricoricoMemory3.memo,
            dateDoubleMemory3: ricoricoMemory3.dateDouble,
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
    ricoricoViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
