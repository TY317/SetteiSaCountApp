//
//  index2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct index2ViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var index2 = Index2()
    @State var isShowAlert: Bool = false
    @StateObject var index2Memory1 = Index2Memory1()
    @StateObject var index2Memory2 = Index2Memory2()
    @StateObject var index2Memory3 = Index2Memory3()
    var body: some View {
        NavigationStack {
            List {

                Section {
                    // 通常時
                    NavigationLink(destination: index2ViewNormal(
                        index2: index2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.index2MenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: index2ViewFirstHit(
                        index2: index2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.index2MenuFirstHitBadge,
                        )
                    }

                    // 終了画面
                    NavigationLink(destination: index2ViewScreen(
                        index2: index2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: common.index2MenuScreenBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: index2ViewEnding(
                        index2: index2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.index2MenuEndingBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewFujimaruCoin()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "藤丸コイン"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: index2.machineName,
                        titleFont: .title,
                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: index2View95Ci(
                    index2: index2,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: index2ViewBayes(
                    index2: index2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.index2MenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5053")

                // コピーライト
                unitSectionCopyright {
                    Text("©︎2017 鎌池和馬／ＫＡＤＯＫＡＷＡ　アスキー・メディアワークス／PROJECT-INDEX Ⅲ")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5053")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: index2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(index2SubViewLoadMemory(
                    index2: index2,
                    index2Memory1: index2Memory1,
                    index2Memory2: index2Memory2,
                    index2Memory3: index2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(index2SubViewSaveMemory(
                    index2: index2,
                    index2Memory1: index2Memory1,
                    index2Memory2: index2Memory2,
                    index2Memory3: index2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: index2.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct index2SubViewSaveMemory: View {
    @ObservedObject var index2: Index2
    @ObservedObject var index2Memory1: Index2Memory1
    @ObservedObject var index2Memory2: Index2Memory2
    @ObservedObject var index2Memory3: Index2Memory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: index2.machineName,
            selectedMemory: $index2.selectedMemory,
            memoMemory1: $index2Memory1.memo,
            dateDoubleMemory1: $index2Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $index2Memory2.memo,
            dateDoubleMemory2: $index2Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $index2Memory3.memo,
            dateDoubleMemory3: $index2Memory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        index2Memory1.suikaCountKoyaku = index2.suikaCountKoyaku
        index2Memory1.suikaCountKokaku = index2.suikaCountKokaku
        index2Memory1.suikaCountMikoto = index2.suikaCountMikoto
        index2Memory1.normalGame = index2.normalGame
        index2Memory1.firstHitCountCz = index2.firstHitCountCz
        index2Memory1.firstHitCountAt = index2.firstHitCountAt
        index2Memory1.screenCount1 = index2.screenCount1
        index2Memory1.screenCount2 = index2.screenCount2
        index2Memory1.screenCount3 = index2.screenCount3
        index2Memory1.screenCount4 = index2.screenCount4
        index2Memory1.screenCount5 = index2.screenCount5
        index2Memory1.screenCount6 = index2.screenCount6
        index2Memory1.screenCount7 = index2.screenCount7
        index2Memory1.screenCount8 = index2.screenCount8
        index2Memory1.screenCount9 = index2.screenCount9
        index2Memory1.screenCount10 = index2.screenCount10
        index2Memory1.screenCount11 = index2.screenCount11
        index2Memory1.screenCountSum = index2.screenCountSum
        index2Memory1.commentCount1 = index2.commentCount1
        index2Memory1.commentCount2 = index2.commentCount2
        index2Memory1.commentCount3 = index2.commentCount3
        index2Memory1.commentCount4 = index2.commentCount4
        index2Memory1.commentCount5 = index2.commentCount5
        index2Memory1.commentCount6 = index2.commentCount6
        index2Memory1.commentCount7 = index2.commentCount7
        index2Memory1.commentCount8 = index2.commentCount8
        index2Memory1.commentCount9 = index2.commentCount9
        index2Memory1.commentCountSum = index2.commentCountSum
    }
    func saveMemory2() {
        index2Memory2.suikaCountKoyaku = index2.suikaCountKoyaku
        index2Memory2.suikaCountKokaku = index2.suikaCountKokaku
        index2Memory2.suikaCountMikoto = index2.suikaCountMikoto
        index2Memory2.normalGame = index2.normalGame
        index2Memory2.firstHitCountCz = index2.firstHitCountCz
        index2Memory2.firstHitCountAt = index2.firstHitCountAt
        index2Memory2.screenCount1 = index2.screenCount1
        index2Memory2.screenCount2 = index2.screenCount2
        index2Memory2.screenCount3 = index2.screenCount3
        index2Memory2.screenCount4 = index2.screenCount4
        index2Memory2.screenCount5 = index2.screenCount5
        index2Memory2.screenCount6 = index2.screenCount6
        index2Memory2.screenCount7 = index2.screenCount7
        index2Memory2.screenCount8 = index2.screenCount8
        index2Memory2.screenCount9 = index2.screenCount9
        index2Memory2.screenCount10 = index2.screenCount10
        index2Memory2.screenCount11 = index2.screenCount11
        index2Memory2.screenCountSum = index2.screenCountSum
        index2Memory2.commentCount1 = index2.commentCount1
        index2Memory2.commentCount2 = index2.commentCount2
        index2Memory2.commentCount3 = index2.commentCount3
        index2Memory2.commentCount4 = index2.commentCount4
        index2Memory2.commentCount5 = index2.commentCount5
        index2Memory2.commentCount6 = index2.commentCount6
        index2Memory2.commentCount7 = index2.commentCount7
        index2Memory2.commentCount8 = index2.commentCount8
        index2Memory2.commentCount9 = index2.commentCount9
        index2Memory2.commentCountSum = index2.commentCountSum
    }
    func saveMemory3() {
        index2Memory3.suikaCountKoyaku = index2.suikaCountKoyaku
        index2Memory3.suikaCountKokaku = index2.suikaCountKokaku
        index2Memory3.suikaCountMikoto = index2.suikaCountMikoto
        index2Memory3.normalGame = index2.normalGame
        index2Memory3.firstHitCountCz = index2.firstHitCountCz
        index2Memory3.firstHitCountAt = index2.firstHitCountAt
        index2Memory3.screenCount1 = index2.screenCount1
        index2Memory3.screenCount2 = index2.screenCount2
        index2Memory3.screenCount3 = index2.screenCount3
        index2Memory3.screenCount4 = index2.screenCount4
        index2Memory3.screenCount5 = index2.screenCount5
        index2Memory3.screenCount6 = index2.screenCount6
        index2Memory3.screenCount7 = index2.screenCount7
        index2Memory3.screenCount8 = index2.screenCount8
        index2Memory3.screenCount9 = index2.screenCount9
        index2Memory3.screenCount10 = index2.screenCount10
        index2Memory3.screenCount11 = index2.screenCount11
        index2Memory3.screenCountSum = index2.screenCountSum
        index2Memory3.commentCount1 = index2.commentCount1
        index2Memory3.commentCount2 = index2.commentCount2
        index2Memory3.commentCount3 = index2.commentCount3
        index2Memory3.commentCount4 = index2.commentCount4
        index2Memory3.commentCount5 = index2.commentCount5
        index2Memory3.commentCount6 = index2.commentCount6
        index2Memory3.commentCount7 = index2.commentCount7
        index2Memory3.commentCount8 = index2.commentCount8
        index2Memory3.commentCount9 = index2.commentCount9
        index2Memory3.commentCountSum = index2.commentCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct index2SubViewLoadMemory: View {
    @ObservedObject var index2: Index2
    @ObservedObject var index2Memory1: Index2Memory1
    @ObservedObject var index2Memory2: Index2Memory2
    @ObservedObject var index2Memory3: Index2Memory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: index2.machineName,
            selectedMemory: $index2.selectedMemory,
            memoMemory1: index2Memory1.memo,
            dateDoubleMemory1: index2Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: index2Memory2.memo,
            dateDoubleMemory2: index2Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: index2Memory3.memo,
            dateDoubleMemory3: index2Memory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        index2.suikaCountKoyaku = index2Memory1.suikaCountKoyaku
        index2.suikaCountKokaku = index2Memory1.suikaCountKokaku
        index2.suikaCountMikoto = index2Memory1.suikaCountMikoto
        index2.normalGame = index2Memory1.normalGame
        index2.firstHitCountCz = index2Memory1.firstHitCountCz
        index2.firstHitCountAt = index2Memory1.firstHitCountAt
        index2.screenCount1 = index2Memory1.screenCount1
        index2.screenCount2 = index2Memory1.screenCount2
        index2.screenCount3 = index2Memory1.screenCount3
        index2.screenCount4 = index2Memory1.screenCount4
        index2.screenCount5 = index2Memory1.screenCount5
        index2.screenCount6 = index2Memory1.screenCount6
        index2.screenCount7 = index2Memory1.screenCount7
        index2.screenCount8 = index2Memory1.screenCount8
        index2.screenCount9 = index2Memory1.screenCount9
        index2.screenCount10 = index2Memory1.screenCount10
        index2.screenCount11 = index2Memory1.screenCount11
        index2.screenCountSum = index2Memory1.screenCountSum
        index2.commentCount1 = index2Memory1.commentCount1
        index2.commentCount2 = index2Memory1.commentCount2
        index2.commentCount3 = index2Memory1.commentCount3
        index2.commentCount4 = index2Memory1.commentCount4
        index2.commentCount5 = index2Memory1.commentCount5
        index2.commentCount6 = index2Memory1.commentCount6
        index2.commentCount7 = index2Memory1.commentCount7
        index2.commentCount8 = index2Memory1.commentCount8
        index2.commentCount9 = index2Memory1.commentCount9
        index2.commentCountSum = index2Memory1.commentCountSum
    }
    func loadMemory2() {
        index2.suikaCountKoyaku = index2Memory2.suikaCountKoyaku
        index2.suikaCountKokaku = index2Memory2.suikaCountKokaku
        index2.suikaCountMikoto = index2Memory2.suikaCountMikoto
        index2.normalGame = index2Memory2.normalGame
        index2.firstHitCountCz = index2Memory2.firstHitCountCz
        index2.firstHitCountAt = index2Memory2.firstHitCountAt
        index2.screenCount1 = index2Memory2.screenCount1
        index2.screenCount2 = index2Memory2.screenCount2
        index2.screenCount3 = index2Memory2.screenCount3
        index2.screenCount4 = index2Memory2.screenCount4
        index2.screenCount5 = index2Memory2.screenCount5
        index2.screenCount6 = index2Memory2.screenCount6
        index2.screenCount7 = index2Memory2.screenCount7
        index2.screenCount8 = index2Memory2.screenCount8
        index2.screenCount9 = index2Memory2.screenCount9
        index2.screenCount10 = index2Memory2.screenCount10
        index2.screenCount11 = index2Memory2.screenCount11
        index2.screenCountSum = index2Memory2.screenCountSum
        index2.commentCount1 = index2Memory2.commentCount1
        index2.commentCount2 = index2Memory2.commentCount2
        index2.commentCount3 = index2Memory2.commentCount3
        index2.commentCount4 = index2Memory2.commentCount4
        index2.commentCount5 = index2Memory2.commentCount5
        index2.commentCount6 = index2Memory2.commentCount6
        index2.commentCount7 = index2Memory2.commentCount7
        index2.commentCount8 = index2Memory2.commentCount8
        index2.commentCount9 = index2Memory2.commentCount9
        index2.commentCountSum = index2Memory2.commentCountSum
    }
    func loadMemory3() {
        index2.suikaCountKoyaku = index2Memory3.suikaCountKoyaku
        index2.suikaCountKokaku = index2Memory3.suikaCountKokaku
        index2.suikaCountMikoto = index2Memory3.suikaCountMikoto
        index2.normalGame = index2Memory3.normalGame
        index2.firstHitCountCz = index2Memory3.firstHitCountCz
        index2.firstHitCountAt = index2Memory3.firstHitCountAt
        index2.screenCount1 = index2Memory3.screenCount1
        index2.screenCount2 = index2Memory3.screenCount2
        index2.screenCount3 = index2Memory3.screenCount3
        index2.screenCount4 = index2Memory3.screenCount4
        index2.screenCount5 = index2Memory3.screenCount5
        index2.screenCount6 = index2Memory3.screenCount6
        index2.screenCount7 = index2Memory3.screenCount7
        index2.screenCount8 = index2Memory3.screenCount8
        index2.screenCount9 = index2Memory3.screenCount9
        index2.screenCount10 = index2Memory3.screenCount10
        index2.screenCount11 = index2Memory3.screenCount11
        index2.screenCountSum = index2Memory3.screenCountSum
        index2.commentCount1 = index2Memory3.commentCount1
        index2.commentCount2 = index2Memory3.commentCount2
        index2.commentCount3 = index2Memory3.commentCount3
        index2.commentCount4 = index2Memory3.commentCount4
        index2.commentCount5 = index2Memory3.commentCount5
        index2.commentCount6 = index2Memory3.commentCount6
        index2.commentCount7 = index2Memory3.commentCount7
        index2.commentCount8 = index2Memory3.commentCount8
        index2.commentCount9 = index2Memory3.commentCount9
        index2.commentCountSum = index2Memory3.commentCountSum
    }
}

#Preview {
    index2ViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
