//
//  karakuriTableStage.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct karakuriTableStage: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [1,2,4,5,6])
            unitTablePercent(
                columTitle: "鳴海スタート",
                percentList: [53,40,40,60,50]
            )
            unitTablePercent(
                columTitle: "勝スタート",
                percentList: [47,60,60,40,50]
            )
        }
    }
}

#Preview {
    karakuriTableStage()
        .padding(.horizontal)
}
