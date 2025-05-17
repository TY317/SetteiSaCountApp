//
//  midoriDonTableReachReplay.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/17.
//

import SwiftUI

struct midoriDonTableReachReplay: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "リーチ目リプレイ",
                denominateList: [2978.9,2520.6,2048],
                numberofDicimal: 0,
                maxWidth: 200,
                lineList: [2,2,2]
            )
        }
    }
}

#Preview {
    midoriDonTableReachReplay()
}
