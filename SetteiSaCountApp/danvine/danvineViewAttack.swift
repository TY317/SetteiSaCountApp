//
//  danvineViewAttack.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/30.
//

import SwiftUI

struct danvineViewAttack: View {
    @ObservedObject var danvine = Danvine()
    @State var isShowAlert = false
    var body: some View {
        List {
            Section {
                // //// カウントボタン
                HStack {
                    // ハズレ3連回数
                    unitCountButtonVerticalWithoutRatio(
                        title: "ハズレ3連",
                        count: $danvine.hazure3CountAll,
                        color: .personalSummerLightBlue,
                        minusBool: $danvine.minusCheck
                    )
                    // 高確当選
                    unitCountButtonVerticalWithoutRatio(
                        title: "高確当選",
                        count: $danvine.hazure3CountWin,
                        color: .personalSummerLightRed,
                        minusBool: $danvine.minusCheck
                    )
                    // 当選率
                    unitResultRatioPercent2Line(
                        title: "当選率",
                        count: $danvine.hazure3CountWin,
                        bigNumber: $danvine.hazure3CountAll,
                        numberofDicimal: 0
                    )
                    .padding(.vertical)
                }
                // //// 参考情報
                unitLinkButton(
                    title: "ハズレ3連時のオーラ狙え高確について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ハズレ3連での高確",
                            textBody1: "・ハズレ3連時のオーラ狙え高確の当選率に設定差あり",
                            textBody2: "（ハズレ4連時の当選率にもわずかに設定差あるが微差のためカウント機能は設けていません）",
                            image1: Image("danvineAuraAimRatio")
                        )
                    )
                )
            } header: {
                Text("ハズレ3連続時のオーラ狙え高確当選")
            }
        }
        .navigationTitle("アタックモード")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $danvine.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: danvine.resetAttack)
                }
            }
        }
    }
}

#Preview {
    danvineViewAttack()
}
