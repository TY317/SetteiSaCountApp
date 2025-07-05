//
//  watakonTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/28.
//

import SwiftUI

struct watakonTableMode: View {
    var body: some View {
        VStack {
            Text("[ゾーン表]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "〜50G",
                        "〜100G",
                        "〜150G",
                        "〜200G",
                        "〜250G",
                        "〜300G",
                        "〜350G",
                        "〜400G",
                        "〜450G",
                        "〜500G",
                        "〜550G",
                        "〜600G",
                        "〜650G",
                        "〜700G",
                        "〜750G",
                        "〜800G",
                    ],
                    contentFont: .body,
                )
                unitTableString(
                    columTitle: "通常A",
                    stringList: [
                        "-",
                        "△",
                        "-",
                        "-",
                        "◯",
                        "-",
                        "◯",
                        "-",
                        "◯",
                        "-",
                        "-",
                        "-",
                        "◎",
                        "-",
                        "◎",
                        "天井"
                    ]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: [
                        "-",
                        "△",
                        "◯",
                        "-",
                        "-",
                        "-",
                        "◎",
                        "-",
                        "-",
                        "-",
                        "◎",
                        "-",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut"
                    ]
                )
                unitTableString(
                    columTitle: "通常C",
                    stringList: [
                        "-",
                        "△",
                        "◯",
                        "-",
                        "◯",
                        "-",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: [
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "超天国",
                    stringList: [
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
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
//            Text("期待度：◯ > △ > ▲")
        }
    }
}

#Preview {
    watakonTableMode()
        .padding(.horizontal)
}
