//
//  toreveTableModeRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/13.
//

import SwiftUI

struct toreveTableModeRatio: View {
    var body: some View {
        VStack {
            Text("・設定変更時、リベンジチャンス終了時、天上天下唯我独尊終了時共通のモード振り分けが判明")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            Text("[設定変更時\nリベンジチャンス終了時\n天上天下唯我独尊終了時]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "モードA",
                    percentList: [34.4,34.4,28.5,27.3,21.1,18.8]
                )
                unitTablePercent(
                    columTitle: "モードB",
                    percentList: [25],
                    lineList: [6],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "モードC",
                    percentList: [25],
                    lineList: [6],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "天国",
                    percentList: [9.4,9.4,15.2,16.4,22.7,25.0]
                )
                unitTablePercent(
                    columTitle: "特殊",
                    percentList: [6.3],
//                    numberofDicimal: 1,
                    lineList: [6],
                    colorList: [.white],
                )
            }
        }
    }
}

#Preview {
    toreveTableModeRatio()
        .padding(.horizontal)
}
