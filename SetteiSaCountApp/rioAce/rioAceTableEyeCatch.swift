//
//  rioAceTableEyeCatch.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/24.
//

import SwiftUI

struct rioAceTableEyeCatch: View {
    let lineList: [Int] = [1,1,1,6]
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "リオ",
                    "リナ",
                    "ミント",
                    "全員集合",
                ],
                maxWidth: 100,
                lineList: self.lineList,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "エースモード滞在期待度 約43%",
                    "エースモード滞在濃厚",
                    "次回ノワールルームで\n　　・のわーるるーむ\n　　・AT当選\n　　・ノワールタイム\nのいずれかに当選\nどれにも当選しなかった場合は高設定の期待度が大幅アップ",
                ],
                maxWidth: 300,
                lineList: self.lineList,
                textAlignment: .leading
            )
        }
    }
}

#Preview {
    rioAceTableEyeCatch()
        .padding(.horizontal)
}
