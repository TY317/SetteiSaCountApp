//
//  gareiViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct gareiViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var garei = Garei()
    @State var isShowAlert: Bool = false
    @StateObject var gareiMemory1 = GareiMemory1()
    @StateObject var gareiMemory2 = GareiMemory2()
    @StateObject var gareiMemory3 = GareiMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: gareiViewNormal(
                        garei: garei,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.gareiMenuNormalBadge,
                        )
                    }

                    // CZ
                    NavigationLink(destination: gareiViewCz(
                        garei: garei,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "scope",
                            textBody: "CZ",
                            badgeStatus: common.gareiMenuCzBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: gareiViewFirstHit(
                        garei: garei,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.gareiMenuFirstHitBadge,
                        )
                    }

                    // ボーナス終了画面
                    NavigationLink(destination: gareiViewBonusScreen(
                        garei: garei,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面",
                            badgeStatus: common.gareiMenuScreenBadge,
                        )
                    }

                    // ART終了画面
                    NavigationLink(destination: gareiViewArtScreen(
                        garei: garei,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ART終了画面",
                            badgeStatus: common.gareiMenuArtScreenBadge,
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: garei.machineName,
                        titleFont: .title,
                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: gareiView95Ci(
                    garei: garei,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: gareiViewBayes(
                    garei: garei,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.gareiMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5028")

                // コピーライト
                unitSectionCopyright {
                    Text("©2008 瀬川はじめ／［喰霊−零−］製作委員会")
                    Text("©OIZUMI")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5028")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: garei.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(gareiSubViewLoadMemory(
                    garei: garei,
                    gareiMemory1: gareiMemory1,
                    gareiMemory2: gareiMemory2,
                    gareiMemory3: gareiMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(gareiSubViewSaveMemory(
                    garei: garei,
                    gareiMemory1: gareiMemory1,
                    gareiMemory2: gareiMemory2,
                    gareiMemory3: gareiMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: garei.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct gareiSubViewSaveMemory: View {
    @ObservedObject var garei: Garei
    @ObservedObject var gareiMemory1: GareiMemory1
    @ObservedObject var gareiMemory2: GareiMemory2
    @ObservedObject var gareiMemory3: GareiMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: garei.machineName,
            selectedMemory: $garei.selectedMemory,
            memoMemory1: $gareiMemory1.memo,
            dateDoubleMemory1: $gareiMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $gareiMemory2.memo,
            dateDoubleMemory2: $gareiMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $gareiMemory3.memo,
            dateDoubleMemory3: $gareiMemory3.dateDouble,
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
struct gareiSubViewLoadMemory: View {
    @ObservedObject var garei: Garei
    @ObservedObject var gareiMemory1: GareiMemory1
    @ObservedObject var gareiMemory2: GareiMemory2
    @ObservedObject var gareiMemory3: GareiMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: garei.machineName,
            selectedMemory: $garei.selectedMemory,
            memoMemory1: gareiMemory1.memo,
            dateDoubleMemory1: gareiMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: gareiMemory2.memo,
            dateDoubleMemory2: gareiMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: gareiMemory3.memo,
            dateDoubleMemory3: gareiMemory3.dateDouble,
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
    gareiViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
