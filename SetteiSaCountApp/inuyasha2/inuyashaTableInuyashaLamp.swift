//
//  inuyashaTableInuyashaLamp.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/13.
//

import SwiftUI

struct inuyashaTableInuyashaLamp: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: ["白","青","虹"],
                maxWidth: 100
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "奇数設定",
                    "偶数設定",
                    "高設定の期待大"
                ],
                maxWidth: 200
            )
        }
    }
}

#Preview {
    inuyashaTableInuyashaLamp()
}
