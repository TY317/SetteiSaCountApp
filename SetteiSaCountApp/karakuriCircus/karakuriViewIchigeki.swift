//
//  karakuriViewIchigeki.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/06.
//

import SwiftUI

struct karakuriViewIchigeki: View {
//    @ObservedObject var karakuri = Karakuri()
    @ObservedObject var karakuri: Karakuri
    @State var isShowAlert: Bool = false
    
    var body: some View {
        List {
            Section {
                Text("2回目以降＆子役ハズレでの成功・失敗をカウント")
                    .font(.footnote)
                // //// カウントボタン
                HStack {
                    // 成功カウントボタン
                    unitCountButtonVerticalWithoutRatio(title: "成功", count: $karakuri.ichigekiSuccessCount, color: .lightRed, minusBool: $karakuri.minusCheck)
                    // 失敗カウントボタン
                    unitCountButtonVerticalWithoutRatio(title: "失敗", count: $karakuri.ichigekiFalceCount, color: .personalSummerLightBlue, minusBool: $karakuri.minusCheck)
                    // 成功率
                    unitResultRatioPercent2Line(title: "成功率", color: .grayBack, count: $karakuri.ichigekiSuccessCount, bigNumber: $karakuri.ichigekiCountSum, numberofDicimal: 0)
                        .padding(.vertical)
                }
                // //// 参考情報リンク
                unitLinkButton(title: "運命の一劇 成功率について", exview: AnyView(unitExView5body2image(title: "運命の一劇 成功率", textBody1: "・初回の成功は設定差ないと言われている", textBody2: "・2回目以降の成功には設定差があると言われている", textBody3: "・設定差は子役ハズレでの成功率で、設定6では6割程度あるのではとも言われている")))
            } header: {
                Text("2回目以降の運命の一劇")
            }
        }
        .navigationTitle("運命の一劇")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    unitButtonMinusCheck(minusCheck: $karakuri.minusCheck)
                    unitButtonReset(isShowAlert: $isShowAlert, action: karakuri.resetIchigeki)
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}

#Preview {
    karakuriViewIchigeki(karakuri: Karakuri())
}
