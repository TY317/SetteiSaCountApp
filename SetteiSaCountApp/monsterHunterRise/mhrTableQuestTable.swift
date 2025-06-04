//
//  mhrTableQuestTable.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/27.
//

import SwiftUI

struct mhrTableQuestTable: View {
    var body: some View {
        VStack {
            HStack(spacing:0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "テーブルA",
                        "テーブルB",
                        "天国準備",
                        "天国"
                    ],
                    maxWidth: 100,
                    contentFont: .subheadline
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "偶数回目のｸｴｽﾄに期待",
                        "奇数回目のｸｴｽﾄに期待",
                        "2周期目以降のｸｴｽﾄに期待",
                        "1周期目のｸｴｽﾄで当選"
                    ],
                    maxWidth: 200,
                    contentFont: .subheadline
                )
                unitTableString(
                    columTitle: "天井",
                    stringList: [
                        "7周期",
                        "7周期",
                        "7周期",
                        "1周期"
                    ],
                    maxWidth: 60,
                    contentFont: .subheadline
                )
            }
            .padding(.bottom)
            Text("[テーブルごとの周期期待度]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "1周期",
                        "2周期",
                        "3周期",
                        "4周期",
                        "5周期",
                        "6周期",
                        "7周期"
                    ],
                    titleFont: .body
                )
                unitTableString(
                    columTitle: "ﾃｰﾌﾞﾙA",
                    stringList: [
                        "▲",
                        "◯",
                        "△",
                        "◯",
                        "△",
                        "◯",
                        "天井"
                    ],
                    titleFont: .body
                )
                unitTableString(
                    columTitle: "ﾃｰﾌﾞﾙB",
                    stringList: [
                        "▲",
                        "△",
                        "◯",
                        "△",
                        "◯",
                        "△",
                        "天井"
                    ],
                    titleFont: .body
                )
                unitTableString(
                    columTitle: "天国準備",
                    stringList: [
                        "▲",
                        "◯",
                        "◯",
                        "◎",
                        "◯",
                        "◎",
                        "天井"
                    ],
                    titleFont: .body
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
                        "grayOut"
                    ]
                )
            }
        }
    }
}

#Preview {
    mhrTableQuestTable()
        .padding(.horizontal)
}
