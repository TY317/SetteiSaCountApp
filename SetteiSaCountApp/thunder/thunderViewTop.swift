//
//  thunderViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/09.
//

import SwiftUI

struct thunderViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var thunder = Thunder()
    @State var isShowAlert: Bool = false
//    @StateObject var thunderMemory1 = ThunderMemory1()
//    @StateObject var thunderMemory2 = ThunderMemory2()
//    @StateObject var thunderMemory3 = ThunderMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ユニメモの利用を前提としています\n遊技前にユニメモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: thunder.machineName)
                }
                
                Section {
                    // 打ち始めデータ入力
                    NavigationLink(destination: thunderViewStart(
                        thunder: thunder,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "airplane.departure",
                            textBody: "打ち始めデータ入力",
                            badgeStatus: common.thunderMenuStartBadge,
                        )
                    }
                    
                    // プレイデータ入力
                    NavigationLink(destination: thunderViewPlay(
                        thunder: thunder,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "arcade.stick.and.arrow.down",
                            textBody: "ユニメモデータ入力",
                            badgeStatus: common.thunderMenuPlayBadge,
                        )
                    }
                    
                    // ボーナス終了画面
                    NavigationLink(destination: thunderViewScreen(
                        thunder: thunder,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "ボーナス終了画面",
                            badgeStatus: common.thunderMenuScreenBadge,
                        )
                    }
//                    
//                    // おみくじ
//                    NavigationLink(destination: thunderViewOmikuji(
//                        thunder: thunder,
//                        bayes: bayes,
//                        viewModel: viewModel,
//                    )) {
//                        unitLabelMenu(
//                            imageSystemName: "tag.fill",
//                            textBody: "おみくじ",
//                            badgeStatus: common.thunderMenuOmikujiBadge,
//                        )
//                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: thunderView95Ci(
                    thunder: thunder,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: thunderViewBayes(
                    thunder: thunder,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.thunderMenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4943")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©UNIVERSAL ENTERTAINMENT")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.thunderMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: thunder.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(thunderSubViewLoadMemory(
//                    thunder: thunder,
//                    thunderMemory1: thunderMemory1,
//                    thunderMemory2: thunderMemory2,
//                    thunderMemory3: thunderMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(thunderSubViewSaveMemory(
//                    thunder: thunder,
//                    thunderMemory1: thunderMemory1,
//                    thunderMemory2: thunderMemory2,
//                    thunderMemory3: thunderMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: thunder.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    thunderViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
