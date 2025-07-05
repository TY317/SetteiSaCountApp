//
//  kaguyaTableEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/15.
//

import SwiftUI

struct kaguyaTableEnding: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(
                titleLine: 2,
            )
            unitTablePercent(
                columTitle: "風船ゲーム",
                percentList: [48,48,44,44,42,42],
                titleLine: 2,
            )
            unitTablePercent(
                columTitle: "2人の恋の行方",
                percentList: [32,32,29,29,28,28],
                titleLine: 2,
            )
            unitTablePercent(
                columTitle: "白銀",
                percentList: [5,15,7,20,7,23],
                titleLine: 2,
            )
            unitTablePercent(
                columTitle: "かぐや",
                percentList: [15,5,20,7,23,7],
                titleLine: 2,
            )
        }
    }
}

#Preview {
    kaguyaTableEnding()
        .padding(.horizontal)
}
