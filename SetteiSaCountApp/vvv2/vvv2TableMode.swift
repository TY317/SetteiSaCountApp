//
//  vvv2TableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/06.
//

import SwiftUI

struct vvv2TableMode: View {
    let itemList: [String] = ["前回600pt以外","前回600pt"]
    @State var selectedItem: String = "前回600pt以外"
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・周期ポイント、周期当落を4つのモードで管理")
                Text("・1周期目は全モード共通で周期ポイント200ptがポイント天井となる(100ptの振分けは5〜10%)")
            }
            .padding(.bottom)
            Text("[2〜6周期目 規定ポイント振分け]")
                .font(.title2)
            Picker("", selection: self.$selectedItem) {
                ForEach(self.itemList, id: \.self) { item in
                    Text(item)
                }
            }
            .pickerStyle(.segmented)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "100pt",
                        "200pt",
                        "300pt",
                        "400pt",
                        "500pt",
                        "600pt",
                    ],
                )
//                unitTableString(
//                    columTitle: "通常A",
//                    stringList: ["◎","◯","△","◎","△","天井",]
//                )
                unitTablePercent(
                    columTitle: "通常A",
                    percentList: self.selectedItem == self.itemList[0] ? [25,23,5,28,4,15] : [16,31,6,47,0,0],
                    colorList: self.selectedItem == self.itemList[0] ? [.tableBlue,.white,.tableBlue,.white,.tableBlue,.white,] : [.tableBlue,.white,.tableBlue,.white,.gray,.gray]
                )
//                unitTableString(
//                    columTitle: "通常B",
//                    stringList: ["◎","◯","◯","◯","◯","天井",]
//                )
                unitTablePercent(
                    columTitle: "通常B",
                    percentList: self.selectedItem == self.itemList[0] ? [29,13,16,12,14,16] : [20,32,31,17,0,0],
                    colorList: self.selectedItem == self.itemList[0] ? [.tableBlue,.white,.tableBlue,.white,.tableBlue,.white,] : [.tableBlue,.white,.tableBlue,.white,.gray,.gray]
                )
//                unitTableString(
//                    columTitle: "通常C",
//                    stringList: ["◎","◎","△","天井","grayOut","grayOut",]
//                )
                unitTablePercent(
                    columTitle: "通常C",
                    percentList: self.selectedItem == self.itemList[0] ? [35,44,3,18,0,0] : [38,39,3,20,0,0],
                    colorList: [.tableBlue,.white,.tableBlue,.white,.gray,.gray]
                )
//                unitTableString(
//                    columTitle: "天国",
//                    stringList: ["天井","grayOut","grayOut","grayOut","grayOut","grayOut",]
//                )
            }
            .padding(.bottom)
            Text("[周期振分け]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "1周期",
                        "2周期",
                        "3周期",
                        "4周期",
                        "5周期",
                        "6周期",
                    ],
                )
//                unitTableString(
//                    columTitle: "通常A",
//                    stringList: ["◯","◎","△","◯","◯","天井",]
//                )
                unitTablePercent(
                    columTitle: "通常A",
                    percentList: [14,29,4,15,13,23]
                )
//                unitTableString(
//                    columTitle: "通常B",
//                    stringList: ["△","◯","天井","grayOut","grayOut","grayOut",]
//                )
                unitTablePercent(
                    columTitle: "通常B",
                    percentList: [5,13,82,0,0,0],
                    colorList: [.tableBlue,.white,.tableBlue,.gray,.gray,.gray,]
                )
//                unitTableString(
//                    columTitle: "通常C",
//                    stringList: ["◯","◯","◯","◯","天井","grayOut",]
//                )
                unitTablePercent(
                    columTitle: "通常C",
                    percentList: [11,18,14,12,45,0],
                    colorList: [.tableBlue,.white,.tableBlue,.white,.tableBlue,.gray,]
                )
//                unitTableString(
//                    columTitle: "天国",
//                    stringList: ["天井","grayOut","grayOut","grayOut","grayOut","grayOut",]
//                )
                unitTablePercent(
                    columTitle: "天国",
                    percentList: [100,0,0,0,0,0,],
                    colorList: [.tableBlue,.gray,.gray,.gray,.gray,.gray,]
                )
            }
        }
    }
}

#Preview {
    ScrollView {
        vvv2TableMode()
    }
        .padding(.horizontal)
}
