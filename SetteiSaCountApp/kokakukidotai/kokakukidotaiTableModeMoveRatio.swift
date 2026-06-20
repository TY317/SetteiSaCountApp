//
//  kokakukidotaiTableModeMoveRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/20.
//

import SwiftUI

struct kokakukidotaiTableModeMoveRatio: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "通常A",
                percentList: kokakukidotai.ratioModeA
            )
            unitTablePercent(
                columTitle: "通常B",
                percentList: kokakukidotai.ratioModeB
            )
            unitTablePercent(
                columTitle: "通常C",
                percentList: kokakukidotai.ratioModeC
            )
            unitTablePercent(
                columTitle: "通常D",
                percentList: kokakukidotai.ratioModeD
            )
        }
    }
}

#Preview {
    kokakukidotaiTableModeMoveRatio(
        kokakukidotai: Kokakukidotai(),
    )
    .padding(.horizontal)
}
