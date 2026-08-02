//
//  worldDaiStarViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct worldDaiStarViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var worldDaiStar = WorldDaiStar()
    @State var isShowAlert: Bool = false
    @StateObject var worldDaiStarMemory1 = WorldDaiStarMemory1()
    @StateObject var worldDaiStarMemory2 = WorldDaiStarMemory2()
    @StateObject var worldDaiStarMemory3 = WorldDaiStarMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ダイトモの利用を前提としています\n遊技前にダイトモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: worldDaiStar.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: worldDaiStarViewNormal(
                        worldDaiStar: worldDaiStar,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.worldDaiStarMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: worldDaiStarViewFirstHit(
                        worldDaiStar: worldDaiStar,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.worldDaiStarMenuFirstHitBadge,
                        )
                    }

                    // 終了画面
                    NavigationLink(destination: worldDaiStarViewScreen(
                        worldDaiStar: worldDaiStar,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: common.worldDaiStarMenuScreenBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: worldDaiStarViewEnding(
                        worldDaiStar: worldDaiStar,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.worldDaiStarMenuEndingBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewKopandaTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "コパンダトロフィー"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: worldDaiStar.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: worldDaiStarView95Ci(
                    worldDaiStar: worldDaiStar,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: worldDaiStarViewBayes(
                    worldDaiStar: worldDaiStar,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.worldDaiStarMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5055")

                // コピーライト
                unitSectionCopyright {
                    Text("©︎Sirius/Project WDS")
                    Text("©︎DAITO GIKEN,INC")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5055")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: worldDaiStar.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(worldDaiStarSubViewLoadMemory(
                    worldDaiStar: worldDaiStar,
                    worldDaiStarMemory1: worldDaiStarMemory1,
                    worldDaiStarMemory2: worldDaiStarMemory2,
                    worldDaiStarMemory3: worldDaiStarMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(worldDaiStarSubViewSaveMemory(
                    worldDaiStar: worldDaiStar,
                    worldDaiStarMemory1: worldDaiStarMemory1,
                    worldDaiStarMemory2: worldDaiStarMemory2,
                    worldDaiStarMemory3: worldDaiStarMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: worldDaiStar.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct worldDaiStarSubViewSaveMemory: View {
    @ObservedObject var worldDaiStar: WorldDaiStar
    @ObservedObject var worldDaiStarMemory1: WorldDaiStarMemory1
    @ObservedObject var worldDaiStarMemory2: WorldDaiStarMemory2
    @ObservedObject var worldDaiStarMemory3: WorldDaiStarMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: worldDaiStar.machineName,
            selectedMemory: $worldDaiStar.selectedMemory,
            memoMemory1: $worldDaiStarMemory1.memo,
            dateDoubleMemory1: $worldDaiStarMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $worldDaiStarMemory2.memo,
            dateDoubleMemory2: $worldDaiStarMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $worldDaiStarMemory3.memo,
            dateDoubleMemory3: $worldDaiStarMemory3.dateDouble,
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
struct worldDaiStarSubViewLoadMemory: View {
    @ObservedObject var worldDaiStar: WorldDaiStar
    @ObservedObject var worldDaiStarMemory1: WorldDaiStarMemory1
    @ObservedObject var worldDaiStarMemory2: WorldDaiStarMemory2
    @ObservedObject var worldDaiStarMemory3: WorldDaiStarMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: worldDaiStar.machineName,
            selectedMemory: $worldDaiStar.selectedMemory,
            memoMemory1: worldDaiStarMemory1.memo,
            dateDoubleMemory1: worldDaiStarMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: worldDaiStarMemory2.memo,
            dateDoubleMemory2: worldDaiStarMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: worldDaiStarMemory3.memo,
            dateDoubleMemory3: worldDaiStarMemory3.dateDouble,
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
    worldDaiStarViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
