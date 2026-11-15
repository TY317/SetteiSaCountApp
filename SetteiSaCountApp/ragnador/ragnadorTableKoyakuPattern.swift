//
//  ragnadorTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ragnadorTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            VStack {
                HStack(spacing: 15) {
                    // 弱チェリー
                    unitReelPattern(
                        titleText: "弱🍒",
                        leftReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelBar(),
                            lower: unitReelText(textBody: "🍒")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelReplay(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelReplay(),
                            lower: unitReelDefault()
                        ),
                    )
                    // 強チェリー
                    unitReelPattern(
                        titleText: "強🍒",
                        leftReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelBar(),
                            lower: unitReelText(textBody: "🍒")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: ragnadorReelSpecialCherry(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍒"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                    )
                }
            }

            // //// 2段目
            VStack {
                HStack(spacing: 15) {
                    // チャンス目A
                    unitReelPattern(
                        titleText: "チャンス目A",
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelReplay(),
                            lower: unitReelBar()
                        ),
                        centerReel: unitReelHazure(),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍒"),
                            middle: unitReelReplay(),
                            lower: unitReelText(textBody: "🔔")
                        ),
                    )
                    // チャンス目B
                    unitReelPattern(
                        titleText: "チャンス目B",
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelReplay()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault()
                        ),
                    )
                }
            }

            // //// 3段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "極チャンス目")
                HStack(spacing: 15) {
                    // 極チャンス目１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelReplay(),
                            middle: unitReelBar(),
                            lower: unitReelText(textBody: "🍒")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍒"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🍒")
                        ),
                    )
                    // 極チャンス目２
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelReplay()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                    )
                }
            }

            // //// 4段目
            VStack {
                HStack(spacing: 15) {
                    // スイカ
                    unitReelPattern(
                        titleText: "🍉",
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelReplay()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                    )
                    unitReelSpacer()
                }
            }
        }
    }
}

// ///////////////////////
// 強チェリーの中リール：青BARと🍒のどちらでもよい（2図柄を斜めに重ねて表現）
// ///////////////////////
struct ragnadorReelSpecialCherry: View {
    var body: some View {
        unitReelDefault()
            .overlay {
                ZStack {
                    // 青BAR（左上）
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(
                                LinearGradient(
                                    colors: [Color(red: 0.2, green: 0.45, blue: 0.95), Color(red: 0.05, green: 0.2, blue: 0.65)],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        Text("BAR")
                            .font(.system(size: 11, weight: .heavy))
                            .minimumScaleFactor(0.5)
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 34, height: 20)
                    .offset(x: -8, y: -7)
                    // 🍒（右下）
                    Text("🍒")
                        .font(.system(size: 22))
                        .offset(x: 10, y: 8)
                }
            }
    }
}

#Preview {
    ragnadorTableKoyakuPattern()
}
