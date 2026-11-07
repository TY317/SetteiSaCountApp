//
//  seiyaTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//
//  ※これは代表的なレア役停止形の雛形。実機に合わせて図柄/役を編集すること。
//  使えるパーツ：unitReelPattern / unitReelColumn / unitReelAny / unitReelHazure /
//  unitReelSpacer / unitReelLongTitle / unitReelReplay(xmarkBool:) / unitReelBar /
//  unitReelText(textBody:) / unitReelDefault

import SwiftUI

struct seiyaTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "小宇宙目（リプレイ or 1枚）")
                HStack(spacing: 15) {
                    // 小宇宙目１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelReplay(),
                            lower: unitReelBar()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelSeiyaCosmo(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelSeiyaCosmo(),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                    )
                    // 小宇宙目２（小宇宙揃い）
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelSeiyaCosmo(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelSeiyaCosmo(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelSeiyaCosmo(),
                            lower: unitReelDefault()
                        ),
                    )
                }
            }

            // //// 2段目
            HStack(spacing: 15) {
                // 強小宇宙目
                unitReelPattern(
                    titleText: "強小宇宙目",
                    leftReel: unitReelAny(),
                    centerReel: unitReelColumn(
                        upper: unitReelSeiyaCosmo(),
                        middle: unitReelBar(),
                        lower: unitReelSeiyaCosmo()
                    ),
                    rightReel: unitReelAny(),
                )
                
                // スイカ
                unitReelPattern(
                    titleText: "🍉",
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
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelText(textBody: "🍉")
                    ),
                )
            }

            // //// 3段目
            HStack(spacing: 15) {
                // 弱チェリー
                unitReelPattern(
                    titleText: "弱🍒",
//                    titleFont: .body,
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
//                    titleFont: .body,
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
                        upper: unitReelReplay(),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    ),
                )
            }

            // //// 5段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "チャンス目")
                HStack(spacing: 15) {
                    // チャンス目１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🔔"),
                            middle: unitReelReplay(),
                            lower: unitReelBar()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelReplay(),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelDefault()
                        ),
                    )
                    // チャンス目２
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
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault()
                        ),
                    )
                }
            }
        }
    }
}


// //// 小宇宙図柄
struct unitReelSeiyaCosmo: View {
    let cosmoGradient = LinearGradient(
        colors: [.blue, .red],
        startPoint: .leading,
        endPoint: .trailing
    )

    var body: some View {
        unitReelDefault()
            .overlay {
                ZStack {
                    unitReelSeiyaCosmoShape()
                        .fill(self.cosmoGradient)
                    unitReelSeiyaCosmoShape()
                        .stroke(Color.black, lineWidth: 1)
                    Ellipse()
                        .stroke(Color.white, lineWidth: 1)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 9)
            }
    }
}


// //// 小宇宙図柄の外形（ふちがギザギザの楕円）
struct unitReelSeiyaCosmoShape: Shape {
    let spikeCount: Int = 14
    let innerRatio: Double = 0.82

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let pointCount = self.spikeCount * 2
        for index in 0..<pointCount {
            let angle = 2 * Double.pi * Double(index) / Double(pointCount)
            let ratio = index % 2 == 0 ? 1.0 : self.innerRatio
            let point = CGPoint(
                x: rect.midX + rect.width / 2 * ratio * cos(angle),
                y: rect.midY + rect.height / 2 * ratio * sin(angle)
            )
            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        return path
    }
}


#Preview {
    ScrollView {
        seiyaTableKoyakuPattern()
    }
}
