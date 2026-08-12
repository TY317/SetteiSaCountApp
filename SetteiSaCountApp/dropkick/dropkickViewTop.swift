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
                        titleFont: .title,
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

    }
    func saveMemory2() {

    }
    func saveMemory3() {

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

    }
    func loadMemory2() {

    }
    func loadMemory3() {

    }
}

#Preview {
    dropkickViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
