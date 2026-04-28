//
//  commonSectionCustomEnterise.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/20.
//

import SwiftUI

struct commonSectionCustomEnterise: View {
    var body: some View {
        Section {
            HStack {
                Text("タイプ")
                Spacer()
                Text("時間帯")
                    .foregroundStyle(Color.secondary)
            }
            unitLinkButtonViewBuilder(sheetTitle: "カスタム詳細") {
                VStack(spacing: 30) {
                    unitTableString(
                        columTitle: "時間帯",
                        stringList: [
                            "9:00〜11:59",
                            "12:00〜14:59",
                            "15:00〜17:59",
                            "18:00〜20:59",
                            "21:00〜23:59",
                            "0:00〜8:59",
                        ]
                    )
                    
                    unitTableString(
                        columTitle: "カスタムモード",
                        stringList: [
                            "1：下位否定が出やすい",
                            "2：ほぼ出現しない",
                            "3：全体的に出現率アップ",
                            "4：最高が超高頻度",
                        ],
                        maxWidth: 250,
                    )
                }
            }
        } header: {
            Text("店長カスタム")
        }
    }
}

#Preview {
    List {
        commonSectionCustomEnterise()
    }
}
