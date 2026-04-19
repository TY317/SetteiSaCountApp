//
//  enen2TableEndingRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/19.
//

import SwiftUI

struct enen2TableEndingRatio: View {
    let items: [String] = ["十字目リプ以外", "十字目リプ"]
    @State var selectedItem: String = "十字目リプ以外"
    var body: some View {
        Picker("", selection: self.$selectedItem) {
            ForEach(self.items, id: \.self) { item in
                Text(item)
            }
        }
        .pickerStyle(.segmented)
        .padding(.bottom)
        
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "奇数示唆",
                        "偶数示唆",
                        "高設定示唆",
                        "設定2 以上濃厚",
                        "設定4 以上濃厚",
                        "設定5 以上濃厚",
                        "設定6 濃厚",
                    ])
                unitTablePercent(
                    columTitle: "設定1",
                    percentList: [51,34,15,0,0,0,0],
                    maxWidth: 70,
                )
                unitTablePercent(
                    columTitle: "設定2",
                    percentList: setting2Ratio(item: self.selectedItem),
                    maxWidth: 70,
                )
                unitTablePercent(
                    columTitle: "設定3",
                    percentList: setting3Ratio(item: self.selectedItem),
                    maxWidth: 70,
                )
            }
            
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "奇数示唆",
                        "偶数示唆",
                        "高設定示唆",
                        "設定2 以上濃厚",
                        "設定4 以上濃厚",
                        "設定5 以上濃厚",
                        "設定6 濃厚",
                    ])
                unitTablePercent(
                    columTitle: "設定4",
                    percentList: setting4Ratio(item: self.selectedItem),
                    maxWidth: 70,
                )
                unitTablePercent(
                    columTitle: "設定5",
                    percentList: setting5Ratio(item: self.selectedItem),
                    maxWidth: 70,
                )
                unitTablePercent(
                    columTitle: "設定6",
                    percentList: setting6Ratio(item: self.selectedItem),
                    maxWidth: 70,
                )
            }
        }
    }
    
    func setting2Ratio(item: String) -> [Double] {
        switch item {
        case self.items[1]: return [30,45,15,10,0,0,0]
        default: return [32,48,15,5,0,0,0]
        }
    }
    func setting3Ratio(item: String) -> [Double] {
        switch item {
        case self.items[1]: return [45,30,15,10,0,0,0]
        default: return [48,32,15,5,0,0,0]
        }
    }
    func setting4Ratio(item: String) -> [Double] {
        switch item {
        case self.items[1]: return [24,36,20,10,10,0,0]
        default: return [28,42,20,5,5,0,0]
        }
    }
    func setting5Ratio(item: String) -> [Double] {
        switch item {
        case self.items[1]: return [30,20,20,10,10,10,0]
        default: return [39,26,20,5,5,5,0]
        }
    }
    func setting6Ratio(item: String) -> [Double] {
        switch item {
        case self.items[1]: return [16,24,20,10,10,10,10]
        default: return [22,33,20,10,5,5,5]
        }
    }
}

#Preview {
    enen2TableEndingRatio()
        .padding(.horizontal)
}
