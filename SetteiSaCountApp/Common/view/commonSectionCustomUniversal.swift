//
//  commonSectionCustomUniversal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/21.
//

import SwiftUI

struct commonSectionCustomUniversal: View {
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
                    VStack {
                        unitTableString(
                            columTitle: "時間帯",
                            stringList: [
                                "8:00〜11:59",
                                "12:00〜16:59",
                                "17:00〜19:59",
                                "20:00〜23:59",
                            ]
                        )
                        Text("※ 上記は一例で時間帯の数字もカスタム可能")
                            .foregroundStyle(Color.secondary)
                            .font(.caption)
                    }
                    
                    unitTableString(
                        columTitle: "カスタムモード",
                        stringList: [
                            "2：銅が出現",
                            "3：銀が出現",
                            "4：金が出現",
                            "5：花火柄が出現",
                            "6：最高プレート",
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
    commonSectionCustomUniversal()
}
