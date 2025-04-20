//
//  sbjTableKokakuKiteiGame.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct sbjTableKokakuKiteiGame: View {
    var body: some View {
        VStack {
            Text("[規定ゲーム数での移行]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: ["100G","百の位 偶数", "百の位 奇数"],
                    maxWidth: 110,
                    lineList: [2,2,1],
                    contentFont: .body
                )
                unitTableString(
                    columTitle: "期待度",
                    stringList: ["◎","◯","△"],
                    maxWidth: 70,
                    lineList: [2,2,1],
                    titleFont: .body
                )
                unitTableString(
                    columTitle: "特徴",
                    stringList: [
                        "内部的に\nﾁｬｲﾅor高確移行濃厚",
                        "内部的に50%以上で\nﾁｬｲﾅor高確移行",
                        "-"
                    ],
                    maxWidth: 250,
                    lineList: [2,2,1],
                    contentFont: .body
                )
            }
        }
//        .padding(.horizontal)
    }
}

#Preview {
    sbjTableKokakuKiteiGame()
}
