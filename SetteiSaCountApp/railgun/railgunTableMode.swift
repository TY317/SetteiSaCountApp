//
//  railgunTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/08.
//

import SwiftUI

struct railgunTableMode: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "通常A",
                        "通常B",
                        "通常C",
                        "通常D",
                        "通常E",
                    ]
                )
                unitTableString(
                    columTitle: "天井",
                    stringList: [
                        "999G",
                        "699G",
                        "699G",
                        "299G",
                        "199G",
                    ]
                )
                unitTableString(
                    columTitle: "花火シナリオ",
                    stringList: [
                        "シナリオ0",
                        "シナリオ1",
                        "シナリオ0〜2のいずれか",
                    ],
                    lineList: [2,1,2],
                    colorList: [.white,.tableBlue,.white]
                )
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "シナリオ0",
                        "シナリオ1",
                        "シナリオ2",
                    ],
                    lineList: [1,1,2]
                )
                unitTableString(
                    columTitle: "移行ゲーム数",
                    stringList: [
                        "百の位が奇数",
                        "百の位が偶数",
                        "百の位が奇数の75%\n百の位が偶数の67%",
                    ],
                    maxWidth: 200,
                    lineList: [1,1,2],
                )
            }
        }
    }
}

#Preview {
    railgunTableMode()
        .padding(.horizontal)
}
