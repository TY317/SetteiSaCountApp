//
//  danvineTableAttackStartRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct danvineTableAttackStartRatio: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "成功当選率",
                percentList: [2.0,2.3,2.7,3.5,4.3,5.1],
                numberofDicimal: 1
            )
        }
    }
}

#Preview {
    danvineTableAttackStartRatio()
}
