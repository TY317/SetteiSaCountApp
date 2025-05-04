//
//  dumbbellTableCzSecondPart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct dumbbellTableCzSecondPart: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "後半パート成功期待度",
                percentList: [52,53,56,57,59,59],
                maxWidth: 230
            )
        }
    }
}

#Preview {
    dumbbellTableCzSecondPart()
        .padding(.horizontal)
}
