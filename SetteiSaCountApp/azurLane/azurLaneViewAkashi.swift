//
//  azurLaneViewAkashi.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/29.
//

import SwiftUI

struct azurLaneViewAkashi: View {
    @ObservedObject var ver391: Ver391
    @ObservedObject var azurLane: AzurLane
    @State var isShowAlert: Bool = false
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    
    var body: some View {
        List {
            Section {
                // //// 注意書き
                VStack {
//                    Text("・告知時の残りゲーム数で設定を示唆！？")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Text("・残りゲーム数が奇数or偶数かに注目！？")
                    Text("・レア役以外での成功時のみ有効！！")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                // //// カウントボタン横並び
                HStack {
                    // 奇数ゲーム
                    unitCountButtonPercentWithFunc(
                        title: "奇数ゲーム",
                        count: $azurLane.akashiCountKisu,
                        color: .personalSummerLightGreen,
                        bigNumber: $azurLane.akashiCountSum,
                        numberofDicimal: 0,
                        minusBool: $azurLane.minusCheck) {
                            azurLane.akashiCountSumFunc()
                        }
                    // 偶数ゲーム
                    unitCountButtonPercentWithFunc(
                        title: "偶数ゲーム",
                        count: $azurLane.akashiCountGusu,
                        color: .personalSummerLightRed,
                        bigNumber: $azurLane.akashiCountSum,
                        numberofDicimal: 0,
                        minusBool: $azurLane.minusCheck) {
                            azurLane.akashiCountSumFunc()
                        }
                    // 最終ゲーム
                    unitCountButtonPercentWithFunc(
                        title: "最終ゲーム",
                        count: $azurLane.akashiCountLast,
                        color: .personalSummerLightBlue,
                        bigNumber: $azurLane.akashiCountSum,
                        numberofDicimal: 0,
                        minusBool: $azurLane.minusCheck) {
                            azurLane.akashiCountSumFunc()
                        }
                }
                .popoverTip(tipVer391AzurLaneAkashi())
                
                // 参考情報）振り分け
                unitLinkButtonViewBuilder(sheetTitle: "告知G数の振分け") {
                    HStack(spacing: 0) {
                        unitTableSettingIndex()
                        unitTablePercent(
                            columTitle: "奇数ゲーム",
                            percentList: azurLane.ratioAkashiKisu,
                        )
                        unitTablePercent(
                            columTitle: "偶数ゲーム",
                            percentList: azurLane.ratioAkashiGusu,
                        )
                        unitTablePercent(
                            columTitle: "最終ゲーム",
                            percentList: [azurLane.ratioAkashiLast[0]],
                            lineList: [6],
                            colorList: [.white],
                        )
                    }
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        azurLaneView95Ci(
                            azurLane: azurLane,
                            selection: 9,
                        )
                    )
                )
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    azurLaneViewBayes(
                        azurLane: azurLane,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("告知G数")
            }
//            unitAdBannerMediumRectangle()
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($ver391.azurLaneMenuAkashiBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: azurLane.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("明石チャレンジ")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $azurLane.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: azurLane.resetAkashi)
                }
            }
        }
    }
}

#Preview {
    azurLaneViewAkashi(
        ver391: Ver391(),
        azurLane: AzurLane(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
