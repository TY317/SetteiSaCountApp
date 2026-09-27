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
        kanokariMemory1.normalGame = kanokari.normalGame
        kanokariMemory1.firstHitCountCz = kanokari.firstHitCountCz
        kanokariMemory1.firstHitCountBonus = kanokari.firstHitCountBonus
        kanokariMemory1.screenCount1 = kanokari.screenCount1
        kanokariMemory1.screenCount2 = kanokari.screenCount2
        kanokariMemory1.screenCount3 = kanokari.screenCount3
        kanokariMemory1.screenCount4 = kanokari.screenCount4
        kanokariMemory1.screenCount5 = kanokari.screenCount5
        kanokariMemory1.screenCount6 = kanokari.screenCount6
        kanokariMemory1.screenCount7 = kanokari.screenCount7
        kanokariMemory1.screenCountSum = kanokari.screenCountSum
        kanokariMemory1.charaSenarioCount1 = kanokari.charaSenarioCount1
        kanokariMemory1.charaSenarioCount2 = kanokari.charaSenarioCount2
        kanokariMemory1.charaSenarioCount3 = kanokari.charaSenarioCount3
        kanokariMemory1.charaSenarioCount4 = kanokari.charaSenarioCount4
        kanokariMemory1.charaSenarioCount5 = kanokari.charaSenarioCount5
        kanokariMemory1.charaSenarioCount6 = kanokari.charaSenarioCount6
        kanokariMemory1.charaSenarioCount7 = kanokari.charaSenarioCount7
        kanokariMemory1.charaSenarioCount8 = kanokari.charaSenarioCount8
        kanokariMemory1.charaSenarioCountSum = kanokari.charaSenarioCountSum
        kanokariMemory1.koryakuCharaCount1 = kanokari.koryakuCharaCount1
        kanokariMemory1.koryakuCharaCount2 = kanokari.koryakuCharaCount2
        kanokariMemory1.koryakuCharaCountSum = kanokari.koryakuCharaCountSum
    }
    func saveMemory2() {
        kanokariMemory2.normalGame = kanokari.normalGame
        kanokariMemory2.firstHitCountCz = kanokari.firstHitCountCz
        kanokariMemory2.firstHitCountBonus = kanokari.firstHitCountBonus
        kanokariMemory2.screenCount1 = kanokari.screenCount1
        kanokariMemory2.screenCount2 = kanokari.screenCount2
        kanokariMemory2.screenCount3 = kanokari.screenCount3
        kanokariMemory2.screenCount4 = kanokari.screenCount4
        kanokariMemory2.screenCount5 = kanokari.screenCount5
        kanokariMemory2.screenCount6 = kanokari.screenCount6
        kanokariMemory2.screenCount7 = kanokari.screenCount7
        kanokariMemory2.screenCountSum = kanokari.screenCountSum
        kanokariMemory2.charaSenarioCount1 = kanokari.charaSenarioCount1
        kanokariMemory2.charaSenarioCount2 = kanokari.charaSenarioCount2
        kanokariMemory2.charaSenarioCount3 = kanokari.charaSenarioCount3
        kanokariMemory2.charaSenarioCount4 = kanokari.charaSenarioCount4
        kanokariMemory2.charaSenarioCount5 = kanokari.charaSenarioCount5
        kanokariMemory2.charaSenarioCount6 = kanokari.charaSenarioCount6
        kanokariMemory2.charaSenarioCount7 = kanokari.charaSenarioCount7
        kanokariMemory2.charaSenarioCount8 = kanokari.charaSenarioCount8
        kanokariMemory2.charaSenarioCountSum = kanokari.charaSenarioCountSum
        kanokariMemory2.koryakuCharaCount1 = kanokari.koryakuCharaCount1
        kanokariMemory2.koryakuCharaCount2 = kanokari.koryakuCharaCount2
        kanokariMemory2.koryakuCharaCountSum = kanokari.koryakuCharaCountSum
    }
    func saveMemory3() {
        kanokariMemory3.normalGame = kanokari.normalGame
        kanokariMemory3.firstHitCountCz = kanokari.firstHitCountCz
        kanokariMemory3.firstHitCountBonus = kanokari.firstHitCountBonus
        kanokariMemory3.screenCount1 = kanokari.screenCount1
        kanokariMemory3.screenCount2 = kanokari.screenCount2
        kanokariMemory3.screenCount3 = kanokari.screenCount3
        kanokariMemory3.screenCount4 = kanokari.screenCount4
        kanokariMemory3.screenCount5 = kanokari.screenCount5
        kanokariMemory3.screenCount6 = kanokari.screenCount6
        kanokariMemory3.screenCount7 = kanokari.screenCount7
        kanokariMemory3.screenCountSum = kanokari.screenCountSum
        kanokariMemory3.charaSenarioCount1 = kanokari.charaSenarioCount1
        kanokariMemory3.charaSenarioCount2 = kanokari.charaSenarioCount2
        kanokariMemory3.charaSenarioCount3 = kanokari.charaSenarioCount3
        kanokariMemory3.charaSenarioCount4 = kanokari.charaSenarioCount4
        kanokariMemory3.charaSenarioCount5 = kanokari.charaSenarioCount5
        kanokariMemory3.charaSenarioCount6 = kanokari.charaSenarioCount6
        kanokariMemory3.charaSenarioCount7 = kanokari.charaSenarioCount7
        kanokariMemory3.charaSenarioCount8 = kanokari.charaSenarioCount8
        kanokariMemory3.charaSenarioCountSum = kanokari.charaSenarioCountSum
        kanokariMemory3.koryakuCharaCount1 = kanokari.koryakuCharaCount1
        kanokariMemory3.koryakuCharaCount2 = kanokari.koryakuCharaCount2
        kanokariMemory3.koryakuCharaCountSum = kanokari.koryakuCharaCountSum
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
        kanokari.normalGame = kanokariMemory1.normalGame
        kanokari.firstHitCountCz = kanokariMemory1.firstHitCountCz
        kanokari.firstHitCountBonus = kanokariMemory1.firstHitCountBonus
        kanokari.screenCount1 = kanokariMemory1.screenCount1
        kanokari.screenCount2 = kanokariMemory1.screenCount2
        kanokari.screenCount3 = kanokariMemory1.screenCount3
        kanokari.screenCount4 = kanokariMemory1.screenCount4
        kanokari.screenCount5 = kanokariMemory1.screenCount5
        kanokari.screenCount6 = kanokariMemory1.screenCount6
        kanokari.screenCount7 = kanokariMemory1.screenCount7
        kanokari.screenCountSum = kanokariMemory1.screenCountSum
        kanokari.charaSenarioCount1 = kanokariMemory1.charaSenarioCount1
        kanokari.charaSenarioCount2 = kanokariMemory1.charaSenarioCount2
        kanokari.charaSenarioCount3 = kanokariMemory1.charaSenarioCount3
        kanokari.charaSenarioCount4 = kanokariMemory1.charaSenarioCount4
        kanokari.charaSenarioCount5 = kanokariMemory1.charaSenarioCount5
        kanokari.charaSenarioCount6 = kanokariMemory1.charaSenarioCount6
        kanokari.charaSenarioCount7 = kanokariMemory1.charaSenarioCount7
        kanokari.charaSenarioCount8 = kanokariMemory1.charaSenarioCount8
        kanokari.charaSenarioCountSum = kanokariMemory1.charaSenarioCountSum
        kanokari.koryakuCharaCount1 = kanokariMemory1.koryakuCharaCount1
        kanokari.koryakuCharaCount2 = kanokariMemory1.koryakuCharaCount2
        kanokari.koryakuCharaCountSum = kanokariMemory1.koryakuCharaCountSum
    }
    func loadMemory2() {
        kanokari.normalGame = kanokariMemory2.normalGame
        kanokari.firstHitCountCz = kanokariMemory2.firstHitCountCz
        kanokari.firstHitCountBonus = kanokariMemory2.firstHitCountBonus
        kanokari.screenCount1 = kanokariMemory2.screenCount1
        kanokari.screenCount2 = kanokariMemory2.screenCount2
        kanokari.screenCount3 = kanokariMemory2.screenCount3
        kanokari.screenCount4 = kanokariMemory2.screenCount4
        kanokari.screenCount5 = kanokariMemory2.screenCount5
        kanokari.screenCount6 = kanokariMemory2.screenCount6
        kanokari.screenCount7 = kanokariMemory2.screenCount7
        kanokari.screenCountSum = kanokariMemory2.screenCountSum
        kanokari.charaSenarioCount1 = kanokariMemory2.charaSenarioCount1
        kanokari.charaSenarioCount2 = kanokariMemory2.charaSenarioCount2
        kanokari.charaSenarioCount3 = kanokariMemory2.charaSenarioCount3
        kanokari.charaSenarioCount4 = kanokariMemory2.charaSenarioCount4
        kanokari.charaSenarioCount5 = kanokariMemory2.charaSenarioCount5
        kanokari.charaSenarioCount6 = kanokariMemory2.charaSenarioCount6
        kanokari.charaSenarioCount7 = kanokariMemory2.charaSenarioCount7
        kanokari.charaSenarioCount8 = kanokariMemory2.charaSenarioCount8
        kanokari.charaSenarioCountSum = kanokariMemory2.charaSenarioCountSum
        kanokari.koryakuCharaCount1 = kanokariMemory2.koryakuCharaCount1
        kanokari.koryakuCharaCount2 = kanokariMemory2.koryakuCharaCount2
        kanokari.koryakuCharaCountSum = kanokariMemory2.koryakuCharaCountSum
    }
    func loadMemory3() {
        kanokari.normalGame = kanokariMemory3.normalGame
        kanokari.firstHitCountCz = kanokariMemory3.firstHitCountCz
        kanokari.firstHitCountBonus = kanokariMemory3.firstHitCountBonus
        kanokari.screenCount1 = kanokariMemory3.screenCount1
        kanokari.screenCount2 = kanokariMemory3.screenCount2
        kanokari.screenCount3 = kanokariMemory3.screenCount3
        kanokari.screenCount4 = kanokariMemory3.screenCount4
        kanokari.screenCount5 = kanokariMemory3.screenCount5
        kanokari.screenCount6 = kanokariMemory3.screenCount6
        kanokari.screenCount7 = kanokariMemory3.screenCount7
        kanokari.screenCountSum = kanokariMemory3.screenCountSum
        kanokari.charaSenarioCount1 = kanokariMemory3.charaSenarioCount1
        kanokari.charaSenarioCount2 = kanokariMemory3.charaSenarioCount2
        kanokari.charaSenarioCount3 = kanokariMemory3.charaSenarioCount3
        kanokari.charaSenarioCount4 = kanokariMemory3.charaSenarioCount4
        kanokari.charaSenarioCount5 = kanokariMemory3.charaSenarioCount5
        kanokari.charaSenarioCount6 = kanokariMemory3.charaSenarioCount6
        kanokari.charaSenarioCount7 = kanokariMemory3.charaSenarioCount7
        kanokari.charaSenarioCount8 = kanokariMemory3.charaSenarioCount8
        kanokari.charaSenarioCountSum = kanokariMemory3.charaSenarioCountSum
        kanokari.koryakuCharaCount1 = kanokariMemory3.koryakuCharaCount1
        kanokari.koryakuCharaCount2 = kanokariMemory3.koryakuCharaCount2
        kanokari.koryakuCharaCountSum = kanokariMemory3.koryakuCharaCountSum
    }
}

#Preview {
    kanokariViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
