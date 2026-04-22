//
//  commonSectionCustomKerotto.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/21.
//

import SwiftUI

struct commonSectionCustomKerotto: View {
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
                            "8:00〜11:59",
                            "12:00〜15:59",
                            "16:00〜19:59",
                            "20:00〜23:59",
                        ]
                    )
                    
                    unitTableString(
                        columTitle: "カスタムモード",
                        stringList: [
                            "1：銅が出現",
                            "2：ランダムで出現",
                            "3：最高が出現",
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
    commonSectionCustomKerotto()
}
