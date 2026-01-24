//
//  hokutoTenseiTableStatusMove.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/23.
//

import SwiftUI

struct hokutoTenseiTableStatusMove: View {
    @State var selectedItem: String = "弱🍒"
    let itemList: [String] = ["弱🍒","🍉","チャンス目・勝舞"]
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
                unitTableSettingIndex()
                
                if self.selectedItem == self.itemList[0] {
                    unitTablePercent(
                        columTitle: "低確へ",
                        percentList: [53.1,52.0,48.4,37.5,32.8],
                        lineList: [2,1,1,1,1],
                        colorList: [.white,.tableBlue,.white,.tableBlue,]
                    )
                    unitTablePercent(
                        columTitle: "通常へ",
                        percentList: [46.1,46.9,50,59.4,62.5],
                        lineList: [2,1,1,1,1],
                        colorList: [.white,.tableBlue,.white,.tableBlue,]
                    )
                    unitTablePercent(
                        columTitle: "高確へ",
                        percentList: [0.8,1.2,1.6,3.1,4.7],
                        numberofDicimal: 1,
                        lineList: [2,1,1,1,1],
                        colorList: [.white,.tableBlue,.white,.tableBlue,],
                    )
                }
                
                else if self.selectedItem == self.itemList[1] {
                    unitTablePercent(
                        columTitle: "低確へ",
                        percentList: [32.8,32.4,26.6,17.2,10.9],
                        lineList: [2,1,1,1,1],
                        colorList: [.white,.tableBlue,.white,.tableBlue,]
                    )
                    unitTablePercent(
                        columTitle: "通常へ",
                        percentList: [65.6,70.3,76.6,81.3],
                        lineList: [3,1,1,1],
                        colorList: [.tableBlue,.white,.tableBlue,]
                    )
                    unitTablePercent(
                        columTitle: "高確へ",
                        percentList: [1.6,2,3.1,6.3,7.8],
                        numberofDicimal: 1,
                        lineList: [2,1,1,1,1],
                        colorList: [.white,.tableBlue,.white,.tableBlue,],
                    )
                }
                
                else {
                    unitTablePercent(
                        columTitle: "低確へ",
                        percentList: [28.1,27.7,27.3,25,18.8,12.5],
                    )
                    unitTablePercent(
                        columTitle: "通常へ",
                        percentList: [50],
                        lineList: [6],
                        colorList: [.white]
                    )
                    unitTablePercent(
                        columTitle: "高確へ",
                        percentList: [21.9,22.3,22.7,25,31.3,37.5],
                    )
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        hokutoTenseiTableStatusMove(
            selectedItem: "チャンス目・勝舞"
        )
    }
        .padding(.horizontal)
}
