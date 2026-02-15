//
//  kokakukidotaiTableEyechatch.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/15.
//

import SwiftUI

struct kokakukidotaiTableEyechatch: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "キャラなし",
                    "素子",
                    "タチコマ",
                    "3人＋タチコマ",
                    "9課",
                    "アオイ",
                ],
                maxWidth: 120,
                lineList: [1,2,2,2,3,2],
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "約60%で殲滅ゾーン3回以上",
                    "タチコマCZ保有期待＋モードD示唆 弱",
                    "殲滅ゾーン3回以上\nor モードD",
                    "殲滅ゾーン5回以上\nor モードD\n(約75%でモードD)",
                    "???",
                ],
                maxWidth: 200,
                lineList: [1,2,2,2,3,2],
            )
        }
    }
}

#Preview {
    kokakukidotaiTableEyechatch()
        .padding(.horizontal)
}
