//
//  azurLaneTableKoyakuHitRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/30.
//

import SwiftUI

struct azurLaneTableKoyakuHitRatio: View {
    @ObservedObject var azurLane: AzurLane
    var body: some View {
        VStack {
            Text("[通常滞在時]")
                .font(.title)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "その他",
                    percentList: azurLane.ratioChofukuNormalAny,
                    numberofDicimal: 3,
                )
                unitTablePercent(
                    columTitle: "弱🍒",
                    percentList: azurLane.ratioChofukuNormalCherry,
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "🍉",
                    percentList: azurLane.ratioChofukuNormalSuika,
                    numberofDicimal: 1,
                )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex(titleLine: 2)
                unitTablePercent(
                    columTitle: "強🍒\nチャンス目",
                    percentList: azurLane.ratioChofukuNormalKyoCherryChance,
                    numberofDicimal: 1,
                    titleLine: 2,
                )
                unitTablePercent(
                    columTitle: "強🍉",
                    percentList: azurLane.ratioChofukuNormalKyoSuika,
                    numberofDicimal: 1,
                    titleLine: 2,
                    lineList: [6],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "明石チャンス\n成功",
                    percentList: azurLane.ratioChofukuNormalAkashiSuccess,
                    numberofDicimal: 1,
                    titleLine: 2,
                )
            }
            .padding(.bottom)
            
            Text("[高確滞在時]")
                .font(.title)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "その他",
                    percentList: azurLane.ratioChofukuHighAny,
                    numberofDicimal: 3,
                )
                unitTablePercent(
                    columTitle: "弱🍒",
                    percentList: azurLane.ratioChofukuHighCherry,
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "🍉",
                    percentList: azurLane.ratioChofukuHighSuika,
                    numberofDicimal: 1,
                )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex(titleLine: 2)
                unitTablePercent(
                    columTitle: "強🍒\nチャンス目",
                    percentList: azurLane.ratioChofukuHighKyoCherryChance,
                    numberofDicimal: 1,
                    titleLine: 2,
                )
                unitTablePercent(
                    columTitle: "強🍉",
                    percentList: azurLane.ratioChofukuHighKyoSuika,
                    numberofDicimal: 1,
                    titleLine: 2,
                    lineList: [6],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "明石チャンス\n成功",
                    percentList: azurLane.ratioChofukuHighAkashiSuccess,
                    numberofDicimal: 1,
                    titleLine: 2,
                )
            }
            .padding(.bottom)
            
            Text("[超高確滞在時]")
                .font(.title)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "その他",
                    percentList: azurLane.ratioChofukuChoHighAny,
                    numberofDicimal: 2,
                    lineList: [6],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "弱🍒",
                    percentList: azurLane.ratioChofukuChoHighCherry,
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "🍉",
                    percentList: azurLane.ratioChofukuChoHighSuika,
                    numberofDicimal: 1,
                )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex(titleLine: 2)
                unitTablePercent(
                    columTitle: "強🍒\nチャンス目",
                    percentList: azurLane.ratioChofukuChoHighKyoCherryChance,
                    numberofDicimal: 1,
                    titleLine: 2,
                )
                unitTablePercent(
                    columTitle: "強🍉",
                    percentList: azurLane.ratioChofukuChoHighKyoSuika,
                    numberofDicimal: 1,
                    titleLine: 2,
                    lineList: [6],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "明石チャンス\n成功",
                    percentList: azurLane.ratioChofukuChoHighAkashiSuccess,
                    numberofDicimal: 1,
                    titleLine: 2,
                )
            }
        }
    }
}

#Preview {
    ScrollView {
        azurLaneTableKoyakuHitRatio(
            azurLane: AzurLane(),
        )
        .padding(.horizontal)
    }
}
