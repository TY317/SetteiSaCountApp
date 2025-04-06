//
//  tokyoGhoulTable100Hit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/03.
//

import SwiftUI

struct tokyoGhoulTable100Hit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "100G以内の当選率",
                percentList: [19.6,21.0,23.2,26.4,32.0,36.0],
                titleFont: .body
            )
        }
    }
}

#Preview {
    tokyoGhoulTable100Hit()
}
