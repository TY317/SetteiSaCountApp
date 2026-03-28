//
//  enen2TableScreenRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/23.
//

import SwiftUI

struct enen2TableScreenRatio: View {
    @ObservedObject var enen2: Enen2
    let items: [String] = ["炎炎ボーナス後", "それ以外"]
    @State var selectedItem: String = "炎炎ボーナス後"
    let lowerBeltTextList: [String] = [
        "デフォルト",
        "高設定示唆 弱",
        "高設定示唆 強",
        "設定4 以上濃厚",
        "設定5 以上濃厚",
        "設定6 濃厚",
    ]
    
    var body: some View {
        VStack {
            // ピッカー
            Picker("", selection: self.$selectedItem) {
                ForEach(self.items, id: \.self) { item in
                    Text(item)
                }
            }
            .pickerStyle(.segmented)
            Text("それ以外：REG,アクセルボーナス,灰焔ボーナス後")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom)
            if self.selectedItem == self.items[0] {
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: self.lowerBeltTextList,
                    )
                    unitTablePercent(
                        columTitle: "設定1",
                        percentList: [
                            enen2.ratioScreenBig1[0],
                            enen2.ratioScreenBig2[0],
                            enen2.ratioScreenBig3[0],
                            enen2.ratioScreenBig4[0],
                            enen2.ratioScreenBig5[0],
                            enen2.ratioScreenBig6[0],
                        ],
                        maxWidth: 70,
                    )
                    unitTablePercent(
                        columTitle: "設定2",
                        percentList: [
                            enen2.ratioScreenBig1[1],
                            enen2.ratioScreenBig2[1],
                            enen2.ratioScreenBig3[1],
                            enen2.ratioScreenBig4[1],
                            enen2.ratioScreenBig5[1],
                            enen2.ratioScreenBig6[1],
                        ],
                        maxWidth: 70,
                    )
                    unitTablePercent(
                        columTitle: "設定3",
                        percentList: [
                            enen2.ratioScreenBig1[2],
                            enen2.ratioScreenBig2[2],
                            enen2.ratioScreenBig3[2],
                            enen2.ratioScreenBig4[2],
                            enen2.ratioScreenBig5[2],
                            enen2.ratioScreenBig6[2],
                        ],
                        maxWidth: 70,
                    )
                }
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: self.lowerBeltTextList,
                    )
                    unitTablePercent(
                        columTitle: "設定4",
                        percentList: [
                            enen2.ratioScreenBig1[3],
                            enen2.ratioScreenBig2[3],
                            enen2.ratioScreenBig3[3],
                            enen2.ratioScreenBig4[3],
                            enen2.ratioScreenBig5[3],
                            enen2.ratioScreenBig6[3],
                        ],
                        maxWidth: 70,
                    )
                    unitTablePercent(
                        columTitle: "設定5",
                        percentList: [
                            enen2.ratioScreenBig1[4],
                            enen2.ratioScreenBig2[4],
                            enen2.ratioScreenBig3[4],
                            enen2.ratioScreenBig4[4],
                            enen2.ratioScreenBig5[4],
                            enen2.ratioScreenBig6[4],
                        ],
                        maxWidth: 70,
                    )
                    unitTablePercent(
                        columTitle: "設定6",
                        percentList: [
                            enen2.ratioScreenBig1[5],
                            enen2.ratioScreenBig2[5],
                            enen2.ratioScreenBig3[5],
                            enen2.ratioScreenBig4[5],
                            enen2.ratioScreenBig5[5],
                            enen2.ratioScreenBig6[5],
                        ],
                        maxWidth: 70,
                    )
                }
            }
            
            else {
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: self.lowerBeltTextList,
                    )
                    unitTablePercent(
                        columTitle: "設定1",
                        percentList: [
                            enen2.ratioScreen1[0],
                            enen2.ratioScreen2[0],
                            enen2.ratioScreen3[0],
                            enen2.ratioScreen4[0],
                            enen2.ratioScreen5[0],
                            enen2.ratioScreen6[0],
                        ],
                        maxWidth: 70,
                    )
                    unitTablePercent(
                        columTitle: "設定2",
                        percentList: [
                            enen2.ratioScreen1[1],
                            enen2.ratioScreen2[1],
                            enen2.ratioScreen3[1],
                            enen2.ratioScreen4[1],
                            enen2.ratioScreen5[1],
                            enen2.ratioScreen6[1],
                        ],
                        maxWidth: 70,
                    )
                    unitTablePercent(
                        columTitle: "設定3",
                        percentList: [
                            enen2.ratioScreen1[2],
                            enen2.ratioScreen2[2],
                            enen2.ratioScreen3[2],
                            enen2.ratioScreen4[2],
                            enen2.ratioScreen5[2],
                            enen2.ratioScreen6[2],
                        ],
                        maxWidth: 70,
                    )
                }
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: self.lowerBeltTextList,
                    )
                    unitTablePercent(
                        columTitle: "設定4",
                        percentList: [
                            enen2.ratioScreen1[3],
                            enen2.ratioScreen2[3],
                            enen2.ratioScreen3[3],
                            enen2.ratioScreen4[3],
                            enen2.ratioScreen5[3],
                            enen2.ratioScreen6[3],
                        ],
                        maxWidth: 70,
                    )
                    unitTablePercent(
                        columTitle: "設定5",
                        percentList: [
                            enen2.ratioScreen1[4],
                            enen2.ratioScreen2[4],
                            enen2.ratioScreen3[4],
                            enen2.ratioScreen4[4],
                            enen2.ratioScreen5[4],
                            enen2.ratioScreen6[4],
                        ],
                        maxWidth: 70,
                    )
                    unitTablePercent(
                        columTitle: "設定6",
                        percentList: [
                            enen2.ratioScreen1[5],
                            enen2.ratioScreen2[5],
                            enen2.ratioScreen3[5],
                            enen2.ratioScreen4[5],
                            enen2.ratioScreen5[5],
                            enen2.ratioScreen6[5],
                        ],
                        maxWidth: 70,
                    )
                }
            }
        }
    }
}

#Preview {
    enen2TableScreenRatio(
        enen2: Enen2(),
    )
    .padding(.horizontal)
}
