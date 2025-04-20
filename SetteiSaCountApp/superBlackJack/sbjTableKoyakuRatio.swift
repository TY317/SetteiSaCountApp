//
//  sbjTableKoyakuRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct sbjTableKoyakuRatio: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "🍒",
                denominateList: [75.0,-1,-1,-1,-1,-1]
            )
            unitTableDenominate(
                columTitle: "🍉",
                denominateList: [99.9,91.1,87.7,86.7,85.0,83.9]
            )
            unitTableDenominate(
                columTitle: "ﾁｬﾝｽ目",
                denominateList: [99.9,-1,-1,-1,-1,-1]
            )
            unitTableDenominate(
                columTitle: "合算",
                denominateList: [30.0,-1,-1,-1,-1,-1]
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    sbjTableKoyakuRatio()
}
