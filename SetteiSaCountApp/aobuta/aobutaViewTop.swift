//
//  aobutaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct aobutaViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var aobuta = Aobuta()
    @State var isShowAlert: Bool = false
    @StateObject var aobutaMemory1 = AobutaMemory1()
    @StateObject var aobutaMemory2 = AobutaMemory2()
    @StateObject var aobutaMemory3 = AobutaMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("打-WINの利用を前提としています\n遊技前に打-WINを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: aobuta.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: aobutaViewNormal(
                        aobuta: aobuta,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.aobutaMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: aobutaViewFirstHit(
                        aobuta: aobuta,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.aobutaMenuFirstHitBadge,
                        )
                    }

                    // ST中
                    NavigationLink(destination: aobutaViewDuringSt(
                        aobuta: aobuta,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "hare.fill",
                            textBody: "ST中",
                            badgeStatus: common.aobutaMenuDuringStBadge,
                        )
                    }

                    // 隠れ凪
                    NavigationLink(destination: commonViewKakureNagi()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "隠れ凪"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: aobuta.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: aobutaView95Ci(
                    aobuta: aobuta,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: aobutaViewBayes(
                    aobuta: aobuta,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.aobutaMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5064")

                // コピーライト
                unitSectionCopyright {
                    Text("©2022 鴨志田 一/KADOKAWA/青ブタ Project")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5064")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: aobuta.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(aobutaSubViewLoadMemory(
                    aobuta: aobuta,
                    aobutaMemory1: aobutaMemory1,
                    aobutaMemory2: aobutaMemory2,
                    aobutaMemory3: aobutaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(aobutaSubViewSaveMemory(
                    aobuta: aobuta,
                    aobutaMemory1: aobutaMemory1,
                    aobutaMemory2: aobutaMemory2,
                    aobutaMemory3: aobutaMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: aobuta.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct aobutaSubViewSaveMemory: View {
    @ObservedObject var aobuta: Aobuta
    @ObservedObject var aobutaMemory1: AobutaMemory1
    @ObservedObject var aobutaMemory2: AobutaMemory2
    @ObservedObject var aobutaMemory3: AobutaMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: aobuta.machineName,
            selectedMemory: $aobuta.selectedMemory,
            memoMemory1: $aobutaMemory1.memo,
            dateDoubleMemory1: $aobutaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $aobutaMemory2.memo,
            dateDoubleMemory2: $aobutaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $aobutaMemory3.memo,
            dateDoubleMemory3: $aobutaMemory3.dateDouble,
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
struct aobutaSubViewLoadMemory: View {
    @ObservedObject var aobuta: Aobuta
    @ObservedObject var aobutaMemory1: AobutaMemory1
    @ObservedObject var aobutaMemory2: AobutaMemory2
    @ObservedObject var aobutaMemory3: AobutaMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: aobuta.machineName,
            selectedMemory: $aobuta.selectedMemory,
            memoMemory1: aobutaMemory1.memo,
            dateDoubleMemory1: aobutaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: aobutaMemory2.memo,
            dateDoubleMemory2: aobutaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: aobutaMemory3.memo,
            dateDoubleMemory3: aobutaMemory3.dateDouble,
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
    aobutaViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
