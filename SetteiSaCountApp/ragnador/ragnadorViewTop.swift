//
//  ragnadorViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ragnadorViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var ragnador = Ragnador()
    @State var isShowAlert: Bool = false
    @StateObject var ragnadorMemory1 = RagnadorMemory1()
    @StateObject var ragnadorMemory2 = RagnadorMemory2()
    @StateObject var ragnadorMemory3 = RagnadorMemory3()
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
                        machineName: ragnador.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: ragnadorViewNormal(
                        ragnador: ragnador,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.ragnadorMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: ragnadorViewFirstHit(
                        ragnador: ragnador,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.ragnadorMenuFirstHitBadge,
                        )
                    }

                    // CZ,AT終了時のボイス
                    NavigationLink(destination: ragnadorViewEndVoice(
                        ragnador: ragnador,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "message.fill",
                            textBody: "CZ,AT終了時のボイス",
                            badgeStatus: common.ragnadorMenuEndVoiceBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: ragnadorViewEnding(
                        ragnador: ragnador,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.ragnadorMenuEndingBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewUniversalPlate()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ユニバプレート"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: ragnador.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: ragnadorView95Ci(
                    ragnador: ragnador,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: ragnadorViewBayes(
                    ragnador: ragnador,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.ragnadorMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5079")

                // コピーライト
                unitSectionCopyright {
                    Text("©Grams. All rights Reserved.")
                    Text("©UNIVERSAL ENTERTAINMENT")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5079")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: ragnador.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(ragnadorSubViewLoadMemory(
                    ragnador: ragnador,
                    ragnadorMemory1: ragnadorMemory1,
                    ragnadorMemory2: ragnadorMemory2,
                    ragnadorMemory3: ragnadorMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(ragnadorSubViewSaveMemory(
                    ragnador: ragnador,
                    ragnadorMemory1: ragnadorMemory1,
                    ragnadorMemory2: ragnadorMemory2,
                    ragnadorMemory3: ragnadorMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: ragnador.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct ragnadorSubViewSaveMemory: View {
    @ObservedObject var ragnador: Ragnador
    @ObservedObject var ragnadorMemory1: RagnadorMemory1
    @ObservedObject var ragnadorMemory2: RagnadorMemory2
    @ObservedObject var ragnadorMemory3: RagnadorMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: ragnador.machineName,
            selectedMemory: $ragnador.selectedMemory,
            memoMemory1: $ragnadorMemory1.memo,
            dateDoubleMemory1: $ragnadorMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $ragnadorMemory2.memo,
            dateDoubleMemory2: $ragnadorMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $ragnadorMemory3.memo,
            dateDoubleMemory3: $ragnadorMemory3.dateDouble,
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
struct ragnadorSubViewLoadMemory: View {
    @ObservedObject var ragnador: Ragnador
    @ObservedObject var ragnadorMemory1: RagnadorMemory1
    @ObservedObject var ragnadorMemory2: RagnadorMemory2
    @ObservedObject var ragnadorMemory3: RagnadorMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: ragnador.machineName,
            selectedMemory: $ragnador.selectedMemory,
            memoMemory1: ragnadorMemory1.memo,
            dateDoubleMemory1: ragnadorMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: ragnadorMemory2.memo,
            dateDoubleMemory2: ragnadorMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: ragnadorMemory3.memo,
            dateDoubleMemory3: ragnadorMemory3.dateDouble,
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
    ragnadorViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
