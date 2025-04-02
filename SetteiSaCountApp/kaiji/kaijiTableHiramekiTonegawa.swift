//
//  kaijiTableHiramekiTonegawa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/27.
//

import SwiftUI

struct kaijiTableHiramekiTonegawa: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "当選率",
                percentList: [0.4,-1,-1,-1,-1,1.2],
                numberofDicimal: 1
            )
        }
    }
}

#Preview {
    kaijiTableHiramekiTonegawa()
}
