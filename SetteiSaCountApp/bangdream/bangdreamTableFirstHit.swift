//
//  bangdreamTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/28.
//

import SwiftUI

struct bangdreamTableFirstHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [2,3,4,5,6])
            unitTableDenominate(
                columTitle: "ST初当り",
                denominateList: [328,326.4,303.9,291,271.5]
            )
        }
    }
}

#Preview {
    bangdreamTableFirstHit()
}
