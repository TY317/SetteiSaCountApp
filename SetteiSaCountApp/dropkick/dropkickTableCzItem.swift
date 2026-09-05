//
//  dropkickTableCzItem.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/09/05.
//

import SwiftUI

struct dropkickTableCzItem: View {
    var body: some View {
        Text("・高設定ほどハズレ時に落雷が選ばれやすい")
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "アイテム",
                stringList: [
                    "たわし",
                    "たらい",
                    "落雷",
                ],
                lineList: [1,2,3]
            )
            unitTableString(
                columTitle: "当り先",
                stringList: [
                    "ミノス",
                    "ゆりね\nメデューサ",
                    "ミノス\nゆりね\nメデューサ",
                ],
                lineList: [1,2,3]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "設定2 以上",
                    "設定2 以上",
                    "設定2 以上",
                ],
                lineList: [1,2,3]
            )
        }
    }
}

#Preview {
    dropkickTableCzItem()
        .padding(.horizontal)
}
