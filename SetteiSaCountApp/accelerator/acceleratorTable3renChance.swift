//
//  acceleratorTable3renChance.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct acceleratorTable3renChance: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "一方通行",
                percentList: [93.8,93.0,92.2,91.0,89.8,88.3]
            )
            unitTablePercent(
                columTitle: "打ち止め",
                percentList: [5.1,5.5,5.9,6.6,7.4,8.6],
                numberofDicimal: 1
            )
            unitTablePercent(
                columTitle: "一通・打止",
                percentList: [1.2,1.6,2.0,2.3,2.7,3.1],
                numberofDicimal: 1,
                titleFont: .body
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    acceleratorTable3renChance()
}
