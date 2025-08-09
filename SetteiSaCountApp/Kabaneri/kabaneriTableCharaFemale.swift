//
//  kabaneriTableCharaFemale.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct kabaneriTableCharaFemale: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: ["奇数設定", "偶数設定"]
            )
            unitTablePercent(
                columTitle: "男性キャラ",
                percentList: [60,40]
            )
            unitTablePercent(
                columTitle: "女性キャラ",
                percentList: [40,60]
            )
        }
    }
}

#Preview {
    kabaneriTableCharaFemale()
}
