//
//  azurLaneViewKokakuStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/30.
//

import SwiftUI

struct azurLaneViewKokakuStart: View {
    @ObservedObject var azurLane: AzurLane
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            // //// 高確スタートカウント
            Section {
                // 注意書き
                Text("・完全に見抜くことは難しいと思いますが、メモ代わりとしてご利用ください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // カウントボタン横並び
                HStack {
                    // 通常
                    unitCountButtonPercentWithFunc(
                        title: "通常",
                        count: $azurLane.startModeCountNormal,
                        color: .personalSummerLightBlue,
                        bigNumber: $azurLane.startModeCountSum,
                        numberofDicimal: 0,
                        minusBool: $azurLane.minusCheck) {
                            azurLane.modeCountSumFunc()
                        }
                    // 高確
                    unitCountButtonPercentWithFunc(
                        title: "高確",
                        count: $azurLane.startModeCountHigh,
                        color: .personalSummerLightRed,
                        bigNumber: $azurLane.startModeCountSum,
                        numberofDicimal: 0,
                        minusBool: $azurLane.minusCheck) {
                            azurLane.modeCountSumFunc()
                        }
                    // 超高確
                    unitCountButtonPercentWithFunc(
                        title: "超高確",
                        count: $azurLane.startModeCountChoHigh,
                        color: .personalSummerLightPurple,
                        bigNumber: $azurLane.startModeCountSum,
                        numberofDicimal: 0,
                        minusBool: $azurLane.minusCheck) {
                            azurLane.modeCountSumFunc()
                        }
                }
                // 参考情報）AT後のモード振り分け
                unitLinkButtonViewBuilder(sheetTitle: "AT後のモード振り分け") {
                    VStack {
                        Text("・AT後の高確、超高確スタートは高設定ほど優遇")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom)
                        HStack(spacing: 0) {
                            unitTableSettingIndex()
                            unitTablePercent(
                                columTitle: "通常",
                                percentList: azurLane.ratioStartNormal,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "高確",
                                percentList: azurLane.ratioStartHigh,
                                numberofDicimal: 1,
                            )
                            unitTablePercent(
                                columTitle: "超高確",
                                percentList: azurLane.ratioStartChoHigh,
                                numberofDicimal: 1,
                            )
                        }
                    }
                }
                // 参考情報）高確示唆演出
                unitLinkButtonViewBuilder(sheetTitle: "高確示唆演出") {
                    azurLaneTableModeSisa()
                }
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        azurLaneView95Ci(
                            azurLane: azurLane,
                            selection: 6,
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
                Text("高確スタートカウント")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: azurLane.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("高確スタート")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// マイナスチェック
                    unitButtonMinusCheck(minusCheck: $azurLane.minusCheck)
                    // /// リセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: azurLane.resetKokakuStart)
                }
            }
        }
    }
}

#Preview {
    azurLaneViewKokakuStart(
        azurLane: AzurLane(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
}
