//
//  bangdreamTablePicoAttack.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/28.
//

import SwiftUI

struct bangdreamTablePicoAttack: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [2,3,4,5,6])
            unitTablePercent(
                columTitle: "当選率",
                percentList: [
                    7.7,8.1,13,14.6,14.9
                ],
                numberofDicimal: 1
            )
        }
    }
}

#Preview {
    bangdreamTablePicoAttack()
}
