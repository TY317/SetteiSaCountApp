//
//  shakeViewBt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import SwiftUI

struct shakeViewBt: View {
    @ObservedObject var shake: Shake
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            // JAC種類
            Section {
                // カウントボタン横並び
                HStack {
                    // 終了
                    unitCountButtonPercentWithFunc(
                        title: "終了",
                        count: $shake.jacCountEnd,
                        color: .personalSummerLightBlue,
                        bigNumber: $shake.jacCountSum,
                        numberofDicimal: 0,
                        minusBool: $shake.minusCheck) {
                            shake.jackSumFunc()
                        }
                    // 継続
                    unitCountButtonPercentWithFunc(
                        title: "継続",
                        count: $shake.jacCountContinue,
                        color: .personalSummerLightRed,
                        bigNumber: $shake.jacCountSum,
                        numberofDicimal: 0,
                        minusBool: $shake.minusCheck) {
                            shake.jackSumFunc()
                        }
                    // S
                    unitCountButtonPercentWithFunc(
                        title: "S",
                        count: $shake.jacCountSpecial,
                        color: .personalSummerLightPurple,
                        bigNumber: $shake.jacCountSum,
                        numberofDicimal: 0,
                        minusBool: $shake.minusCheck) {
                            shake.jackSumFunc()
                        }
                }
                
                // 参考情報）JAC割合
                unitLinkButtonViewBuilder(sheetTitle: "JAC種類 割合") {
                    shakeTableBt(shake: shake)
                }
                
                // //// 95%信頼区間グラフへのリンク
                unitNaviLink95Ci(
                    Ci95view: AnyView(
                        shakeView95Ci(
                            shake: shake,
                            selection: 10,
                        )
                    )
                )
                
                // //// 設定期待値へのリンク
                unitNaviLinkBayes {
                    shakeViewBayes(
                        shake: shake,
                        bayes: bayes,
                        viewModel: viewModel,
                    )
                }
            } header: {
                Text("JAC種類 割合")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shakeMenuBtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shake.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("BT中")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $shake.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: shake.resetBt)
            }
        }
    }
}

#Preview {
    shakeViewBt(
        shake: Shake(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
