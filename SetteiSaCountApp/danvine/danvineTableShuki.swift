//
//  danvineTableShuki.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct danvineTableShuki: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "周期",
                stringList: [
                    "1周期以内",
                    "3周期以内"
                ]
            )
            unitTablePercent(
                columTitle: "ボーナス当選期待度",
                percentList: [47,77],
                maxWidth: 250
            )
        }
    }
}

#Preview {
    danvineTableShuki()
        .padding(.horizontal)
}
