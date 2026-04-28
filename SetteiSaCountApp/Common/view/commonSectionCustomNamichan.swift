//
//  commonSectionCustomNamichan.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/22.
//

import SwiftUI

struct commonSectionCustomNamichan: View {
    var body: some View {
        Section {
            HStack {
                Text("タイプ")
                Spacer()
                Text("ゲーム数")
                    .foregroundStyle(Color.secondary)
            }
            unitLinkButtonViewBuilder(sheetTitle: "カスタム詳細") {
                VStack(spacing: 30) {
                    unitTableString(
                        columTitle: "ゲーム数",
                        stringList: [
                            "1G〜",
                            "1001G〜",
                            "2001G〜",
                            "3001G〜",
                            "4001G〜",
                            "5001G〜",
                            "6001G〜",
                            "7001G〜",
                            "8001G〜",
                        ]
                    )
                    
                    unitTableString(
                        columTitle: "カスタムモード",
                        stringList: [
                            "1：銅トロフィー",
                            "2：ランダム",
                            "3：最高トロフィー",
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
    commonSectionCustomNamichan()
}
