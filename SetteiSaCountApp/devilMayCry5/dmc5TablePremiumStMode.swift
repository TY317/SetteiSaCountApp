//
//  dmc5TablePremiumStMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/22.
//

import SwiftUI

struct dmc5TablePremiumStMode: View {
    var body: some View {
        VStack {
            Text("・天国振分けに10倍の設定差！")
                .padding(.bottom)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "通常A",
                    percentList: [-100],
                    lineList: [6],
                )
                unitTablePercent(
                    columTitle: "通常B",
                    percentList: [-100],
                    lineList: [6],
                )
                unitTablePercent(
                    columTitle: "通常C",
                    percentList: [94.5,87.5,75,64.8,62.9,45.3]
                )
                unitTablePercent(
                    columTitle: "天国",
                    percentList: [5.5,12.5,25,35.2,37.1,54.7]
                )
            }
        }
    }
}

#Preview {
    dmc5TablePremiumStMode()
        .padding(.horizontal)
}
