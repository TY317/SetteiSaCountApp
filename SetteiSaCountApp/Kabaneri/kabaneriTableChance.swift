//
//  kabaneriTableChance.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct kabaneriTableChance: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableString(
                columTitle: "発光率",
                stringList: [
                    "10%",
                    "↓",
                    "↓",
                    "↓",
                    "↓",
                    "17%",
                ]
            )
        }
    }
}

#Preview {
    kabaneriTableChance()
}
