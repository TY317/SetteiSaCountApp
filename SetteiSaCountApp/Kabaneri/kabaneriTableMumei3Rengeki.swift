//
//  kabaneriTableMumei3Rengeki.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct kabaneriTableMumei3Rengeki: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "3連撃時の当選",
                percentList: [18.7,18.8,23.5,28.3,30.6,40.7],
                maxWidth: 200,
            )
        }
    }
}

#Preview {
    kabaneriTableMumei3Rengeki()
}
