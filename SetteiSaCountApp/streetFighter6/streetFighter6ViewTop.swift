//
//  streetFighter6ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct streetFighter6ViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var streetFighter6 = StreetFighter6()
    @State var isShowAlert: Bool = false
    @StateObject var streetFighter6Memory1 = StreetFighter6Memory1()
    @StateObject var streetFighter6Memory2 = StreetFighter6Memory2()
    @StateObject var streetFighter6Memory3 = StreetFighter6Memory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: streetFighter6ViewNormal(
                        streetFighter6: streetFighter6,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.streetFighter6MenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: streetFighter6ViewFirstHit(
                        streetFighter6: streetFighter6,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.streetFighter6MenuFirstHitBadge,
                        )
                    }

                    // 終了画面
                    NavigationLink(destination: streetFighter6ViewScreen(
                        streetFighter6: streetFighter6,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: common.streetFighter6MenuScreenBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: streetFighter6ViewEnding(
                        streetFighter6: streetFighter6,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.streetFighter6MenuEndingBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewEnteriseTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "エンタトロフィー"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: streetFighter6.machineName,
                        titleFont: .title,
                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: streetFighter6View95Ci(
                    streetFighter6: streetFighter6,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: streetFighter6ViewBayes(
                    streetFighter6: streetFighter6,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.streetFighter6MenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5068")

                // コピーライト
                unitSectionCopyright {
                    Text("©CAPCOM")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5068")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: streetFighter6.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(streetFighter6SubViewLoadMemory(
                    streetFighter6: streetFighter6,
                    streetFighter6Memory1: streetFighter6Memory1,
                    streetFighter6Memory2: streetFighter6Memory2,
                    streetFighter6Memory3: streetFighter6Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(streetFighter6SubViewSaveMemory(
                    streetFighter6: streetFighter6,
                    streetFighter6Memory1: streetFighter6Memory1,
                    streetFighter6Memory2: streetFighter6Memory2,
                    streetFighter6Memory3: streetFighter6Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: streetFighter6.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct streetFighter6SubViewSaveMemory: View {
    @ObservedObject var streetFighter6: StreetFighter6
    @ObservedObject var streetFighter6Memory1: StreetFighter6Memory1
    @ObservedObject var streetFighter6Memory2: StreetFighter6Memory2
    @ObservedObject var streetFighter6Memory3: StreetFighter6Memory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: streetFighter6.machineName,
            selectedMemory: $streetFighter6.selectedMemory,
            memoMemory1: $streetFighter6Memory1.memo,
            dateDoubleMemory1: $streetFighter6Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $streetFighter6Memory2.memo,
            dateDoubleMemory2: $streetFighter6Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $streetFighter6Memory3.memo,
            dateDoubleMemory3: $streetFighter6Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        streetFighter6Memory1.normalGame = streetFighter6.normalGame
        streetFighter6Memory1.firstHitCountFb = streetFighter6.firstHitCountFb
        streetFighter6Memory1.firstHitCountBonus = streetFighter6.firstHitCountBonus
        streetFighter6Memory1.fbTenjoCount1Miss = streetFighter6.fbTenjoCount1Miss
        streetFighter6Memory1.fbTenjoCount1Hit = streetFighter6.fbTenjoCount1Hit
        streetFighter6Memory1.fbTenjoCount1Sum = streetFighter6.fbTenjoCount1Sum
        streetFighter6Memory1.fbTenjoCount2Miss = streetFighter6.fbTenjoCount2Miss
        streetFighter6Memory1.fbTenjoCount2Hit = streetFighter6.fbTenjoCount2Hit
        streetFighter6Memory1.fbTenjoCount2Sum = streetFighter6.fbTenjoCount2Sum
        streetFighter6Memory1.fbTenjoCount3Miss = streetFighter6.fbTenjoCount3Miss
        streetFighter6Memory1.fbTenjoCount3Hit = streetFighter6.fbTenjoCount3Hit
        streetFighter6Memory1.fbTenjoCount3Sum = streetFighter6.fbTenjoCount3Sum
        streetFighter6Memory1.fbTenjoCount4Miss = streetFighter6.fbTenjoCount4Miss
        streetFighter6Memory1.fbTenjoCount4Hit = streetFighter6.fbTenjoCount4Hit
        streetFighter6Memory1.fbTenjoCount4Sum = streetFighter6.fbTenjoCount4Sum
        streetFighter6Memory1.fbTenjoCountOver2 = streetFighter6.fbTenjoCountOver2
        streetFighter6Memory1.fbTenjoCountOver3 = streetFighter6.fbTenjoCountOver3
        streetFighter6Memory1.fbTenjoCountOver4 = streetFighter6.fbTenjoCountOver4
        streetFighter6Memory1.fbTenjoCountAllSum = streetFighter6.fbTenjoCountAllSum
        streetFighter6Memory1.screenCount1 = streetFighter6.screenCount1
        streetFighter6Memory1.screenCount2 = streetFighter6.screenCount2
        streetFighter6Memory1.screenCount3 = streetFighter6.screenCount3
        streetFighter6Memory1.screenCount4 = streetFighter6.screenCount4
        streetFighter6Memory1.screenCount5 = streetFighter6.screenCount5
        streetFighter6Memory1.screenCount6 = streetFighter6.screenCount6
        streetFighter6Memory1.screenCount7 = streetFighter6.screenCount7
        streetFighter6Memory1.screenCount8 = streetFighter6.screenCount8
        streetFighter6Memory1.screenCountSum = streetFighter6.screenCountSum
        streetFighter6Memory1.endingCount1 = streetFighter6.endingCount1
        streetFighter6Memory1.endingCount2 = streetFighter6.endingCount2
        streetFighter6Memory1.endingCount3 = streetFighter6.endingCount3
        streetFighter6Memory1.endingCount4 = streetFighter6.endingCount4
        streetFighter6Memory1.endingCount5 = streetFighter6.endingCount5
        streetFighter6Memory1.endingCountSum = streetFighter6.endingCountSum
    }
    func saveMemory2() {
        streetFighter6Memory2.normalGame = streetFighter6.normalGame
        streetFighter6Memory2.firstHitCountFb = streetFighter6.firstHitCountFb
        streetFighter6Memory2.firstHitCountBonus = streetFighter6.firstHitCountBonus
        streetFighter6Memory2.fbTenjoCount1Miss = streetFighter6.fbTenjoCount1Miss
        streetFighter6Memory2.fbTenjoCount1Hit = streetFighter6.fbTenjoCount1Hit
        streetFighter6Memory2.fbTenjoCount1Sum = streetFighter6.fbTenjoCount1Sum
        streetFighter6Memory2.fbTenjoCount2Miss = streetFighter6.fbTenjoCount2Miss
        streetFighter6Memory2.fbTenjoCount2Hit = streetFighter6.fbTenjoCount2Hit
        streetFighter6Memory2.fbTenjoCount2Sum = streetFighter6.fbTenjoCount2Sum
        streetFighter6Memory2.fbTenjoCount3Miss = streetFighter6.fbTenjoCount3Miss
        streetFighter6Memory2.fbTenjoCount3Hit = streetFighter6.fbTenjoCount3Hit
        streetFighter6Memory2.fbTenjoCount3Sum = streetFighter6.fbTenjoCount3Sum
        streetFighter6Memory2.fbTenjoCount4Miss = streetFighter6.fbTenjoCount4Miss
        streetFighter6Memory2.fbTenjoCount4Hit = streetFighter6.fbTenjoCount4Hit
        streetFighter6Memory2.fbTenjoCount4Sum = streetFighter6.fbTenjoCount4Sum
        streetFighter6Memory2.fbTenjoCountOver2 = streetFighter6.fbTenjoCountOver2
        streetFighter6Memory2.fbTenjoCountOver3 = streetFighter6.fbTenjoCountOver3
        streetFighter6Memory2.fbTenjoCountOver4 = streetFighter6.fbTenjoCountOver4
        streetFighter6Memory2.fbTenjoCountAllSum = streetFighter6.fbTenjoCountAllSum
        streetFighter6Memory2.screenCount1 = streetFighter6.screenCount1
        streetFighter6Memory2.screenCount2 = streetFighter6.screenCount2
        streetFighter6Memory2.screenCount3 = streetFighter6.screenCount3
        streetFighter6Memory2.screenCount4 = streetFighter6.screenCount4
        streetFighter6Memory2.screenCount5 = streetFighter6.screenCount5
        streetFighter6Memory2.screenCount6 = streetFighter6.screenCount6
        streetFighter6Memory2.screenCount7 = streetFighter6.screenCount7
        streetFighter6Memory2.screenCount8 = streetFighter6.screenCount8
        streetFighter6Memory2.screenCountSum = streetFighter6.screenCountSum
        streetFighter6Memory2.endingCount1 = streetFighter6.endingCount1
        streetFighter6Memory2.endingCount2 = streetFighter6.endingCount2
        streetFighter6Memory2.endingCount3 = streetFighter6.endingCount3
        streetFighter6Memory2.endingCount4 = streetFighter6.endingCount4
        streetFighter6Memory2.endingCount5 = streetFighter6.endingCount5
        streetFighter6Memory2.endingCountSum = streetFighter6.endingCountSum
    }
    func saveMemory3() {
        streetFighter6Memory3.normalGame = streetFighter6.normalGame
        streetFighter6Memory3.firstHitCountFb = streetFighter6.firstHitCountFb
        streetFighter6Memory3.firstHitCountBonus = streetFighter6.firstHitCountBonus
        streetFighter6Memory3.fbTenjoCount1Miss = streetFighter6.fbTenjoCount1Miss
        streetFighter6Memory3.fbTenjoCount1Hit = streetFighter6.fbTenjoCount1Hit
        streetFighter6Memory3.fbTenjoCount1Sum = streetFighter6.fbTenjoCount1Sum
        streetFighter6Memory3.fbTenjoCount2Miss = streetFighter6.fbTenjoCount2Miss
        streetFighter6Memory3.fbTenjoCount2Hit = streetFighter6.fbTenjoCount2Hit
        streetFighter6Memory3.fbTenjoCount2Sum = streetFighter6.fbTenjoCount2Sum
        streetFighter6Memory3.fbTenjoCount3Miss = streetFighter6.fbTenjoCount3Miss
        streetFighter6Memory3.fbTenjoCount3Hit = streetFighter6.fbTenjoCount3Hit
        streetFighter6Memory3.fbTenjoCount3Sum = streetFighter6.fbTenjoCount3Sum
        streetFighter6Memory3.fbTenjoCount4Miss = streetFighter6.fbTenjoCount4Miss
        streetFighter6Memory3.fbTenjoCount4Hit = streetFighter6.fbTenjoCount4Hit
        streetFighter6Memory3.fbTenjoCount4Sum = streetFighter6.fbTenjoCount4Sum
        streetFighter6Memory3.fbTenjoCountOver2 = streetFighter6.fbTenjoCountOver2
        streetFighter6Memory3.fbTenjoCountOver3 = streetFighter6.fbTenjoCountOver3
        streetFighter6Memory3.fbTenjoCountOver4 = streetFighter6.fbTenjoCountOver4
        streetFighter6Memory3.fbTenjoCountAllSum = streetFighter6.fbTenjoCountAllSum
        streetFighter6Memory3.screenCount1 = streetFighter6.screenCount1
        streetFighter6Memory3.screenCount2 = streetFighter6.screenCount2
        streetFighter6Memory3.screenCount3 = streetFighter6.screenCount3
        streetFighter6Memory3.screenCount4 = streetFighter6.screenCount4
        streetFighter6Memory3.screenCount5 = streetFighter6.screenCount5
        streetFighter6Memory3.screenCount6 = streetFighter6.screenCount6
        streetFighter6Memory3.screenCount7 = streetFighter6.screenCount7
        streetFighter6Memory3.screenCount8 = streetFighter6.screenCount8
        streetFighter6Memory3.screenCountSum = streetFighter6.screenCountSum
        streetFighter6Memory3.endingCount1 = streetFighter6.endingCount1
        streetFighter6Memory3.endingCount2 = streetFighter6.endingCount2
        streetFighter6Memory3.endingCount3 = streetFighter6.endingCount3
        streetFighter6Memory3.endingCount4 = streetFighter6.endingCount4
        streetFighter6Memory3.endingCount5 = streetFighter6.endingCount5
        streetFighter6Memory3.endingCountSum = streetFighter6.endingCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct streetFighter6SubViewLoadMemory: View {
    @ObservedObject var streetFighter6: StreetFighter6
    @ObservedObject var streetFighter6Memory1: StreetFighter6Memory1
    @ObservedObject var streetFighter6Memory2: StreetFighter6Memory2
    @ObservedObject var streetFighter6Memory3: StreetFighter6Memory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: streetFighter6.machineName,
            selectedMemory: $streetFighter6.selectedMemory,
            memoMemory1: streetFighter6Memory1.memo,
            dateDoubleMemory1: streetFighter6Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: streetFighter6Memory2.memo,
            dateDoubleMemory2: streetFighter6Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: streetFighter6Memory3.memo,
            dateDoubleMemory3: streetFighter6Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        streetFighter6.normalGame = streetFighter6Memory1.normalGame
        streetFighter6.firstHitCountFb = streetFighter6Memory1.firstHitCountFb
        streetFighter6.firstHitCountBonus = streetFighter6Memory1.firstHitCountBonus
        streetFighter6.fbTenjoCount1Miss = streetFighter6Memory1.fbTenjoCount1Miss
        streetFighter6.fbTenjoCount1Hit = streetFighter6Memory1.fbTenjoCount1Hit
        streetFighter6.fbTenjoCount1Sum = streetFighter6Memory1.fbTenjoCount1Sum
        streetFighter6.fbTenjoCount2Miss = streetFighter6Memory1.fbTenjoCount2Miss
        streetFighter6.fbTenjoCount2Hit = streetFighter6Memory1.fbTenjoCount2Hit
        streetFighter6.fbTenjoCount2Sum = streetFighter6Memory1.fbTenjoCount2Sum
        streetFighter6.fbTenjoCount3Miss = streetFighter6Memory1.fbTenjoCount3Miss
        streetFighter6.fbTenjoCount3Hit = streetFighter6Memory1.fbTenjoCount3Hit
        streetFighter6.fbTenjoCount3Sum = streetFighter6Memory1.fbTenjoCount3Sum
        streetFighter6.fbTenjoCount4Miss = streetFighter6Memory1.fbTenjoCount4Miss
        streetFighter6.fbTenjoCount4Hit = streetFighter6Memory1.fbTenjoCount4Hit
        streetFighter6.fbTenjoCount4Sum = streetFighter6Memory1.fbTenjoCount4Sum
        streetFighter6.fbTenjoCountOver2 = streetFighter6Memory1.fbTenjoCountOver2
        streetFighter6.fbTenjoCountOver3 = streetFighter6Memory1.fbTenjoCountOver3
        streetFighter6.fbTenjoCountOver4 = streetFighter6Memory1.fbTenjoCountOver4
        streetFighter6.fbTenjoCountAllSum = streetFighter6Memory1.fbTenjoCountAllSum
        streetFighter6.screenCount1 = streetFighter6Memory1.screenCount1
        streetFighter6.screenCount2 = streetFighter6Memory1.screenCount2
        streetFighter6.screenCount3 = streetFighter6Memory1.screenCount3
        streetFighter6.screenCount4 = streetFighter6Memory1.screenCount4
        streetFighter6.screenCount5 = streetFighter6Memory1.screenCount5
        streetFighter6.screenCount6 = streetFighter6Memory1.screenCount6
        streetFighter6.screenCount7 = streetFighter6Memory1.screenCount7
        streetFighter6.screenCount8 = streetFighter6Memory1.screenCount8
        streetFighter6.screenCountSum = streetFighter6Memory1.screenCountSum
        streetFighter6.endingCount1 = streetFighter6Memory1.endingCount1
        streetFighter6.endingCount2 = streetFighter6Memory1.endingCount2
        streetFighter6.endingCount3 = streetFighter6Memory1.endingCount3
        streetFighter6.endingCount4 = streetFighter6Memory1.endingCount4
        streetFighter6.endingCount5 = streetFighter6Memory1.endingCount5
        streetFighter6.endingCountSum = streetFighter6Memory1.endingCountSum
    }
    func loadMemory2() {
        streetFighter6.normalGame = streetFighter6Memory2.normalGame
        streetFighter6.firstHitCountFb = streetFighter6Memory2.firstHitCountFb
        streetFighter6.firstHitCountBonus = streetFighter6Memory2.firstHitCountBonus
        streetFighter6.fbTenjoCount1Miss = streetFighter6Memory2.fbTenjoCount1Miss
        streetFighter6.fbTenjoCount1Hit = streetFighter6Memory2.fbTenjoCount1Hit
        streetFighter6.fbTenjoCount1Sum = streetFighter6Memory2.fbTenjoCount1Sum
        streetFighter6.fbTenjoCount2Miss = streetFighter6Memory2.fbTenjoCount2Miss
        streetFighter6.fbTenjoCount2Hit = streetFighter6Memory2.fbTenjoCount2Hit
        streetFighter6.fbTenjoCount2Sum = streetFighter6Memory2.fbTenjoCount2Sum
        streetFighter6.fbTenjoCount3Miss = streetFighter6Memory2.fbTenjoCount3Miss
        streetFighter6.fbTenjoCount3Hit = streetFighter6Memory2.fbTenjoCount3Hit
        streetFighter6.fbTenjoCount3Sum = streetFighter6Memory2.fbTenjoCount3Sum
        streetFighter6.fbTenjoCount4Miss = streetFighter6Memory2.fbTenjoCount4Miss
        streetFighter6.fbTenjoCount4Hit = streetFighter6Memory2.fbTenjoCount4Hit
        streetFighter6.fbTenjoCount4Sum = streetFighter6Memory2.fbTenjoCount4Sum
        streetFighter6.fbTenjoCountOver2 = streetFighter6Memory2.fbTenjoCountOver2
        streetFighter6.fbTenjoCountOver3 = streetFighter6Memory2.fbTenjoCountOver3
        streetFighter6.fbTenjoCountOver4 = streetFighter6Memory2.fbTenjoCountOver4
        streetFighter6.fbTenjoCountAllSum = streetFighter6Memory2.fbTenjoCountAllSum
        streetFighter6.screenCount1 = streetFighter6Memory2.screenCount1
        streetFighter6.screenCount2 = streetFighter6Memory2.screenCount2
        streetFighter6.screenCount3 = streetFighter6Memory2.screenCount3
        streetFighter6.screenCount4 = streetFighter6Memory2.screenCount4
        streetFighter6.screenCount5 = streetFighter6Memory2.screenCount5
        streetFighter6.screenCount6 = streetFighter6Memory2.screenCount6
        streetFighter6.screenCount7 = streetFighter6Memory2.screenCount7
        streetFighter6.screenCount8 = streetFighter6Memory2.screenCount8
        streetFighter6.screenCountSum = streetFighter6Memory2.screenCountSum
        streetFighter6.endingCount1 = streetFighter6Memory2.endingCount1
        streetFighter6.endingCount2 = streetFighter6Memory2.endingCount2
        streetFighter6.endingCount3 = streetFighter6Memory2.endingCount3
        streetFighter6.endingCount4 = streetFighter6Memory2.endingCount4
        streetFighter6.endingCount5 = streetFighter6Memory2.endingCount5
        streetFighter6.endingCountSum = streetFighter6Memory2.endingCountSum
    }
    func loadMemory3() {
        streetFighter6.normalGame = streetFighter6Memory3.normalGame
        streetFighter6.firstHitCountFb = streetFighter6Memory3.firstHitCountFb
        streetFighter6.firstHitCountBonus = streetFighter6Memory3.firstHitCountBonus
        streetFighter6.fbTenjoCount1Miss = streetFighter6Memory3.fbTenjoCount1Miss
        streetFighter6.fbTenjoCount1Hit = streetFighter6Memory3.fbTenjoCount1Hit
        streetFighter6.fbTenjoCount1Sum = streetFighter6Memory3.fbTenjoCount1Sum
        streetFighter6.fbTenjoCount2Miss = streetFighter6Memory3.fbTenjoCount2Miss
        streetFighter6.fbTenjoCount2Hit = streetFighter6Memory3.fbTenjoCount2Hit
        streetFighter6.fbTenjoCount2Sum = streetFighter6Memory3.fbTenjoCount2Sum
        streetFighter6.fbTenjoCount3Miss = streetFighter6Memory3.fbTenjoCount3Miss
        streetFighter6.fbTenjoCount3Hit = streetFighter6Memory3.fbTenjoCount3Hit
        streetFighter6.fbTenjoCount3Sum = streetFighter6Memory3.fbTenjoCount3Sum
        streetFighter6.fbTenjoCount4Miss = streetFighter6Memory3.fbTenjoCount4Miss
        streetFighter6.fbTenjoCount4Hit = streetFighter6Memory3.fbTenjoCount4Hit
        streetFighter6.fbTenjoCount4Sum = streetFighter6Memory3.fbTenjoCount4Sum
        streetFighter6.fbTenjoCountOver2 = streetFighter6Memory3.fbTenjoCountOver2
        streetFighter6.fbTenjoCountOver3 = streetFighter6Memory3.fbTenjoCountOver3
        streetFighter6.fbTenjoCountOver4 = streetFighter6Memory3.fbTenjoCountOver4
        streetFighter6.fbTenjoCountAllSum = streetFighter6Memory3.fbTenjoCountAllSum
        streetFighter6.screenCount1 = streetFighter6Memory3.screenCount1
        streetFighter6.screenCount2 = streetFighter6Memory3.screenCount2
        streetFighter6.screenCount3 = streetFighter6Memory3.screenCount3
        streetFighter6.screenCount4 = streetFighter6Memory3.screenCount4
        streetFighter6.screenCount5 = streetFighter6Memory3.screenCount5
        streetFighter6.screenCount6 = streetFighter6Memory3.screenCount6
        streetFighter6.screenCount7 = streetFighter6Memory3.screenCount7
        streetFighter6.screenCount8 = streetFighter6Memory3.screenCount8
        streetFighter6.screenCountSum = streetFighter6Memory3.screenCountSum
        streetFighter6.endingCount1 = streetFighter6Memory3.endingCount1
        streetFighter6.endingCount2 = streetFighter6Memory3.endingCount2
        streetFighter6.endingCount3 = streetFighter6Memory3.endingCount3
        streetFighter6.endingCount4 = streetFighter6Memory3.endingCount4
        streetFighter6.endingCount5 = streetFighter6Memory3.endingCount5
        streetFighter6.endingCountSum = streetFighter6Memory3.endingCountSum
    }
}

#Preview {
    streetFighter6ViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
