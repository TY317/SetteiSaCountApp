//
//  tokyoGhoulViewSuperHigh.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/27.
//

import SwiftUI

struct tokyoGhoulViewSuperHigh: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var tokyoGhoul: TokyoGhoul
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            // ///// 保証G数
            Section {
                // 注意書き
                Text("前兆中は超高確滞在でも精神世界に移行しない場合があるため注意")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                
                // カウントボタン横並び
                HStack {
                    // 13G
                    unitCountButtonPercentWithFunc(
                        title: "13G",
                        count: $tokyoGhoul.superHighCountGame13,
                        color: .personalSummerLightBlue,
                        bigNumber: $tokyoGhoul.superHighCountSum,
                        numberofDicimal: 0,
                        minusBool: $tokyoGhoul.minusCheck) {
                            tokyoGhoul.superHighSumFunc()
                        }
                    // 23G
                    unitCountButtonPercentWithFunc(
                        title: "23G",
                        count: $tokyoGhoul.superHighCountGame23,
                        color: .personalSummerLightGreen,
                        bigNumber: $tokyoGhoul.superHighCountSum,
                        numberofDicimal: 0,
                        minusBool: $tokyoGhoul.minusCheck) {
                            tokyoGhoul.superHighSumFunc()
                        }
                    // 33G
                    unitCountButtonPercentWithFunc(
                        title: "33G",
                        count: $tokyoGhoul.superHighCountGame33,
                        color: .personalSummerLightRed,
                        bigNumber: $tokyoGhoul.superHighCountSum,
                        numberofDicimal: 0,
                        minusBool: $tokyoGhoul.minusCheck) {
                            tokyoGhoul.superHighSumFunc()
                        }
                }
                
                // //// 参考情報）保証G数の振分け
                unitLinkButtonViewBuilder(sheetTitle: "保証G数の振分け") {
                    tokyoGhoulTableSuperHigh(tokyoGhoul: tokyoGhoul)
                }
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    tokyoGhoulViewBayes(
                        tokyoGhoul: tokyoGhoul,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("保証G数")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.tokyoGhoulMenuSuperHighBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "東京喰種",
                screenClass: screenClass
            )
        }
        .navigationTitle("精神世界")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $tokyoGhoul.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: tokyoGhoul.resetSuperHigh)
            }
        }
    }
}

#Preview {
    tokyoGhoulViewSuperHigh(
        tokyoGhoul: TokyoGhoul(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
