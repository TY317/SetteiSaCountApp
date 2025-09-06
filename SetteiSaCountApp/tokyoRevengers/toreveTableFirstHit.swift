//
//  toreveTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/04.
//

import SwiftUI

struct toreveTableFirstHit: View {
    @ObservedObject var toreve: Toreve
    
    var body: some View {
        VStack {
            Text("・CZにも設定差あり\n　特に稀咲陰謀は設定差が大きい")
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "ﾐｯﾄﾞﾅｲﾄﾓｰﾄﾞ",
                    denominateList: toreve.ratioCzMidNight
                )
                unitTableDenominate(
                    columTitle: "稀咲陰謀",
                    denominateList: toreve.ratioCzKisaki
                )
                unitTableDenominate(
                    columTitle: "CZ合算",
                    denominateList: toreve.ratioCzSum
                )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "東卍チャンス",
                    denominateList: toreve.ratioTomanChallenge
                )
                unitTableDenominate(
                    columTitle: "東卍ラッシュ",
                    denominateList: toreve.ratioTomanRush
                )
                unitTableDenominate(
                    columTitle: "初当り合算",
                    denominateList: toreve.ratioFirstHit
                )
            }
            Text("※ 東卍チャンス確率は独自算出値のため参考程度")
                .font(.caption)
        }
    }
}

#Preview {
    toreveTableFirstHit(
        toreve: Toreve(),
    )
    .padding(.horizontal)
}
