//
//  azurLaneTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/30.
//

import SwiftUI

struct azurLaneTableMode: View {
    var body: some View {
        VStack {
            Text("・3種類のモードでレア役時のボーナス当選率を管理")
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "種類",
                        "保障G数",
                        "昇格契機",
                        "転落契機",
                    ],
                    maxWidth: 100,
                )
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "通常・高確・超高確",
                        "10〜30G",
                        "レア役、明石チャンス成功で抽選",
                        "保障G消化後のレア役以外で抽選",
                    ],
                    maxWidth: 300,
                )
            }
        }
    }
}

#Preview {
    azurLaneTableMode()
        .padding(.horizontal)
}
