//
//  goevaTableAtSuika.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/21.
//

import SwiftUI

struct goevaTableAtSuika: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [1,2,4,5,6])
            unitTablePercent(
                columTitle: "CZ当選率",
                percentList: [30.1,30.1,37.5,37.5,39.1]
            )
            unitTablePercent(
                columTitle: "CZ成功率",
                percentList: [49.3,50.4,51.7,52.9,65.3]
            )
        }
    }
}

#Preview {
    goevaTableAtSuika()
        .padding(.horizontal)
}
