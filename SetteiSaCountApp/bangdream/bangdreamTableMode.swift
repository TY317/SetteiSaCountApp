//
//  bangdreamTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/28.
//

import SwiftUI

struct bangdreamTableMode: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "モードA",
                        "モードB",
                        "モードC",
                        "引き戻し",
                        "チャンス",
                        "天国"
                    ]
                )
                unitTableString(
                    columTitle: "天井",
                    stringList: [
                        "10周期",
                        "7周期",
                        "5周期",
                        "3周期",
                        "2周期",
                        "1周期",
                    ]
                )
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "設定変更時",
                        "ST駆け抜け時",
                        "大ｶﾞﾙﾊﾟﾁｬﾚﾝｼﾞ失敗時"
                    ],
                    maxWidth: 250
                )
                unitTableString(
                    columTitle: "短縮天井",
                    stringList: [
                        "7周期",
                        "5周期",
                        "1周期"
                    ],
                    maxWidth: 120
                )
            }
        }
    }
}

#Preview {
    bangdreamTableMode()
}
