//
//  vvv2TableRushScreenRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/22.
//

import SwiftUI

struct vvv2TableRushScreenRatio: View {
    @State var selectedItem: String = "10セット目"
    let itemList: [String] = ["10セット目", "20セット目", "その他10の倍数セット目"]
    var body: some View {
        VStack {
            Picker("", selection: self.$selectedItem) {
                ForEach(self.itemList, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom)
            
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,4,5,6])
                unitTablePercent(
                    columTitle: "マリエ",
                    percentList: [5,9],
                    lineList: [2,3],
                )
                unitTableString(
                    columTitle: "1号機",
                    stringList: ["1%未満", "1%"],
                    lineList: [2,3],
                )
                if self.selectedItem == self.itemList[0] {
                    unitTablePercent(
                        columTitle: "サキ",
                        percentList: [0,0,5,5,4]
                    )
                    unitTablePercent(
                        columTitle: "リーゼロッテ",
                        percentList: [0,0,0,0,1]
                    )
                } else if self.selectedItem == self.itemList[1] {
                    unitTablePercent(
                        columTitle: "サキ",
                        percentList: [0,0,20,20,16]
                    )
                    unitTablePercent(
                        columTitle: "リーゼロッテ",
                        percentList: [0,0,0,0,4]
                    )
                } else {
                    unitTablePercent(
                        columTitle: "サキ",
                        percentList: [0,0,3,30,24]
                    )
                    unitTablePercent(
                        columTitle: "リーゼロッテ",
                        percentList: [0,0,0,0,6]
                    )
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        vvv2TableRushScreenRatio()
    }
    .padding(.horizontal)
}
