//
//  goevaTableSuikaCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/21.
//

import SwiftUI

struct goevaTableSuikaCz: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [1,2,4,5,6])
            unitTablePercent(
                columTitle: "CZ当選率",
                percentList: [20.3,21.1,25.0,27.7,30.5]
            )
        }
    }
}

#Preview {
    goevaTableSuikaCz()
}
