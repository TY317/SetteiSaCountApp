//
//  godeaterTableRareHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/21.
//

import SwiftUI

struct godeaterTableRareHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "弱🍒・🍉",
                percentList: [0.2,0.4,0.6,0.8,1.0,1.2],
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "チャンス目",
                percentList: [15.8,17.2,19.1,21.1,23.4,24.9]
            )
            unitTablePercent(
                columTitle: "強🍒",
                percentList: [55.2],
                lineList: [6],
                colorList: [.white],
            )
        }
    }
}

#Preview {
    godeaterTableRareHit()
        .padding(.horizontal)
}
