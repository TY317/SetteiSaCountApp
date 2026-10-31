//
//  juoViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct juoViewTop: View {
    @EnvironmentObject var common: commonVar
    @EnvironmentObject var bayes: Bayes
    @EnvironmentObject var viewModel: InterstitialViewModel
    @StateObject var juo = Juo()
    @State var isShowAlert: Bool = false
    @StateObject var juoMemory1 = JuoMemory1()
    @StateObject var juoMemory2 = JuoMemory2()
    @StateObject var juoMemory3 = JuoMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("マイスロの利用を前提としています\n遊技前にマイスロを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(
                        machineName: juo.machineName,
                    )
                }

                Section {
                    // 通常時
                    NavigationLink(destination: juoViewNormal(
                        juo: juo,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.juoMenuNormalBadge,
                        )
                    }

                    // 初当り
                    NavigationLink(destination: juoViewFirstHit(
                        juo: juo,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.juoMenuFirstHitBadge,
                        )
                    }

                    // トロフィー
                    NavigationLink(destination: commonViewSammyTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "サミートロフィー"
                        )
                    }
//                } header: {
//                    unitLabelMachineTopTitle(
//                        machineName: juo.machineName,
//                        titleFont: .title,
//                    )
                }

                // 設定推測グラフ
                NavigationLink(destination: juoView95Ci(
                    juo: juo,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: juoViewBayes(
                    juo: juo,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.juoMenuBayesBadge
                    )
                }

                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/5061")

                // コピーライト
                unitSectionCopyright {
                    Text("©Sammy")
                }
            }
        }
        // //// バッジのリセット
        .resetMachineBadgeOnAppear(machines: $common.machines, targetId: "5061")
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: juo.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(juoSubViewLoadMemory(
                    juo: juo,
                    juoMemory1: juoMemory1,
                    juoMemory2: juoMemory2,
                    juoMemory3: juoMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(juoSubViewSaveMemory(
                    juo: juo,
                    juoMemory1: juoMemory1,
                    juoMemory2: juoMemory2,
                    juoMemory3: juoMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: juo.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct juoSubViewSaveMemory: View {
    @ObservedObject var juo: Juo
    @ObservedObject var juoMemory1: JuoMemory1
    @ObservedObject var juoMemory2: JuoMemory2
    @ObservedObject var juoMemory3: JuoMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewSaveMemory(
            machineName: juo.machineName,
            selectedMemory: $juo.selectedMemory,
            memoMemory1: $juoMemory1.memo,
            dateDoubleMemory1: $juoMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $juoMemory2.memo,
            dateDoubleMemory2: $juoMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $juoMemory3.memo,
            dateDoubleMemory3: $juoMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        juoMemory1.cherryCount = juo.cherryCount
        juoMemory1.cherryCountScHigh = juo.cherryCountScHigh
        juoMemory1.rareReplayCount = juo.rareReplayCount
        juoMemory1.rareReplayCountScHigh = juo.rareReplayCountScHigh
        juoMemory1.normalGame = juo.normalGame
        juoMemory1.firstHitCountSc = juo.firstHitCountSc
    }
    func saveMemory2() {
        juoMemory2.cherryCount = juo.cherryCount
        juoMemory2.cherryCountScHigh = juo.cherryCountScHigh
        juoMemory2.rareReplayCount = juo.rareReplayCount
        juoMemory2.rareReplayCountScHigh = juo.rareReplayCountScHigh
        juoMemory2.normalGame = juo.normalGame
        juoMemory2.firstHitCountSc = juo.firstHitCountSc
    }
    func saveMemory3() {
        juoMemory3.cherryCount = juo.cherryCount
        juoMemory3.cherryCountScHigh = juo.cherryCountScHigh
        juoMemory3.rareReplayCount = juo.rareReplayCount
        juoMemory3.rareReplayCountScHigh = juo.rareReplayCountScHigh
        juoMemory3.normalGame = juo.normalGame
        juoMemory3.firstHitCountSc = juo.firstHitCountSc
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct juoSubViewLoadMemory: View {
    @ObservedObject var juo: Juo
    @ObservedObject var juoMemory1: JuoMemory1
    @ObservedObject var juoMemory2: JuoMemory2
    @ObservedObject var juoMemory3: JuoMemory3
    @State var isShowSaveAlert: Bool = false

    var body: some View {
        unitViewLoadMemory(
            machineName: juo.machineName,
            selectedMemory: $juo.selectedMemory,
            memoMemory1: juoMemory1.memo,
            dateDoubleMemory1: juoMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: juoMemory2.memo,
            dateDoubleMemory2: juoMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: juoMemory3.memo,
            dateDoubleMemory3: juoMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        juo.cherryCount = juoMemory1.cherryCount
        juo.cherryCountScHigh = juoMemory1.cherryCountScHigh
        juo.rareReplayCount = juoMemory1.rareReplayCount
        juo.rareReplayCountScHigh = juoMemory1.rareReplayCountScHigh
        juo.normalGame = juoMemory1.normalGame
        juo.firstHitCountSc = juoMemory1.firstHitCountSc
    }
    func loadMemory2() {
        juo.cherryCount = juoMemory2.cherryCount
        juo.cherryCountScHigh = juoMemory2.cherryCountScHigh
        juo.rareReplayCount = juoMemory2.rareReplayCount
        juo.rareReplayCountScHigh = juoMemory2.rareReplayCountScHigh
        juo.normalGame = juoMemory2.normalGame
        juo.firstHitCountSc = juoMemory2.firstHitCountSc
    }
    func loadMemory3() {
        juo.cherryCount = juoMemory3.cherryCount
        juo.cherryCountScHigh = juoMemory3.cherryCountScHigh
        juo.rareReplayCount = juoMemory3.rareReplayCount
        juo.rareReplayCountScHigh = juoMemory3.rareReplayCountScHigh
        juo.normalGame = juoMemory3.normalGame
        juo.firstHitCountSc = juoMemory3.firstHitCountSc
    }
}

#Preview {
    juoViewTop()
        .environmentObject(commonVar())
        .environmentObject(Bayes())
        .environmentObject(InterstitialViewModel())
}
