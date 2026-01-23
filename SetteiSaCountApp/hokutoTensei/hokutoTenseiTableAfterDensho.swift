//
//  hokutoTenseiTableAfterDensho.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/23.
//

import SwiftUI

struct hokutoTenseiTableAfterDensho: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "低確",
                percentList: [71,71.1,70.3,50,43.8,39.1]
            )
            unitTablePercent(
                columTitle: "通常",
                percentList: [25,25.4,25.8,42.2,46.9,50]
            )
            unitTablePercent(
                columTitle: "高確",
                percentList: [3.1,3.5,3.9,7.8,9.4,10.9],
                numberofDicimal: 1,
            )
        }
    }
}

#Preview {
    hokutoTenseiTableAfterDensho()
        .padding(.horizontal)
}
