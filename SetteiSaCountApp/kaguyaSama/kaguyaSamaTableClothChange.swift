//
//  kaguyaSamaTableClothChange.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/14.
//

import SwiftUI

struct kaguyaSamaTableClothChange: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "制服→ラブ探偵",
                    "制服→体操着",
                    "ラブ探偵→体操着",
                    "ラブ探偵→制服",
                    "体操着→制服",
                    "体操着→ラブ探偵",
                ],
                lineList: [1,2,2,1,1,1],
                contentFont: .body,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "通常B 以上濃厚",
                    "通常C 以上濃厚\n引き戻しゾーン中は天国濃厚",
                    "通常C 以上濃厚\n引き戻しゾーン中は天国濃厚",
                    "設定2 以上濃厚",
                    "設定4 以上濃厚",
                    "設定6 濃厚",
                ],
                maxWidth: 200,
                lineList: [1,2,2,1,1,1],
                contentFont: .body,
            )
        }
    }
}

#Preview {
    kaguyaSamaTableClothChange()
        .padding(.horizontal)
}
