//
//  toloveru87Table3renHarlem.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/21.
//

import SwiftUI

struct toloveru87Table3renHarlem: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(
                settingList: [2,3,4,5,6]
            )
            unitTablePercent(
                columTitle: "3連での上位当選",
                percentList: [50.2,-1,-1,-1,-1],
                maxWidth: 200
            )
        }
    }
}

#Preview {
    toloveru87Table3renHarlem()
}
