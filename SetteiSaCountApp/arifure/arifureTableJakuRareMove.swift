//
//  arifureTableJakuRareMove.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/31.
//

import SwiftUI

struct arifureTableJakuRareMove: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "弱🍒",
                percentList: [21,22,22,24,25,28],
                aboutBool: true
            )
            unitTablePercent(
                columTitle: "弱ﾁｬﾝｽ目",
                percentList: [40,41,42,45,47,50],
                aboutBool: true
            )
            unitTablePercent(
                columTitle: "高確🍉",
                percentList: [55,60,65,70,73,85],
                aboutBool: true
            )
        }
    }
}

#Preview {
    arifureTableJakuRareMove()
}
