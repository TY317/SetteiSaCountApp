//
//  otome5TableGameMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/03.
//

import SwiftUI

struct otome5TableGameMode: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・1周期目は必ず200G+αで周期到達")
                Text("・1,2周期目は紫炎が選ばれやすい")
                Text("・3周期目以降での紫炎出現は高設定ほど優遇")
                Text("・チャンス到達までモード転落なし")
            }
            HStack(spacing: 0) {
                unitTableGameIndex(gameList: [50,100,200,300,400,500,])
                unitTableString(
                    columTitle: "1周期目",
                    stringList: [
                        "◎",
                        "△",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "モードA",
                    stringList: [
                        "△",
                        "",
                        "◎",
                        "",
                        "◎",
                        "天井",
                    ]
                )
                unitTableString(
                    columTitle: "モードB",
                    stringList: [
                        "△",
                        "",
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "モードC",
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
                    columTitle: "チャンス",
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
    otome5TableGameMode()
        .padding(.horizontal)
}
