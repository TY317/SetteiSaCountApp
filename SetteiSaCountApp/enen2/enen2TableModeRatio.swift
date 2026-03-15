//
//  enen2TableModeRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/15.
//

import SwiftUI

struct enen2TableModeRatio: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "通常A",
                    "通常B",
                    "通常C",
                    "通常D",
                    "通常E",
                ],
                maxWidth: 80,
            )
            unitTablePercent(
                columTitle: "設定変更時",
                percentList: [0,24,4,39,33]
            )
            unitTablePercent(
                columTitle: "ボーナス終了後",
                percentList: [48,9,14,9,20]
            )
        }
    }
}

#Preview {
    enen2TableModeRatio()
        .padding(.horizontal)
}
