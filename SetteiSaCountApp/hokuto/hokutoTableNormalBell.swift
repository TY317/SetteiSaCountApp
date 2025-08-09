//
//  hokutoTableNormalBell.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct hokutoTableNormalBell: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: ["低設定", "高設定"],
                maxWidth: 100,
            )
            unitTableString(
                columTitle: "斜め：平行比率",
                stringList: ["11 : 1", "6.5 : 1"]
            )
            unitTableDenominate(
                columTitle: "平行ベル",
                denominateList: [170,100]
            )
        }
    }
}

#Preview {
    hokutoTableNormalBell()
        .padding(.horizontal)
}
