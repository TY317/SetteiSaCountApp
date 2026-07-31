//
//  kerottoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct kerottoViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var kerotto = Kerotto()
    @State var isShowAlert: Bool = false
    @StateObject var kerottoMemory1 = KerottoMemory1()
    @StateObject var kerottoMemory2 = KerottoMemory2()
    @StateObject var kerottoMemory3 = KerottoMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("スロプラNEXTの利用を前提としています\n遊技前にスロプラNEXTを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: kerotto.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: kerottoViewNormal(
                        kerotto: kerotto,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.kerottoMenuNormalBadge,
                        )
                    }

                    // ボーナス確定画面
                    NavigationLink(destination: kerottoViewBonusScreen(
                        kerotto: kerotto,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス確定画面",
                            badgeStatus: common.kerottoMenuBonusScreenBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: kerottoViewFirstHit(
                        kerotto: kerotto,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.kerottoMenuFirstHitBadge,
                        )
                    }

                    // REG中
                    NavigationLink(destination: kerottoViewReg(
                        kerotto: kerotto,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "REG中",
                            badgeStatus: common.kerottoMenuRegBadge,
                        )
                    }

                    // BIG終了画面
                    NavigationLink(destination: kerottoViewBigScreen(
                        kerotto: kerotto,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "BIG終了画面",
                            badgeStatus: common.kerottoMenuBigScreenBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewKerottoTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ケロットトロフィー"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: kerotto.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: kerottoView95Ci(
                    kerotto: kerotto,
                    selection: 5,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: kerottoViewBayes(
                    kerotto: kerotto,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.kerottoMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5015")

                // コピーライト
                unitSectionCopyright {
                    Text("©YAMASA")
                    Text("©YAMASA NEXT")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5015")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kerotto.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(kerottoSubViewLoadMemory(
                    kerotto: kerotto,
                    kerottoMemory1: kerottoMemory1,
                    kerottoMemory2: kerottoMemory2,
                    kerottoMemory3: kerottoMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(kerottoSubViewSaveMemory(
                    kerotto: kerotto,
                    kerottoMemory1: kerottoMemory1,
                    kerottoMemory2: kerottoMemory2,
                    kerottoMemory3: kerottoMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: kerotto.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct kerottoSubViewSaveMemory: View {
    @ObservedObject var kerotto: Kerotto
    @ObservedObject var kerottoMemory1: KerottoMemory1
    @ObservedObject var kerottoMemory2: KerottoMemory2
    @ObservedObject var kerottoMemory3: KerottoMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: kerotto.machineName,
            selectedMemory: $kerotto.selectedMemory,
            memoMemory1: $kerottoMemory1.memo,
            dateDoubleMemory1: $kerottoMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $kerottoMemory2.memo,
            dateDoubleMemory2: $kerottoMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $kerottoMemory3.memo,
            dateDoubleMemory3: $kerottoMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        kerottoMemory1.koyakuCountHeikoOrange = kerotto.koyakuCountHeikoOrange
        kerottoMemory1.koyakuCountNanameOrange = kerotto.koyakuCountNanameOrange
        kerottoMemory1.chofukuCountHeikoOrange = kerotto.chofukuCountHeikoOrange
        kerottoMemory1.chofukuCountNanameOrange = kerotto.chofukuCountNanameOrange
        kerottoMemory1.gameNumberStart = kerotto.gameNumberStart
        kerottoMemory1.gameNumberCurrent = kerotto.gameNumberCurrent
        kerottoMemory1.gameNumberPlay = kerotto.gameNumberPlay
        kerottoMemory1.firstHitCountWSBB = kerotto.firstHitCountWSBB
        kerottoMemory1.firstHitCountRSBB = kerotto.firstHitCountRSBB
        kerottoMemory1.firstHitCountWBB = kerotto.firstHitCountWBB
        kerottoMemory1.firstHitCountRBB = kerotto.firstHitCountRBB
        kerottoMemory1.firstHitCountWREG = kerotto.firstHitCountWREG
        kerottoMemory1.firstHitCountRREG = kerotto.firstHitCountRREG
        kerottoMemory1.firstHitCountAllSum = kerotto.firstHitCountAllSum
        kerottoMemory1.firstHitCountWSum = kerotto.firstHitCountWSum
        kerottoMemory1.firstHitCountRSum = kerotto.firstHitCountRSum
        kerottoMemory1.firstHitCountSBBSum = kerotto.firstHitCountSBBSum
        kerottoMemory1.firstHitCountBBSum = kerotto.firstHitCountBBSum
        kerottoMemory1.firstHitCountREGSum = kerotto.firstHitCountREGSum
        kerottoMemory1.screenCount1 = kerotto.screenCount1
        kerottoMemory1.screenCount2 = kerotto.screenCount2
        kerottoMemory1.screenCount3 = kerotto.screenCount3
        kerottoMemory1.screenCount4 = kerotto.screenCount4
        kerottoMemory1.screenCount5 = kerotto.screenCount5
        kerottoMemory1.screenCount6 = kerotto.screenCount6
        kerottoMemory1.screenCount7 = kerotto.screenCount7
        kerottoMemory1.screenCountSum = kerotto.screenCountSum
        kerottoMemory1.bonusScreenCount1 = kerotto.bonusScreenCount1
        kerottoMemory1.bonusScreenCount2 = kerotto.bonusScreenCount2
        kerottoMemory1.bonusScreenCount3 = kerotto.bonusScreenCount3
        kerottoMemory1.bonusScreenCountSum = kerotto.bonusScreenCountSum
        kerottoMemory1.cutinCount1 = kerotto.cutinCount1
        kerottoMemory1.cutinCount2 = kerotto.cutinCount2
        kerottoMemory1.cutinCount3 = kerotto.cutinCount3
        kerottoMemory1.cutinCount4 = kerotto.cutinCount4
        kerottoMemory1.cutinCount5 = kerotto.cutinCount5
        kerottoMemory1.cutinCountSum = kerotto.cutinCountSum
    }
    func saveMemory2() {
        kerottoMemory2.koyakuCountHeikoOrange = kerotto.koyakuCountHeikoOrange
        kerottoMemory2.koyakuCountNanameOrange = kerotto.koyakuCountNanameOrange
        kerottoMemory2.chofukuCountHeikoOrange = kerotto.chofukuCountHeikoOrange
        kerottoMemory2.chofukuCountNanameOrange = kerotto.chofukuCountNanameOrange
        kerottoMemory2.gameNumberStart = kerotto.gameNumberStart
        kerottoMemory2.gameNumberCurrent = kerotto.gameNumberCurrent
        kerottoMemory2.gameNumberPlay = kerotto.gameNumberPlay
        kerottoMemory2.firstHitCountWSBB = kerotto.firstHitCountWSBB
        kerottoMemory2.firstHitCountRSBB = kerotto.firstHitCountRSBB
        kerottoMemory2.firstHitCountWBB = kerotto.firstHitCountWBB
        kerottoMemory2.firstHitCountRBB = kerotto.firstHitCountRBB
        kerottoMemory2.firstHitCountWREG = kerotto.firstHitCountWREG
        kerottoMemory2.firstHitCountRREG = kerotto.firstHitCountRREG
        kerottoMemory2.firstHitCountAllSum = kerotto.firstHitCountAllSum
        kerottoMemory2.firstHitCountWSum = kerotto.firstHitCountWSum
        kerottoMemory2.firstHitCountRSum = kerotto.firstHitCountRSum
        kerottoMemory2.firstHitCountSBBSum = kerotto.firstHitCountSBBSum
        kerottoMemory2.firstHitCountBBSum = kerotto.firstHitCountBBSum
        kerottoMemory2.firstHitCountREGSum = kerotto.firstHitCountREGSum
        kerottoMemory2.screenCount1 = kerotto.screenCount1
        kerottoMemory2.screenCount2 = kerotto.screenCount2
        kerottoMemory2.screenCount3 = kerotto.screenCount3
        kerottoMemory2.screenCount4 = kerotto.screenCount4
        kerottoMemory2.screenCount5 = kerotto.screenCount5
        kerottoMemory2.screenCount6 = kerotto.screenCount6
        kerottoMemory2.screenCount7 = kerotto.screenCount7
        kerottoMemory2.screenCountSum = kerotto.screenCountSum
        kerottoMemory2.bonusScreenCount1 = kerotto.bonusScreenCount1
        kerottoMemory2.bonusScreenCount2 = kerotto.bonusScreenCount2
        kerottoMemory2.bonusScreenCount3 = kerotto.bonusScreenCount3
        kerottoMemory2.bonusScreenCountSum = kerotto.bonusScreenCountSum
        kerottoMemory2.cutinCount1 = kerotto.cutinCount1
        kerottoMemory2.cutinCount2 = kerotto.cutinCount2
        kerottoMemory2.cutinCount3 = kerotto.cutinCount3
        kerottoMemory2.cutinCount4 = kerotto.cutinCount4
        kerottoMemory2.cutinCount5 = kerotto.cutinCount5
        kerottoMemory2.cutinCountSum = kerotto.cutinCountSum
    }
    func saveMemory3() {
        kerottoMemory3.koyakuCountHeikoOrange = kerotto.koyakuCountHeikoOrange
        kerottoMemory3.koyakuCountNanameOrange = kerotto.koyakuCountNanameOrange
        kerottoMemory3.chofukuCountHeikoOrange = kerotto.chofukuCountHeikoOrange
        kerottoMemory3.chofukuCountNanameOrange = kerotto.chofukuCountNanameOrange
        kerottoMemory3.gameNumberStart = kerotto.gameNumberStart
        kerottoMemory3.gameNumberCurrent = kerotto.gameNumberCurrent
        kerottoMemory3.gameNumberPlay = kerotto.gameNumberPlay
        kerottoMemory3.firstHitCountWSBB = kerotto.firstHitCountWSBB
        kerottoMemory3.firstHitCountRSBB = kerotto.firstHitCountRSBB
        kerottoMemory3.firstHitCountWBB = kerotto.firstHitCountWBB
        kerottoMemory3.firstHitCountRBB = kerotto.firstHitCountRBB
        kerottoMemory3.firstHitCountWREG = kerotto.firstHitCountWREG
        kerottoMemory3.firstHitCountRREG = kerotto.firstHitCountRREG
        kerottoMemory3.firstHitCountAllSum = kerotto.firstHitCountAllSum
        kerottoMemory3.firstHitCountWSum = kerotto.firstHitCountWSum
        kerottoMemory3.firstHitCountRSum = kerotto.firstHitCountRSum
        kerottoMemory3.firstHitCountSBBSum = kerotto.firstHitCountSBBSum
        kerottoMemory3.firstHitCountBBSum = kerotto.firstHitCountBBSum
        kerottoMemory3.firstHitCountREGSum = kerotto.firstHitCountREGSum
        kerottoMemory3.screenCount1 = kerotto.screenCount1
        kerottoMemory3.screenCount2 = kerotto.screenCount2
        kerottoMemory3.screenCount3 = kerotto.screenCount3
        kerottoMemory3.screenCount4 = kerotto.screenCount4
        kerottoMemory3.screenCount5 = kerotto.screenCount5
        kerottoMemory3.screenCount6 = kerotto.screenCount6
        kerottoMemory3.screenCount7 = kerotto.screenCount7
        kerottoMemory3.screenCountSum = kerotto.screenCountSum
        kerottoMemory3.bonusScreenCount1 = kerotto.bonusScreenCount1
        kerottoMemory3.bonusScreenCount2 = kerotto.bonusScreenCount2
        kerottoMemory3.bonusScreenCount3 = kerotto.bonusScreenCount3
        kerottoMemory3.bonusScreenCountSum = kerotto.bonusScreenCountSum
        kerottoMemory3.cutinCount1 = kerotto.cutinCount1
        kerottoMemory3.cutinCount2 = kerotto.cutinCount2
        kerottoMemory3.cutinCount3 = kerotto.cutinCount3
        kerottoMemory3.cutinCount4 = kerotto.cutinCount4
        kerottoMemory3.cutinCount5 = kerotto.cutinCount5
        kerottoMemory3.cutinCountSum = kerotto.cutinCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct kerottoSubViewLoadMemory: View {
    @ObservedObject var kerotto: Kerotto
    @ObservedObject var kerottoMemory1: KerottoMemory1
    @ObservedObject var kerottoMemory2: KerottoMemory2
    @ObservedObject var kerottoMemory3: KerottoMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: kerotto.machineName,
            selectedMemory: $kerotto.selectedMemory,
            memoMemory1: kerottoMemory1.memo,
            dateDoubleMemory1: kerottoMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: kerottoMemory2.memo,
            dateDoubleMemory2: kerottoMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: kerottoMemory3.memo,
            dateDoubleMemory3: kerottoMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        kerotto.koyakuCountHeikoOrange = kerottoMemory1.koyakuCountHeikoOrange
        kerotto.koyakuCountNanameOrange = kerottoMemory1.koyakuCountNanameOrange
        kerotto.chofukuCountHeikoOrange = kerottoMemory1.chofukuCountHeikoOrange
        kerotto.chofukuCountNanameOrange = kerottoMemory1.chofukuCountNanameOrange
        kerotto.gameNumberStart = kerottoMemory1.gameNumberStart
        kerotto.gameNumberCurrent = kerottoMemory1.gameNumberCurrent
        kerotto.gameNumberPlay = kerottoMemory1.gameNumberPlay
        kerotto.firstHitCountWSBB = kerottoMemory1.firstHitCountWSBB
        kerotto.firstHitCountRSBB = kerottoMemory1.firstHitCountRSBB
        kerotto.firstHitCountWBB = kerottoMemory1.firstHitCountWBB
        kerotto.firstHitCountRBB = kerottoMemory1.firstHitCountRBB
        kerotto.firstHitCountWREG = kerottoMemory1.firstHitCountWREG
        kerotto.firstHitCountRREG = kerottoMemory1.firstHitCountRREG
        kerotto.firstHitCountAllSum = kerottoMemory1.firstHitCountAllSum
        kerotto.firstHitCountWSum = kerottoMemory1.firstHitCountWSum
        kerotto.firstHitCountRSum = kerottoMemory1.firstHitCountRSum
        kerotto.firstHitCountSBBSum = kerottoMemory1.firstHitCountSBBSum
        kerotto.firstHitCountBBSum = kerottoMemory1.firstHitCountBBSum
        kerotto.firstHitCountREGSum = kerottoMemory1.firstHitCountREGSum
        kerotto.screenCount1 = kerottoMemory1.screenCount1
        kerotto.screenCount2 = kerottoMemory1.screenCount2
        kerotto.screenCount3 = kerottoMemory1.screenCount3
        kerotto.screenCount4 = kerottoMemory1.screenCount4
        kerotto.screenCount5 = kerottoMemory1.screenCount5
        kerotto.screenCount6 = kerottoMemory1.screenCount6
        kerotto.screenCount7 = kerottoMemory1.screenCount7
        kerotto.screenCountSum = kerottoMemory1.screenCountSum
        kerotto.bonusScreenCount1 = kerottoMemory1.bonusScreenCount1
        kerotto.bonusScreenCount2 = kerottoMemory1.bonusScreenCount2
        kerotto.bonusScreenCount3 = kerottoMemory1.bonusScreenCount3
        kerotto.bonusScreenCountSum = kerottoMemory1.bonusScreenCountSum
        kerotto.cutinCount1 = kerottoMemory1.cutinCount1
        kerotto.cutinCount2 = kerottoMemory1.cutinCount2
        kerotto.cutinCount3 = kerottoMemory1.cutinCount3
        kerotto.cutinCount4 = kerottoMemory1.cutinCount4
        kerotto.cutinCount5 = kerottoMemory1.cutinCount5
        kerotto.cutinCountSum = kerottoMemory1.cutinCountSum
    }
    func loadMemory2() {
        kerotto.koyakuCountHeikoOrange = kerottoMemory2.koyakuCountHeikoOrange
        kerotto.koyakuCountNanameOrange = kerottoMemory2.koyakuCountNanameOrange
        kerotto.chofukuCountHeikoOrange = kerottoMemory2.chofukuCountHeikoOrange
        kerotto.chofukuCountNanameOrange = kerottoMemory2.chofukuCountNanameOrange
        kerotto.gameNumberStart = kerottoMemory2.gameNumberStart
        kerotto.gameNumberCurrent = kerottoMemory2.gameNumberCurrent
        kerotto.gameNumberPlay = kerottoMemory2.gameNumberPlay
        kerotto.firstHitCountWSBB = kerottoMemory2.firstHitCountWSBB
        kerotto.firstHitCountRSBB = kerottoMemory2.firstHitCountRSBB
        kerotto.firstHitCountWBB = kerottoMemory2.firstHitCountWBB
        kerotto.firstHitCountRBB = kerottoMemory2.firstHitCountRBB
        kerotto.firstHitCountWREG = kerottoMemory2.firstHitCountWREG
        kerotto.firstHitCountRREG = kerottoMemory2.firstHitCountRREG
        kerotto.firstHitCountAllSum = kerottoMemory2.firstHitCountAllSum
        kerotto.firstHitCountWSum = kerottoMemory2.firstHitCountWSum
        kerotto.firstHitCountRSum = kerottoMemory2.firstHitCountRSum
        kerotto.firstHitCountSBBSum = kerottoMemory2.firstHitCountSBBSum
        kerotto.firstHitCountBBSum = kerottoMemory2.firstHitCountBBSum
        kerotto.firstHitCountREGSum = kerottoMemory2.firstHitCountREGSum
        kerotto.screenCount1 = kerottoMemory2.screenCount1
        kerotto.screenCount2 = kerottoMemory2.screenCount2
        kerotto.screenCount3 = kerottoMemory2.screenCount3
        kerotto.screenCount4 = kerottoMemory2.screenCount4
        kerotto.screenCount5 = kerottoMemory2.screenCount5
        kerotto.screenCount6 = kerottoMemory2.screenCount6
        kerotto.screenCount7 = kerottoMemory2.screenCount7
        kerotto.screenCountSum = kerottoMemory2.screenCountSum
        kerotto.bonusScreenCount1 = kerottoMemory2.bonusScreenCount1
        kerotto.bonusScreenCount2 = kerottoMemory2.bonusScreenCount2
        kerotto.bonusScreenCount3 = kerottoMemory2.bonusScreenCount3
        kerotto.bonusScreenCountSum = kerottoMemory2.bonusScreenCountSum
        kerotto.cutinCount1 = kerottoMemory2.cutinCount1
        kerotto.cutinCount2 = kerottoMemory2.cutinCount2
        kerotto.cutinCount3 = kerottoMemory2.cutinCount3
        kerotto.cutinCount4 = kerottoMemory2.cutinCount4
        kerotto.cutinCount5 = kerottoMemory2.cutinCount5
        kerotto.cutinCountSum = kerottoMemory2.cutinCountSum
    }
    func loadMemory3() {
        kerotto.koyakuCountHeikoOrange = kerottoMemory3.koyakuCountHeikoOrange
        kerotto.koyakuCountNanameOrange = kerottoMemory3.koyakuCountNanameOrange
        kerotto.chofukuCountHeikoOrange = kerottoMemory3.chofukuCountHeikoOrange
        kerotto.chofukuCountNanameOrange = kerottoMemory3.chofukuCountNanameOrange
        kerotto.gameNumberStart = kerottoMemory3.gameNumberStart
        kerotto.gameNumberCurrent = kerottoMemory3.gameNumberCurrent
        kerotto.gameNumberPlay = kerottoMemory3.gameNumberPlay
        kerotto.firstHitCountWSBB = kerottoMemory3.firstHitCountWSBB
        kerotto.firstHitCountRSBB = kerottoMemory3.firstHitCountRSBB
        kerotto.firstHitCountWBB = kerottoMemory3.firstHitCountWBB
        kerotto.firstHitCountRBB = kerottoMemory3.firstHitCountRBB
        kerotto.firstHitCountWREG = kerottoMemory3.firstHitCountWREG
        kerotto.firstHitCountRREG = kerottoMemory3.firstHitCountRREG
        kerotto.firstHitCountAllSum = kerottoMemory3.firstHitCountAllSum
        kerotto.firstHitCountWSum = kerottoMemory3.firstHitCountWSum
        kerotto.firstHitCountRSum = kerottoMemory3.firstHitCountRSum
        kerotto.firstHitCountSBBSum = kerottoMemory3.firstHitCountSBBSum
        kerotto.firstHitCountBBSum = kerottoMemory3.firstHitCountBBSum
        kerotto.firstHitCountREGSum = kerottoMemory3.firstHitCountREGSum
        kerotto.screenCount1 = kerottoMemory3.screenCount1
        kerotto.screenCount2 = kerottoMemory3.screenCount2
        kerotto.screenCount3 = kerottoMemory3.screenCount3
        kerotto.screenCount4 = kerottoMemory3.screenCount4
        kerotto.screenCount5 = kerottoMemory3.screenCount5
        kerotto.screenCount6 = kerottoMemory3.screenCount6
        kerotto.screenCount7 = kerottoMemory3.screenCount7
        kerotto.screenCountSum = kerottoMemory3.screenCountSum
        kerotto.bonusScreenCount1 = kerottoMemory3.bonusScreenCount1
        kerotto.bonusScreenCount2 = kerottoMemory3.bonusScreenCount2
        kerotto.bonusScreenCount3 = kerottoMemory3.bonusScreenCount3
        kerotto.bonusScreenCountSum = kerottoMemory3.bonusScreenCountSum
        kerotto.cutinCount1 = kerottoMemory3.cutinCount1
        kerotto.cutinCount2 = kerottoMemory3.cutinCount2
        kerotto.cutinCount3 = kerottoMemory3.cutinCount3
        kerotto.cutinCount4 = kerottoMemory3.cutinCount4
        kerotto.cutinCount5 = kerottoMemory3.cutinCount5
        kerotto.cutinCountSum = kerottoMemory3.cutinCountSum
    }
}

#Preview {
    kerottoViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
