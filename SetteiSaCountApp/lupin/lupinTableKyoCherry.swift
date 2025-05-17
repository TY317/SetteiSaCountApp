//
//  lupinTableKyoCherry.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/11.
//

import SwiftUI

struct lupinTableKyoCherry: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "ﾎﾞｰﾅｽ直撃",
                percentList: [23.0,27.3],
                lineList: [3,3]
            )
            unitTablePercent(
                columTitle: "AT直撃",
                percentList: [2.0,2.7],
                numberofDicimal: 1,
                lineList: [3,3]
            )
            unitTablePercent(
                columTitle: "合算",
                percentList: [25.0,30.1],
                numberofDicimal: 0,
                lineList: [3,3]
            )
        }
    }
}

#Preview {
    lupinTableKyoCherry()
        .padding(.horizontal)
}
