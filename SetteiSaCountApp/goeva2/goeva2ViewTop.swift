//
//  goeva2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct goeva2ViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var goeva2 = Goeva2()
    @State var isShowAlert: Bool = false
    @StateObject var goeva2Memory1 = Goeva2Memory1()
    @StateObject var goeva2Memory2 = Goeva2Memory2()
    @StateObject var goeva2Memory3 = Goeva2Memory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: goeva2ViewNormal(
                        goeva2: goeva2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.goeva2MenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: goeva2ViewFirstHit(
                        goeva2: goeva2,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.goeva2MenuFirstHitBadge,
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: goeva2.machineName,
                        titleFont: .title2,
                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: goeva2View95Ci(
                    goeva2: goeva2,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: goeva2ViewBayes(
                    goeva2: goeva2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.goeva2MenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5119")

                // コピーライト
                unitSectionCopyright {
                    Text("©︎カラー")
                    Text("TM＆ ©︎ TOHO CO.,LTD.")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5119")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: goeva2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(goeva2SubViewLoadMemory(
                    goeva2: goeva2,
                    goeva2Memory1: goeva2Memory1,
                    goeva2Memory2: goeva2Memory2,
                    goeva2Memory3: goeva2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(goeva2SubViewSaveMemory(
                    goeva2: goeva2,
                    goeva2Memory1: goeva2Memory1,
                    goeva2Memory2: goeva2Memory2,
                    goeva2Memory3: goeva2Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: goeva2.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct goeva2SubViewSaveMemory: View {
    @ObservedObject var goeva2: Goeva2
    @ObservedObject var goeva2Memory1: Goeva2Memory1
    @ObservedObject var goeva2Memory2: Goeva2Memory2
    @ObservedObject var goeva2Memory3: Goeva2Memory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: goeva2.machineName,
            selectedMemory: $goeva2.selectedMemory,
            memoMemory1: $goeva2Memory1.memo,
            dateDoubleMemory1: $goeva2Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $goeva2Memory2.memo,
            dateDoubleMemory2: $goeva2Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $goeva2Memory3.memo,
            dateDoubleMemory3: $goeva2Memory3.dateDouble,
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
struct goeva2SubViewLoadMemory: View {
    @ObservedObject var goeva2: Goeva2
    @ObservedObject var goeva2Memory1: Goeva2Memory1
    @ObservedObject var goeva2Memory2: Goeva2Memory2
    @ObservedObject var goeva2Memory3: Goeva2Memory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: goeva2.machineName,
            selectedMemory: $goeva2.selectedMemory,
            memoMemory1: goeva2Memory1.memo,
            dateDoubleMemory1: goeva2Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: goeva2Memory2.memo,
            dateDoubleMemory2: goeva2Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: goeva2Memory3.memo,
            dateDoubleMemory3: goeva2Memory3.dateDouble,
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
    goeva2ViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
