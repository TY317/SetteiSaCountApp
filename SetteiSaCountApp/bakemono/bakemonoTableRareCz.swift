//
//  bakemonoTableRareCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/23.
//

import SwiftUI

struct bakemonoTableRareCz: View {
    @ObservedObject var bakemono: Bakemono
    @State var selectedItem: String = "通常"
    let itemList: [String] = ["通常","高確","超高確"]
    var body: some View {
        VStack {
            Picker("", selection: self.$selectedItem) {
                ForEach(self.itemList, id: \.self) { item in
                    Text(item)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom)
            
            HStack(spacing: 0) {
                unitTableSettingIndex(
                    titleLine: 2,
                )
                // 通常
                if self.selectedItem == self.itemList[0] {
                    unitTablePercent(
                        columTitle: "🍉",
                        percentList: bakemono.ratioNormalCzSuika,
                        numberofDicimal: 1,
                        titleLine: 2,
                    )
                    unitTablePercent(
                        columTitle: "強🍒\nチャンス目",
                        percentList: bakemono.ratioNormalCzKyoCerryChance,
                        numberofDicimal: 0,
                        titleLine: 2,
                    )
                    unitTablePercent(
                        columTitle: "強🔔A",
                        percentList: [50],
                        numberofDicimal: 0,
                        titleLine: 2,
                        lineList: [6],
                        colorList: [.white],
                    )
                    unitTablePercent(
                        columTitle: "強🔔B",
                        percentList: [100],
                        numberofDicimal: 0,
                        titleLine: 2,
                        lineList: [6],
                        colorList: [.white],
                    )
                }
                
                // 高確
                else if self.selectedItem == self.itemList[1] {
                    unitTablePercent(
                        columTitle: "🍉",
                        percentList: bakemono.ratioNormalCzKyoCerryChance,
                        numberofDicimal: 0,
                        titleLine: 2,
                    )
                    unitTablePercent(
                        columTitle: "強🍒\nチャンス目",
                        percentList: [50],
                        numberofDicimal: 0,
                        titleLine: 2,
                        lineList: [6],
                        colorList: [.white],
                    )
                    unitTablePercent(
                        columTitle: "強🔔A",
                        percentList: [100],
                        numberofDicimal: 0,
                        titleLine: 2,
                        lineList: [6],
                        colorList: [.white],
                    )
                    unitTablePercent(
                        columTitle: "強🔔B",
                        percentList: [100],
                        numberofDicimal: 0,
                        titleLine: 2,
                        lineList: [6],
                        colorList: [.white],
                    )
                }
                
                // 超高確
                else {
                    unitTablePercent(
                        columTitle: "レア役",
                        percentList: [100],
                        numberofDicimal: 0,
                        titleLine: 2,
                        lineList: [6],
                        colorList: [.white],
                    )
                }
            }
        }
    }
}

#Preview {
    bakemonoTableRareCz(
        bakemono: Bakemono(),
        selectedItem: "超高確"
    )
    .padding(.horizontal)
}
