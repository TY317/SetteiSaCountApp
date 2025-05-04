//
//  dumbbellTableGoldenChallenge.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct dumbbellTableGoldenChallenge: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "当選率",
                percentList: [17,17,17,17,18,20]
            )
            unitTablePercent(
                columTitle: "成功率",
                percentList: [56,57,57,58,59,64]
            )
        }
    }
}

#Preview {
    dumbbellTableGoldenChallenge()
        .padding(.horizontal)
}
