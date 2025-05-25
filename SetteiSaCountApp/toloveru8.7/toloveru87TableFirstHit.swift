//
//  toloveru87TableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/21.
//

import SwiftUI

struct toloveru87TableFirstHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(
                settingList: [2,3,4,5,6]
            )
            unitTableDenominate(
                columTitle: "AT",
                denominateList: [353.3,346.3,328.9,312.3,307.6]
            )
        }
    }
}

#Preview {
    toloveru87TableFirstHit()
}
