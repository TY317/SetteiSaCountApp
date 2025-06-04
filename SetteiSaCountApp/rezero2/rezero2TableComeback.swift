//
//  rezero2TableComeback.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/29.
//

import SwiftUI

struct rezero2TableComeback: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "引き戻し確率",
                percentList: [10.2,10.4,13.9,16.0,18,20]
            )
        }
    }
}

#Preview {
    rezero2TableComeback()
}
