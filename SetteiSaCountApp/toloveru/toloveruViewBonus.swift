//
//  toloveruViewBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/09/04.
//

import SwiftUI

struct toloveruViewBonus: View {
    @ObservedObject var toloveru = Toloveru()
    @State var isShowAlert = false
    
    var body: some View {
//        NavigationView {
            List {
                Section {
                    // カウントボタン
                    HStack {
                        unitCountButtonVerticalPercent(title: "ばいんアタック", count: $toloveru.bonusBainCount, color: .personalSummerLightBlue, bigNumber: $toloveru.bonusCountSum, numberofDicimal: 0, minusBool: $toloveru.minusCheck)
                        unitCountButtonVerticalPercent(title: "ぺろぺろチャンス", count: $toloveru.bonusPeroCount, color: .personalSummerLightGreen, bigNumber: $toloveru.bonusCountSum, numberofDicimal: 0, minusBool: $toloveru.minusCheck)
                        unitCountButtonVerticalPercent(title: "愛すぷラッシュ", count: $toloveru.bonusLovesplushCount, color: .personalSummerLightRed, bigNumber: $toloveru.bonusCountSum, numberofDicimal: 0, minusBool: $toloveru.minusCheck)
                    }
                    // 参考情報リンク
                    unitLinkButton(title: "250G以降当選での初回ボーナス種類", exview: AnyView(unitExView5body2image(title: "初回ボーナス種類について（全て噂）", textBody1: "・250以降当選での初回ボーナスは、ばいんアタックが少なくなりやすい！？\n・基本的に差枚2400枚に近づくほどばいんアタックや駆け抜けが多い！？\n・いわゆる冷遇中のばいんアタックの選択率に設定差があるのではという噂！？", textBody2: "・上記仮定のもと、250G以降当選に限って初回ボーナス種類を集計すると設定差があるかも！？", textBody3: "・250G以降当選の初回ボーナスでばいんアタックが一番比率が多いようだとちょっと怪しんだ方がいいかも！？？")))
                } header: {
                    Text("250G以降当選での初回ボーナス種類")
                }
            }
            .navigationTitle("初回ボーナス")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    HStack {
                        unitButtonMinusCheck(minusCheck: $toloveru.minusCheck)
                        unitButtonReset(isShowAlert: $isShowAlert, action: toloveru.resetBonus)
                            .popoverTip(tipUnitButtonReset())
                    }
                }
            }
//        }
//        .navigationTitle("初回ボーナス")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .automatic) {
//                HStack {
//                    unitButtonMinusCheck(minusCheck: $toloveru.minusCheck)
//                    unitButtonReset(isShowAlert: $isShowAlert, action: toloveru.resetBonus)
//                        .popoverTip(tipUnitButtonReset())
//                }
//            }
//        }
    }
}

#Preview {
    toloveruViewBonus()
}
