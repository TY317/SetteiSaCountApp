//
//  arifureViewAfterAtKokaku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/05.
//

import SwiftUI

struct arifureViewAfterAtKokaku: View {
//    @ObservedObject var arifure = Arifure()
    @ObservedObject var arifure: Arifure
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            // //// カウントボタン横並び
            HStack {
                // 高確なし
                unitCountButtonVerticalPercent(
                    title: "高確なし",
                    count: $arifure.afterKokakuCountMiss,
                    color: .personalSummerLightBlue,
                    bigNumber: $arifure.afterKokakuCountSum,
                    numberofDicimal: 0,
                    minusBool: $arifure.minusCheck
                )
                // 高確あり
                unitCountButtonVerticalPercent(
                    title: "高確あり",
                    count: $arifure.afterKokakuCountHit,
                    color: .personalSummerLightRed,
                    bigNumber: $arifure.afterKokakuCountSum,
                    numberofDicimal: 0,
                    minusBool: $arifure.minusCheck
                )
            }
            // //// 参考情報リンク
            unitLinkButton(
                title: "AT終了後の高確移行について",
                exview: AnyView(
                    unitExView5body2image(
                        title: "AT終了後の高確移行",
                        textBody1: "・設定変更後やAT・上位AT終了後の高確（魔力駆動四輪ブリーゼステージ）移行に設定差あり",
                        tableView: AnyView(arifureTableAfterKokaku(arifure: arifure))
//                        image1: Image("arifureKokakuStartRatio")
                    )
                )
            )
            // 95%信頼区間グラフ
            unitNaviLink95Ci(Ci95view: AnyView(arifureView95Ci(arifure: arifure, selection: 9)))
                .popoverTip(tipUnitButtonLink95Ci())
        }
        .navigationTitle("AT終了後の高確移行")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // マイナスチェック
                    unitButtonMinusCheck(minusCheck: $arifure.minusCheck)
                    // リセットボタン
                    unitButtonReset(isShowAlert: $isShowAlert, action: arifure.resetAfterKokaku)
                }
            }
        }
    }
}

#Preview {
    arifureViewAfterAtKokaku(arifure: Arifure())
}
