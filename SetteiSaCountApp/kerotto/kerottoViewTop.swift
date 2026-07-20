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
                    selection: 1,
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

    }
    func saveMemory2() {

    }
    func saveMemory3() {

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

    }
    func loadMemory2() {

    }
    func loadMemory3() {

    }
}

#Preview {
    kerottoViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
