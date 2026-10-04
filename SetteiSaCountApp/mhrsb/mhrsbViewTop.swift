//
//  mhrsbViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct mhrsbViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var mhrsb = Mhrsb()
    @State var isShowAlert: Bool = false
    @StateObject var mhrsbMemory1 = MhrsbMemory1()
    @StateObject var mhrsbMemory2 = MhrsbMemory2()
    @StateObject var mhrsbMemory3 = MhrsbMemory3()
    var body: some View {
        NavigationStack {
            List {

                Section {
                    // 通常時
                    NavigationLink(destination: mhrsbViewNormal(
                        mhrsb: mhrsb,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.mhrsbMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: mhrsbViewFirstHit(
                        mhrsb: mhrsb,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.mhrsbMenuFirstHitBadge,
                        )
                    }

                    // 終了画面
                    NavigationLink(destination: mhrsbViewScreen(
                        mhrsb: mhrsb,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: common.mhrsbMenuScreenBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: mhrsbViewEnding(
                        mhrsb: mhrsb,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.mhrsbMenuEndingBadge,
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
                        machineName: mhrsb.machineName,
                        titleFont: .body,
                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: mhrsbView95Ci(
                    mhrsb: mhrsb,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: mhrsbViewBayes(
                    mhrsb: mhrsb,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.mhrsbMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5095")

                // コピーライト
                unitSectionCopyright {
                    Text("©CAPCOM")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5095")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: mhrsb.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(mhrsbSubViewLoadMemory(
                    mhrsb: mhrsb,
                    mhrsbMemory1: mhrsbMemory1,
                    mhrsbMemory2: mhrsbMemory2,
                    mhrsbMemory3: mhrsbMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(mhrsbSubViewSaveMemory(
                    mhrsb: mhrsb,
                    mhrsbMemory1: mhrsbMemory1,
                    mhrsbMemory2: mhrsbMemory2,
                    mhrsbMemory3: mhrsbMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: mhrsb.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct mhrsbSubViewSaveMemory: View {
    @ObservedObject var mhrsb: Mhrsb
    @ObservedObject var mhrsbMemory1: MhrsbMemory1
    @ObservedObject var mhrsbMemory2: MhrsbMemory2
    @ObservedObject var mhrsbMemory3: MhrsbMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: mhrsb.machineName,
            selectedMemory: $mhrsb.selectedMemory,
            memoMemory1: $mhrsbMemory1.memo,
            dateDoubleMemory1: $mhrsbMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $mhrsbMemory2.memo,
            dateDoubleMemory2: $mhrsbMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $mhrsbMemory3.memo,
            dateDoubleMemory3: $mhrsbMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        mhrsbMemory1.normalGame = mhrsb.normalGame
        mhrsbMemory1.firstHitCountAt = mhrsb.firstHitCountAt
        mhrsbMemory1.screenCount1 = mhrsb.screenCount1
        mhrsbMemory1.screenCount2 = mhrsb.screenCount2
        mhrsbMemory1.screenCount3 = mhrsb.screenCount3
        mhrsbMemory1.screenCount4 = mhrsb.screenCount4
        mhrsbMemory1.screenCount5 = mhrsb.screenCount5
        mhrsbMemory1.screenCount6 = mhrsb.screenCount6
        mhrsbMemory1.screenCount7 = mhrsb.screenCount7
        mhrsbMemory1.screenCount8 = mhrsb.screenCount8
        mhrsbMemory1.screenCount9 = mhrsb.screenCount9
        mhrsbMemory1.screenCountSum = mhrsb.screenCountSum
        mhrsbMemory1.endingCount1 = mhrsb.endingCount1
        mhrsbMemory1.endingCount2 = mhrsb.endingCount2
        mhrsbMemory1.endingCount3 = mhrsb.endingCount3
        mhrsbMemory1.endingCount4 = mhrsb.endingCount4
        mhrsbMemory1.endingCount5 = mhrsb.endingCount5
        mhrsbMemory1.endingCount6 = mhrsb.endingCount6
        mhrsbMemory1.endingCount7 = mhrsb.endingCount7
        mhrsbMemory1.endingCount8 = mhrsb.endingCount8
        mhrsbMemory1.endingCount9 = mhrsb.endingCount9
        mhrsbMemory1.endingCountSum = mhrsb.endingCountSum
    }
    func saveMemory2() {
        mhrsbMemory2.normalGame = mhrsb.normalGame
        mhrsbMemory2.firstHitCountAt = mhrsb.firstHitCountAt
        mhrsbMemory2.screenCount1 = mhrsb.screenCount1
        mhrsbMemory2.screenCount2 = mhrsb.screenCount2
        mhrsbMemory2.screenCount3 = mhrsb.screenCount3
        mhrsbMemory2.screenCount4 = mhrsb.screenCount4
        mhrsbMemory2.screenCount5 = mhrsb.screenCount5
        mhrsbMemory2.screenCount6 = mhrsb.screenCount6
        mhrsbMemory2.screenCount7 = mhrsb.screenCount7
        mhrsbMemory2.screenCount8 = mhrsb.screenCount8
        mhrsbMemory2.screenCount9 = mhrsb.screenCount9
        mhrsbMemory2.screenCountSum = mhrsb.screenCountSum
        mhrsbMemory2.endingCount1 = mhrsb.endingCount1
        mhrsbMemory2.endingCount2 = mhrsb.endingCount2
        mhrsbMemory2.endingCount3 = mhrsb.endingCount3
        mhrsbMemory2.endingCount4 = mhrsb.endingCount4
        mhrsbMemory2.endingCount5 = mhrsb.endingCount5
        mhrsbMemory2.endingCount6 = mhrsb.endingCount6
        mhrsbMemory2.endingCount7 = mhrsb.endingCount7
        mhrsbMemory2.endingCount8 = mhrsb.endingCount8
        mhrsbMemory2.endingCount9 = mhrsb.endingCount9
        mhrsbMemory2.endingCountSum = mhrsb.endingCountSum
    }
    func saveMemory3() {
        mhrsbMemory3.normalGame = mhrsb.normalGame
        mhrsbMemory3.firstHitCountAt = mhrsb.firstHitCountAt
        mhrsbMemory3.screenCount1 = mhrsb.screenCount1
        mhrsbMemory3.screenCount2 = mhrsb.screenCount2
        mhrsbMemory3.screenCount3 = mhrsb.screenCount3
        mhrsbMemory3.screenCount4 = mhrsb.screenCount4
        mhrsbMemory3.screenCount5 = mhrsb.screenCount5
        mhrsbMemory3.screenCount6 = mhrsb.screenCount6
        mhrsbMemory3.screenCount7 = mhrsb.screenCount7
        mhrsbMemory3.screenCount8 = mhrsb.screenCount8
        mhrsbMemory3.screenCount9 = mhrsb.screenCount9
        mhrsbMemory3.screenCountSum = mhrsb.screenCountSum
        mhrsbMemory3.endingCount1 = mhrsb.endingCount1
        mhrsbMemory3.endingCount2 = mhrsb.endingCount2
        mhrsbMemory3.endingCount3 = mhrsb.endingCount3
        mhrsbMemory3.endingCount4 = mhrsb.endingCount4
        mhrsbMemory3.endingCount5 = mhrsb.endingCount5
        mhrsbMemory3.endingCount6 = mhrsb.endingCount6
        mhrsbMemory3.endingCount7 = mhrsb.endingCount7
        mhrsbMemory3.endingCount8 = mhrsb.endingCount8
        mhrsbMemory3.endingCount9 = mhrsb.endingCount9
        mhrsbMemory3.endingCountSum = mhrsb.endingCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct mhrsbSubViewLoadMemory: View {
    @ObservedObject var mhrsb: Mhrsb
    @ObservedObject var mhrsbMemory1: MhrsbMemory1
    @ObservedObject var mhrsbMemory2: MhrsbMemory2
    @ObservedObject var mhrsbMemory3: MhrsbMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: mhrsb.machineName,
            selectedMemory: $mhrsb.selectedMemory,
            memoMemory1: mhrsbMemory1.memo,
            dateDoubleMemory1: mhrsbMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: mhrsbMemory2.memo,
            dateDoubleMemory2: mhrsbMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: mhrsbMemory3.memo,
            dateDoubleMemory3: mhrsbMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        mhrsb.normalGame = mhrsbMemory1.normalGame
        mhrsb.firstHitCountAt = mhrsbMemory1.firstHitCountAt
        mhrsb.screenCount1 = mhrsbMemory1.screenCount1
        mhrsb.screenCount2 = mhrsbMemory1.screenCount2
        mhrsb.screenCount3 = mhrsbMemory1.screenCount3
        mhrsb.screenCount4 = mhrsbMemory1.screenCount4
        mhrsb.screenCount5 = mhrsbMemory1.screenCount5
        mhrsb.screenCount6 = mhrsbMemory1.screenCount6
        mhrsb.screenCount7 = mhrsbMemory1.screenCount7
        mhrsb.screenCount8 = mhrsbMemory1.screenCount8
        mhrsb.screenCount9 = mhrsbMemory1.screenCount9
        mhrsb.screenCountSum = mhrsbMemory1.screenCountSum
        mhrsb.endingCount1 = mhrsbMemory1.endingCount1
        mhrsb.endingCount2 = mhrsbMemory1.endingCount2
        mhrsb.endingCount3 = mhrsbMemory1.endingCount3
        mhrsb.endingCount4 = mhrsbMemory1.endingCount4
        mhrsb.endingCount5 = mhrsbMemory1.endingCount5
        mhrsb.endingCount6 = mhrsbMemory1.endingCount6
        mhrsb.endingCount7 = mhrsbMemory1.endingCount7
        mhrsb.endingCount8 = mhrsbMemory1.endingCount8
        mhrsb.endingCount9 = mhrsbMemory1.endingCount9
        mhrsb.endingCountSum = mhrsbMemory1.endingCountSum
    }
    func loadMemory2() {
        mhrsb.normalGame = mhrsbMemory2.normalGame
        mhrsb.firstHitCountAt = mhrsbMemory2.firstHitCountAt
        mhrsb.screenCount1 = mhrsbMemory2.screenCount1
        mhrsb.screenCount2 = mhrsbMemory2.screenCount2
        mhrsb.screenCount3 = mhrsbMemory2.screenCount3
        mhrsb.screenCount4 = mhrsbMemory2.screenCount4
        mhrsb.screenCount5 = mhrsbMemory2.screenCount5
        mhrsb.screenCount6 = mhrsbMemory2.screenCount6
        mhrsb.screenCount7 = mhrsbMemory2.screenCount7
        mhrsb.screenCount8 = mhrsbMemory2.screenCount8
        mhrsb.screenCount9 = mhrsbMemory2.screenCount9
        mhrsb.screenCountSum = mhrsbMemory2.screenCountSum
        mhrsb.endingCount1 = mhrsbMemory2.endingCount1
        mhrsb.endingCount2 = mhrsbMemory2.endingCount2
        mhrsb.endingCount3 = mhrsbMemory2.endingCount3
        mhrsb.endingCount4 = mhrsbMemory2.endingCount4
        mhrsb.endingCount5 = mhrsbMemory2.endingCount5
        mhrsb.endingCount6 = mhrsbMemory2.endingCount6
        mhrsb.endingCount7 = mhrsbMemory2.endingCount7
        mhrsb.endingCount8 = mhrsbMemory2.endingCount8
        mhrsb.endingCount9 = mhrsbMemory2.endingCount9
        mhrsb.endingCountSum = mhrsbMemory2.endingCountSum
    }
    func loadMemory3() {
        mhrsb.normalGame = mhrsbMemory3.normalGame
        mhrsb.firstHitCountAt = mhrsbMemory3.firstHitCountAt
        mhrsb.screenCount1 = mhrsbMemory3.screenCount1
        mhrsb.screenCount2 = mhrsbMemory3.screenCount2
        mhrsb.screenCount3 = mhrsbMemory3.screenCount3
        mhrsb.screenCount4 = mhrsbMemory3.screenCount4
        mhrsb.screenCount5 = mhrsbMemory3.screenCount5
        mhrsb.screenCount6 = mhrsbMemory3.screenCount6
        mhrsb.screenCount7 = mhrsbMemory3.screenCount7
        mhrsb.screenCount8 = mhrsbMemory3.screenCount8
        mhrsb.screenCount9 = mhrsbMemory3.screenCount9
        mhrsb.screenCountSum = mhrsbMemory3.screenCountSum
        mhrsb.endingCount1 = mhrsbMemory3.endingCount1
        mhrsb.endingCount2 = mhrsbMemory3.endingCount2
        mhrsb.endingCount3 = mhrsbMemory3.endingCount3
        mhrsb.endingCount4 = mhrsbMemory3.endingCount4
        mhrsb.endingCount5 = mhrsbMemory3.endingCount5
        mhrsb.endingCount6 = mhrsbMemory3.endingCount6
        mhrsb.endingCount7 = mhrsbMemory3.endingCount7
        mhrsb.endingCount8 = mhrsbMemory3.endingCount8
        mhrsb.endingCount9 = mhrsbMemory3.endingCount9
        mhrsb.endingCountSum = mhrsbMemory3.endingCountSum
    }
}

#Preview {
    mhrsbViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
