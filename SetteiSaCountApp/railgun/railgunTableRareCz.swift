//
//  railgunTableRareCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/05.
//

import SwiftUI

struct railgunTableRareCz: View {
    @ObservedObject var railgun: Railgun
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "🍒",
                percentList: [
                    railgun.ratioRareCzCherry[0],
                    railgun.ratioRareCzCherry[2],
                    railgun.ratioRareCzCherry[3],
                    railgun.ratioRareCzCherry[5],
                ],
                numberofDicimal: 1,
                lineList: [2,1,2,1],
            )
            unitTablePercent(
                columTitle: "🍉",
                percentList: [
                    railgun.ratioRareCzSuika[0],
                    railgun.ratioRareCzSuika[2],
                    railgun.ratioRareCzSuika[3],
                    railgun.ratioRareCzSuika[4],
                    railgun.ratioRareCzSuika[5],
                ],
                numberofDicimal: 1,
                lineList: [2,1,1,1,1]
            )
        }
    }
}

#Preview {
    railgunTableRareCz(
        railgun: Railgun(),
    )
}
