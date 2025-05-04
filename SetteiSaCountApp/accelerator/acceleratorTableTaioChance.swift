//
//  acceleratorTableTaioChance.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct acceleratorTableTaioChance: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "一方通行",
                percentList: [38.7,39.5,41.4,43.4,46.1,51.6]
            )
            unitTablePercent(
                columTitle: "打ち止め",
                percentList: [1.2,1.2,1.6,2.3,3.1,3.9],
                numberofDicimal: 1
            )
            unitTablePercent(
                columTitle: "合算",
                percentList: [39.9,40.7,43.0,45.7,49.2,55.5]
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    acceleratorTableTaioChance()
}
