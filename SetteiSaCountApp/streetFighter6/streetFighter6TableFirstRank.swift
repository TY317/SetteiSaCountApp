//
//  streetFighter6TableFirstRank.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/10/11.
//

import SwiftUI

struct streetFighter6TableFirstRank: View {
    @ObservedObject var streetFighter6: StreetFighter6
    let segmentList: [String] = ["設定変更後", "レジェンド後"]
    @State var selectedSegment: String = "レジェンド後"

    var body: some View {
        VStack(spacing: 20) {
            // セグメントピッカー
            Picker("", selection: self.$selectedSegment) {
                ForEach(self.segmentList, id: \.self) { segment in
                    Text(segment)
                }
            }
            .pickerStyle(.segmented)

            // ルーキー・ブロンズ・シルバー
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "ルーキー",
                    percentList: isReset() ? streetFighter6.ratioFirstRankRookieReset : streetFighter6.ratioFirstRankRookieLegend,
                )
                unitTablePercent(
                    columTitle: "ブロンズ",
                    percentList: [streetFighter6.ratioFirstRankBronze[0]],
                    numberofDicimal: 1,
                    lineList: [6],
                    colorList: [.white]
                )
                unitTablePercent(
                    columTitle: "シルバー",
                    percentList: [streetFighter6.ratioFirstRankSilver[0]],
                    numberofDicimal: 1,
                    lineList: [6],
                    colorList: [.white]
                )
            }

            // ゴールド・レジェンド
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "ゴールド",
                    percentList: isReset() ? streetFighter6.ratioFirstRankGoldReset : streetFighter6.ratioFirstRankGoldLegend,
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "レジェンド",
                    percentList: isReset() ? streetFighter6.ratioFirstRankLegendReset : streetFighter6.ratioFirstRankLegendLegend,
                    numberofDicimal: 1,
                )
            }
        }
    }

    // 設定変更後が選ばれているか
    private func isReset() -> Bool {
        return self.selectedSegment == self.segmentList[0]
    }
}

#Preview {
    streetFighter6TableFirstRank(
        streetFighter6: StreetFighter6(),
    )
    .padding(.horizontal)
}
