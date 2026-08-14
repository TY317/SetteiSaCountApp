//
//  dropkickViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct dropkickViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var dropkick = Dropkick()
    @State var isShowAlert: Bool = false
    @StateObject var dropkickMemory1 = DropkickMemory1()
    @StateObject var dropkickMemory2 = DropkickMemory2()
    @StateObject var dropkickMemory3 = DropkickMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: dropkickViewNormal(
                        dropkick: dropkick,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.dropkickMenuNormalBadge,
                        )
                    }

                    // とにかくうれしいちゃんす
                    NavigationLink(destination: dropkickViewTuc(
                        dropkick: dropkick,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.text.rectangle.fill",
                            textBody: "とにかくうれしいちゃんす",
                            badgeStatus: common.dropkickMenuTucBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: dropkickViewFirstHit(
                        dropkick: dropkick,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.dropkickMenuFirstHitBadge,
                        )
                    }

                    // 小悪魔ボーナス
                    NavigationLink(destination: dropkickViewKoakuma(
                        dropkick: dropkick,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "person.2.fill",
                            textBody: "小悪魔ボーナス",
                            badgeStatus: common.dropkickMenuKoakumaBadge,
                        )
                    }

                    // 終了画面
                    NavigationLink(destination: dropkickViewScreen(
                        dropkick: dropkick,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面",
                            badgeStatus: common.dropkickMenuScreenBadge,
                        )
                    }

                    // 引き戻し
                    NavigationLink(destination: dropkickViewBack(
                        dropkick: dropkick,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arrow.trianglehead.2.counterclockwise",
                            textBody: "引き戻し",
                            badgeStatus: common.dropkickMenuBackBadge,
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
                        machineName: dropkick.machineName,
                        titleFont: .title2,
                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: dropkickView95Ci(
                    dropkick: dropkick,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: dropkickViewBayes(
                    dropkick: dropkick,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.dropkickMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5020")

                // コピーライト
                unitSectionCopyright {
                    Text("©ユキヲ・COMICメテオ／邪神ちゃんドロップキックX製作委員会")
                    Text("©︎SANYO BUSSAN CO.,LTD.")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5020")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dropkick.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(dropkickSubViewLoadMemory(
                    dropkick: dropkick,
                    dropkickMemory1: dropkickMemory1,
                    dropkickMemory2: dropkickMemory2,
                    dropkickMemory3: dropkickMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(dropkickSubViewSaveMemory(
                    dropkick: dropkick,
                    dropkickMemory1: dropkickMemory1,
                    dropkickMemory2: dropkickMemory2,
                    dropkickMemory3: dropkickMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: dropkick.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct dropkickSubViewSaveMemory: View {
    @ObservedObject var dropkick: Dropkick
    @ObservedObject var dropkickMemory1: DropkickMemory1
    @ObservedObject var dropkickMemory2: DropkickMemory2
    @ObservedObject var dropkickMemory3: DropkickMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: dropkick.machineName,
            selectedMemory: $dropkick.selectedMemory,
            memoMemory1: $dropkickMemory1.memo,
            dateDoubleMemory1: $dropkickMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $dropkickMemory2.memo,
            dateDoubleMemory2: $dropkickMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $dropkickMemory3.memo,
            dateDoubleMemory3: $dropkickMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        dropkickMemory1.ptMigisagari = dropkick.ptMigisagari
        dropkickMemory1.ptUpper = dropkick.ptUpper
        dropkickMemory1.ptMiddle = dropkick.ptMiddle
        dropkickMemory1.ptLower = dropkick.ptLower
        dropkickMemory1.ptMigiagari = dropkick.ptMigiagari
        dropkickMemory1.normalGame = dropkick.normalGame
        dropkickMemory1.firstHitCountBonus = dropkick.firstHitCountBonus
        dropkickMemory1.firstHitCountAt = dropkick.firstHitCountAt
        dropkickMemory1.screenCount1 = dropkick.screenCount1
        dropkickMemory1.screenCount2 = dropkick.screenCount2
        dropkickMemory1.screenCount3 = dropkick.screenCount3
        dropkickMemory1.screenCount4 = dropkick.screenCount4
        dropkickMemory1.screenCount5 = dropkick.screenCount5
        dropkickMemory1.screenCount6 = dropkick.screenCount6
        dropkickMemory1.screenCount7 = dropkick.screenCount7
        dropkickMemory1.screenCount8 = dropkick.screenCount8
        dropkickMemory1.screenCount9 = dropkick.screenCount9
        dropkickMemory1.screenCount10 = dropkick.screenCount10
        dropkickMemory1.screenCount11 = dropkick.screenCount11
        dropkickMemory1.screenCountSum = dropkick.screenCountSum
        dropkickMemory1.charaCount1 = dropkick.charaCount1
        dropkickMemory1.charaCount2 = dropkick.charaCount2
        dropkickMemory1.charaCount3 = dropkick.charaCount3
        dropkickMemory1.charaCount4 = dropkick.charaCount4
        dropkickMemory1.charaCount5 = dropkick.charaCount5
        dropkickMemory1.charaCount6 = dropkick.charaCount6
        dropkickMemory1.charaCount7 = dropkick.charaCount7
        dropkickMemory1.charaCount8 = dropkick.charaCount8
        dropkickMemory1.charaCount9 = dropkick.charaCount9
        dropkickMemory1.charaCount10 = dropkick.charaCount10
        dropkickMemory1.charaCount11 = dropkick.charaCount11
        dropkickMemory1.charaCount12 = dropkick.charaCount12
        dropkickMemory1.charaCountSum = dropkick.charaCountSum
        dropkickMemory1.tucSealCount1 = dropkick.tucSealCount1
        dropkickMemory1.tucSealCount2 = dropkick.tucSealCount2
        dropkickMemory1.tucSealCount3 = dropkick.tucSealCount3
        dropkickMemory1.tucSealCount4 = dropkick.tucSealCount4
        dropkickMemory1.tucSealCount5 = dropkick.tucSealCount5
        dropkickMemory1.tucSealCount6 = dropkick.tucSealCount6
        dropkickMemory1.tucSealCount7 = dropkick.tucSealCount7
        dropkickMemory1.tucSealCountSum = dropkick.tucSealCountSum
    }
    func saveMemory2() {
        dropkickMemory2.ptMigisagari = dropkick.ptMigisagari
        dropkickMemory2.ptUpper = dropkick.ptUpper
        dropkickMemory2.ptMiddle = dropkick.ptMiddle
        dropkickMemory2.ptLower = dropkick.ptLower
        dropkickMemory2.ptMigiagari = dropkick.ptMigiagari
        dropkickMemory2.normalGame = dropkick.normalGame
        dropkickMemory2.firstHitCountBonus = dropkick.firstHitCountBonus
        dropkickMemory2.firstHitCountAt = dropkick.firstHitCountAt
        dropkickMemory2.screenCount1 = dropkick.screenCount1
        dropkickMemory2.screenCount2 = dropkick.screenCount2
        dropkickMemory2.screenCount3 = dropkick.screenCount3
        dropkickMemory2.screenCount4 = dropkick.screenCount4
        dropkickMemory2.screenCount5 = dropkick.screenCount5
        dropkickMemory2.screenCount6 = dropkick.screenCount6
        dropkickMemory2.screenCount7 = dropkick.screenCount7
        dropkickMemory2.screenCount8 = dropkick.screenCount8
        dropkickMemory2.screenCount9 = dropkick.screenCount9
        dropkickMemory2.screenCount10 = dropkick.screenCount10
        dropkickMemory2.screenCount11 = dropkick.screenCount11
        dropkickMemory2.screenCountSum = dropkick.screenCountSum
        dropkickMemory2.charaCount1 = dropkick.charaCount1
        dropkickMemory2.charaCount2 = dropkick.charaCount2
        dropkickMemory2.charaCount3 = dropkick.charaCount3
        dropkickMemory2.charaCount4 = dropkick.charaCount4
        dropkickMemory2.charaCount5 = dropkick.charaCount5
        dropkickMemory2.charaCount6 = dropkick.charaCount6
        dropkickMemory2.charaCount7 = dropkick.charaCount7
        dropkickMemory2.charaCount8 = dropkick.charaCount8
        dropkickMemory2.charaCount9 = dropkick.charaCount9
        dropkickMemory2.charaCount10 = dropkick.charaCount10
        dropkickMemory2.charaCount11 = dropkick.charaCount11
        dropkickMemory2.charaCount12 = dropkick.charaCount12
        dropkickMemory2.charaCountSum = dropkick.charaCountSum
        dropkickMemory2.tucSealCount1 = dropkick.tucSealCount1
        dropkickMemory2.tucSealCount2 = dropkick.tucSealCount2
        dropkickMemory2.tucSealCount3 = dropkick.tucSealCount3
        dropkickMemory2.tucSealCount4 = dropkick.tucSealCount4
        dropkickMemory2.tucSealCount5 = dropkick.tucSealCount5
        dropkickMemory2.tucSealCount6 = dropkick.tucSealCount6
        dropkickMemory2.tucSealCount7 = dropkick.tucSealCount7
        dropkickMemory2.tucSealCountSum = dropkick.tucSealCountSum
    }
    func saveMemory3() {
        dropkickMemory3.ptMigisagari = dropkick.ptMigisagari
        dropkickMemory3.ptUpper = dropkick.ptUpper
        dropkickMemory3.ptMiddle = dropkick.ptMiddle
        dropkickMemory3.ptLower = dropkick.ptLower
        dropkickMemory3.ptMigiagari = dropkick.ptMigiagari
        dropkickMemory3.normalGame = dropkick.normalGame
        dropkickMemory3.firstHitCountBonus = dropkick.firstHitCountBonus
        dropkickMemory3.firstHitCountAt = dropkick.firstHitCountAt
        dropkickMemory3.screenCount1 = dropkick.screenCount1
        dropkickMemory3.screenCount2 = dropkick.screenCount2
        dropkickMemory3.screenCount3 = dropkick.screenCount3
        dropkickMemory3.screenCount4 = dropkick.screenCount4
        dropkickMemory3.screenCount5 = dropkick.screenCount5
        dropkickMemory3.screenCount6 = dropkick.screenCount6
        dropkickMemory3.screenCount7 = dropkick.screenCount7
        dropkickMemory3.screenCount8 = dropkick.screenCount8
        dropkickMemory3.screenCount9 = dropkick.screenCount9
        dropkickMemory3.screenCount10 = dropkick.screenCount10
        dropkickMemory3.screenCount11 = dropkick.screenCount11
        dropkickMemory3.screenCountSum = dropkick.screenCountSum
        dropkickMemory3.charaCount1 = dropkick.charaCount1
        dropkickMemory3.charaCount2 = dropkick.charaCount2
        dropkickMemory3.charaCount3 = dropkick.charaCount3
        dropkickMemory3.charaCount4 = dropkick.charaCount4
        dropkickMemory3.charaCount5 = dropkick.charaCount5
        dropkickMemory3.charaCount6 = dropkick.charaCount6
        dropkickMemory3.charaCount7 = dropkick.charaCount7
        dropkickMemory3.charaCount8 = dropkick.charaCount8
        dropkickMemory3.charaCount9 = dropkick.charaCount9
        dropkickMemory3.charaCount10 = dropkick.charaCount10
        dropkickMemory3.charaCount11 = dropkick.charaCount11
        dropkickMemory3.charaCount12 = dropkick.charaCount12
        dropkickMemory3.charaCountSum = dropkick.charaCountSum
        dropkickMemory3.tucSealCount1 = dropkick.tucSealCount1
        dropkickMemory3.tucSealCount2 = dropkick.tucSealCount2
        dropkickMemory3.tucSealCount3 = dropkick.tucSealCount3
        dropkickMemory3.tucSealCount4 = dropkick.tucSealCount4
        dropkickMemory3.tucSealCount5 = dropkick.tucSealCount5
        dropkickMemory3.tucSealCount6 = dropkick.tucSealCount6
        dropkickMemory3.tucSealCount7 = dropkick.tucSealCount7
        dropkickMemory3.tucSealCountSum = dropkick.tucSealCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct dropkickSubViewLoadMemory: View {
    @ObservedObject var dropkick: Dropkick
    @ObservedObject var dropkickMemory1: DropkickMemory1
    @ObservedObject var dropkickMemory2: DropkickMemory2
    @ObservedObject var dropkickMemory3: DropkickMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: dropkick.machineName,
            selectedMemory: $dropkick.selectedMemory,
            memoMemory1: dropkickMemory1.memo,
            dateDoubleMemory1: dropkickMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: dropkickMemory2.memo,
            dateDoubleMemory2: dropkickMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: dropkickMemory3.memo,
            dateDoubleMemory3: dropkickMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        dropkick.ptMigisagari = dropkickMemory1.ptMigisagari
        dropkick.ptUpper = dropkickMemory1.ptUpper
        dropkick.ptMiddle = dropkickMemory1.ptMiddle
        dropkick.ptLower = dropkickMemory1.ptLower
        dropkick.ptMigiagari = dropkickMemory1.ptMigiagari
        dropkick.normalGame = dropkickMemory1.normalGame
        dropkick.firstHitCountBonus = dropkickMemory1.firstHitCountBonus
        dropkick.firstHitCountAt = dropkickMemory1.firstHitCountAt
        dropkick.screenCount1 = dropkickMemory1.screenCount1
        dropkick.screenCount2 = dropkickMemory1.screenCount2
        dropkick.screenCount3 = dropkickMemory1.screenCount3
        dropkick.screenCount4 = dropkickMemory1.screenCount4
        dropkick.screenCount5 = dropkickMemory1.screenCount5
        dropkick.screenCount6 = dropkickMemory1.screenCount6
        dropkick.screenCount7 = dropkickMemory1.screenCount7
        dropkick.screenCount8 = dropkickMemory1.screenCount8
        dropkick.screenCount9 = dropkickMemory1.screenCount9
        dropkick.screenCount10 = dropkickMemory1.screenCount10
        dropkick.screenCount11 = dropkickMemory1.screenCount11
        dropkick.screenCountSum = dropkickMemory1.screenCountSum
        dropkick.charaCount1 = dropkickMemory1.charaCount1
        dropkick.charaCount2 = dropkickMemory1.charaCount2
        dropkick.charaCount3 = dropkickMemory1.charaCount3
        dropkick.charaCount4 = dropkickMemory1.charaCount4
        dropkick.charaCount5 = dropkickMemory1.charaCount5
        dropkick.charaCount6 = dropkickMemory1.charaCount6
        dropkick.charaCount7 = dropkickMemory1.charaCount7
        dropkick.charaCount8 = dropkickMemory1.charaCount8
        dropkick.charaCount9 = dropkickMemory1.charaCount9
        dropkick.charaCount10 = dropkickMemory1.charaCount10
        dropkick.charaCount11 = dropkickMemory1.charaCount11
        dropkick.charaCount12 = dropkickMemory1.charaCount12
        dropkick.charaCountSum = dropkickMemory1.charaCountSum
        dropkick.tucSealCount1 = dropkickMemory1.tucSealCount1
        dropkick.tucSealCount2 = dropkickMemory1.tucSealCount2
        dropkick.tucSealCount3 = dropkickMemory1.tucSealCount3
        dropkick.tucSealCount4 = dropkickMemory1.tucSealCount4
        dropkick.tucSealCount5 = dropkickMemory1.tucSealCount5
        dropkick.tucSealCount6 = dropkickMemory1.tucSealCount6
        dropkick.tucSealCount7 = dropkickMemory1.tucSealCount7
        dropkick.tucSealCountSum = dropkickMemory1.tucSealCountSum
    }
    func loadMemory2() {
        dropkick.ptMigisagari = dropkickMemory2.ptMigisagari
        dropkick.ptUpper = dropkickMemory2.ptUpper
        dropkick.ptMiddle = dropkickMemory2.ptMiddle
        dropkick.ptLower = dropkickMemory2.ptLower
        dropkick.ptMigiagari = dropkickMemory2.ptMigiagari
        dropkick.normalGame = dropkickMemory2.normalGame
        dropkick.firstHitCountBonus = dropkickMemory2.firstHitCountBonus
        dropkick.firstHitCountAt = dropkickMemory2.firstHitCountAt
        dropkick.screenCount1 = dropkickMemory2.screenCount1
        dropkick.screenCount2 = dropkickMemory2.screenCount2
        dropkick.screenCount3 = dropkickMemory2.screenCount3
        dropkick.screenCount4 = dropkickMemory2.screenCount4
        dropkick.screenCount5 = dropkickMemory2.screenCount5
        dropkick.screenCount6 = dropkickMemory2.screenCount6
        dropkick.screenCount7 = dropkickMemory2.screenCount7
        dropkick.screenCount8 = dropkickMemory2.screenCount8
        dropkick.screenCount9 = dropkickMemory2.screenCount9
        dropkick.screenCount10 = dropkickMemory2.screenCount10
        dropkick.screenCount11 = dropkickMemory2.screenCount11
        dropkick.screenCountSum = dropkickMemory2.screenCountSum
        dropkick.charaCount1 = dropkickMemory2.charaCount1
        dropkick.charaCount2 = dropkickMemory2.charaCount2
        dropkick.charaCount3 = dropkickMemory2.charaCount3
        dropkick.charaCount4 = dropkickMemory2.charaCount4
        dropkick.charaCount5 = dropkickMemory2.charaCount5
        dropkick.charaCount6 = dropkickMemory2.charaCount6
        dropkick.charaCount7 = dropkickMemory2.charaCount7
        dropkick.charaCount8 = dropkickMemory2.charaCount8
        dropkick.charaCount9 = dropkickMemory2.charaCount9
        dropkick.charaCount10 = dropkickMemory2.charaCount10
        dropkick.charaCount11 = dropkickMemory2.charaCount11
        dropkick.charaCount12 = dropkickMemory2.charaCount12
        dropkick.charaCountSum = dropkickMemory2.charaCountSum
        dropkick.tucSealCount1 = dropkickMemory2.tucSealCount1
        dropkick.tucSealCount2 = dropkickMemory2.tucSealCount2
        dropkick.tucSealCount3 = dropkickMemory2.tucSealCount3
        dropkick.tucSealCount4 = dropkickMemory2.tucSealCount4
        dropkick.tucSealCount5 = dropkickMemory2.tucSealCount5
        dropkick.tucSealCount6 = dropkickMemory2.tucSealCount6
        dropkick.tucSealCount7 = dropkickMemory2.tucSealCount7
        dropkick.tucSealCountSum = dropkickMemory2.tucSealCountSum
    }
    func loadMemory3() {
        dropkick.ptMigisagari = dropkickMemory3.ptMigisagari
        dropkick.ptUpper = dropkickMemory3.ptUpper
        dropkick.ptMiddle = dropkickMemory3.ptMiddle
        dropkick.ptLower = dropkickMemory3.ptLower
        dropkick.ptMigiagari = dropkickMemory3.ptMigiagari
        dropkick.normalGame = dropkickMemory3.normalGame
        dropkick.firstHitCountBonus = dropkickMemory3.firstHitCountBonus
        dropkick.firstHitCountAt = dropkickMemory3.firstHitCountAt
        dropkick.screenCount1 = dropkickMemory3.screenCount1
        dropkick.screenCount2 = dropkickMemory3.screenCount2
        dropkick.screenCount3 = dropkickMemory3.screenCount3
        dropkick.screenCount4 = dropkickMemory3.screenCount4
        dropkick.screenCount5 = dropkickMemory3.screenCount5
        dropkick.screenCount6 = dropkickMemory3.screenCount6
        dropkick.screenCount7 = dropkickMemory3.screenCount7
        dropkick.screenCount8 = dropkickMemory3.screenCount8
        dropkick.screenCount9 = dropkickMemory3.screenCount9
        dropkick.screenCount10 = dropkickMemory3.screenCount10
        dropkick.screenCount11 = dropkickMemory3.screenCount11
        dropkick.screenCountSum = dropkickMemory3.screenCountSum
        dropkick.charaCount1 = dropkickMemory3.charaCount1
        dropkick.charaCount2 = dropkickMemory3.charaCount2
        dropkick.charaCount3 = dropkickMemory3.charaCount3
        dropkick.charaCount4 = dropkickMemory3.charaCount4
        dropkick.charaCount5 = dropkickMemory3.charaCount5
        dropkick.charaCount6 = dropkickMemory3.charaCount6
        dropkick.charaCount7 = dropkickMemory3.charaCount7
        dropkick.charaCount8 = dropkickMemory3.charaCount8
        dropkick.charaCount9 = dropkickMemory3.charaCount9
        dropkick.charaCount10 = dropkickMemory3.charaCount10
        dropkick.charaCount11 = dropkickMemory3.charaCount11
        dropkick.charaCount12 = dropkickMemory3.charaCount12
        dropkick.charaCountSum = dropkickMemory3.charaCountSum
        dropkick.tucSealCount1 = dropkickMemory3.tucSealCount1
        dropkick.tucSealCount2 = dropkickMemory3.tucSealCount2
        dropkick.tucSealCount3 = dropkickMemory3.tucSealCount3
        dropkick.tucSealCount4 = dropkickMemory3.tucSealCount4
        dropkick.tucSealCount5 = dropkickMemory3.tucSealCount5
        dropkick.tucSealCount6 = dropkickMemory3.tucSealCount6
        dropkick.tucSealCount7 = dropkickMemory3.tucSealCount7
        dropkick.tucSealCountSum = dropkickMemory3.tucSealCountSum
    }
}

#Preview {
    dropkickViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
