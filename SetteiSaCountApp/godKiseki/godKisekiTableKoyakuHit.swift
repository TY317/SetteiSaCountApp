//
//  godKisekiTableKoyakuHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/07.
//

import SwiftUI

struct godKisekiTableKoyakuHit: View {
    let items: [String] = ["その他役", "レア役"]
    @State var selectedItem: String = "その他役"
    var body: some View {
        // セグメントピッカー
        Picker("", selection: self.$selectedItem) {
            ForEach(self.items, id: \.self) { item in
                Text(item)
            }
        }
        .pickerStyle(.segmented)
        .padding(.bottom)
        
        if self.selectedItem == self.items[0] {
            HStack(spacing: 0) {
                unitTableSettingIndex(titleLine: 2)
                unitTablePercent(
                    columTitle: "低確A\n低確B\n天国準備",
                    percentList: [0.01,0.01,0.01,0.02,0.01,0.04],
                    numberofDicimal: 2,
                    titleLine: 2,
                )
                unitTablePercent(
                    columTitle: "通常",
                    percentList: [0.01,0.02,0.01,0.03,0.01,0.04],
                    numberofDicimal: 2,
                    titleLine: 2,
                )
                unitTablePercent(
                    columTitle: "天国",
                    percentList: [3.4],
                    numberofDicimal: 1,
                    titleLine: 2,
                    lineList: [6],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "超天国",
                    percentList: [5.4],
                    numberofDicimal: 1,
                    titleLine: 2,
                    lineList: [6],
                    colorList: [.white],
                )
            }
        } else {
            VStack {
                Text("・全設定共通")
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "中段青7",
                            "右上り黄7",
                            "中段黄7",
                            "SP役",
                        ],
                        titleLine: 2,
                    )
                    unitTablePercent(
                        columTitle: "低確A\n低確B\n天国準備",
                        percentList: [0.2,0.7,7.5,50],
                        numberofDicimal: 1,
                        titleLine: 2,
                    )
                    unitTablePercent(
                        columTitle: "通常",
                        percentList: [0.3,3.5,15.0,50],
                        numberofDicimal: 1,
                        titleLine: 2,
                    )
                    unitTablePercent(
                        columTitle: "天国",
                        percentList: [40,60,80,50],
                        numberofDicimal: 0,
                        titleLine: 2,
    //                    lineList: [6],
    //                    colorList: [.white],
                    )
                    unitTablePercent(
                        columTitle: "超天国",
                        percentList: [75,80,90,50],
                        numberofDicimal: 0,
                        titleLine: 2,
    //                    lineList: [6],
    //                    colorList: [.white],
                    )
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        godKisekiTableKoyakuHit()
    }
    .padding(.horizontal)
}
