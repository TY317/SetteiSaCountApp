//
//  yajikitaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct yajikitaViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var yajikita = Yajikita()
    @State var isShowAlert: Bool = false
    @StateObject var yajikitaMemory1 = YajikitaMemory1()
    @StateObject var yajikitaMemory2 = YajikitaMemory2()
    @StateObject var yajikitaMemory3 = YajikitaMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ユニメモの利用を前提としています\n遊技前にユニメモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: yajikita.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: yajikitaViewNormal(
                        yajikita: yajikita,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.yajikitaMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: yajikitaViewFirstHit(
                        yajikita: yajikita,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.yajikitaMenuFirstHitBadge,
                        )
                    }

                    // 終了画面
                    NavigationLink(destination: yajikitaViewScreen(
                        yajikita: yajikita,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "終了画面",
                            badgeStatus: common.yajikitaMenuScreenBadge,
                        )
                    }

                    // エンディング
                    NavigationLink(destination: yajikitaViewEnding(
                        yajikita: yajikita,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "flag.pattern.checkered",
                            textBody: "エンディング",
                            badgeStatus: common.yajikitaMenuEndingBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewUniversalPlate()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ユニバプレート"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: yajikita.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: yajikitaView95Ci(
                    yajikita: yajikita,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: yajikitaViewBayes(
                    yajikita: yajikita,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.yajikitaMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5027")

                // コピーライト
                unitSectionCopyright {
                    Text("©UNIVERSAL ENTERTAINMENT")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5027")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: yajikita.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(yajikitaSubViewLoadMemory(
                    yajikita: yajikita,
                    yajikitaMemory1: yajikitaMemory1,
                    yajikitaMemory2: yajikitaMemory2,
                    yajikitaMemory3: yajikitaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(yajikitaSubViewSaveMemory(
                    yajikita: yajikita,
                    yajikitaMemory1: yajikitaMemory1,
                    yajikitaMemory2: yajikitaMemory2,
                    yajikitaMemory3: yajikitaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: yajikita.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct yajikitaSubViewSaveMemory: View {
    @ObservedObject var yajikita: Yajikita
    @ObservedObject var yajikitaMemory1: YajikitaMemory1
    @ObservedObject var yajikitaMemory2: YajikitaMemory2
    @ObservedObject var yajikitaMemory3: YajikitaMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: yajikita.machineName,
            selectedMemory: $yajikita.selectedMemory,
            memoMemory1: $yajikitaMemory1.memo,
            dateDoubleMemory1: $yajikitaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $yajikitaMemory2.memo,
            dateDoubleMemory2: $yajikitaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $yajikitaMemory3.memo,
            dateDoubleMemory3: $yajikitaMemory3.dateDouble,
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
struct yajikitaSubViewLoadMemory: View {
    @ObservedObject var yajikita: Yajikita
    @ObservedObject var yajikitaMemory1: YajikitaMemory1
    @ObservedObject var yajikitaMemory2: YajikitaMemory2
    @ObservedObject var yajikitaMemory3: YajikitaMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: yajikita.machineName,
            selectedMemory: $yajikita.selectedMemory,
            memoMemory1: yajikitaMemory1.memo,
            dateDoubleMemory1: yajikitaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: yajikitaMemory2.memo,
            dateDoubleMemory2: yajikitaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: yajikitaMemory3.memo,
            dateDoubleMemory3: yajikitaMemory3.dateDouble,
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
    yajikitaViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
