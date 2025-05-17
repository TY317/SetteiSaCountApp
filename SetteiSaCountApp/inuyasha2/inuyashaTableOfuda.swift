//
//  inuyashaTableOfuda.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/11.
//

import SwiftUI

struct inuyashaTableOfuda: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "好機有り",
                    "勝機有り"
                ],
                maxWidth: 100,
                lineList: [2,2]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "次回スルー天井濃厚かつ高設定示唆",
                    "次回スルー天井濃厚かつ設定4 以上濃厚"
                ],
                maxWidth: 200,
                lineList: [2,2]
            )
        }
    }
}

#Preview {
    inuyashaTableOfuda()
}
