//
//  shamanKingTableHyoiGattai.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct shamanKingTableHyoiGattai: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "残7〜8",
                percentList: [3.1,3.5,4.3,5.5,7.0,8.6],
                numberofDicimal: 1,
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "残5〜6",
                percentList: [6.6,7.4,8.2,9.8,11.3,13.3],
                numberofDicimal: 1,
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "残4",
                percentList: [25.0,25.4,25.8,27.0,28.1,29.7],
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "残3",
                percentList: [40.2,40.6,41.0,42.2,43.8,45.3],
                titleFont: .body
            )
        }
        .padding(.bottom)
        HStack(spacing: 0) {
            unitTableSettingIndex()
//            unitTablePercent(
//                columTitle: "残3",
//                percentList: [40.2,40.6,41.0,42.2,43.8,45.3]
//            )
            unitTablePercent(
                columTitle: "残2",
                percentList: [67.2],
                maxWidth: 100,
                lineList: [6],
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "残1",
                percentList: [85.2],
                maxWidth: 100,
                lineList: [6],
                titleFont: .body
            )
        }
    }
}

#Preview {
    shamanKingTableHyoiGattai()
}
