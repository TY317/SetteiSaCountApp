//
//  acceleratorTableShutterOpenGame.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct acceleratorTableShutterOpenGame: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "18G",
                percentList: [64.7,62.9,60.6,58.6,56.7,53.0]
            )
            unitTablePercent(
                columTitle: "23G",
                percentList: [32.9,33.7,35.1,36.4,36.5,38.3]
            )
            unitTablePercent(
                columTitle: "33G",
                percentList: [2.4,3.4,4.3,5.1,6.7,8.7],
                numberofDicimal: 1
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    acceleratorTableShutterOpenGame()
}
