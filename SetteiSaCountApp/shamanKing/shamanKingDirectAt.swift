//
//  shamanKingDirectAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct shamanKingDirectAt: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "内部OS揃いからのAT直撃",
                denominateList: [34953,31069,25420,13981,9321,6991],
                maxWidth: 230,
                titleFont: .body
            )
        }
    }
}

#Preview {
    shamanKingDirectAt()
}
