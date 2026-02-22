//
//  kokakukidotaiTableAfterAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/22.
//

import SwiftUI

struct kokakukidotaiTableAfterAt: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "通常へ",
                percentList: kokakukidotai.ratioAfterAtNormal,
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "高確へ",
                percentList: kokakukidotai.ratioAfterAtHigh,
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "超高確へ",
                percentList: kokakukidotai.ratioAfterAtSuperHigh,
                numberofDicimal: 1,
            )
        }
    }
}

#Preview {
    kokakukidotaiTableAfterAt(
        kokakukidotai: Kokakukidotai(),
    )
}
