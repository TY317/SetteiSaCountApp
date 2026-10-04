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
                        titleFont: .title3,
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

    }
    func saveMemory2() {

    }
    func saveMemory3() {

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

    }
    func loadMemory2() {

    }
    func loadMemory3() {

    }
}

#Preview {
    mhrsbViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
