//
//  toreveTablePtTable.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/03.
//

import SwiftUI

struct toreveTablePtTable: View {
    @State var selectedKind: String = "通常時"
    let kindList: [String] = ["通常時", "東卍ラッシュ中"]
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・モードごとにポイント天井、期待度が変化")
                Text("・1周期目は全モード一律で天井が200")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            Picker("", selection: self.$selectedKind) {
                ForEach(self.kindList, id: \.self) { kind in
                    Text(kind)
                }
            }
            .pickerStyle(.segmented)
            Text("[1周期目]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "100pt",
                        "200pt",
                        "300pt",
                        "400pt",
                        "500pt",
                    ],
                    maxWidth: 80,
                )
                unitTablePercent(
                    columTitle: "通常A",
                    percentList: [12.5,87.5,0,0,0],
                    colorList: [.tableBlue, .white, .gray,.gray,.gray,]
                )
                unitTablePercent(
                    columTitle: "通常B",
                    percentList: [12.5,87.5,0,0,0],
                    colorList: [.tableBlue, .white, .gray,.gray,.gray,]
                )
                unitTablePercent(
                    columTitle: "チャンス",
                    percentList: [12.5,87.5,0,0,0],
                    colorList: [.tableBlue, .white, .gray,.gray,.gray,]
                )
                unitTablePercent(
                    columTitle: "天国",
                    percentList: [12.5,87.5,0,0,0],
                    colorList: [.tableBlue, .white, .gray,.gray,.gray,]
                )
                unitTablePercent(
                    columTitle: "特殊",
                    percentList: [12.5,87.5,0,0,0],
                    colorList: [.tableBlue, .white, .gray,.gray,.gray,]
                )
//                unitTableString(
//                    columTitle: "通常A",
//                    stringList: [
//                        "◯",
//                        "天井",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                    ]
//                )
//                unitTableString(
//                    columTitle: "通常B",
//                    stringList: [
//                        "◯",
//                        "天井",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                    ]
//                )
//                unitTableString(
//                    columTitle: "チャンス",
//                    stringList: [
//                        "◯",
//                        "天井",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                    ]
//                )
//                unitTableString(
//                    columTitle: "天国",
//                    stringList: [
//                        "◯",
//                        "天井",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                    ]
//                )
//                unitTableString(
//                    columTitle: "特殊",
//                    stringList: [
//                        "◯",
//                        "天井",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                    ]
//                )
            }
            .padding(.bottom)
            Text("[2〜6周期目]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "100pt",
                        "200pt",
                        "300pt",
                        "400pt",
                        "500pt",
                    ],
                    maxWidth: 80,
                )
                if self.selectedKind == self.kindList[0] {
                    unitTablePercent(
                        columTitle: "通常A",
                        percentList: [9.8,3.1,43,3.1,41],
                    )
                } else {
                    unitTablePercent(
                        columTitle: "通常A",
                        percentList: [9.8,3.1,46.9,3.1,37.1],
                    )
                }
                unitTablePercent(
                    columTitle: "通常B",
                    percentList: [6.3,25,68.6,0,0],
                    colorList: [.tableBlue,.white,.tableBlue,.gray,.gray]
                )
                if self.selectedKind == self.kindList[0] {
                    unitTablePercent(
                        columTitle: "チャンス",
                        percentList: [9.8,3.1,34.4,3.1,49.6],
                    )
                } else {
                    unitTablePercent(
                        columTitle: "チャンス",
                        percentList: [9.8,3.1,46.9,3.1,37.1],
                    )
                }
                unitTablePercent(
                    columTitle: "天国",
                    percentList: [0,0,0,0,0],
                    colorList: [.gray,.gray,.gray,.gray,.gray,]
                )
                unitTablePercent(
                    columTitle: "チャンス",
                    percentList: [15.6,15.6,15.6,15.6,37.5],
                )
//                unitTableString(
//                    columTitle: "通常A",
//                    stringList: [
//                        "◯",
//                        "△",
//                        "◎",
//                        "△",
//                        "天井",
//                    ]
//                )
//                unitTableString(
//                    columTitle: "通常B",
//                    stringList: [
//                        "△",
//                        "◯",
//                        "天井",
//                        "grayOut",
//                        "grayOut",
//                    ]
//                )
//                unitTableString(
//                    columTitle: "チャンス",
//                    stringList: [
//                        "◯",
//                        "△",
//                        "◎",
//                        "△",
//                        "天井",
//                    ]
//                )
//                unitTableString(
//                    columTitle: "天国",
//                    stringList: [
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                        "grayOut",
//                    ]
//                )
//                unitTableString(
//                    columTitle: "特殊",
//                    stringList: [
//                        "◯",
//                        "◯",
//                        "◯",
//                        "◯",
//                        "天井",
//                    ]
//                )
            }
        }
    }
}

#Preview {
    toreveTablePtTable()
        .padding(.horizontal)
}
