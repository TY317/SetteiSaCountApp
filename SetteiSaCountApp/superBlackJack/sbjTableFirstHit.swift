//
//  sbjTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct sbjTableFirstHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ﾎﾞｰﾅｽ高確",
                denominateList: [114.7,112.4,110.5,96.4,92.0,90.3],
                titleFont: .body
            )
            unitTableDenominate(
                columTitle: "ﾎﾞｰﾅｽ初当り",
                denominateList: [241.7,238.8,235.9,201.8,194.9,181.3],
                titleFont: .body
            )
            unitTableDenominate(
                columTitle: "ﾘｵﾁｬﾝｽ高確",
                denominateList: [417.6,411.7,405.8,350.4,335.9,312.1],
                titleFont: .body
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    sbjTableFirstHit()
}
