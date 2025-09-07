//
//  toreveTableCycleTable.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/03.
//

import SwiftUI

struct toreveTableCycleTable: View {
    var body: some View {
        VStack {
            Text("・モードごとに周期天井、期待度が変化")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
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
                    ],
                    maxWidth: 80,
                )
                unitTableString(
                    columTitle: "通常A",
                    stringList: [
                        "◎",
                        "△",
                        "◯",
                        "◯",
                        "◯",
                        "天井",
                    ]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: [
                        "△",
                        "◯",
                        "◎",
                        "◯",
                        "◯",
                        "天井",
                    ]
                )
                unitTableString(
                    columTitle: "チャンス",
                    stringList: [
                        "△",
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
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
                    ]
                )
                unitTableString(
                    columTitle: "特殊",
                    stringList: [
                        "◯",
                        "◯",
                        "◎",
                        "◯",
                        "△",
                        "天井",
                    ]
                )
            }
        }
    }
}

#Preview {
    toreveTableCycleTable()
        .padding(.horizontal)
}
