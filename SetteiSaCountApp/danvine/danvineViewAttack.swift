//
//  danvineViewAttack.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/30.
//

import SwiftUI

struct danvineViewAttack: View {
//    @ObservedObject var danvine = Danvine()
    @ObservedObject var danvine: Danvine
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
                            tableView: AnyView(danvineTableHazure3ren())
//                            image1: Image("danvineAuraAimRatio")
                        )
                    )
                )
                unitNaviLink95Ci(Ci95view: AnyView(danvineView95Ci(danvine: danvine, selection: 4)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("ハズレ3連続時のオーラ狙え高確当選")
            }
            
            // //// 敵機数での示唆
            Section {
                unitLinkButton(
                    title: "撃破数、初期機数での示唆について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "機数での示唆",
                            textBody1: "・残り1001機からスタートの場合は設定6濃厚",
                            textBody2: "・敵撃破数がゾロ目の場合は特定設定以上が濃厚となる",
                            tableView: AnyView(danvineTableEnemyNumberSisa())
//                            image1: Image("danvineAttackEnemyNumber")
                        )
                    )
                )
            } header: {
                Text("撃破数、初期機数での示唆")
            }
            
            // //// 突入時の成功
            Section {
                unitLinkButton(
                    title: "突入時の成功抽選について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "突入時成功抽選",
                            textBody1: "・アタックモード当選時に成功抽選をしており、当選時は必ず成功",
                            textBody2: "・高設定ほど当選率が高い",
                            textBody3: "・自力で成功した場合は判別はできないが、初期機数が777機や1001機の場合は成功抽選の当選に期待できる",
                            textBody4: "・残りゲーム数が0かつ、オーラ狙え高確中以外の敵非撃破でアタックモードが終了しない場合も成功抽選の当選に期待できる",
                            tableView: AnyView(danvineTableAttackStartRatio())
//                            image1: Image("danvineAttackWinRatio")
                        )
                    )
                )
            } header: {
                Text("突入時の成功抽選")
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
    danvineViewAttack(danvine: Danvine())
}
