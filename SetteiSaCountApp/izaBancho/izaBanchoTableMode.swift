//
//  izaBanchoTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/31.
//

import SwiftUI

struct izaBanchoTableMode: View {
    var body: some View {
        VStack {
            Text("[修行(前兆)移行期待度]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableGameIndex(gameList: [100,200,300,400,500,600,700,800,900,999]
                )
                unitTableString(
                    columTitle: "通常",
                    stringList: [
                        "◯",
                        "▲",
                        "◯",
                        "▲",
                        "△",
                        "◯",
                        "△",
                        "△",
                        "△",
                        "天井"
                    ]
                )
                unitTableString(
                    columTitle: "ﾁｬﾝｽA",
                    stringList: [
                        "◯",
                        "△",
                        "◯",
                        "△",
                        "△",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut"
                    ]
                )
                unitTableString(
                    columTitle: "ﾁｬﾝｽB",
                    stringList: [
                        "◯",
                        "△",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut"
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
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut"
                    ]
                )
            }
            Text("期待度：◯ > △ > ▲")
        }
    }
}

#Preview {
    izaBanchoTableMode()
        .padding(.horizontal)
}
