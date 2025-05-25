//
//  toloveruTableDokidokiDefault.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/21.
//

import SwiftUI

struct toloveruTableDokidokiDefault: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "獲得契機",
                    "150pt到達時",
                    "リセット契機"
                ],
                maxWidth: 120,
                lineList: [2,1,2],
                contentFont: .body
            )
            unitTableString(
                columTitle: "内容",
                stringList: [
                    "・チャンス目成立時\n・CZ終了時の初期ポイント",
                    "該当するチャンス目のCZ突入",
                    "もぐもぐたい焼きタイム終了後\n(STではリセットされない)"
                ],
                maxWidth: 300,
                lineList: [2,1,2],
                contentFont: .subheadline
            )
        }
    }
}

#Preview {
    toloveruTableDokidokiDefault()
        .padding(.horizontal)
}
