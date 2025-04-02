//
//  arifureTableMyuAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/31.
//

import SwiftUI

struct arifureTableMyuAt: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(titleLine: 2)
            unitTablePercent(
                columTitle: "ミュウボーナス開始時\nAT当選率",
                percentList: [5,6,9,15,20,27],
                maxWidth: 200,
                titleLine: 2
            )
        }
    }
}

#Preview {
    arifureTableMyuAt()
}
