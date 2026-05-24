//
//  bioRe3TableCzVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/14.
//

import SwiftUI

struct bioRe3TableCzVoice: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "ここまでね",
                    "どこまでも追ってくる",
                    "諦めるにはまだ早い",
                    "良いサンプルが取れた",
                    "私（俺）達は負けない",
                ]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "残り3回以内示唆",
                    "残り3回以内濃厚",
                    "次回CZ成功濃厚",
                    "復活濃厚",
                ]
            )
        }
    }
}

#Preview {
    bioRe3TableCzVoice()
}
