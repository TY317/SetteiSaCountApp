//
//  vivyViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct vivyViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var vivy = Vivy()
    @State var isShowAlert: Bool = false
    @StateObject var vivyMemory1 = VivyMemory1()
    @StateObject var vivyMemory2 = VivyMemory2()
    @StateObject var vivyMemory3 = VivyMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ダイトモの利用を前提としています\n遊技前にダイトモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: vivy.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: vivyViewNormal(
                        vivy: vivy,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.vivyMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: vivyViewFirstHit(
                        vivy: vivy,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.vivyMenuFirstHitBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewKopandaTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "コパンダトロフィー"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: vivy.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: vivyView95Ci(
                    vivy: vivy,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: vivyViewBayes(
                    vivy: vivy,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.vivyMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5120")

                // コピーライト
                unitSectionCopyright {
                    Text("©Vivy Score／アニプレックス・WIT STUDIO")
                    Text("©DAITO GIKEN,INC.")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5120")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vivy.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(vivySubViewLoadMemory(
                    vivy: vivy,
                    vivyMemory1: vivyMemory1,
                    vivyMemory2: vivyMemory2,
                    vivyMemory3: vivyMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(vivySubViewSaveMemory(
                    vivy: vivy,
                    vivyMemory1: vivyMemory1,
                    vivyMemory2: vivyMemory2,
                    vivyMemory3: vivyMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: vivy.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct vivySubViewSaveMemory: View {
    @ObservedObject var vivy: Vivy
    @ObservedObject var vivyMemory1: VivyMemory1
    @ObservedObject var vivyMemory2: VivyMemory2
    @ObservedObject var vivyMemory3: VivyMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: vivy.machineName,
            selectedMemory: $vivy.selectedMemory,
            memoMemory1: $vivyMemory1.memo,
            dateDoubleMemory1: $vivyMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $vivyMemory2.memo,
            dateDoubleMemory2: $vivyMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $vivyMemory3.memo,
            dateDoubleMemory3: $vivyMemory3.dateDouble,
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
struct vivySubViewLoadMemory: View {
    @ObservedObject var vivy: Vivy
    @ObservedObject var vivyMemory1: VivyMemory1
    @ObservedObject var vivyMemory2: VivyMemory2
    @ObservedObject var vivyMemory3: VivyMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: vivy.machineName,
            selectedMemory: $vivy.selectedMemory,
            memoMemory1: vivyMemory1.memo,
            dateDoubleMemory1: vivyMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: vivyMemory2.memo,
            dateDoubleMemory2: vivyMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: vivyMemory3.memo,
            dateDoubleMemory3: vivyMemory3.dateDouble,
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
    vivyViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
