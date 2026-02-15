//
//  enen2TableRegSenario.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/15.
//

import SwiftUI

struct enen2TableRegSenario: View {
    var body: some View {
        VStack {
            Text("[シナリオごとの示唆]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "第8 ①",
                        "第8 ②",
                        "第8 ③",
                        "伝道者 ①",
                        "伝道者 ②",
                        "伝道者 ③",
                        "伝道者 ④",
                        "まもるくん ①",
                        "まもるくん ②",
                        "まもるくん ③",
                        "まもるくん ④",
                        "まもるくん ⑤",
                        "アイリス",
                        "大隊長",
                    ],
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト",
                        "???",
                        "???",
                        "高設定示唆",
                        "高設定濃厚",
                        "まもるくんの登場順で法則あり！？",
                        "???",
                        "高設定濃厚",
                    ],
                    lineList: [1,1,1,3,1,5]
                )
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.bottom)
            Text("[シナリオごとのキャラ順]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "第8 ①",
                        "第8 ②",
                        "第8 ③",
                        "伝道 ①",
                        "伝道 ②",
                        "伝道 ③",
                        "伝道 ④",
                        "まもる ①",
                        "まもる ②",
                        "まもる ③",
                        "まもる ④",
                        "まもる ⑤",
                        "アイリス",
                        "大隊長",
                    ],
                    maxWidth: 80,
                    contentFont: .footnote
                )
                unitTableString(
                    columTitle: "1人目",
                    stringList: [
                        "シンラ",
                        "シンラ",
                        "シンラ",
                        "ジョヴァンニ",
                        "ジョヴァンニ",
                        "ジョヴァンニ",
                        "ジョヴァンニ",
                        "まもるくん",
                        "アイリス",
                        "アイリス",
                        "アイリス",
                        "アイリス",
                        "アイリス",
                        "ジョヴァンニ",
                    ],
                    maxWidth: 80,
                    contentFont: .footnote,
                    colorList: [
                        .tableBlue,
                        .tableBlue,
                        .tableBlue,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableBlue,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                    ]
                )
                unitTableString(
                    columTitle: "2人目",
                    stringList: [
                        "アーサー",
                        "リヒト",
                        "リヒト",
                        "カロン",
                        "カロン",
                        "カロン",
                        "カロン",
                        "オウビ",
                        "まもるくん",
                        "オウビ",
                        "オウビ",
                        "オウビ",
                        "オウビ",
                        "オウビ",
                    ],
                    maxWidth: 80,
                    contentFont: .footnote,
                    colorList: [
                        .tableBlue,
                        .tableBlue,
                        .tableBlue,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableBlue,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                    ]
                )
                unitTableString(
                    columTitle: "3人目",
                    stringList: [
                        "タマキ",
                        "ヴァルカン",
                        "ヴァルカン",
                        "ハウメア",
                        "ハウメア",
                        "ハウメア",
                        "ハウメア",
                        "インカ",
                        "インカ",
                        "まもるくん",
                        "インカ",
                        "インカ",
                        "インカ",
                        "アーグ",
                    ],
                    maxWidth: 80,
                    contentFont: .footnote,
                    colorList: [
                        .tableBlue,
                        .tableBlue,
                        .tableBlue,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableBlue,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                    ]
                )
                unitTableString(
                    columTitle: "4人目",
                    stringList: [
                        "マキ",
                        "アイリス",
                        "アイリス",
                        "フレイル",
                        "フレイル",
                        "フレイル",
                        "フレイル",
                        "アーグ",
                        "アーグ",
                        "アーグ",
                        "まもるくん",
                        "アーグ",
                        "アーグ",
                        "バーンズ",
                    ],
                    maxWidth: 80,
                    contentFont: .footnote,
                    colorList: [
                        .tableBlue,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableBlue,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                    ]
                )
                unitTableString(
                    columTitle: "5人目",
                    stringList: [
                        "ヒナワ",
                        "オウビ",
                        "シンラ",
                        "オロチ",
                        "インカ",
                        "リツ",
                        "シンラ",
                        "バーンズ",
                        "バーンズ",
                        "バーンズ",
                        "バーンズ",
                        "まもるくん",
                        "バーンズ",
                        "紅丸",
                    ],
                    maxWidth: 80,
                    contentFont: .footnote,
                    colorList: [
                        .tableBlue,
                        .tableRed,
                        .tableYellow,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableYellow,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableRed,
                        .tableBlue,
                        .tableRed,
                        .tableYellow,
                    ]
                )
            }
        }
    }
}

#Preview {
    List {
        enen2TableRegSenario()
    }
}
