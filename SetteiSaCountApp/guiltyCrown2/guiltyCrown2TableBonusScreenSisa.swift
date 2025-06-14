//
//  guiltyCrown2TableBonusScreenSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/07.
//

import SwiftUI

struct guiltyCrown2TableBonusScreenSisa: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableString(
                columTitle: "黒白比率の特徴",
                stringList: [
                    "均等",
                    "黒が多い",
                    "白が多い",
                    "均等",
                    "黒が多い",
                    "白が多い",
                ],
                maxWidth: 200,
            )
        }
    }
}

#Preview {
    guiltyCrown2TableBonusScreenSisa()
}
