//
//  shamanKingTableQualify.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/25.
//

import SwiftUI

struct shamanKingTableQualify: View {
    @ObservedObject var shamanKing: ShamanKing
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・対戦相手がファウスト または 道蓮時の撃破率に設定差あり")
                Text("・1〜6G目がカウント対象。7G目の撃破率は全設定共通")
                Text("・OS役：オーバーソウル停止役、オーバーソウル揃い役")
            }
            .padding(.bottom)
            Text("[OS役での撃破率]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "vsファウスト",
                    percentList: shamanKing.ratioQualifyFaust
                )
                unitTablePercent(
                    columTitle: "vs道蓮",
                    percentList: shamanKing.ratioQualifyRen
                )
                unitTablePercent(
                    columTitle: "vsホロホロ",
                    percentList: shamanKing.ratioQualifyHolo,
                    lineList: [6],
                    colorList: [.white],
                )
            }
        }
    }
}

#Preview {
    shamanKingTableQualify(
        shamanKing: ShamanKing(),
    )
    .padding(.horizontal)
}
