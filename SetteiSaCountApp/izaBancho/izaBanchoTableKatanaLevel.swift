//
//  izaBanchoTableKatanaLevel.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/05.
//

import SwiftUI

struct izaBanchoTableKatanaLevel: View {
    var body: some View {
        VStack {
            Text("[刀の色によるレベル示唆]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: ["青","黄","赤"],
                    maxWidth: 100,
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "全レベルの可能性あり",
                        "レベル2 以上濃厚",
                        "レベル3 濃厚",
                    ],
                    maxWidth: 200,
                )
            }
            .padding(.bottom)
            Text("[CZ,AT非当選時のレベル移行抽選]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "レベル2へ移行",
                        "レベル3へ移行",
                    ]
                )
                unitTablePercent(
                    columTitle: "レベル1滞在中",
                    percentList: [99.6,0.4],
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "レベル2滞在中",
                    percentList: [93.7,6.3],
                    numberofDicimal: 1,
                )
            }
        }
    }
}

#Preview {
    izaBanchoTableKatanaLevel()
        .padding(.horizontal)
}
