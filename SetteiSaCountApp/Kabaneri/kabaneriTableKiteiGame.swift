//
//  kabaneriTableKiteiGame.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct kabaneriTableKiteiGame: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "100G",
                percentList: [35.3,35.7,36.1,36.6,37,37.4],
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "250G",
                percentList: [33.1,37.3,37.7,42.7,43.1,44.8],
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "450G",
                percentList: [13.9,13.9,15.6,22.2,22.7,23.1],
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "650G",
                percentList: [37.8,39.9,40.3,43.6,46.3,49.5],
                numberofDicimal: 1,
            )
        }
    }
}

#Preview {
    kabaneriTableKiteiGame()
        .padding(.horizontal)
}
