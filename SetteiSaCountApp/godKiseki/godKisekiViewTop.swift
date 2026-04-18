//
//  godKisekiViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/13.
//

import SwiftUI

struct godKisekiViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var godKiseki = GodKiseki()
    @State var isShowAlert: Bool = false
//    @StateObject var godKisekiMemory1 = GodKisekiMemory1()
//    @StateObject var godKisekiMemory2 = GodKisekiMemory2()
//    @StateObject var godKisekiMemory3 = GodKisekiMemory3()
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
                        machineName: godKiseki.machineName,
                        titleFont: .title2,
                    )
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: godKisekiViewNormal(
                        godKiseki: godKiseki,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.godKisekiMenuNormalBadge,
                        )
                    }
                    
//                    // CZ
//                    NavigationLink(destination: godKisekiViewCz(
//                        godKiseki: godKiseki,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "scope",
//                            textBody: "CZ",
//                            badgeStatus: common.godKisekiMenuCzBadge,
//                        )
//                    }
                    
//                    // 初当り
//                    NavigationLink(destination: godKisekiViewFirstHit(
//                        godKiseki: godKiseki,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "party.popper.fill",
//                            textBody: "初当り",
//                            badgeStatus: common.godKisekiMenuFirstHitBadge,
//                        )
//                    }
//                    
//                    // REG
//                    NavigationLink(destination: godKisekiViewReg(
//                        godKiseki: godKiseki,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "person.2.fill",
//                            textBody: "REG",
//                            badgeStatus: common.godKisekiMenuRegBadge,
//                        )
//                    }
//                    
//                    // AT終了画面
//                    NavigationLink(destination: godKisekiViewScreen(
//                        godKiseki: godKiseki,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "photo.on.rectangle.angled.fill",
//                            textBody: "ボーナス終了画面",
//                            badgeStatus: common.godKisekiMenuScreenBadge,
//                        )
//                    }
//
//                    // エンディング
//                    NavigationLink(destination: godKisekiViewEnding(
//                        godKiseki: godKiseki,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "flag.pattern.checkered",
//                            textBody: "エンディング",
//                            badgeStatus: common.godKisekiMenuEndingBadge,
//                        )
//                    }
//
//                    // おみくじ
//                    NavigationLink(destination: godKisekiViewOmikuji(
//                        godKiseki: godKiseki,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.godKisekiMenuOmikujiBadge,
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
                NavigationLink(destination: godKisekiView95Ci(
//                    godKiseki: godKiseki,
//                    selection: 3,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: godKisekiViewBayes(
//                    godKiseki: godKiseki,
//                    bayes: bayes,
//                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.godKisekiMenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4961")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©UNIVERSAL ENTERTAINMENT")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.godKisekiMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: godKiseki.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(godKisekiSubViewLoadMemory(
//                    godKiseki: godKiseki,
//                    godKisekiMemory1: godKisekiMemory1,
//                    godKisekiMemory2: godKisekiMemory2,
//                    godKisekiMemory3: godKisekiMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(godKisekiSubViewSaveMemory(
//                    godKiseki: godKiseki,
//                    godKisekiMemory1: godKisekiMemory1,
//                    godKisekiMemory2: godKisekiMemory2,
//                    godKisekiMemory3: godKisekiMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: godKiseki.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    godKisekiViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
