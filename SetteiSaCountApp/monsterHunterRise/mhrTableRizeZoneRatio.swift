//
//  mhrTableRizeZoneRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/27.
//

import SwiftUI

struct mhrTableRizeZoneRatio: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ライズゾーン",
                denominateList: [75.6,75.2,72.9,71.8,68.9,68.2]
            )
        }
    }
}

#Preview {
    mhrTableRizeZoneRatio()
}
