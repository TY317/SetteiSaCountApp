//
//  goevaViewAtSuika.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/28.
//

import SwiftUI

struct goevaViewAtSuika: View {
    @ObservedObject var goeva = Goeva()
    @State var isShowAlert = false
    
    var body: some View {
//        NavigationView {
            List {
                Section {
                    // //// カウントボタン
                    HStack {
                        // スイカカウント
                        unitCountButtonVerticalWithoutRatio(title: "スイカ", count: $goeva.atSuikaCount, color: .personalSummerLightGreen, minusBool: $goeva.minusCheck)
                        // CZカウント
                        unitCountButtonVerticalWithoutRatio(title: "CZ当選", count: $goeva.atCzCount, color: .personalSummerLightRed, minusBool: $goeva.minusCheck)
                        // CZ勝利
                        unitCountButtonVerticalWithoutRatio(title: "CZ成功", count: $goeva.atCzWinCount, color: .personalSummerLightPurple, minusBool: $goeva.minusCheck)
                    }
                    // //// 結果表示
                    HStack {
                        // 当選率表示
                        unitResultRatioPercent2Line(title: "CZ当選率", color: .grayBack, count: $goeva.atCzCount, bigNumber: $goeva.atSuikaCount, numberofDicimal: 0)
                        // 勝利率
                        unitResultRatioPercent2Line(title: "CZ成功率", color: .grayBack, count: $goeva.atCzWinCount, bigNumber: $goeva.atCzCount, numberofDicimal: 0)
                    }
                    // //// 参考情報リンク
                    unitLinkButton(title: "スイカからのCZ当選と成功について", exview: AnyView(goevaExViewAtSuika()))
                } header: {
                    Text("スイカとCZ 殲滅作戦")
                }
            }
            .navigationTitle("AT中スイカからのCZ")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $goeva.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: goeva.resetAtSuika)
                    }
                }
            }
//        }
//        .navigationTitle("AT中スイカからのCZ")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: $goeva.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: goeva.resetAtSuika)
//                }
//            }
//        }
    }
}


struct goevaExViewAtSuika: View {
    var body: some View {
        unitExView5body2image(title: "AT中スイカからのCZ", textBody1: "・AT中のスイカからのCZ当選とCZ成功に設定差", image1: Image("goevaAtSuika"))
    }
}

#Preview {
    goevaViewAtSuika()
}
