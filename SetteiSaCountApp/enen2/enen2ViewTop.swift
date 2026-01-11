//
//  enen2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/11.
//

import SwiftUI

struct enen2ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var enen2 = Enen2()
    @State var isShowAlert: Bool = false
//    @StateObject var enen2Memory1 = Enen2Memory1()
//    @StateObject var enen2Memory2 = Enen2Memory2()
//    @StateObject var enen2Memory3 = Enen2Memory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: enen2ViewNormal(
                        enen2: enen2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.enen2MenuNormalBadge,
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: enen2.machineName)
                }
                
                // 設定推測グラフ
                NavigationLink(destination: enen2View95Ci(
//                    enen2: enen2,
//                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: enen2ViewBayes(
//                    enen2: enen2,
//                    bayes: bayes,
//                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.enen2MenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4926")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©大久保篤／講談社")
                    Text("©大久保篤・講談社／特殊消防隊動画広報課")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.enen2MachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(enen2SubViewLoadMemory(
//                    enen2: enen2,
//                    enen2Memory1: enen2Memory1,
//                    enen2Memory2: enen2Memory2,
//                    enen2Memory3: enen2Memory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(enen2SubViewSaveMemory(
//                    enen2: enen2,
//                    enen2Memory1: enen2Memory1,
//                    enen2Memory2: enen2Memory2,
//                    enen2Memory3: enen2Memory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: enen2.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    enen2ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
