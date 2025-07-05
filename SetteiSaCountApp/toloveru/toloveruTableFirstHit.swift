//
//  toloveruTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/21.
//

import SwiftUI

struct toloveruTableFirstHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [2,3,4,5,6])
            unitTableDenominate(
                columTitle: "AT",
                denominateList: [352,345.7,328.4,311.1,311.1]
            )
        }
    }
}

#Preview {
    toloveruTableFirstHit()
}
