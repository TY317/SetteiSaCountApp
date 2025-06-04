//
//  dmc5TableModeSuisoku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/01.
//

import SwiftUI

struct dmc5TableModeSuisoku: View {
    let lineList: [Int] = [1,1,4,3,2,3,1,2,1]
    var body: some View {
        HStack(spacing: 0) {
            unitTableGameIndex(
                gameList: [100,200,300,400,500,600,700,800,900],
                lineList: self.lineList
            )
            unitTableString(
                columTitle: "特徴・モード推測",
                stringList: [
                    "・ボーナス期待度約35%(モード不問)",
                    "・ボーナス期待度約35%(モード不問)",
                    "・前兆ステージ移行で通常A or 通常C滞在示唆\n・前兆ステージへ移行しなければ通常B期待度約40%\n・ゾーン内のボーナス当選は通常C滞在中の可能性大\n・V以上のディスク獲得→フェイク前兆なら通常C滞在の期待大",
                    "・前兆ステージ移行で通常B or 通常C滞在示唆\n・ゾーン内のボーナス当選は通常B滞在中の可能性大\n・V以上のディスク獲得→フェイク前兆なら通常B滞在の期待大",
                    "・前兆ステージ移行で通常A or 通常C滞在示唆\n・前兆ステージへ移行しなければ通常B滞在の期待大",
                    "・通常A or 通常C滞在時：ボーナス期待度約25%\n・通常B滞在時：ボーナス期待度約30%\n※ 設定変更時を除く",
                    "・前兆ステージ移行でボーナス濃厚",
                    "・前兆ステージ移行で通常A or 通常C滞在示唆\n・ゾーン内のボーナス当選は通常C滞在中の可能性大",
                    "ゾーン内のボーナス当選は通常B滞在中の可能性大"
                ],
                maxWidth: 300,
                lineList: self.lineList,
                contentFont: .footnote
            )
        }
    }
}

#Preview {
    dmc5TableModeSuisoku()
        .padding(.horizontal)
}
