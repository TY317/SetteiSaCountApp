//
//  tonskillViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct tonskillViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var tonskill = Tonskill()
    @State var isShowAlert: Bool = false
    @StateObject var tonskillMemory1 = TonskillMemory1()
    @StateObject var tonskillMemory2 = TonskillMemory2()
    @StateObject var tonskillMemory3 = TonskillMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("e-slot+の利用を前提としています\n遊技前にe-slot+を開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: tonskill.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: tonskillViewNormal(
                        tonskill: tonskill,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.tonskillMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: tonskillViewFirstHit(
                        tonskill: tonskill,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.tonskillMenuFirstHitBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewArisuTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "アリストロフィー"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: tonskill.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: tonskillView95Ci(
                    tonskill: tonskill,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: tonskillViewBayes(
                    tonskill: tonskill,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.tonskillMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5030")

                // コピーライト
                unitSectionCopyright {
                    Text("©江口連・オーバーラップ／MAPPA／とんでもスキル")
                    Text("©Konami Amusement")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5030")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tonskill.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(tonskillSubViewLoadMemory(
                    tonskill: tonskill,
                    tonskillMemory1: tonskillMemory1,
                    tonskillMemory2: tonskillMemory2,
                    tonskillMemory3: tonskillMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(tonskillSubViewSaveMemory(
                    tonskill: tonskill,
                    tonskillMemory1: tonskillMemory1,
                    tonskillMemory2: tonskillMemory2,
                    tonskillMemory3: tonskillMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: tonskill.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct tonskillSubViewSaveMemory: View {
    @ObservedObject var tonskill: Tonskill
    @ObservedObject var tonskillMemory1: TonskillMemory1
    @ObservedObject var tonskillMemory2: TonskillMemory2
    @ObservedObject var tonskillMemory3: TonskillMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: tonskill.machineName,
            selectedMemory: $tonskill.selectedMemory,
            memoMemory1: $tonskillMemory1.memo,
            dateDoubleMemory1: $tonskillMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $tonskillMemory2.memo,
            dateDoubleMemory2: $tonskillMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $tonskillMemory3.memo,
            dateDoubleMemory3: $tonskillMemory3.dateDouble,
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
struct tonskillSubViewLoadMemory: View {
    @ObservedObject var tonskill: Tonskill
    @ObservedObject var tonskillMemory1: TonskillMemory1
    @ObservedObject var tonskillMemory2: TonskillMemory2
    @ObservedObject var tonskillMemory3: TonskillMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: tonskill.machineName,
            selectedMemory: $tonskill.selectedMemory,
            memoMemory1: tonskillMemory1.memo,
            dateDoubleMemory1: tonskillMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: tonskillMemory2.memo,
            dateDoubleMemory2: tonskillMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: tonskillMemory3.memo,
            dateDoubleMemory3: tonskillMemory3.dateDouble,
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
    tonskillViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
