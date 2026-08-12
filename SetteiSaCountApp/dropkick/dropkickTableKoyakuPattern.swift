//
//  dropkickTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//
//  ※これは代表的なレア役停止形の雛形。実機に合わせて図柄/役を編集すること。
//  使えるパーツ：unitReelPattern / unitReelColumn / unitReelAny / unitReelHazure /
//  unitReelSpacer / unitReelLongTitle / unitReelReplay(xmarkBool:) / unitReelBar /
//  unitReelText(textBody:) / unitReelDefault

import SwiftUI

struct dropkickTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            VStack {
                HStack(spacing: 15) {
                    // スイカ
                    unitReelPattern(
                        titleText: "🍉",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault()
                        ),
                    )
                    // 邪神ちゃん揃い
                    unitReelPattern(
                        titleText: "邪神ちゃん揃い",
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelJashinBar(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelJashinBar(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelJashinBar(),
                            lower: unitReelDefault()
                        ),
                    )
                }
                Text("※ 全ライン有効")
            }
        }
    }
}


struct unitReelJashinBar: View {
    var body: some View {
        unitReelDefault()
            .overlay {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Color.yellow)
                        .cornerRadius(8)
                        .padding(5)
                    Text("邪神")
                        .foregroundStyle(Color.black)
                        .fontWeight(.bold)
                        .font(.title3)
                }
            }
    }
}


#Preview {
    dropkickTableKoyakuPattern()
}
