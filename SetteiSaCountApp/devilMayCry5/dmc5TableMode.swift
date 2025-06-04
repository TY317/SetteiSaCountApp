//
//  dmc5TableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/01.
//

import SwiftUI

struct dmc5TableMode: View {
    var body: some View {
        VStack {
            Text("[ゾーン表]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableGameIndex(
                    gameList: [100,200,300,400,500,600,700,800,900,1000],
                    contentFont: .body
                )
                unitTableString(
                    columTitle: "通常A",
                    stringList: [
                        "◯",
                        "◯",
                        "×",
                        "×",
                        "▲",
                        "▲",
                        "×",
                        "×",
                        "×",
                        "天井"
                    ]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: [
                        "◯",
                        "◯",
                        "×",
                        "◎",
                        "×",
                        "◎",
                        "×",
                        "×",
                        "天井",
                        "grayOut"
                    ]
                )
                unitTableString(
                    columTitle: "通常C",
                    stringList: [
                        "◯",
                        "◯",
                        "◎",
                        "×",
                        "▲",
                        "◯",
                        "×",
                        "天井",
                        "grayOut",
                        "grayOut"
                    ]
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: [
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut"
                    ]
                )
            }
            Text("期待度：◎ > ◯ > ▲ > ×")
        }
    }
}

#Preview {
    dmc5TableMode()
        .padding(.horizontal)
}
