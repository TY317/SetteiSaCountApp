//
//  hihodenTableHihoNews.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/24.
//

import SwiftUI

struct hihodenTableHihoNews: View {
    var body: some View {
        VStack {
            Text("・通常時のリール下に表示される秘宝ニュースに設定示唆パターンがある")
                .padding(.bottom)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "2時46分",
                        "4時56分",
                    ]
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "設定2,4,6濃厚",
                        "設定4 以上濃厚",
                    ]
                )
            }
        }
    }
}

#Preview {
    hihodenTableHihoNews()
        .padding(.horizontal)
}
