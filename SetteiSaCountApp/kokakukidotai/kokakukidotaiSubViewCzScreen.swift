//
//  kokakukidotaiSubViewCzScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/15.
//

import SwiftUI

struct kokakukidotaiSubViewCzScreen: View {
    var body: some View {
        Section {
            unitLinkButtonViewBuilder(sheetTitle: "CZ終了画面 示唆") {
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "青空",
                            "青空＋笑い男マーク",
                            "青空＋9課",
                            "オペ子 3人",
                            "タチコマ",
                            "トグサ家",
                            "イシカワ＋老人たち",
                            "素子",
                            "バカンス(素子＆バトー)",
                            "金背景 9課",
                        ],
                        maxWidth: 200,
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "デフォルト",
                            "復活期待度 50%",
                            "設定2 以上濃厚",
                            "???",
                            "???",
                            "???",
                            "???",
                            "???",
                            "設定4 以上濃厚",
                            "設定6 濃厚",
                        ]
                    )
                }
            }
//            HStack(spacing: 0) {
//                unitTableString(
//                    columTitle: "",
//                    stringList: [
//                        "青空",
//                        "青空＋笑い男マーク",
//                        "青空＋9課",
//                        "オペ子 3人",
//                        "タチコマ",
//                        "トグサ家",
//                        "イシカワ＋老人たち",
//                        "素子",
//                        "バカンス(素子＆バトー)",
//                        "金背景 9課",
//                    ],
//                    maxWidth: 200,
//                )
//                unitTableString(
//                    columTitle: "示唆",
//                    stringList: [
//                        "デフォルト",
//                        "復活期待度 50%",
//                        "設定2 以上濃厚",
//                        "???",
//                        "???",
//                        "???",
//                        "???",
//                        "???",
//                        "設定4 以上濃厚",
//                        "設定6 濃厚",
//                    ]
//                )
//            }
//            .frame(maxWidth: .infinity, alignment: .center)
        } header: {
            Text("CZ 終了画面")
        }
    }
}

#Preview {
    List {
        kokakukidotaiSubViewCzScreen()
    }
}
