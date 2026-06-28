//
//  sencole6ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct sencole6ViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var sencole6 = Sencole6()
    @State var isShowAlert: Bool = false
    @StateObject var sencole6Memory1 = Sencole6Memory1()
    @StateObject var sencole6Memory2 = Sencole6Memory2()
    @StateObject var sencole6Memory3 = Sencole6Memory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("の利用を前提としています\n遊技前にを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: sencole6.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: sencole6ViewNormal(
                        sencole6: sencole6,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.sencole6MenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: sencole6ViewFirstHit(
                        sencole6: sencole6,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.sencole6MenuFirstHitBadge,
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: sencole6.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: sencole6View95Ci(
                    sencole6: sencole6,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
//                NavigationLink(destination: sencole6ViewBayes(
//                    sencole6: sencole6,
//                )) {
//                    unitLabelMenu(
//                        imageSystemName: "gauge.open.with.lines.needle.33percent",
//                        textBody: "設定期待値",
//                        badgeStatus: common.sencole6MenuBayesBadge
//                    )
//                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5010")

                // コピーライト
                unitSectionCopyright {
                    Text("©Konami Digital Entertainment,NAS/「戦国コレクション」製作委員会")
                    Text("©Konami Amusement")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5010")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: sencole6.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(sencole6SubViewLoadMemory(
                    sencole6: sencole6,
                    sencole6Memory1: sencole6Memory1,
                    sencole6Memory2: sencole6Memory2,
                    sencole6Memory3: sencole6Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(sencole6SubViewSaveMemory(
                    sencole6: sencole6,
                    sencole6Memory1: sencole6Memory1,
                    sencole6Memory2: sencole6Memory2,
                    sencole6Memory3: sencole6Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: sencole6.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct sencole6SubViewSaveMemory: View {
    @ObservedObject var sencole6: Sencole6
    @ObservedObject var sencole6Memory1: Sencole6Memory1
    @ObservedObject var sencole6Memory2: Sencole6Memory2
    @ObservedObject var sencole6Memory3: Sencole6Memory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: sencole6.machineName,
            selectedMemory: $sencole6.selectedMemory,
            memoMemory1: $sencole6Memory1.memo,
            dateDoubleMemory1: $sencole6Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $sencole6Memory2.memo,
            dateDoubleMemory2: $sencole6Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $sencole6Memory3.memo,
            dateDoubleMemory3: $sencole6Memory3.dateDouble,
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
struct sencole6SubViewLoadMemory: View {
    @ObservedObject var sencole6: Sencole6
    @ObservedObject var sencole6Memory1: Sencole6Memory1
    @ObservedObject var sencole6Memory2: Sencole6Memory2
    @ObservedObject var sencole6Memory3: Sencole6Memory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: sencole6.machineName,
            selectedMemory: $sencole6.selectedMemory,
            memoMemory1: sencole6Memory1.memo,
            dateDoubleMemory1: sencole6Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: sencole6Memory2.memo,
            dateDoubleMemory2: sencole6Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: sencole6Memory3.memo,
            dateDoubleMemory3: sencole6Memory3.dateDouble,
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
    sencole6ViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
