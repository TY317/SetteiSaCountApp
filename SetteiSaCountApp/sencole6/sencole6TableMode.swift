//
//  sencole6TableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/03.
//

import SwiftUI

struct sencole6TableMode: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・周期到達の規定コレ数は111〜666までの3桁ゾロ目")
                Text("・リセット後、AT終了後の1周期目は222コレで周期到達")
                Text("・規定コレ数555以上だった場合、次の周期は222コレ以下で周期到達")
            }
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
                    maxWidth: 70,
                )
                unitTableString(
                    columTitle: "モードA",
                    stringList: [
                        "grayOut",
                        "◯",
                        "△",
                        "◯",
                        "◯",
                        "天井",
                    ]
                )
                unitTableString(
                    columTitle: "モードB",
                    stringList: [
                        "grayOut",
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
            }
        }
    }
}

#Preview {
    sencole6TableMode()
        .padding(.horizontal)
}
