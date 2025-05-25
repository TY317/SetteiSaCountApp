//
//  toloveruTableWhisper.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/24.
//

import SwiftUI

struct toloveruTableWhisper: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(
                settingList: [2,3,4,5,6]
            )
            unitTablePercent(
                columTitle: "ウィスパー",
                percentList: [3.1,3.6,6.0,7.1,11.9],
                numberofDicimal: 1,
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "愛すぷﾗｯｼｭ",
                percentList: [96.2,95.7,93.3,92.2,87.4],
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "エピソード",
                percentList: [0.7],
                numberofDicimal: 1,
                lineList: [5],
                titleFont: .body
            )
        }
    }
}

#Preview {
    toloveruTableWhisper()
        .padding(.horizontal)
}
