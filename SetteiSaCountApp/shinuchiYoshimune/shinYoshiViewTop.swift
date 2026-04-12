//
//  shinYoshiViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/29.
//

import SwiftUI

struct shinYoshiViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var shinYoshi = ShinYoshi()
    @State var isShowAlert: Bool = false
    @StateObject var shinYoshiMemory1 = ShinYoshiMemory1()
    @StateObject var shinYoshiMemory2 = ShinYoshiMemory2()
    @StateObject var shinYoshiMemory3 = ShinYoshiMemory3()
    
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
                        machineName: shinYoshi.machineName,
//                        titleFont: .title2,
                    )
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: shinYoshiViewNormal(
                        shinYoshi: shinYoshi,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.shinYoshiMenuNormalBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: shinYoshiViewFirstHit(
                        shinYoshi: shinYoshi,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.shinYoshiMenuFirstHitBadge,
                        )
                    }
                    
                    // 白洲ビジョン
                    NavigationLink(destination: shinYoshiViewOshirasu(
                        shinYoshi: shinYoshi,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "display",
                            textBody: "御白洲ビジョン",
                            badgeStatus: common.shinYoshiMenuOshirasuBadge,
                        )
                    }
                    
                    // AT終了画面
                    NavigationLink(destination: shinYoshiViewScreen(
                        shinYoshi: shinYoshi,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT終了画面",
                            badgeStatus: common.shinYoshiMenuScreenBadge,
                        )
                    }
//                    
//                    // ST終了画面
//                    NavigationLink(destination: shinYoshiViewScreen(
//                        shinYoshi: shinYoshi,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "photo.on.rectangle.angled.fill",
//                            textBody: "ST終了画面",
//                            badgeStatus: common.shinYoshiMenuScreenBadge,
//                        )
//                    }
//                    
//                    // おみくじ
//                    NavigationLink(destination: shinYoshiViewOmikuji(
//                        shinYoshi: shinYoshi,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.shinYoshiMenuOmikujiBadge,
//                        )
//                    }
//                    
//                    // サミートロフィー
//                    NavigationLink(destination: commonViewSammyTrophy()) {
//                        unitLabelMenu(
//                            imageSystemName: "trophy.fill",
//                            textBody: "サミートロフィー"
//                        )
//                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: shinYoshiView95Ci(
                    shinYoshi: shinYoshi,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: shinYoshiViewBayes(
                    shinYoshi: shinYoshi,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.shinYoshiMenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4983")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©DAITO GIKEN,INC.")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shinYoshiMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shinYoshi.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(shinYoshiSubViewLoadMemory(
                    shinYoshi: shinYoshi,
                    shinYoshiMemory1: shinYoshiMemory1,
                    shinYoshiMemory2: shinYoshiMemory2,
                    shinYoshiMemory3: shinYoshiMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(shinYoshiSubViewSaveMemory(
                    shinYoshi: shinYoshi,
                    shinYoshiMemory1: shinYoshiMemory1,
                    shinYoshiMemory2: shinYoshiMemory2,
                    shinYoshiMemory3: shinYoshiMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: shinYoshi.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct shinYoshiSubViewSaveMemory: View {
    @ObservedObject var shinYoshi: ShinYoshi
    @ObservedObject var shinYoshiMemory1: ShinYoshiMemory1
    @ObservedObject var shinYoshiMemory2: ShinYoshiMemory2
    @ObservedObject var shinYoshiMemory3: ShinYoshiMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: shinYoshi.machineName,
            selectedMemory: $shinYoshi.selectedMemory,
            memoMemory1: $shinYoshiMemory1.memo,
            dateDoubleMemory1: $shinYoshiMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $shinYoshiMemory2.memo,
            dateDoubleMemory2: $shinYoshiMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $shinYoshiMemory3.memo,
            dateDoubleMemory3: $shinYoshiMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        shinYoshiMemory1.normalGame = shinYoshi.normalGame
        shinYoshiMemory1.firstHitCountAt = shinYoshi.firstHitCountAt
    }
    func saveMemory2() {
        shinYoshiMemory2.normalGame = shinYoshi.normalGame
        shinYoshiMemory2.firstHitCountAt = shinYoshi.firstHitCountAt
    }
    func saveMemory3() {
        shinYoshiMemory3.normalGame = shinYoshi.normalGame
        shinYoshiMemory3.firstHitCountAt = shinYoshi.firstHitCountAt
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct shinYoshiSubViewLoadMemory: View {
    @ObservedObject var shinYoshi: ShinYoshi
    @ObservedObject var shinYoshiMemory1: ShinYoshiMemory1
    @ObservedObject var shinYoshiMemory2: ShinYoshiMemory2
    @ObservedObject var shinYoshiMemory3: ShinYoshiMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: shinYoshi.machineName,
            selectedMemory: $shinYoshi.selectedMemory,
            memoMemory1: shinYoshiMemory1.memo,
            dateDoubleMemory1: shinYoshiMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: shinYoshiMemory2.memo,
            dateDoubleMemory2: shinYoshiMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: shinYoshiMemory3.memo,
            dateDoubleMemory3: shinYoshiMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        shinYoshi.normalGame = shinYoshiMemory1.normalGame
        shinYoshi.firstHitCountAt = shinYoshiMemory1.firstHitCountAt
    }
    func loadMemory2() {
        shinYoshi.normalGame = shinYoshiMemory2.normalGame
        shinYoshi.firstHitCountAt = shinYoshiMemory2.firstHitCountAt
    }
    func loadMemory3() {
        shinYoshi.normalGame = shinYoshiMemory3.normalGame
        shinYoshi.firstHitCountAt = shinYoshiMemory3.firstHitCountAt
    }
}

#Preview {
    shinYoshiViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
