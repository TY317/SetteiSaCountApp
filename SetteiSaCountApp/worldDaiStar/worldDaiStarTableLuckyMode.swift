//
//  worldDaiStarTableLuckyMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/04.
//

import SwiftUI

struct worldDaiStarTableLuckyMode: View {
    let lineList: [Int] = [2,1,2,1]
    var body: some View {
        VStack(alignment: .leading) {
            Text("・通常時が始まるタイミングで突入抽選")
            Text("・当選すればST突入まで転落なし")
            Text("・モンキーのライバルモードのようなイメージ！？")
        }
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "ノスタルジアモード",
                    "しりうす湯モード",
                    "センスモード",
                    "ワールドダイスターモード",
                ],
                lineList: self.lineList,
                contentFont: .subheadline,
            )
            unitTableString(
                columTitle: "特徴",
                stringList: [
                    "浅いゲーム数での当選に期待\n最大天井を600G+αに短縮",
                    "しりうす湯当選時の約50%でロングになる",
                    "次回ST中の最初のボーナス当選時に、成功濃厚のセンス覚醒チャレンジ当選濃厚",
                    "初当り当選で上位ST濃厚",
                ],
                maxWidth: 300,
                lineList: self.lineList,
                contentFont: .subheadline,
            )
        }
    }
}

#Preview {
    worldDaiStarTableLuckyMode()
        .padding(.horizontal)
}
