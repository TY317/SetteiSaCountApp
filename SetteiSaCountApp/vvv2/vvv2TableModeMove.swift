//
//  vvv2TableModeMove.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/25.
//

import SwiftUI

struct vvv2TableModeMove: View {
    var body: some View {
        VStack {
            Text("[設定変更時、革命ボーナス後、AT後]")
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "通常A",
                        "通常B",
                        "通常C",
                        "天国",
                    ]
                )
                unitTablePercent(
                    columTitle: "振分け",
                    percentList: [69,25,5,1]
                )
            }
            .padding(.bottom)
            
            Text("[CZ失敗後、決戦ボーナス後]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "通常Aへ",
                        "通常Bへ",
                        "通常Cへ",
                        "天国へ",
                    ]
                )
                unitTablePercent(
                    columTitle: "通常Aから",
                    percentList: [66,29,4,1],
                )
                unitTablePercent(
                    columTitle: "通常Bから",
                    percentList: [0,66,32,2],
                    colorList: [.gray,.white,.tableBlue,.white]
                )
                unitTablePercent(
                    columTitle: "通常Cから",
                    percentList: [0,0,57,43],
                    colorList: [.gray,.gray,.tableBlue,.white]
                )
                unitTablePercent(
                    columTitle: "天国から",
                    percentList: [66,31,2,1],
                )
            }
        }
    }
}

#Preview {
    vvv2TableModeMove()
}
