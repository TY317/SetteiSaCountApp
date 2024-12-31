//
//  danvineViewPt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/31.
//

import SwiftUI

struct danvineViewPt: View {
    @ObservedObject var danvine = Danvine()
    @State var isShowAlert = false
    
    var body: some View {
        List {
            Section {
                // //// カウントボタン
                HStack {
                    // 11以外
                    unitCountButtonVerticalWithoutRatio(
                        title: "11Pt以外",
                        count: $danvine.ptCountNot11,
                        color: .personalSummerLightBlue,
                        minusBool: $danvine.minusCheck
                    )
                    // 11以外
                    unitCountButtonVerticalWithoutRatio(
                        title: "11Pt",
                        count: $danvine.ptCount11,
                        color: .personalSummerLightRed,
                        minusBool: $danvine.minusCheck
                    )
                    // 確率
                    unitResultRatioPercent2Line(
                        title: "11Pt選択率",
                        count: $danvine.ptCount11,
                        bigNumber: $danvine.ptCountSum,
                        numberofDicimal: 1,
                        spacerBool: false
                    )
                    .padding(.vertical)
                }
                // //// 参考情報リンク
                // 規定ポイントについて
                unitLinkButton(
                    title: "規定Ptについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "規定Ptについて",
                            textBody1: "・オーラ役成立時にポイントを獲得し、規定ポイントに到達すると前兆へ移行、ボーナス当否を告知する",
                            textBody2: "・下表の規定ポイント以外で当選した場合は高設定の期待度アップとなる",
                            textBody3: "・青オーラ役成立時は複数ポイント獲得。かつモードによって獲得ポイントが異なるため現在モードの推測も可能",
                            image1: Image("danvinePoint"),
                            image2: Image("danvineGetPoint")
                        )
                    )
                )
                // 11Ptの選択率について
                unitLinkButton(
                    title: "11Ptの選択率について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "11Ptの選択率",
                            textBody1: "・規定ポイント 11Ptは高設定ほど選択率が高い",
                            image1: Image("danvinePt11Ratio")
                        )
                    )
                )
            } header: {
                Text("規定Pt 11の選択率")
            }
        }
        .navigationTitle("規定ポイント")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $danvine.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: danvine.resetPt)
                }
            }
        }
    }
}

#Preview {
    danvineViewPt()
}
