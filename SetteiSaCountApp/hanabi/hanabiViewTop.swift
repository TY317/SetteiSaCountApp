//
//  hanabiViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/02.
//

import SwiftUI

struct hanabiViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var hanabi = Hanabi()
    @State var isShowAlert: Bool = false
//    @StateObject var hanabiMemory1 = HanabiMemory1()
//    @StateObject var hanabiMemory2 = HanabiMemory2()
//    @StateObject var hanabiMemory3 = HanabiMemory3()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ユニメモの利用を前提としています\n遊技前にユニメモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: hanabi.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: hanabiViewKen(
                        hanabi: hanabi,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "magnifyingglass",
                            textBody: "空き台チェック",
                            badgeStatus: common.hanabiMenuKenBadge,
                        )
                    }
                } header: {
                    HStack {
                        Text("見")
                        unitToolbarButtonQuestion {
                            unitExView5body2image(
                                title: "見",
                                textBody1: "・空き台の設定判別やベル逆算はこちらから"
                            )
                        }
                    }
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: hanabiViewNormal(
                        hanabi: hanabi,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.hanabiMenuNormalBadge,
                        )
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: hanabiView95Ci(
//                    hanabi: hanabi,
//                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: hanabiViewBayes(
//                    hanabi: hanabi,
//                    bayes: bayes,
//                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.hanabiMenuBayesBadge
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4928")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©UNIVERSAL ENTERTAINMENT")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.hanabiMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: hanabi.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
//                unitButtonLoadMemory(loadView: AnyView(hanabiSubViewLoadMemory(
//                    hanabi: hanabi,
//                    hanabiMemory1: hanabiMemory1,
//                    hanabiMemory2: hanabiMemory2,
//                    hanabiMemory3: hanabiMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
//                unitButtonSaveMemory(saveView: AnyView(hanabiSubViewSaveMemory(
//                    hanabi: hanabi,
//                    hanabiMemory1: hanabiMemory1,
//                    hanabiMemory2: hanabiMemory2,
//                    hanabiMemory3: hanabiMemory3
//                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: hanabi.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

#Preview {
    hanabiViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
