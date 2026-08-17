//
//  yajikitaTableMileTable.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/17.
//

import SwiftUI

struct yajikitaTableMileTable: View {
    let maxWidth: CGFloat = 40
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・規定まいる到達後は最大32Gの前兆経由して関所チャレンジに突入")
                Text("・900まいる以上だった場合は次回300まいる以下になる")
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "1〜99",
                        "100〜199",
                        "200〜299",
                        "300〜399",
                        "400〜499",
                        "500〜599",
                        "600〜699",
                        "700〜799",
                        "800〜899",
                        "900〜999",
                    ],
                    maxWidth: 90,
                    contentFont: .subheadline,
                )
                unitTableZoneKitai(
                    columTitle: "通常A",
                    kitaiList: [1,1,1,2,1,3,1,2,1,10],
                    maxWidth: self.maxWidth,
                    titleFont: .subheadline,
                )
                unitTableZoneKitai(
                    columTitle: "通常B",
                    kitaiList: [1,1,2,1,3,1,10,-1,-1,-1,],
                    maxWidth: self.maxWidth,
                    titleFont: .subheadline,
                )
                unitTableZoneKitai(
                    columTitle: "特殊A",
                    kitaiList: [1,2,1,10,-1,-1,-1,-1,-1,-1,],
                    maxWidth: self.maxWidth,
                    titleFont: .subheadline,
                )
                unitTableZoneKitai(
                    columTitle: "特殊B",
                    kitaiList: [1,1,1,1,1,1,2,1,1,10],
                    maxWidth: self.maxWidth,
                    titleFont: .subheadline,
                )
                unitTableZoneKitai(
                    columTitle: "天国A",
                    kitaiList: [1,10,-1,-1,-1,-1,-1,-1,-1,-1,],
                    maxWidth: self.maxWidth,
                    titleFont: .subheadline,
                )
                unitTableZoneKitai(
                    columTitle: "天国B",
                    kitaiList: [1,10,-1,-1,-1,-1,-1,-1,-1,-1,],
                    maxWidth: self.maxWidth,
                    titleFont: .subheadline,
                )
            }
        }
    }
}

#Preview {
    yajikitaTableMileTable()
        .padding(.horizontal)
}
