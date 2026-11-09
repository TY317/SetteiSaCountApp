//
//  ggoTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct ggoTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            HStack(spacing: 15) {
                // チェリー
                unitReelPattern(
                    titleText: "🍒",
                    leftReel: unitReelColumn(
                        upper: unitReelGgoBullet(),
                        middle: unitReelBar(),
                        lower: unitReelText(textBody: "🍒")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelGgoBullet(),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelText(textBody: "🔔"),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    ),
                )
                // バレットチェリー
                unitReelPattern(
                    titleText: "バレット🍒",
                    leftReel: unitReelColumn(
                        upper: unitReelGgoBullet(),
                        middle: unitReelBar(),
                        lower: unitReelText(textBody: "🍒")
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelGgoBullet(),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelGgoBullet(),
                        middle: unitReelDefault(),
                        lower: unitReelDefault()
                    ),
                )
            }

            // //// 2段目
            HStack(spacing: 15) {
                // スイカ
                unitReelPattern(
                    titleText: "🍉（3枚）",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelGgoBullet()
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
                // バレットスイカ
                unitReelPattern(
                    titleText: "バレット🍉",
                    leftReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelGgoBullet()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelDefault(),
                        lower: unitReelGgoBullet()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelText(textBody: "🍉"),
                        middle: unitReelDefault(),
                        lower: unitReelGgoBullet()
                    ),
                )
            }

            // //// 3段目
            VStack(spacing: 7) {
                // バレット
                unitReelPattern(
                    titleText: "バレット",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelGgoBullet(),
                        lower: unitReelDefault()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelGgoBullet(),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelGgoBullet(),
                        lower: unitReelDefault()
                    ),
                )
                Text("※中段・右下がり・右上がり")
                    .font(.footnote)
                    .foregroundStyle(Color.secondary)
            }
        }
    }
}


// //// バレット図柄（銃弾）
struct unitReelGgoBullet: View {
    // 薬莢（真鍮色）
    let caseGradient = LinearGradient(
        colors: [Color(red: 0.95, green: 0.82, blue: 0.45), Color(red: 0.70, green: 0.52, blue: 0.15)],
        startPoint: .top,
        endPoint: .bottom
    )
    // 弾頭（紫）
    let tipGradient = LinearGradient(
        colors: [Color(red: 0.85, green: 0.55, blue: 0.95), Color(red: 0.45, green: 0.15, blue: 0.60)],
        startPoint: .top,
        endPoint: .bottom
    )

    var body: some View {
        unitReelDefault()
            .overlay {
                ZStack {
                    unitReelGgoBulletCaseShape()
                        .fill(self.caseGradient)
                    unitReelGgoBulletTipShape()
                        .fill(self.tipGradient)
                    unitReelGgoBulletCaseShape()
                        .stroke(Color.black, lineWidth: 1)
                    unitReelGgoBulletTipShape()
                        .stroke(Color.black, lineWidth: 1)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
            }
    }
}


// //// 銃弾の薬莢部分（左側。後端にリム付き）
struct unitReelGgoBulletCaseShape: Shape {
    let caseRatio: CGFloat = 0.58   // 全長に対する薬莢の長さ
    let rimWidth: CGFloat = 3

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let caseEnd = rect.minX + rect.width * self.caseRatio
        let inset = rect.height * 0.12
        // リム（後端の少し太い部分）
        path.addRect(CGRect(x: rect.minX, y: rect.minY, width: self.rimWidth, height: rect.height))
        // 胴体
        path.addRect(CGRect(
            x: rect.minX + self.rimWidth,
            y: rect.minY + inset,
            width: caseEnd - rect.minX - self.rimWidth,
            height: rect.height - inset * 2
        ))
        return path
    }
}


// //// 銃弾の弾頭部分（右側。先端に向かって丸くすぼまる）
struct unitReelGgoBulletTipShape: Shape {
    let caseRatio: CGFloat = 0.58

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let start = rect.minX + rect.width * self.caseRatio
        let inset = rect.height * 0.12
        let top = rect.minY + inset
        let bottom = rect.maxY - inset
        path.move(to: CGPoint(x: start, y: top))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.midY),
            control: CGPoint(x: rect.maxX - rect.width * 0.12, y: top)
        )
        path.addQuadCurve(
            to: CGPoint(x: start, y: bottom),
            control: CGPoint(x: rect.maxX - rect.width * 0.12, y: bottom)
        )
        path.closeSubpath()
        return path
    }
}


#Preview {
    ScrollView {
        ggoTableKoyakuPattern()
    }
}
