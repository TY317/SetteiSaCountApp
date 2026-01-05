//
//  shakeViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import SwiftUI

struct shakeViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var shake = Shake()
    @State var isShowAlert: Bool = false
//    @StateObject var shakeMemory1 = ShakeMemory1()
//    @StateObject var shakeMemory2 = ShakeMemory2()
//    @StateObject var shakeMemory3 = ShakeMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ダイトモの利用を前提としています\n遊技前にダイトモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: shake.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: shakeViewNormal(
                        shake: shake,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.shakeMenuNormalBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: shakeViewFirstHit(
                        shake: shake,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.shakeMenuFirstHitBadge,
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: shakeView95Ci(
                    shake: shake,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: shakeViewBayes(
                    shake: shake,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.shakeMenuBayesBadge,
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4893")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎DAITO GIKEN,INC.")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shakeMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shake.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(shakeSubViewLoadMemory(
//                    shake: shake,
//                    shakeMemory1: shakeMemory1,
//                    shakeMemory2: shakeMemory2,
//                    shakeMemory3: shakeMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(shakeSubViewSaveMemory(
//                    shake: shake,
//                    shakeMemory1: shakeMemory1,
//                    shakeMemory2: shakeMemory2,
//                    shakeMemory3: shakeMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: shake.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    shakeViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
