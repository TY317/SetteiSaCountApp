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

                    // AT中
                    NavigationLink(destination: ricoricoViewDuringAt(
                        ricorico: ricorico,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "film",
                            textBody: "AT中",
                            badgeStatus: common.ricoricoMenuDuringAtBadge,
                        )
                    }

                    // 終了画面
                    NavigationLink(destination: ricoricoViewScreen(
                        ricorico: ricorico,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: common.ricoricoMenuScreenBadge,
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
                    selection: 2,
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
        ricoricoMemory1.normalGame = ricorico.normalGame
        ricoricoMemory1.firstHitCountBattleCz = ricorico.firstHitCountBattleCz
        ricoricoMemory1.firstHitCountYoshokiCz = ricorico.firstHitCountYoshokiCz
        ricoricoMemory1.firstHitCountCz = ricorico.firstHitCountCz
        ricoricoMemory1.firstHitCountAt = ricorico.firstHitCountAt
        ricoricoMemory1.screenCount1 = ricorico.screenCount1
        ricoricoMemory1.screenCount2 = ricorico.screenCount2
        ricoricoMemory1.screenCount3 = ricorico.screenCount3
        ricoricoMemory1.screenCount4 = ricorico.screenCount4
        ricoricoMemory1.screenCount5 = ricorico.screenCount5
        ricoricoMemory1.screenCount6 = ricorico.screenCount6
        ricoricoMemory1.screenCountSum = ricorico.screenCountSum
        ricoricoMemory1.wScreenCount1 = ricorico.wScreenCount1
        ricoricoMemory1.wScreenCount2 = ricorico.wScreenCount2
        ricoricoMemory1.wScreenCount3 = ricorico.wScreenCount3
        ricoricoMemory1.wScreenCount4 = ricorico.wScreenCount4
        ricoricoMemory1.wScreenCount5 = ricorico.wScreenCount5
        ricoricoMemory1.wScreenCount6 = ricorico.wScreenCount6
        ricoricoMemory1.wScreenCountSum = ricorico.wScreenCountSum
        ricoricoMemory1.prologueCount1 = ricorico.prologueCount1
        ricoricoMemory1.prologueCount2 = ricorico.prologueCount2
        ricoricoMemory1.prologueCount3 = ricorico.prologueCount3
        ricoricoMemory1.prologueCountSum = ricorico.prologueCountSum
        ricoricoMemory1.rushEpiboCount1 = ricorico.rushEpiboCount1
        ricoricoMemory1.rushEpiboCount2 = ricorico.rushEpiboCount2
        ricoricoMemory1.rushEpiboCount3 = ricorico.rushEpiboCount3
        ricoricoMemory1.rushEpiboCountSum = ricorico.rushEpiboCountSum
        ricoricoMemory1.wRushEpiboCount1 = ricorico.wRushEpiboCount1
        ricoricoMemory1.wRushEpiboCount2 = ricorico.wRushEpiboCount2
        ricoricoMemory1.wRushEpiboCount3 = ricorico.wRushEpiboCount3
        ricoricoMemory1.wRushEpiboCountSum = ricorico.wRushEpiboCountSum
    }
    func saveMemory2() {
        ricoricoMemory2.normalGame = ricorico.normalGame
        ricoricoMemory2.firstHitCountBattleCz = ricorico.firstHitCountBattleCz
        ricoricoMemory2.firstHitCountYoshokiCz = ricorico.firstHitCountYoshokiCz
        ricoricoMemory2.firstHitCountCz = ricorico.firstHitCountCz
        ricoricoMemory2.firstHitCountAt = ricorico.firstHitCountAt
        ricoricoMemory2.screenCount1 = ricorico.screenCount1
        ricoricoMemory2.screenCount2 = ricorico.screenCount2
        ricoricoMemory2.screenCount3 = ricorico.screenCount3
        ricoricoMemory2.screenCount4 = ricorico.screenCount4
        ricoricoMemory2.screenCount5 = ricorico.screenCount5
        ricoricoMemory2.screenCount6 = ricorico.screenCount6
        ricoricoMemory2.screenCountSum = ricorico.screenCountSum
        ricoricoMemory2.wScreenCount1 = ricorico.wScreenCount1
        ricoricoMemory2.wScreenCount2 = ricorico.wScreenCount2
        ricoricoMemory2.wScreenCount3 = ricorico.wScreenCount3
        ricoricoMemory2.wScreenCount4 = ricorico.wScreenCount4
        ricoricoMemory2.wScreenCount5 = ricorico.wScreenCount5
        ricoricoMemory2.wScreenCount6 = ricorico.wScreenCount6
        ricoricoMemory2.wScreenCountSum = ricorico.wScreenCountSum
        ricoricoMemory2.prologueCount1 = ricorico.prologueCount1
        ricoricoMemory2.prologueCount2 = ricorico.prologueCount2
        ricoricoMemory2.prologueCount3 = ricorico.prologueCount3
        ricoricoMemory2.prologueCountSum = ricorico.prologueCountSum
        ricoricoMemory2.rushEpiboCount1 = ricorico.rushEpiboCount1
        ricoricoMemory2.rushEpiboCount2 = ricorico.rushEpiboCount2
        ricoricoMemory2.rushEpiboCount3 = ricorico.rushEpiboCount3
        ricoricoMemory2.rushEpiboCountSum = ricorico.rushEpiboCountSum
        ricoricoMemory2.wRushEpiboCount1 = ricorico.wRushEpiboCount1
        ricoricoMemory2.wRushEpiboCount2 = ricorico.wRushEpiboCount2
        ricoricoMemory2.wRushEpiboCount3 = ricorico.wRushEpiboCount3
        ricoricoMemory2.wRushEpiboCountSum = ricorico.wRushEpiboCountSum
    }
    func saveMemory3() {
        ricoricoMemory3.normalGame = ricorico.normalGame
        ricoricoMemory3.firstHitCountBattleCz = ricorico.firstHitCountBattleCz
        ricoricoMemory3.firstHitCountYoshokiCz = ricorico.firstHitCountYoshokiCz
        ricoricoMemory3.firstHitCountCz = ricorico.firstHitCountCz
        ricoricoMemory3.firstHitCountAt = ricorico.firstHitCountAt
        ricoricoMemory3.screenCount1 = ricorico.screenCount1
        ricoricoMemory3.screenCount2 = ricorico.screenCount2
        ricoricoMemory3.screenCount3 = ricorico.screenCount3
        ricoricoMemory3.screenCount4 = ricorico.screenCount4
        ricoricoMemory3.screenCount5 = ricorico.screenCount5
        ricoricoMemory3.screenCount6 = ricorico.screenCount6
        ricoricoMemory3.screenCountSum = ricorico.screenCountSum
        ricoricoMemory3.wScreenCount1 = ricorico.wScreenCount1
        ricoricoMemory3.wScreenCount2 = ricorico.wScreenCount2
        ricoricoMemory3.wScreenCount3 = ricorico.wScreenCount3
        ricoricoMemory3.wScreenCount4 = ricorico.wScreenCount4
        ricoricoMemory3.wScreenCount5 = ricorico.wScreenCount5
        ricoricoMemory3.wScreenCount6 = ricorico.wScreenCount6
        ricoricoMemory3.wScreenCountSum = ricorico.wScreenCountSum
        ricoricoMemory3.prologueCount1 = ricorico.prologueCount1
        ricoricoMemory3.prologueCount2 = ricorico.prologueCount2
        ricoricoMemory3.prologueCount3 = ricorico.prologueCount3
        ricoricoMemory3.prologueCountSum = ricorico.prologueCountSum
        ricoricoMemory3.rushEpiboCount1 = ricorico.rushEpiboCount1
        ricoricoMemory3.rushEpiboCount2 = ricorico.rushEpiboCount2
        ricoricoMemory3.rushEpiboCount3 = ricorico.rushEpiboCount3
        ricoricoMemory3.rushEpiboCountSum = ricorico.rushEpiboCountSum
        ricoricoMemory3.wRushEpiboCount1 = ricorico.wRushEpiboCount1
        ricoricoMemory3.wRushEpiboCount2 = ricorico.wRushEpiboCount2
        ricoricoMemory3.wRushEpiboCount3 = ricorico.wRushEpiboCount3
        ricoricoMemory3.wRushEpiboCountSum = ricorico.wRushEpiboCountSum
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
        ricorico.normalGame = ricoricoMemory1.normalGame
        ricorico.firstHitCountBattleCz = ricoricoMemory1.firstHitCountBattleCz
        ricorico.firstHitCountYoshokiCz = ricoricoMemory1.firstHitCountYoshokiCz
        ricorico.firstHitCountCz = ricoricoMemory1.firstHitCountCz
        ricorico.firstHitCountAt = ricoricoMemory1.firstHitCountAt
        ricorico.screenCount1 = ricoricoMemory1.screenCount1
        ricorico.screenCount2 = ricoricoMemory1.screenCount2
        ricorico.screenCount3 = ricoricoMemory1.screenCount3
        ricorico.screenCount4 = ricoricoMemory1.screenCount4
        ricorico.screenCount5 = ricoricoMemory1.screenCount5
        ricorico.screenCount6 = ricoricoMemory1.screenCount6
        ricorico.screenCountSum = ricoricoMemory1.screenCountSum
        ricorico.wScreenCount1 = ricoricoMemory1.wScreenCount1
        ricorico.wScreenCount2 = ricoricoMemory1.wScreenCount2
        ricorico.wScreenCount3 = ricoricoMemory1.wScreenCount3
        ricorico.wScreenCount4 = ricoricoMemory1.wScreenCount4
        ricorico.wScreenCount5 = ricoricoMemory1.wScreenCount5
        ricorico.wScreenCount6 = ricoricoMemory1.wScreenCount6
        ricorico.wScreenCountSum = ricoricoMemory1.wScreenCountSum
        ricorico.prologueCount1 = ricoricoMemory1.prologueCount1
        ricorico.prologueCount2 = ricoricoMemory1.prologueCount2
        ricorico.prologueCount3 = ricoricoMemory1.prologueCount3
        ricorico.prologueCountSum = ricoricoMemory1.prologueCountSum
        ricorico.rushEpiboCount1 = ricoricoMemory1.rushEpiboCount1
        ricorico.rushEpiboCount2 = ricoricoMemory1.rushEpiboCount2
        ricorico.rushEpiboCount3 = ricoricoMemory1.rushEpiboCount3
        ricorico.rushEpiboCountSum = ricoricoMemory1.rushEpiboCountSum
        ricorico.wRushEpiboCount1 = ricoricoMemory1.wRushEpiboCount1
        ricorico.wRushEpiboCount2 = ricoricoMemory1.wRushEpiboCount2
        ricorico.wRushEpiboCount3 = ricoricoMemory1.wRushEpiboCount3
        ricorico.wRushEpiboCountSum = ricoricoMemory1.wRushEpiboCountSum
    }
    func loadMemory2() {
        ricorico.normalGame = ricoricoMemory2.normalGame
        ricorico.firstHitCountBattleCz = ricoricoMemory2.firstHitCountBattleCz
        ricorico.firstHitCountYoshokiCz = ricoricoMemory2.firstHitCountYoshokiCz
        ricorico.firstHitCountCz = ricoricoMemory2.firstHitCountCz
        ricorico.firstHitCountAt = ricoricoMemory2.firstHitCountAt
        ricorico.screenCount1 = ricoricoMemory2.screenCount1
        ricorico.screenCount2 = ricoricoMemory2.screenCount2
        ricorico.screenCount3 = ricoricoMemory2.screenCount3
        ricorico.screenCount4 = ricoricoMemory2.screenCount4
        ricorico.screenCount5 = ricoricoMemory2.screenCount5
        ricorico.screenCount6 = ricoricoMemory2.screenCount6
        ricorico.screenCountSum = ricoricoMemory2.screenCountSum
        ricorico.wScreenCount1 = ricoricoMemory2.wScreenCount1
        ricorico.wScreenCount2 = ricoricoMemory2.wScreenCount2
        ricorico.wScreenCount3 = ricoricoMemory2.wScreenCount3
        ricorico.wScreenCount4 = ricoricoMemory2.wScreenCount4
        ricorico.wScreenCount5 = ricoricoMemory2.wScreenCount5
        ricorico.wScreenCount6 = ricoricoMemory2.wScreenCount6
        ricorico.wScreenCountSum = ricoricoMemory2.wScreenCountSum
        ricorico.prologueCount1 = ricoricoMemory2.prologueCount1
        ricorico.prologueCount2 = ricoricoMemory2.prologueCount2
        ricorico.prologueCount3 = ricoricoMemory2.prologueCount3
        ricorico.prologueCountSum = ricoricoMemory2.prologueCountSum
        ricorico.rushEpiboCount1 = ricoricoMemory2.rushEpiboCount1
        ricorico.rushEpiboCount2 = ricoricoMemory2.rushEpiboCount2
        ricorico.rushEpiboCount3 = ricoricoMemory2.rushEpiboCount3
        ricorico.rushEpiboCountSum = ricoricoMemory2.rushEpiboCountSum
        ricorico.wRushEpiboCount1 = ricoricoMemory2.wRushEpiboCount1
        ricorico.wRushEpiboCount2 = ricoricoMemory2.wRushEpiboCount2
        ricorico.wRushEpiboCount3 = ricoricoMemory2.wRushEpiboCount3
        ricorico.wRushEpiboCountSum = ricoricoMemory2.wRushEpiboCountSum
    }
    func loadMemory3() {
        ricorico.normalGame = ricoricoMemory3.normalGame
        ricorico.firstHitCountBattleCz = ricoricoMemory3.firstHitCountBattleCz
        ricorico.firstHitCountYoshokiCz = ricoricoMemory3.firstHitCountYoshokiCz
        ricorico.firstHitCountCz = ricoricoMemory3.firstHitCountCz
        ricorico.firstHitCountAt = ricoricoMemory3.firstHitCountAt
        ricorico.screenCount1 = ricoricoMemory3.screenCount1
        ricorico.screenCount2 = ricoricoMemory3.screenCount2
        ricorico.screenCount3 = ricoricoMemory3.screenCount3
        ricorico.screenCount4 = ricoricoMemory3.screenCount4
        ricorico.screenCount5 = ricoricoMemory3.screenCount5
        ricorico.screenCount6 = ricoricoMemory3.screenCount6
        ricorico.screenCountSum = ricoricoMemory3.screenCountSum
        ricorico.wScreenCount1 = ricoricoMemory3.wScreenCount1
        ricorico.wScreenCount2 = ricoricoMemory3.wScreenCount2
        ricorico.wScreenCount3 = ricoricoMemory3.wScreenCount3
        ricorico.wScreenCount4 = ricoricoMemory3.wScreenCount4
        ricorico.wScreenCount5 = ricoricoMemory3.wScreenCount5
        ricorico.wScreenCount6 = ricoricoMemory3.wScreenCount6
        ricorico.wScreenCountSum = ricoricoMemory3.wScreenCountSum
        ricorico.prologueCount1 = ricoricoMemory3.prologueCount1
        ricorico.prologueCount2 = ricoricoMemory3.prologueCount2
        ricorico.prologueCount3 = ricoricoMemory3.prologueCount3
        ricorico.prologueCountSum = ricoricoMemory3.prologueCountSum
        ricorico.rushEpiboCount1 = ricoricoMemory3.rushEpiboCount1
        ricorico.rushEpiboCount2 = ricoricoMemory3.rushEpiboCount2
        ricorico.rushEpiboCount3 = ricoricoMemory3.rushEpiboCount3
        ricorico.rushEpiboCountSum = ricoricoMemory3.rushEpiboCountSum
        ricorico.wRushEpiboCount1 = ricoricoMemory3.wRushEpiboCount1
        ricorico.wRushEpiboCount2 = ricoricoMemory3.wRushEpiboCount2
        ricorico.wRushEpiboCount3 = ricoricoMemory3.wRushEpiboCount3
        ricorico.wRushEpiboCountSum = ricoricoMemory3.wRushEpiboCountSum
    }
}

#Preview {
    ricoricoViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
