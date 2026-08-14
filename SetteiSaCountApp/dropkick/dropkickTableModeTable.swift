//
//  dropkickTableModeTable.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/13.
//

import SwiftUI

struct dropkickTableModeTable: View {
    let maxWidth: CGFloat = 40
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "1〜49G",
                    "50〜99G",
                    "100〜149G",
                    "150〜199G",
                    "200〜249G",
                    "250〜299G",
                    "300〜349G",
                    "350〜399G",
                    "400〜449G",
                    "450〜499G",
                    "500〜549G",
                    "550〜599G",
                    "600〜649G",
                    "650〜699G",
                    "700〜749G",
                    "750〜799G",
                ],
                maxWidth: 90,
                contentFont: .subheadline,
            )
            unitTableZoneKitai(
                columTitle: "通常A",
                kitaiList: [4,4,4,4,2,4,4,4,2,4,4,4,2,4,10,-1],
                maxWidth: self.maxWidth,
                titleFont: .subheadline,
            )
            unitTableZoneKitai(
                columTitle: "通常B",
                kitaiList: [4,4,2,4,4,4,2,4,4,4,2,4,4,4,10,-1],
                maxWidth: self.maxWidth,
                titleFont: .subheadline,
            )
            unitTableZoneKitai(
                columTitle: "通常C",
                kitaiList: [4,4,2,2,2,2,2,2,4,4,2,10,-1,-1,-1,-1,],
                maxWidth: self.maxWidth,
                titleFont: .subheadline,
            )
            unitTableZoneKitai(
                columTitle: "特殊",
                kitaiList: [4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,10],
                maxWidth: self.maxWidth,
                titleFont: .subheadline,
            )
            unitTableZoneKitai(
                columTitle: "天国A",
                kitaiList: [3,10,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,],
                maxWidth: self.maxWidth,
                titleFont: .subheadline,
            )
            unitTableZoneKitai(
                columTitle: "天国B",
                kitaiList: [3,10,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,],
                maxWidth: self.maxWidth,
                titleFont: .subheadline,
            )
        }
    }
}

#Preview {
    dropkickTableModeTable()
        .padding(.horizontal)
}
