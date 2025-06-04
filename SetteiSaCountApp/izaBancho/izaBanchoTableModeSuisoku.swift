//
//  izaBanchoTableModeSuisoku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI

struct izaBanchoTableModeSuisoku: View {
    var body: some View {
        VStack {
            Text("[修行の有無・結果からの推測]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "100G台の修行なし",
                        "200G台の修行ハズレ",
                        "300G台の修行なし",
                        "400G台の修行ハズレ"
                    ],
                    maxWidth: 200,
                    lineList: [1,2,1,1],
                    contentFont: .body
                )
                unitTableString(
                    columTitle: "モード推測",
                    stringList: [
                        "チャンスB濃厚",
                        "チャンスA or チャンスB濃厚",
                        "チャンスA濃厚",
                        "チャンスA濃厚"
                    ],
                    lineList: [1,2,1,1],
                    contentFont: .body
                )
            }
            .padding(.bottom)
            Text("[強対決からの推測]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "強対決でハズレ"
                    ],
                    contentFont: .body
                )
                unitTableString(
                    columTitle: "モード推測",
                    stringList: [
                        "高モードの可能性アップ"
                    ],
                    maxWidth: 200,
                    contentFont: .body
                )
            }
        }
    }
}

#Preview {
    izaBanchoTableModeSuisoku()
}
