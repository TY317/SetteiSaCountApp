//
//  jormungandTableRareCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/08.
//

import SwiftUI

struct jormungandTableRareCz: View {
    @ObservedObject var jormungand: Jormungand
    let itemList: [String] = ["通常", "高確"]
    @State var selectedItem: String = "通常"
    var body: some View {
        VStack {
            // セグメントピッカー
            Picker("", selection: self.$selectedItem) {
                ForEach(self.itemList, id: \.self) { item in
                    Text(item)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom)
            
            HStack(spacing: 0) {
                unitTableSettingIndex()
                if self.selectedItem == self.itemList[0] {
                    unitTablePercent(
                        columTitle: "チャンス目",
                        percentList: jormungand.ratioRareCzNormalChance
                    )
                    unitTablePercent(
                        columTitle: "強🍒",
                        percentList: jormungand.ratioRareCzNormalKyoCherry
                    )
                } else {
                    unitTablePercent(
                        columTitle: "チャンス目",
                        percentList: jormungand.ratioRareCzHighChance
                    )
                    unitTablePercent(
                        columTitle: "強🍒",
                        percentList: jormungand.ratioRareCzHighKyoCherry
                    )
                }
            }
        }
    }
}

#Preview {
    jormungandTableRareCz(
        jormungand: Jormungand(),
    )
    .padding(.horizontal)
}
