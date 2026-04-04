//
//  shinYoshiTableScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import SwiftUI

struct shinYoshiTableScreen: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "新月",
                    "三日月",
                    "満月",
                    "大岡越前",
                    "柳生",
                    "大奥",
                    "吉宗",
                ],
                maxWidth: 100,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "？？？",
                    "？？？",
                    "？？？",
                    "？？？",
                    "？？？",
                    "？？？",
                ]
            )
        }
    }
}

#Preview {
    shinYoshiTableScreen()
}
