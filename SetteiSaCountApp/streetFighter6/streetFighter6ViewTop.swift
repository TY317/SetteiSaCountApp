//
//  streetFighter6ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct streetFighter6ViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var streetFighter6 = StreetFighter6()
    @State var isShowAlert: Bool = false
    @StateObject var streetFighter6Memory1 = StreetFighter6Memory1()
    @StateObject var streetFighter6Memory2 = StreetFighter6Memory2()
    @StateObject var streetFighter6Memory3 = StreetFighter6Memory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: streetFighter6ViewNormal(
                        streetFighter6: streetFighter6,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.streetFighter6MenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: streetFighter6ViewFirstHit(
                        streetFighter6: streetFighter6,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.streetFighter6MenuFirstHitBadge,
                        )
                    }

                    // 終了画面
                    NavigationLink(destination: streetFighter6ViewScreen(
                        streetFighter6: streetFighter6,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: common.streetFighter6MenuScreenBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: streetFighter6ViewEnding(
                        streetFighter6: streetFighter6,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.streetFighter6MenuEndingBadge,
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
                        machineName: streetFighter6.machineName,
                        titleFont: .title,
                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: streetFighter6View95Ci(
                    streetFighter6: streetFighter6,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: streetFighter6ViewBayes(
                    streetFighter6: streetFighter6,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.streetFighter6MenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5068")

                // コピーライト
                unitSectionCopyright {
                    Text("©CAPCOM")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5068")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: streetFighter6.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(streetFighter6SubViewLoadMemory(
                    streetFighter6: streetFighter6,
                    streetFighter6Memory1: streetFighter6Memory1,
                    streetFighter6Memory2: streetFighter6Memory2,
                    streetFighter6Memory3: streetFighter6Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(streetFighter6SubViewSaveMemory(
                    streetFighter6: streetFighter6,
                    streetFighter6Memory1: streetFighter6Memory1,
                    streetFighter6Memory2: streetFighter6Memory2,
                    streetFighter6Memory3: streetFighter6Memory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: streetFighter6.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct streetFighter6SubViewSaveMemory: View {
    @ObservedObject var streetFighter6: StreetFighter6
    @ObservedObject var streetFighter6Memory1: StreetFighter6Memory1
    @ObservedObject var streetFighter6Memory2: StreetFighter6Memory2
    @ObservedObject var streetFighter6Memory3: StreetFighter6Memory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: streetFighter6.machineName,
            selectedMemory: $streetFighter6.selectedMemory,
            memoMemory1: $streetFighter6Memory1.memo,
            dateDoubleMemory1: $streetFighter6Memory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $streetFighter6Memory2.memo,
            dateDoubleMemory2: $streetFighter6Memory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $streetFighter6Memory3.memo,
            dateDoubleMemory3: $streetFighter6Memory3.dateDouble,
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
struct streetFighter6SubViewLoadMemory: View {
    @ObservedObject var streetFighter6: StreetFighter6
    @ObservedObject var streetFighter6Memory1: StreetFighter6Memory1
    @ObservedObject var streetFighter6Memory2: StreetFighter6Memory2
    @ObservedObject var streetFighter6Memory3: StreetFighter6Memory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: streetFighter6.machineName,
            selectedMemory: $streetFighter6.selectedMemory,
            memoMemory1: streetFighter6Memory1.memo,
            dateDoubleMemory1: streetFighter6Memory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: streetFighter6Memory2.memo,
            dateDoubleMemory2: streetFighter6Memory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: streetFighter6Memory3.memo,
            dateDoubleMemory3: streetFighter6Memory3.dateDouble,
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
    streetFighter6ViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
