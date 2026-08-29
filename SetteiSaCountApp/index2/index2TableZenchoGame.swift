//
//  index2TableZenchoGame.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/24.
//

import SwiftUI

struct index2TableZenchoGame: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "50Gから前兆開始",
                    "100Gで魔導図書に移動なし",
                    "100Gごとのゾーン\n2連続で魔導図書に移行なし",
                    "150Gから前兆開始",
                    "200Gで魔導図書に移動なし",
                ],
                maxWidth: 200,
                lineList: [1,1,2,1,1]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "天国濃厚",
                    "天国準備濃厚",
                    "天国準備濃厚",
                    "天国準備濃厚",
                    "通常B or 天国準備濃厚",
                ],
                maxWidth: 160,
                lineList: [1,1,2,1,1]
            )
        }
    }
}

#Preview {
    index2TableZenchoGame()
        .padding(.horizontal)
}
