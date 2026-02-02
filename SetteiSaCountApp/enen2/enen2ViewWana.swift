//
//  enen2ViewWana.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/02.
//

import SwiftUI

struct enen2ViewWana: View {
    @ObservedObject var enen2: Enen2
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    @State var isShowAlert: Bool = false
    var body: some View {
        List {
            // ---- 成功期待度
            Section {
                HStack {
                    // 失敗
                    unitCountButtonPercentWithFunc(
                        title: "失敗",
                        count: $enen2.wanaCountMiss,
                        color: .personalSummerLightBlue,
                        bigNumber: $enen2.wanaCountSum,
                        numberofDicimal: 0,
                        minusBool: $enen2.minusCheck) {
                            enen2.wanaSumFunc()
                        }
                    // 成功
                    unitCountButtonPercentWithFunc(
                        title: "成功",
                        count: $enen2.wanaCountHit,
                        color: .personalSummerLightRed,
                        bigNumber: $enen2.wanaCountSum,
                        numberofDicimal: 0,
                        minusBool: $enen2.minusCheck) {
                            enen2.wanaSumFunc()
                        }
                }
                
                // 参考情報）成功期待度
                unitLinkButtonViewBuilder(sheetTitle: "成功期待度") {
                    VStack(alignment: .leading) {
                        Text("・伝道者の罠 成功期待度は約40%とされているが、高設定ほど優遇!?")
                        Text("　(前作は40〜45%の設定差)")
                    }
                }
            } header: {
                Text("成功率")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.enen2MenuWanaBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("伝道者の罠")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // //// マイナスチェック
                unitButtonMinusCheck(minusCheck: $enen2.minusCheck)
            }
            ToolbarItem(placement: .automatic) {
                // /// リセット
                unitButtonReset(isShowAlert: $isShowAlert, action: enen2.resetWana)
            }
        }
    }
}

#Preview {
    enen2ViewWana(
        enen2: Enen2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
