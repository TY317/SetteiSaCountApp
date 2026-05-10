//
//  rioAceTableReelEffect.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/10.
//

import SwiftUI

struct rioAceTableReelEffect: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "白",
                    "青",
                    "黄",
                    "緑",
                    "赤",
                    "紫",
                    "虹",
                ],
                maxWidth: 60,
                lineList: [1,1,1,1,1,2,1]
            )
            unitTableString(
                columTitle: "対応役",
                stringList: [
                    "全役",
                    "リプレイ",
                    "ベル",
                    "スイカ",
                    "チェリー",
                    "チャンス目\nチャンスリプレイ",
                    "全役",
                ],
                lineList: [1,1,1,1,1,2,1]
            )
        }
    }
}

#Preview {
    rioAceTableReelEffect()
}
