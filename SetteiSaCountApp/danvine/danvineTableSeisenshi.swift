//
//  danvineTableSeisenshi.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct danvineTableSeisenshi: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "初期表示",
                stringList: [
                    "10G",
                    "20G",
                    "30G"
                ],
                maxWidth: 120
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "設定2 以上示唆",
                    "設定3 以上示唆"
                ],
                maxWidth: 180
            )
        }
    }
}

#Preview {
    danvineTableSeisenshi()
}
