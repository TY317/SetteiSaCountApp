//
//  gobsla2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/23.
//

import SwiftUI

struct gobsla2ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var gobsla2 = Gobsla2()
    @State var isShowAlert: Bool = false
//    @StateObject var gobsla2Memory1 = Gobsla2Memory1()
//    @StateObject var gobsla2Memory2 = Gobsla2Memory2()
//    @StateObject var gobsla2Memory3 = Gobsla2Memory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    
                } header: {
                    unitLabelMachineTopTitle(machineName: gobsla2.machineName)
                }
                
                // 設定推測グラフ
//                NavigationLink(destination: gobsla2View95Ci(
//                    gobsla2: gobsla2,
//                    selection: 1,
//                )) {
//                    unitLabelMenu(
//                        imageSystemName: "chart.bar.xaxis",
//                        textBody: "設定推測グラフ"
//                    )
//                }

                // 設定期待値計算
//                NavigationLink(destination: gobsla2ViewBayes(
//                    gobsla2: gobsla2,
//                    bayes: bayes,
//                    viewModel: viewModel,
//                )) {
//                    unitLabelMenu(
//                        imageSystemName: "gauge.open.with.lines.needle.33percent",
//                        textBody: "設定期待値",
//                        badgeStatus: common.gobsla2MenuBayesBadge
//                    )
//                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4950")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©蝸牛くも・SBクリエイティブ／ゴブリンスレイヤー2製作委員会")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.gobsla2MachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: gobsla2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(gobsla2SubViewLoadMemory(
//                    gobsla2: gobsla2,
//                    gobsla2Memory1: gobsla2Memory1,
//                    gobsla2Memory2: gobsla2Memory2,
//                    gobsla2Memory3: gobsla2Memory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(gobsla2SubViewSaveMemory(
//                    gobsla2: gobsla2,
//                    gobsla2Memory1: gobsla2Memory1,
//                    gobsla2Memory2: gobsla2Memory2,
//                    gobsla2Memory3: gobsla2Memory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: gobsla2.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    gobsla2ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
