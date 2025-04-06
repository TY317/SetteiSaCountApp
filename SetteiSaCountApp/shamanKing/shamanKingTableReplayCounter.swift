//
//  shamanKingTableReplayCounter.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct shamanKingTableReplayCounter: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "カウンタ 1",
                percentList: [92.2,91.8,91.0,89.8,88.3,86.7],
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "カウンタ 10",
                percentList: [6.3,6.6,7.4,8.2,9.4,10.2],
                numberofDicimal: 1,
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "カウンタ 99",
                percentList: [1.6,1.6,1.6,2.0,2.3,3.1],
                numberofDicimal: 1,
                titleFont: .body
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    shamanKingTableReplayCounter()
}
