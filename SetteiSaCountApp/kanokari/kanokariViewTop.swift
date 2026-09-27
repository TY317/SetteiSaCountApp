//
//  kanokariViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kanokariViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var kanokari = Kanokari()
    @State var isShowAlert: Bool = false
    @StateObject var kanokariMemory1 = KanokariMemory1()
    @StateObject var kanokariMemory2 = KanokariMemory2()
    @StateObject var kanokariMemory3 = KanokariMemory3()
    var body: some View {
        NavigationStack {
            List {

                Section {
                    // 通常時
                    NavigationLink(destination: kanokariViewNormal(
                        kanokari: kanokari,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.kanokariMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: kanokariViewFirstHit(
                        kanokari: kanokari,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.kanokariMenuFirstHitBadge,
                        )
                    }

                    // RB中
                    NavigationLink(destination: kanokariViewDuringRb(
                        kanokari: kanokari,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.2.fill",
                            textBody: "RB中",
                            badgeStatus: common.kanokariMenuDuringRbBadge,
                        )
                    }

                    // 終了画面
                    NavigationLink(destination: kanokariViewScreen(
                        kanokari: kanokari,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: common.kanokariMenuScreenBadge,
                        )
                    }

                    // 1Gレンチャンス
                    NavigationLink(destination: kanokariViewRenChance(
                        kanokari: kanokari,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "1.circle.fill",
                            textBody: "1Gレンチャンス",
                            badgeStatus: common.kanokariMenuRenChanceBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: kanokariViewEnding(
                        kanokari: kanokari,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.kanokariMenuEndingBadge,
                        )
                    }

                } header: {
                    unitLabelMachineTopTitle(
                        machineName: kanokari.machineName,
                        titleFont: .title,
                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: kanokariView95Ci(
                    kanokari: kanokari,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: kanokariViewBayes(
                    kanokari: kanokari,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.kanokariMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5065")

                // コピーライト
                unitSectionCopyright {
                    Text("©︎宮島礼吏／講談社")
                    Text("©︎宮島礼吏・講談社／「彼女、お借りします」製作委員会")
                    Text("©︎宮島礼吏・講談社／「彼女、お借りします」製作委員会2022")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5065")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kanokari.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(kanokariSubViewLoadMemory(
                    kanokari: kanokari,
                    kanokariMemory1: kanokariMemory1,
                    kanokariMemory2: kanokariMemory2,
                    kanokariMemory3: kanokariMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(kanokariSubViewSaveMemory(
                    kanokari: kanokari,
                    kanokariMemory1: kanokariMemory1,
                    kanokariMemory2: kanokariMemory2,
                    kanokariMemory3: kanokariMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: kanokari.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct kanokariSubViewSaveMemory: View {
    @ObservedObject var kanokari: Kanokari
    @ObservedObject var kanokariMemory1: KanokariMemory1
    @ObservedObject var kanokariMemory2: KanokariMemory2
    @ObservedObject var kanokariMemory3: KanokariMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: kanokari.machineName,
            selectedMemory: $kanokari.selectedMemory,
            memoMemory1: $kanokariMemory1.memo,
            dateDoubleMemory1: $kanokariMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $kanokariMemory2.memo,
            dateDoubleMemory2: $kanokariMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $kanokariMemory3.memo,
            dateDoubleMemory3: $kanokariMemory3.dateDouble,
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
struct kanokariSubViewLoadMemory: View {
    @ObservedObject var kanokari: Kanokari
    @ObservedObject var kanokariMemory1: KanokariMemory1
    @ObservedObject var kanokariMemory2: KanokariMemory2
    @ObservedObject var kanokariMemory3: KanokariMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: kanokari.machineName,
            selectedMemory: $kanokari.selectedMemory,
            memoMemory1: kanokariMemory1.memo,
            dateDoubleMemory1: kanokariMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: kanokariMemory2.memo,
            dateDoubleMemory2: kanokariMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: kanokariMemory3.memo,
            dateDoubleMemory3: kanokariMemory3.dateDouble,
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
    kanokariViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
