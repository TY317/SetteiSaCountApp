//
//  railgunTableMaisuSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/15.
//

import SwiftUI

struct railgunTableMaisuSisa: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "087枚OVER",
                    "310枚OVER",
                    "965枚OVER",
                    "456枚OVER\n1456枚OVER",
                    "555枚OVER\n1555枚OVER",
                    "666枚OVER\n1666枚OVER",
                ],
                lineList: [1,1,1,2,2,2],
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "設定2 以上濃厚",
                    "設定3 以上濃厚",
                    "設定4 以上濃厚",
                    "設定4 以上濃厚",
                    "設定5 以上濃厚",
                    "設定6 濃厚",
                ],
                lineList: [1,1,1,2,2,2],
            )
        }
    }
}

#Preview {
    railgunTableMaisuSisa()
}
