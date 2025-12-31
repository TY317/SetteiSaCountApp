//
//  tekken6ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/29.
//

import SwiftUI

struct tekken6ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var tekken6 = Tekken6()
    @State var isShowAlert: Bool = false
//    @StateObject var tekken6Memory1 = Tekken6Memory1()
//    @StateObject var tekken6Memory2 = Tekken6Memory2()
//    @StateObject var tekken6Memory3 = Tekken6Memory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("スロプラNEXTの利用を前提としています\n遊技前にスロプラNEXTを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: tekken6.machineName, titleFont: .title2)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: tekken6ViewNormal(
                        tekken6: tekken6,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.tekken6MenuNormalBadge,
                        )
                    }
                    
                    // 通常時
                    NavigationLink(destination: tekken6ViewFirstHit(
                        tekken6: tekken6,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.tekken6MenuFirstHitBadge,
                        )
                    }
                    
                    // ボーナス終了画面
                    NavigationLink(destination: tekken6ViewScreen(
                        tekken6: tekken6,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "AT中",
                            badgeStatus: common.tekken6MenuScreenBadge,
                        )
                    }
                    
                    // 引き戻し
                    NavigationLink(destination: tekken6ViewBack(
                        tekken6: tekken6,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arrow.trianglehead.2.counterclockwise",
                            textBody: "引き戻し",
                            badgeStatus: common.tekken6MenuBackBadge,
                        )
                    }
                    
                    // ケロットトロフィー
                    NavigationLink(destination: commonViewKerottoTrophy()) {
                        unitLabelMenu(
                            imageSystemName: "trophy.fill",
                            textBody: "ケロットトロフィー"
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: tekken6View95Ci(
                    tekken6: tekken6,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: tekken6ViewBayes(
                    tekken6: tekken6,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.tekken6MenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4913")
                
                // コピーライト
                unitSectionCopyright {
                    Text("TEKKEN™Series & ©Bandai Namco Entertainment Inc.")
                    Text("©Bandai Namco Sevens Inc.")
                    Text("©YAMASA")
                    Text("©YAMASA NEXT")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.tekken6MachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: tekken6.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(tekken6SubViewLoadMemory(
//                    tekken6: tekken6,
//                    tekken6Memory1: tekken6Memory1,
//                    tekken6Memory2: tekken6Memory2,
//                    tekken6Memory3: tekken6Memory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(tekken6SubViewSaveMemory(
//                    tekken6: tekken6,
//                    tekken6Memory1: tekken6Memory1,
//                    tekken6Memory2: tekken6Memory2,
//                    tekken6Memory3: tekken6Memory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: tekken6.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    tekken6ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
