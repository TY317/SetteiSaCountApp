//
//  bangdreamTableCycle1Band.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/28.
//

import SwiftUI

struct bangdreamTableCycle1Band: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "Poppin'Party",
                    "Afterglow",
                    "Pastel*Palettes",
                    "ﾊﾛｰ,ﾊｯﾋﾟｰﾜｰﾙﾄﾞ!",
                    "Roselia"
                ],
                maxWidth: 150,
                lineList: [1,2,1,1,1],
                contentFont: .body
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "モードB以上期待度 約50%\nモードC以上期待度 約30%",
                    "モードC以上期待度 約40%",
                    "引き戻し以上期待度 約37%",
                    "引き戻し以上期待度 約50%"
                ],
                maxWidth: 250,
                lineList: [1,2,1,1,1],
                contentFont: .subheadline
            )
        }
    }
}

#Preview {
    bangdreamTableCycle1Band()
        .padding(.horizontal)
}
