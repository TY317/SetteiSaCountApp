//
//  seiyaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct seiyaViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var seiya = Seiya()
    @State var isShowAlert: Bool = false
    @StateObject var seiyaMemory1 = SeiyaMemory1()
    @StateObject var seiyaMemory2 = SeiyaMemory2()
    @StateObject var seiyaMemory3 = SeiyaMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: seiyaViewNormal(
                        seiya: seiya,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.seiyaMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: seiyaViewFirstHit(
                        seiya: seiya,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.seiyaMenuFirstHitBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewKujiluckyTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "クジラッキートロフィー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: seiya.machineName,
                        titleFont: .title,
                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: seiyaView95Ci(
                    seiya: seiya,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: seiyaViewBayes(
                    seiya: seiya,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.seiyaMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5104")

                // コピーライト
                unitSectionCopyright {
                    Text("©車田正美・東映アニメーション")
                    Text("©SANYO BUSSAN CO.,LTD.")
                    Text("©SANTHREE CO.,LTD.")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5104")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: seiya.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(seiyaSubViewLoadMemory(
                    seiya: seiya,
                    seiyaMemory1: seiyaMemory1,
                    seiyaMemory2: seiyaMemory2,
                    seiyaMemory3: seiyaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(seiyaSubViewSaveMemory(
                    seiya: seiya,
                    seiyaMemory1: seiyaMemory1,
                    seiyaMemory2: seiyaMemory2,
                    seiyaMemory3: seiyaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: seiya.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct seiyaSubViewSaveMemory: View {
    @ObservedObject var seiya: Seiya
    @ObservedObject var seiyaMemory1: SeiyaMemory1
    @ObservedObject var seiyaMemory2: SeiyaMemory2
    @ObservedObject var seiyaMemory3: SeiyaMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: seiya.machineName,
            selectedMemory: $seiya.selectedMemory,
            memoMemory1: $seiyaMemory1.memo,
            dateDoubleMemory1: $seiyaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $seiyaMemory2.memo,
            dateDoubleMemory2: $seiyaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $seiyaMemory3.memo,
            dateDoubleMemory3: $seiyaMemory3.dateDouble,
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
struct seiyaSubViewLoadMemory: View {
    @ObservedObject var seiya: Seiya
    @ObservedObject var seiyaMemory1: SeiyaMemory1
    @ObservedObject var seiyaMemory2: SeiyaMemory2
    @ObservedObject var seiyaMemory3: SeiyaMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: seiya.machineName,
            selectedMemory: $seiya.selectedMemory,
            memoMemory1: seiyaMemory1.memo,
            dateDoubleMemory1: seiyaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: seiyaMemory2.memo,
            dateDoubleMemory2: seiyaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: seiyaMemory3.memo,
            dateDoubleMemory3: seiyaMemory3.dateDouble,
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
    seiyaViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
