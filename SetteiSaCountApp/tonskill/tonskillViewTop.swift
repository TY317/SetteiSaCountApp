//
//  tonskillViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct tonskillViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var tonskill = Tonskill()
    @State var isShowAlert: Bool = false
    @StateObject var tonskillMemory1 = TonskillMemory1()
    @StateObject var tonskillMemory2 = TonskillMemory2()
    @StateObject var tonskillMemory3 = TonskillMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("e-slot+の利用を前提としています\n遊技前にe-slot+を開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: tonskill.machineName,
                        titleFont: .title2
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: tonskillViewNormal(
                        tonskill: tonskill,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.tonskillMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: tonskillViewFirstHit(
                        tonskill: tonskill,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.tonskillMenuFirstHitBadge,
                        )
                    }

                    // 終了画面
                    NavigationLink(destination: tonskillViewScreen(
                        tonskill: tonskill,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: common.tonskillMenuScreenBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: tonskillViewEnding(
                        tonskill: tonskill,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.tonskillMenuEndingBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewArisuTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "アリストロフィー"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: tonskill.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: tonskillView95Ci(
                    tonskill: tonskill,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: tonskillViewBayes(
                    tonskill: tonskill,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.tonskillMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5030")

                // コピーライト
                unitSectionCopyright {
                    Text("©江口連・オーバーラップ／MAPPA／とんでもスキル")
                    Text("©Konami Amusement")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5030")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tonskill.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(tonskillSubViewLoadMemory(
                    tonskill: tonskill,
                    tonskillMemory1: tonskillMemory1,
                    tonskillMemory2: tonskillMemory2,
                    tonskillMemory3: tonskillMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(tonskillSubViewSaveMemory(
                    tonskill: tonskill,
                    tonskillMemory1: tonskillMemory1,
                    tonskillMemory2: tonskillMemory2,
                    tonskillMemory3: tonskillMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: tonskill.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct tonskillSubViewSaveMemory: View {
    @ObservedObject var tonskill: Tonskill
    @ObservedObject var tonskillMemory1: TonskillMemory1
    @ObservedObject var tonskillMemory2: TonskillMemory2
    @ObservedObject var tonskillMemory3: TonskillMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: tonskill.machineName,
            selectedMemory: $tonskill.selectedMemory,
            memoMemory1: $tonskillMemory1.memo,
            dateDoubleMemory1: $tonskillMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $tonskillMemory2.memo,
            dateDoubleMemory2: $tonskillMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $tonskillMemory3.memo,
            dateDoubleMemory3: $tonskillMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        tonskillMemory1.ptSui = tonskill.ptSui
        tonskillMemory1.ptMukoda = tonskill.ptMukoda
        tonskillMemory1.ptFeru = tonskill.ptFeru
        tonskillMemory1.normalGame = tonskill.normalGame
        tonskillMemory1.firstHitCountCz = tonskill.firstHitCountCz
        tonskillMemory1.firstHitCountBonus = tonskill.firstHitCountBonus
        tonskillMemory1.endingCount1 = tonskill.endingCount1
        tonskillMemory1.endingCount2 = tonskill.endingCount2
        tonskillMemory1.endingCount3 = tonskill.endingCount3
        tonskillMemory1.endingCount4 = tonskill.endingCount4
        tonskillMemory1.endingCount5 = tonskill.endingCount5
        tonskillMemory1.endingCount6 = tonskill.endingCount6
        tonskillMemory1.endingCountSum = tonskill.endingCountSum
    }
    func saveMemory2() {
        tonskillMemory2.ptSui = tonskill.ptSui
        tonskillMemory2.ptMukoda = tonskill.ptMukoda
        tonskillMemory2.ptFeru = tonskill.ptFeru
        tonskillMemory2.normalGame = tonskill.normalGame
        tonskillMemory2.firstHitCountCz = tonskill.firstHitCountCz
        tonskillMemory2.firstHitCountBonus = tonskill.firstHitCountBonus
        tonskillMemory2.endingCount1 = tonskill.endingCount1
        tonskillMemory2.endingCount2 = tonskill.endingCount2
        tonskillMemory2.endingCount3 = tonskill.endingCount3
        tonskillMemory2.endingCount4 = tonskill.endingCount4
        tonskillMemory2.endingCount5 = tonskill.endingCount5
        tonskillMemory2.endingCount6 = tonskill.endingCount6
        tonskillMemory2.endingCountSum = tonskill.endingCountSum
    }
    func saveMemory3() {
        tonskillMemory3.ptSui = tonskill.ptSui
        tonskillMemory3.ptMukoda = tonskill.ptMukoda
        tonskillMemory3.ptFeru = tonskill.ptFeru
        tonskillMemory3.normalGame = tonskill.normalGame
        tonskillMemory3.firstHitCountCz = tonskill.firstHitCountCz
        tonskillMemory3.firstHitCountBonus = tonskill.firstHitCountBonus
        tonskillMemory3.endingCount1 = tonskill.endingCount1
        tonskillMemory3.endingCount2 = tonskill.endingCount2
        tonskillMemory3.endingCount3 = tonskill.endingCount3
        tonskillMemory3.endingCount4 = tonskill.endingCount4
        tonskillMemory3.endingCount5 = tonskill.endingCount5
        tonskillMemory3.endingCount6 = tonskill.endingCount6
        tonskillMemory3.endingCountSum = tonskill.endingCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct tonskillSubViewLoadMemory: View {
    @ObservedObject var tonskill: Tonskill
    @ObservedObject var tonskillMemory1: TonskillMemory1
    @ObservedObject var tonskillMemory2: TonskillMemory2
    @ObservedObject var tonskillMemory3: TonskillMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: tonskill.machineName,
            selectedMemory: $tonskill.selectedMemory,
            memoMemory1: tonskillMemory1.memo,
            dateDoubleMemory1: tonskillMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: tonskillMemory2.memo,
            dateDoubleMemory2: tonskillMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: tonskillMemory3.memo,
            dateDoubleMemory3: tonskillMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        tonskill.ptSui = tonskillMemory1.ptSui
        tonskill.ptMukoda = tonskillMemory1.ptMukoda
        tonskill.ptFeru = tonskillMemory1.ptFeru
        tonskill.normalGame = tonskillMemory1.normalGame
        tonskill.firstHitCountCz = tonskillMemory1.firstHitCountCz
        tonskill.firstHitCountBonus = tonskillMemory1.firstHitCountBonus
        tonskill.endingCount1 = tonskillMemory1.endingCount1
        tonskill.endingCount2 = tonskillMemory1.endingCount2
        tonskill.endingCount3 = tonskillMemory1.endingCount3
        tonskill.endingCount4 = tonskillMemory1.endingCount4
        tonskill.endingCount5 = tonskillMemory1.endingCount5
        tonskill.endingCount6 = tonskillMemory1.endingCount6
        tonskill.endingCountSum = tonskillMemory1.endingCountSum
    }
    func loadMemory2() {
        tonskill.ptSui = tonskillMemory2.ptSui
        tonskill.ptMukoda = tonskillMemory2.ptMukoda
        tonskill.ptFeru = tonskillMemory2.ptFeru
        tonskill.normalGame = tonskillMemory2.normalGame
        tonskill.firstHitCountCz = tonskillMemory2.firstHitCountCz
        tonskill.firstHitCountBonus = tonskillMemory2.firstHitCountBonus
        tonskill.endingCount1 = tonskillMemory2.endingCount1
        tonskill.endingCount2 = tonskillMemory2.endingCount2
        tonskill.endingCount3 = tonskillMemory2.endingCount3
        tonskill.endingCount4 = tonskillMemory2.endingCount4
        tonskill.endingCount5 = tonskillMemory2.endingCount5
        tonskill.endingCount6 = tonskillMemory2.endingCount6
        tonskill.endingCountSum = tonskillMemory2.endingCountSum
    }
    func loadMemory3() {
        tonskill.ptSui = tonskillMemory3.ptSui
        tonskill.ptMukoda = tonskillMemory3.ptMukoda
        tonskill.ptFeru = tonskillMemory3.ptFeru
        tonskill.normalGame = tonskillMemory3.normalGame
        tonskill.firstHitCountCz = tonskillMemory3.firstHitCountCz
        tonskill.firstHitCountBonus = tonskillMemory3.firstHitCountBonus
        tonskill.endingCount1 = tonskillMemory3.endingCount1
        tonskill.endingCount2 = tonskillMemory3.endingCount2
        tonskill.endingCount3 = tonskillMemory3.endingCount3
        tonskill.endingCount4 = tonskillMemory3.endingCount4
        tonskill.endingCount5 = tonskillMemory3.endingCount5
        tonskill.endingCount6 = tonskillMemory3.endingCount6
        tonskill.endingCountSum = tonskillMemory3.endingCountSum
    }
}

#Preview {
    tonskillViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
