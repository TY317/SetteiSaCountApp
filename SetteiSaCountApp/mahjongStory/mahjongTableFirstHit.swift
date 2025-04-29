//
//  mahjongTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/17.
//

import SwiftUI

struct mahjongTableFirstHit: View {
    @ObservedObject var mahjong: Mahjong
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "初当り",
                    denominateList: mahjong.ratioFirstHit,
                    maxWidth: 90
                )
                unitTableDenominate(
                    columTitle: "通常時ﾎﾞｰﾅｽ",
                    denominateList: mahjong.ratioNormalBonus,
                    maxWidth: 170,
                    titleFont: .body
                )
                unitTableDenominate(
                    columTitle: "AT直撃",
                    denominateList: mahjong.ratioDirectAt
                )
            }
    //        .padding(.horizontal)
            Text("※ AT直撃は前兆中の昇格抽選を含まない数値")
        }
    }
}

#Preview {
    mahjongTableFirstHit(mahjong: Mahjong())
}
