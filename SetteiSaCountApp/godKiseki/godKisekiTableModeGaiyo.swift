//
//  godKisekiTableModeGaiyo.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/18.
//

import SwiftUI

struct godKisekiTableModeGaiyo: View {
    var body: some View {
        VStack {
            Text("・通常時は6種類の表モードと2種類の裏モードでGG抽選を管理")
                .padding(.bottom)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "表モード",
                    stringList: [
                        "低確A",
                        "低確B",
                        "通常",
                        "天国準備",
                        "天国",
                        "超天国",
                    ]
                )
                unitTableString(
                    columTitle: "状態",
                    stringList: [
                        "低",
                        "↓",
                        "↓",
                        "↓",
                        "↓",
                        "高",
                    ],
                    maxWidth: 80,
                )
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "裏モード",
                    stringList: [
                        "通常",
                        "天国",
                    ]
                )
                unitTableString(
                    columTitle: "状態",
                    stringList: [
                        "低",
                        "高",
                    ],
                    maxWidth: 80,
                )
            }
        }
    }
}

#Preview {
    godKisekiTableModeGaiyo()
        .padding(.horizontal)
}
