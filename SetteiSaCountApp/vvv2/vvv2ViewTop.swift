//
//  vvv2ViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/16.
//

import SwiftUI

struct vvv2ViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var vvv2 = Vvv2()
    @State var isShowAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時
                    NavigationLink(destination: vvv2ViewNormal(
                        vvv2: vvv2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時"
                        )
                    }
                    // 初当り
                    NavigationLink(destination: vvv2ViewFirstHit(
                        vvv2: vvv2,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り"
                        )
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: vvv2.machineName)
                }
                
                // 設定推測グラフ
                NavigationLink(destination: vvv2View95Ci(
                    vvv2: vvv2,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }
                
                // 設定期待値計算
                NavigationLink(destination: vvv2ViewBayes(
                    vvv2: vvv2,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4885")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎SUNRISE/VVV Committee")
                    Text("©︎SANKYO")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.vvv2MachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: vvv2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(vvv2SubViewLoadMemory(
//                    vvv2: vvv2,
//                    vvv2Memory1: vvv2Memory1,
//                    vvv2Memory2: vvv2Memory2,
//                    vvv2Memory3: vvv2Memory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(vvv2SubViewSaveMemory(
//                    vvv2: vvv2,
//                    vvv2Memory1: vvv2Memory1,
//                    vvv2Memory2: vvv2Memory2,
//                    vvv2Memory3: vvv2Memory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: vvv2.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    vvv2ViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
