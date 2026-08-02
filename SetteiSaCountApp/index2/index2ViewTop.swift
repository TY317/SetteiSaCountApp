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
                    Text("2017 鎌池和馬／ＫＡＤＯＫＡＷＡ　アスキー・メディアワークス／PROJECT-INDEX Ⅲ")
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

    }
    func saveMemory2() {

    }
    func saveMemory3() {

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

    }
    func loadMemory2() {

    }
    func loadMemory3() {

    }
}

#Preview {
    index2ViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
