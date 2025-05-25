//
//  rezero2ViewSnowball.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/31.
//

import SwiftUI

struct rezero2ViewSnowball: View {
//    @ObservedObject var rezero2 = Rezero2()
    @ObservedObject var rezero2: Rezero2
    @State var isShowAlert: Bool = false
    var body: some View {
        List {
            Section {
                // カウントボタン横並び
                HStack {
                    // 単発
                    unitCountButtonVerticalPercent(title: "単発", count: $rezero2.snowballCountSingle, color: .personalSummerLightBlue, bigNumber: $rezero2.snowballCountSum, numberofDicimal: 0, minusBool: $rezero2.minusCheck)
                    // 複数セット
                    unitCountButtonVerticalPercent(title: "複数セット", count: $rezero2.snowballCountMultiple, color: .personalSummerLightRed, bigNumber: $rezero2.snowballCountSum, numberofDicimal: 0, minusBool: $rezero2.minusCheck)
                }
                // 参考情報リンク
                unitLinkButton(title: "セット数について", exview: AnyView(unitExView5body2image(title: "チキチキ雪合戦のセット数", textBody1: "・高設定ほど複数セットが出現しやすいとの噂あり", textBody2: "・複数セットの獲得が複数回確認できれば好材料かも")))
            } header: {
                Text("複数セット率")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "Re:ゼロ season2",
                screenClass: screenClass
            )
        }
        .navigationTitle("チキチキ雪合戦")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $rezero2.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: rezero2.resetSnowball)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    rezero2ViewSnowball(rezero2: Rezero2())
}
