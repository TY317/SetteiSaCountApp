//
//  lupinTableCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/11.
//

import SwiftUI

struct lupinTableCz: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "初当り",
                denominateList: [211.5,210.0,204.9,199.7,199.0,198.0]
            )
            unitTablePercent(
                columTitle: "成功率",
                percentList: [43.4,44.6,46.1,48.9,51.5,51.8]
            )
        }
    }
}

#Preview {
    lupinTableCz()
}
