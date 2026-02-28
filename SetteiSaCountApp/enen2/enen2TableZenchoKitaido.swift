//
//  enen2TableZenchoKitaido.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/28.
//

import SwiftUI

struct enen2TableZenchoKitaido: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "88Gで移行なし",
                        "88Gで連続演出すらなし",
                        "250Gで移行なし",
                        "350Gで移行",
                        "550Gで移行",
                    ],
                    maxWidth: 200,
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "通常C以上濃厚",
                        "通常D以上濃厚",
                        "通常B以上期待度UP",
                        "通常B以上期待度 大",
                        "通常B期待度 大",
                    ],
                    maxWidth: 200,
                )
            }
            .padding(.bottom)
            Text("[中華半島上陸作戦 移行期待度]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableGameIndex(gameList: [88,250,350,450,550,650,750,850])
                unitTableString(
                    columTitle: "通常A",
                    stringList: [
                        "濃厚",
                        "◎",
                        "△",
                        "濃厚",
                        "△",
                        "濃厚",
                        "◎",
                        "天井"
                    ]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: [
                        "濃厚",
                        "◎",
                        "△",
                        "濃厚",
                        "△",
                        "天井",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "通常C",
                    stringList: [
                        "◎",
                        "◎",
                        "△",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "通常D",
                    stringList: [
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "通常E",
                    stringList: [
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
            }
        }
    }
}

#Preview {
    enen2TableZenchoKitaido()
        .padding(.horizontal)
}
