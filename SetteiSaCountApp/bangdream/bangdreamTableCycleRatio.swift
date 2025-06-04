//
//  bangdreamTableCycleRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/28.
//

import SwiftUI

struct bangdreamTableCycleRatio: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [2,3,4,5,6])
            unitTablePercent(
                columTitle: "周期当選時の期待度",
                percentList: [27.5,27.7,30.1,31.7,34.4],
                maxWidth: 250
            )
        }
    }
}

#Preview {
    bangdreamTableCycleRatio()
}
