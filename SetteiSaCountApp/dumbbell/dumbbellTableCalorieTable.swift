//
//  dumbbellTableCalorieTable.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct dumbbellTableCalorieTable: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "摂取カロリー",
                stringList: [
                    "10,000",
                    "20,000",
                    "30,000",
                    "40,000",
                    "50,000",
                    "60,000",
                    "70,000",
                    "80,000",
                    "90,000",
                    "100,000",
                ]
            )
            unitTableString(
                columTitle: "当選期待度",
                stringList: [
                    "◯",
                    "△",
                    "△",
                    "◯",
                    "◎",
                    "◯",
                    "◎",
                    "◯",
                    "◎",
                    "天井",
                ]
            )
        }
    }
}

#Preview {
    dumbbellTableCalorieTable()
}
