//
//  toloveruTable3RenJohi.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/21.
//

import SwiftUI

struct toloveruTable3RenJohi: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [2,3,4,5,6])
            unitTableString(
                columTitle: "ボーナス3連での上位当選",
                stringList: [
                    "34%",
                    "?",
                    "?",
                    "?",
                    "2%程度?",
                ],
                maxWidth: 250,
            )
        }
    }
}

#Preview {
    toloveruTable3RenJohi()
}
