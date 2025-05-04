//
//  dumbbellTableCheatDay.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct dumbbellTableCheatDay: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: ["456kcal","666kcal"],
                maxWidth: 120
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "設定4 以上濃厚",
                    "設定6 濃厚"
                ],
                maxWidth: 180
            )
        }
    }
}

#Preview {
    dumbbellTableCheatDay()
        .padding(.horizontal)
}
