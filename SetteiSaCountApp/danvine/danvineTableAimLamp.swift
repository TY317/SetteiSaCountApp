//
//  danvineTableAimLamp.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct danvineTableAimLamp: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "白",
                        "青",
                        "黄",
                        "緑",
                        "赤"
                    ],
                    maxWidth: 100
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト",
                        "デフォルト",
                        "高設定示唆 弱",
                        "高設定示唆 中",
                        "高設定示唆 強"
                    ],
                    maxWidth: 200
                )
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "緑",
                    percentList: [3.1,3.3,3.6,3.9,4.3,4.8],
                    numberofDicimal: 1
                )
                unitTablePercent(
                    columTitle: "赤",
                    percentList: [0.8,0.9,1.0,1.1,1.3,1.4],
                    numberofDicimal: 1
                )
            }
        }
    }
}

#Preview {
    danvineTableAimLamp()
        .padding(.horizontal)
}
