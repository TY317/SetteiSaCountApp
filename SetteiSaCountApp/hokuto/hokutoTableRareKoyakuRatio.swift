//
//  hokutoTableRareKoyakuRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct hokutoTableRareKoyakuRatio: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [1,2,4,5,6])
            unitTableDenominate(
                columTitle: "🍉合算",
                denominateList: [86.1,85.7,82.6,78.3,76.1]
            )
            unitTableDenominate(
                columTitle: "中段🍒",
                denominateList: [210.1,204.8,199.8,195,190.5]
            )
            unitTableDenominate(
                columTitle: "リーチ目役",
                denominateList: [16384,13107,10922,9362,8192]
            )
        }
    }
}

#Preview {
    hokutoTableRareKoyakuRatio()
        .padding(.horizontal)
}
