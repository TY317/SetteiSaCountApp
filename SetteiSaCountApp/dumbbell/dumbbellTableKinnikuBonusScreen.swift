//
//  dumbbellTableKinnikuBonusScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct dumbbellTableKinnikuBonusScreen: View {
    let maxWidth: CGFloat = 46
    let titleFont: Font = .caption
    let contentFont: Font = .subheadline
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "奇数示唆",
                    "偶数示唆",
                    "設定4\n以上濃厚",
                    "設定6 濃厚"
                ],
                lineList: [1,1,2,1],
                contentFont: self.contentFont
            )
            unitTablePercent(
                columTitle: "設定1",
                percentList: [65,35,0,0],
                maxWidth: self.maxWidth,
                lineList: [1,1,2,1],
                titleFont: self.titleFont,
                contentFont: self.contentFont
            )
            unitTablePercent(
                columTitle: "設定2",
                percentList: [35,65,0,0],
                maxWidth: self.maxWidth,
                lineList: [1,1,2,1],
                titleFont: self.titleFont,
                contentFont: self.contentFont
            )
            unitTablePercent(
                columTitle: "設定3",
                percentList: [65,35,0,0],
                maxWidth: self.maxWidth,
                lineList: [1,1,2,1],
                titleFont: self.titleFont,
                contentFont: self.contentFont
            )
            unitTablePercent(
                columTitle: "設定4",
                percentList: [35,63,2,0],
                maxWidth: self.maxWidth,
                lineList: [1,1,2,1],
                titleFont: self.titleFont,
                contentFont: self.contentFont
            )
            unitTablePercent(
                columTitle: "設定5",
                percentList: [63,35,2,0],
                maxWidth: self.maxWidth,
                lineList: [1,1,2,1],
                titleFont: self.titleFont,
                contentFont: self.contentFont
            )
            unitTablePercent(
                columTitle: "設定6",
                percentList: [48,48,2,2],
                maxWidth: self.maxWidth,
                lineList: [1,1,2,1],
                titleFont: self.titleFont,
                contentFont: self.contentFont
            )
        }
    }
}

#Preview {
    dumbbellTableKinnikuBonusScreen()
        .padding(.horizontal)
}
