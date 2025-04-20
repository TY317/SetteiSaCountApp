//
//  godzillaTableCzMonster.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/13.
//

import SwiftUI

struct godzillaTableCzMonster: View {
    @ObservedObject var godzilla = Godzilla()
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "ラドン",
                percentList: godzilla.ratioCzCharaRadon,
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "ｶﾞｲｶﾞﾝ",
                percentList: godzilla.ratioCzCharaGaigan,
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "ﾋﾞｵﾗﾝﾃ",
                percentList: godzilla.ratioCzCharaBiorante,
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "ﾃﾞｽﾄﾛｲｱ",
                percentList: godzilla.ratioCzCharaDestoroia,
                numberofDicimal: 1,
                titleFont: .subheadline
            )
            unitTablePercent(
                columTitle: "ｷﾝｸﾞｷﾞﾄﾞﾗ",
                percentList: [0.1],
                numberofDicimal: 1,
                lineList: [6],
                titleFont: .caption
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    godzillaTableCzMonster()
}
