//
//  toreveTablePtTable.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/03.
//

import SwiftUI

struct toreveTablePtTable: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・モードごとにポイント天井、期待度が変化")
                Text("・1周期目は全モード一律で天井が200")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom)
            Text("[1周期目]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "100pt",
                        "200pt",
                        "300pt",
                        "400pt",
                        "500pt",
                    ],
                    maxWidth: 80,
                )
                unitTableString(
                    columTitle: "通常A",
                    stringList: [
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: [
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "チャンス",
                    stringList: [
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
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "特殊",
                    stringList: [
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
            }
            .padding(.bottom)
            Text("[2〜6周期目]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "100pt",
                        "200pt",
                        "300pt",
                        "400pt",
                        "500pt",
                    ],
                    maxWidth: 80,
                )
                unitTableString(
                    columTitle: "通常A",
                    stringList: [
                        "◯",
                        "△",
                        "◎",
                        "△",
                        "天井",
                    ]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: [
                        "△",
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "チャンス",
                    stringList: [
                        "◯",
                        "△",
                        "◎",
                        "△",
                        "天井",
                    ]
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: [
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
                        "◯",
                        "◯",
                        "天井",
                    ]
                )
            }
        }
    }
}

#Preview {
    toreveTablePtTable()
        .padding(.horizontal)
}
