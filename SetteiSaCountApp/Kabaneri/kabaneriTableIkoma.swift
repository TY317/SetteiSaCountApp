//
//  kabaneriTableIkoma.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct kabaneriTableIkoma: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "ライフ3",
                percentList: [66.8,66.8,65.1,62.2,60.8,55],
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "ライフ2",
                percentList: [44.2,44.2,42.4,40.3,38.8,34.5],
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "ライフ1",
                percentList: [39.8,39.8,38,35.9,34.4,30.8],
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "ライフ4",
                percentList: [87.6,87.6,87.8,87.8,87.9,88.1],
                numberofDicimal: 1,
            )
        }
    }
}

#Preview {
    kabaneriTableIkoma()
        .padding(.horizontal)
}
