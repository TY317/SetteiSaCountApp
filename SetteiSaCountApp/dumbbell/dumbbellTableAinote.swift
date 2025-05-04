//
//  dumbbellTableAinote.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct dumbbellTableAinote: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "1人",
                percentList: [97,97,97,94,94,94]
            )
            unitTablePercent(
                columTitle: "2人",
                percentList: [2,2,2,5,5,5]
            )
            unitTableString(
                columTitle: "5人",
                stringList: [
                    "激低",
                    "激低",
                    "激低",
                    "約1%",
                    "約1%",
                    "約1%"
                ])
        }
    }
}

#Preview {
    dumbbellTableAinote()
        .padding(.horizontal)
}
