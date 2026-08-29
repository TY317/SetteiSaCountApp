//
//  yajikitaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct yajikitaViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var yajikita = Yajikita()
    @State var isShowAlert: Bool = false
    @StateObject var yajikitaMemory1 = YajikitaMemory1()
    @StateObject var yajikitaMemory2 = YajikitaMemory2()
    @StateObject var yajikitaMemory3 = YajikitaMemory3()
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
                        machineName: yajikita.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: yajikitaViewNormal(
                        yajikita: yajikita,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.yajikitaMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: yajikitaViewFirstHit(
                        yajikita: yajikita,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.yajikitaMenuFirstHitBadge,
                        )
                    }

                    // AT中
                    NavigationLink(destination: yajikitaViewDuringAt(
                        yajikita: yajikita,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "AT中",
                            badgeStatus: common.yajikitaMenuDuringAtBadge,
                        )
                    }

                    // 終了画面
                    NavigationLink(destination: yajikitaViewScreen(
                        yajikita: yajikita,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: common.yajikitaMenuScreenBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: yajikitaViewEnding(
                        yajikita: yajikita,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.yajikitaMenuEndingBadge,
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
//                        machineName: yajikita.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: yajikitaView95Ci(
                    yajikita: yajikita,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: yajikitaViewBayes(
                    yajikita: yajikita,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.yajikitaMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5027")

                // コピーライト
                unitSectionCopyright {
                    Text("©UNIVERSAL ENTERTAINMENT")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5027")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: yajikita.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(yajikitaSubViewLoadMemory(
                    yajikita: yajikita,
                    yajikitaMemory1: yajikitaMemory1,
                    yajikitaMemory2: yajikitaMemory2,
                    yajikitaMemory3: yajikitaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(yajikitaSubViewSaveMemory(
                    yajikita: yajikita,
                    yajikitaMemory1: yajikitaMemory1,
                    yajikitaMemory2: yajikitaMemory2,
                    yajikitaMemory3: yajikitaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: yajikita.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct yajikitaSubViewSaveMemory: View {
    @ObservedObject var yajikita: Yajikita
    @ObservedObject var yajikitaMemory1: YajikitaMemory1
    @ObservedObject var yajikitaMemory2: YajikitaMemory2
    @ObservedObject var yajikitaMemory3: YajikitaMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: yajikita.machineName,
            selectedMemory: $yajikita.selectedMemory,
            memoMemory1: $yajikitaMemory1.memo,
            dateDoubleMemory1: $yajikitaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $yajikitaMemory2.memo,
            dateDoubleMemory2: $yajikitaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $yajikitaMemory3.memo,
            dateDoubleMemory3: $yajikitaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        yajikitaMemory1.normalGame = yajikita.normalGame
        yajikitaMemory1.firstHitCountCz = yajikita.firstHitCountCz
        yajikitaMemory1.firstHitCountAt = yajikita.firstHitCountAt
        yajikitaMemory1.screenCount1 = yajikita.screenCount1
        yajikitaMemory1.screenCount2 = yajikita.screenCount2
        yajikitaMemory1.screenCount3 = yajikita.screenCount3
        yajikitaMemory1.screenCountSum = yajikita.screenCountSum
        yajikitaMemory1.endingCount1 = yajikita.endingCount1
        yajikitaMemory1.endingCount2 = yajikita.endingCount2
        yajikitaMemory1.endingCountSum = yajikita.endingCountSum
        yajikitaMemory1.onsenCountMiss = yajikita.onsenCountMiss
        yajikitaMemory1.onsenCountHit = yajikita.onsenCountHit
        yajikitaMemory1.onsenCountSum = yajikita.onsenCountSum
    }
    func saveMemory2() {
        yajikitaMemory2.normalGame = yajikita.normalGame
        yajikitaMemory2.firstHitCountCz = yajikita.firstHitCountCz
        yajikitaMemory2.firstHitCountAt = yajikita.firstHitCountAt
        yajikitaMemory2.screenCount1 = yajikita.screenCount1
        yajikitaMemory2.screenCount2 = yajikita.screenCount2
        yajikitaMemory2.screenCount3 = yajikita.screenCount3
        yajikitaMemory2.screenCountSum = yajikita.screenCountSum
        yajikitaMemory2.endingCount1 = yajikita.endingCount1
        yajikitaMemory2.endingCount2 = yajikita.endingCount2
        yajikitaMemory2.endingCountSum = yajikita.endingCountSum
        yajikitaMemory2.onsenCountMiss = yajikita.onsenCountMiss
        yajikitaMemory2.onsenCountHit = yajikita.onsenCountHit
        yajikitaMemory2.onsenCountSum = yajikita.onsenCountSum
    }
    func saveMemory3() {
        yajikitaMemory3.normalGame = yajikita.normalGame
        yajikitaMemory3.firstHitCountCz = yajikita.firstHitCountCz
        yajikitaMemory3.firstHitCountAt = yajikita.firstHitCountAt
        yajikitaMemory3.screenCount1 = yajikita.screenCount1
        yajikitaMemory3.screenCount2 = yajikita.screenCount2
        yajikitaMemory3.screenCount3 = yajikita.screenCount3
        yajikitaMemory3.screenCountSum = yajikita.screenCountSum
        yajikitaMemory3.endingCount1 = yajikita.endingCount1
        yajikitaMemory3.endingCount2 = yajikita.endingCount2
        yajikitaMemory3.endingCountSum = yajikita.endingCountSum
        yajikitaMemory3.onsenCountMiss = yajikita.onsenCountMiss
        yajikitaMemory3.onsenCountHit = yajikita.onsenCountHit
        yajikitaMemory3.onsenCountSum = yajikita.onsenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct yajikitaSubViewLoadMemory: View {
    @ObservedObject var yajikita: Yajikita
    @ObservedObject var yajikitaMemory1: YajikitaMemory1
    @ObservedObject var yajikitaMemory2: YajikitaMemory2
    @ObservedObject var yajikitaMemory3: YajikitaMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: yajikita.machineName,
            selectedMemory: $yajikita.selectedMemory,
            memoMemory1: yajikitaMemory1.memo,
            dateDoubleMemory1: yajikitaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: yajikitaMemory2.memo,
            dateDoubleMemory2: yajikitaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: yajikitaMemory3.memo,
            dateDoubleMemory3: yajikitaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        yajikita.normalGame = yajikitaMemory1.normalGame
        yajikita.firstHitCountCz = yajikitaMemory1.firstHitCountCz
        yajikita.firstHitCountAt = yajikitaMemory1.firstHitCountAt
        yajikita.screenCount1 = yajikitaMemory1.screenCount1
        yajikita.screenCount2 = yajikitaMemory1.screenCount2
        yajikita.screenCount3 = yajikitaMemory1.screenCount3
        yajikita.screenCountSum = yajikitaMemory1.screenCountSum
        yajikita.endingCount1 = yajikitaMemory1.endingCount1
        yajikita.endingCount2 = yajikitaMemory1.endingCount2
        yajikita.endingCountSum = yajikitaMemory1.endingCountSum
        yajikita.onsenCountMiss = yajikitaMemory1.onsenCountMiss
        yajikita.onsenCountHit = yajikitaMemory1.onsenCountHit
        yajikita.onsenCountSum = yajikitaMemory1.onsenCountSum
    }
    func loadMemory2() {
        yajikita.normalGame = yajikitaMemory2.normalGame
        yajikita.firstHitCountCz = yajikitaMemory2.firstHitCountCz
        yajikita.firstHitCountAt = yajikitaMemory2.firstHitCountAt
        yajikita.screenCount1 = yajikitaMemory2.screenCount1
        yajikita.screenCount2 = yajikitaMemory2.screenCount2
        yajikita.screenCount3 = yajikitaMemory2.screenCount3
        yajikita.screenCountSum = yajikitaMemory2.screenCountSum
        yajikita.endingCount1 = yajikitaMemory2.endingCount1
        yajikita.endingCount2 = yajikitaMemory2.endingCount2
        yajikita.endingCountSum = yajikitaMemory2.endingCountSum
        yajikita.onsenCountMiss = yajikitaMemory2.onsenCountMiss
        yajikita.onsenCountHit = yajikitaMemory2.onsenCountHit
        yajikita.onsenCountSum = yajikitaMemory2.onsenCountSum
    }
    func loadMemory3() {
        yajikita.normalGame = yajikitaMemory3.normalGame
        yajikita.firstHitCountCz = yajikitaMemory3.firstHitCountCz
        yajikita.firstHitCountAt = yajikitaMemory3.firstHitCountAt
        yajikita.screenCount1 = yajikitaMemory3.screenCount1
        yajikita.screenCount2 = yajikitaMemory3.screenCount2
        yajikita.screenCount3 = yajikitaMemory3.screenCount3
        yajikita.screenCountSum = yajikitaMemory3.screenCountSum
        yajikita.endingCount1 = yajikitaMemory3.endingCount1
        yajikita.endingCount2 = yajikitaMemory3.endingCount2
        yajikita.endingCountSum = yajikitaMemory3.endingCountSum
        yajikita.onsenCountMiss = yajikitaMemory3.onsenCountMiss
        yajikita.onsenCountHit = yajikitaMemory3.onsenCountHit
        yajikita.onsenCountSum = yajikitaMemory3.onsenCountSum
    }
}

#Preview {
    yajikitaViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
