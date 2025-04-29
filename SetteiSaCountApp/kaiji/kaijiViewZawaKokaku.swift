//
//  kaijiViewZawaKokaku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/22.
//

import SwiftUI

struct kaijiViewZawaKokaku: View {
//    @ObservedObject var kaiji = Kaiji()
    @ObservedObject var kaiji: Kaiji
    @State var isShowAlert = false
    
    var body: some View {
        List {
            // //// 弱レア役からの移行率
            Section {
                // 注意、説明
                Text("・通常時の弱レア役回数とその弱レア役から高確移行した回数をカウント")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // //// カウントボタン横並び
                HStack {
                    // 弱レア役
                    unitCountButtonVerticalWithoutRatio(
                        title: "弱レア役",
                        count: $kaiji.zawaKokakuCountJakuRare,
                        color: .personalSummerLightBlue,
                        minusBool: $kaiji.minusCheck
                    )
                    // ざわ高確移行
                    unitCountButtonVerticalWithoutRatio(
                        title: "高確移行",
                        count: $kaiji.zawaKokakuCountMove,
                        color: .personalSummerLightRed,
                        minusBool: $kaiji.minusCheck
                    )
                    // 移行率
                    unitResultRatioPercent2Line(
                        title: "移行率",
                        count: $kaiji.zawaKokakuCountMove,
                        bigNumber: $kaiji.zawaKokakuCountJakuRare,
                        numberofDicimal: 0
                    )
                    .padding(.vertical)
                }
                // //// 参考情報）ざわ高確移行率
                unitLinkButton(
                    title: "弱レア役からのざわ高確移行について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "弱レア役からの高確移行",
                            textBody1: "・弱レア役からの高確移行は高設定ほど優遇",
                            textBody2: "・ざわ高確は閃き前兆の高確状態",
                            textBody3: "・滞在中は液晶上に「ざわ」の文字が出現",
                            tableView: AnyView(kaijiTableZawaKokaku(kaiji: kaiji))
                        )
                    )
                )
                // //// 参考情報）小役停止形
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            image1: Image("kaijiKoyakuStyle")
                        )
                    )
                )
                // 95%信頼区間グラフ
                unitNaviLink95Ci(Ci95view: AnyView(kaijiView95Ci(kaiji: kaiji, selection: 1)))
                    .popoverTip(tipUnitButtonLink95Ci())
            } header: {
                Text("弱レア役からの移行率")
            }
        }
        .navigationTitle("ざわ高確")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $kaiji.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: kaiji.resetZawaKokaku)
                }
            }
        }
    }
}

#Preview {
    kaijiViewZawaKokaku(kaiji: Kaiji())
}
