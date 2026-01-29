//
//  kokakukidotaiViewtop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/12.
//

import SwiftUI

struct kokakukidotaiViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var kokakukidotai = Kokakukidotai()
    @State var isShowAlert: Bool = false
//    @StateObject var kokakukidotaiMemory1 = KokakukidotaiMemory1()
//    @StateObject var kokakukidotaiMemory2 = KokakukidotaiMemory2()
//    @StateObject var kokakukidotaiMemory3 = KokakukidotaiMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("マイスロの利用を前提としています\n遊技前にマイスロを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: kokakukidotai.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: kokakukidotaiViewNormal(
                        kokakukidotai: kokakukidotai,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.kokakukidotaiMenuNormalBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: kokakukidotaiViewFirstHit(
                        kokakukidotai: kokakukidotai,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.kokakukidotaiMenuFirstHitBadge,
                        )
                    }
                    
                    // 示唆ウィンドウ
                    NavigationLink(destination: kokakukidotaiViewScreen(
                        kokakukidotai: kokakukidotai,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "示唆ウィンドウ",
                            badgeStatus: common.kokakukidotaiMenuScreenBadge,
                        )
                    }
                    
                    // AT中
                    NavigationLink(destination: kokakukidotaiViewAt(
                        kokakukidotai: kokakukidotai,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arrow.trianglehead.2.counterclockwise",
                            textBody: "AT中",
                            badgeStatus: common.kokakukidotaiMenuAtBadge,
                        )
                    }
                    
                    // サミートロフィー
                    NavigationLink(destination: commonViewSammyTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "サミートロフィー"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: kokakukidotaiView95Ci(
                    kokakukidotai: kokakukidotai,
                    selection: 2,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: kokakukidotaiViewBayes(
                    kokakukidotai: kokakukidotai,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.kokakukidotaiMenuBayesBadge,
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4931")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎士郎正宗・Production I.G／講談社・攻殻機動隊製作委員会")
                    Text("©︎Sammy")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kokakukidotaiMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kokakukidotai.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(kokakukidotaiSubViewLoadMemory(
//                    kokakukidotai: kokakukidotai,
//                    kokakukidotaiMemory1: kokakukidotaiMemory1,
//                    kokakukidotaiMemory2: kokakukidotaiMemory2,
//                    kokakukidotaiMemory3: kokakukidotaiMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(kokakukidotaiSubViewSaveMemory(
//                    kokakukidotai: kokakukidotai,
//                    kokakukidotaiMemory1: kokakukidotaiMemory1,
//                    kokakukidotaiMemory2: kokakukidotaiMemory2,
//                    kokakukidotaiMemory3: kokakukidotaiMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: kokakukidotai.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    kokakukidotaiViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
