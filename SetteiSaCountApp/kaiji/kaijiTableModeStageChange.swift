//
//  kaijiTableModeStageChange.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/05.
//

import SwiftUI

struct kaijiTableModeStageChange: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: ["モードA", "モードB", "モードC", "モードD"]
            )
            unitTablePercent(
                columTitle: "出現頻度",
                percentList: [5,5,7.5,10],
                numberofDicimal: 1
            )
        }
    }
}

#Preview {
    kaijiTableModeStageChange()
}
