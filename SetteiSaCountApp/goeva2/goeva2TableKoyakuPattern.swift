//
//  goeva2TableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//
//  ※これは代表的なレア役停止形の雛形。実機に合わせて図柄/役を編集すること。
//  使えるパーツ：unitReelPattern / unitReelColumn / unitReelAny / unitReelHazure /
//  unitReelSpacer / unitReelLongTitle / unitReelReplay(xmarkBool:) / unitReelBar /
//  unitReelText(textBody:) / unitReelDefault

import SwiftUI

struct goeva2TableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            HStack(spacing: 15) {
                // 弱チェリー
                unitReelPattern(
                    titleText: "弱🍒",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelGoeva2G(),
                        lower: unitReelText(textBody: "🍒")
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    ),
                )
                // 強チェリー
                unitReelPattern(
                    titleText: "強🍒",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelGoeva2G(),
                        lower: unitReelText(textBody: "🍒")
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔", xmarkBool: true),
                        lower: unitReelDefault()
                    ),
                )
            }

            // //// 2段目
            HStack(spacing: 15) {
                // スイカ
                unitReelPattern(
                    titleText: "🍉",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelBar()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🍉"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🍉")
                    ),
                )
                // チャンス目
                unitReelPattern(
                    titleText: "チャンス目",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelBar()
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
            }

            // //// 3段目
            HStack(spacing: 15) {
                // G侵食役
                unitReelPattern(
                    titleText: "G侵食役",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelGoeva2BarG()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelGoeva2G(),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelGoeva2G(),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    ),
                )
                // 強G侵食役
                unitReelPattern(
                    titleText: "強G侵食役",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelGoeva2BarG()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelGoeva2G(),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelGoeva2G(),
                        middle: unitReelDefault(),
                        lower: unitReelGoeva2G()
                    ),
                )
            }

            // //// 4段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "リーチ目役")
                HStack(spacing: 15) {
                    // リーチ目役１（左リール G／🍒／🍉）
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelGoeva2G(),
                            middle: unitReelText(textBody: "🍒"),
                            lower: unitReelText(textBody: "🍉")
                        ),
                        centerReel: unitReelAny(),
                        rightReel: unitReelAny(),
                    )
                    // リーチ目役２（BAR揃い）
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelBar(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelBar(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelBar(),
                            lower: unitReelDefault()
                        ),
                    )
                }
                Text("※BAR揃いは全ライン有効")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
            }
        }
    }
}


// //// G図柄
struct unitReelGoeva2G: View {
    var body: some View {
        unitReelText(textBody: "G", textColor: .purple)
    }
}


// //// BARとG図柄が重なった図柄（G侵食役の左リール下段）
struct unitReelGoeva2BarG: View {
    var body: some View {
        unitReelDefault()
            .overlay(alignment: .topLeading) {
                ZStack {
                    Rectangle()
                        .foregroundStyle(Color.black)
                        .cornerRadius(8)
                        .padding(5)
                    Text("BAR")
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                        .font(.subheadline)
                }
                .frame(width: 50,height: 30)
            }
//        unitReelBar()
            .overlay(alignment: .bottomTrailing) {
                Text("G")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.purple)
                    .padding(.horizontal, 4)
                    .background(Color.reelBack)
                    .clipShape(Circle())
                    .padding(2)
            }
    }
}


#Preview {
    goeva2TableKoyakuPattern()
}
