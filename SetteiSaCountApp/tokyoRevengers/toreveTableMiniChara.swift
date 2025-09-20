//
//  toreveTableMiniChara.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/14.
//

import SwiftUI

struct toreveTableMiniChara: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "武道",
                        "千冬",
                        "ドラケン",
                        "マイキー",
                        "稀咲",
                        "一虎",
                    ],
                    maxWidth: 70,
                    lineList: [4,4,3,2,4,1],
                    contentFont: .body,
                    colorList: [.white,.white,.white,.white,.white,.white]
                )
                unitTableString(
                    columTitle: "",
                    stringList: ["白","青","赤","白","青","赤","青","赤","青","赤","白","青","赤","赤",],
                    maxWidth: 40,
                    lineList: [1,1,2,1,1,2,1,2,1,1,1,1,2,1],
                    colorList: [.white,.tableBlue,.tableRed,.white,.tableBlue,.tableRed,.tableBlue,.tableRed,.tableBlue,.tableRed,.white,.tableBlue,.tableRed,.tableRed,]
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト",
                        "通常B以上 期待度UP",
                        "当該周期の期待度大幅アップ\nハズレなら次周期当選濃厚",
                        "通常B以上 示唆",
                        "通常B以上 期待度UP",
                        "通常B以上濃厚\n当該周期の期待度大幅アップ",
                        "チャンス以上期待度アップ",
                        "チャンス以上濃厚\n当該周期の期待度大幅アップ",
                        "天国期待度アップ",
                        "天国濃厚",
                        "特殊示唆",
                        "特殊濃厚",
                        "特殊濃厚\n当該周期での当選濃厚",
                        "当該周期での当選濃厚",
                    ],
                    maxWidth: 250,
                    lineList: [1,1,2,1,1,2,1,2,1,1,1,1,2,1],
                    contentFont: .subheadline,
                    colorList: [.white,.tableBlue,.tableRed,.white,.tableBlue,.tableRed,.tableBlue,.tableRed,.tableBlue,.tableRed,.white,.tableBlue,.tableRed,.tableRed,]
                )
            }
            .padding(.bottom)
            Text("[復活濃厚パターン]")
                .font(.title2)
            Text("・下記パターンは復活濃厚を示唆")
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "武道",
                        "千冬",
                        "半間",
                        "一虎",
                    ],
                    maxWidth: 70,
                    lineList: [1,3,2,1,],
                    contentFont: .body,
                    colorList: [.white,.white,.white,.white,.white,.white]
                )
                unitTableString(
                    columTitle: "",
                    stringList: ["白","白","白","青","白","青","白",],
                    maxWidth: 40,
//                    lineList: [1,1,2,1,1,2,1,2,1,1,1,1,2,1],
                    colorList: [.white,.white,.white,.tableBlue,.white,.tableBlue,.white,.white,]
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "このままじゃダメなんだ",
                        "クソッ キリがねえ",
                        "オレは負けねぇ・・!",
                        "心配すんな まだ手はある",
                        "もっともっと殴り合おうぜぇ",
                        "ヒャハ♡おっぱじめるか!?",
                        "オレ達は東卍を潰す",
                    ],
                    maxWidth: 250,
//                    lineList: [1,1,1,1,1,2,1,2,1,1,1,1,2,1],
                    contentFont: .subheadline,
                    colorList: [.white,.white,.white,.tableBlue,.white,.tableBlue,.white,.white,]
                )
            }
        }
    }
}

#Preview {
    List {
        toreveTableMiniChara()
    }
}
