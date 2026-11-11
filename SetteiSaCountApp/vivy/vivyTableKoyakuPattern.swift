//
//  vivyTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import SwiftUI

struct vivyTableKoyakuPattern: View {
    var body: some View {
        VStack(spacing: 20) {
            // //// 1段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "弱🍒")
                HStack(spacing: 15) {
                    // 弱チェリー１
                    unitReelPattern(
                        leftReel: unitReelVivyCherryEither(),
                        centerReel: unitReelAny(),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelVivyCell(xmarkBool: true) { vivyMarkMatsumoto() },
                            lower: unitReelDefault()
                        ),
                    )
                    // 弱チェリー２
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelVivyPair(first: { vivyMarkBlue7() }, second: { vivyMarkLightBlueV() }),
                            lower: unitReelDefault()
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
                }
            }

            // //// 2段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "強🍒")
                HStack(spacing: 15) {
                    // 強チェリー１
                    unitReelPattern(
                        leftReel: unitReelVivyCherryEither(),
                        centerReel: unitReelAny(),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelVivyCell { vivyMarkMatsumoto() },
                            lower: unitReelDefault()
                        ),
                    )
                    // 強チェリー２
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelVivyPair(first: { vivyMarkBlue7() }, second: { vivyMarkLightBlueV() }),
                            lower: unitReelText(textBody: "🔔")
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🔔"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelText(textBody: "🔔")
                        ),
                    )
                }
            }
            
            // //// 2段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "弱🍉")
                HStack(spacing: 15) {
                    unitReelPattern(
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
                            middle: unitReelVivyPair(first: { vivyMarkBlue7() }, second: { vivyMarkEmoji(text: "🍉") }),
                            lower: unitReelDefault()
                        ),
                    )
                    // 弱スイカ
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelVivyPair(first: { vivyMarkBlue7() }, second: { vivyMarkEmoji(text: "🍉") })
                        ),
                    )
                }
            }
            
            // //// 2段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "強🍉")
                HStack(spacing: 15) {
                    unitReelPattern(
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
                            middle: unitReelVivyCell { vivyMarkLightBlueV() },
                            lower: unitReelDefault()
                        ),
                    )
                    // 弱スイカ
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelText(textBody: "🍉"),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelVivyCell { vivyMarkLightBlueV() }
                        ),
                    )
                }
            }
            
            // //// 4段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "チャンス目（1枚）")
                HStack(spacing: 15) {
                    // チャンス目１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelText(textBody: "🍉"),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelVivyPair(xmarkBool: true, first: { vivyMarkLogo() }, second: { vivyMarkEmoji(text: "🍉") }),
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelVivyPair(first: { vivyMarkBlue7() }, second: { vivyMarkEmoji(text: "🍉") }),
                            lower: unitReelDefault()
                        ),
                    )
                    // チャンス目２
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelVivyCell { vivyMarkLogo() },
                            lower: unitReelDefault()
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
                }
            }

            // //// 5段目
            VStack(spacing: 7) {
                unitReelLongTitle(titleText: "マツモト揃い")
                HStack(spacing: 15) {
                    // マツモト揃い１
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelVivyPair(first: { vivyMarkLogo() }, second: { vivyMarkMatsumoto() }),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelVivyCell { vivyMarkMatsumoto() },
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelVivyCell { vivyMarkMatsumoto() },
                            lower: unitReelDefault()
                        ),
                    )
                    // マツモト揃い２
                    unitReelPattern(
                        leftReel: unitReelColumn(
                            upper: unitReelVivyPair(first: { vivyMarkLogo() }, second: { vivyMarkMatsumoto() }),
                            middle: unitReelDefault(),
                            lower: unitReelDefault()
                        ),
                        centerReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelVivyCell { vivyMarkMatsumoto() },
                            lower: unitReelDefault()
                        ),
                        rightReel: unitReelColumn(
                            upper: unitReelDefault(),
                            middle: unitReelDefault(),
                            lower: unitReelVivyCell { vivyMarkMatsumoto() }
                        ),
                    )
                }
            }

            // //// 6段目
            HStack(spacing: 15) {
                // 変換高確移行ベル
                unitReelPattern(
                    titleText: "変換高確移行ベル",
                    titleFont: .body,
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelText(textBody: "🔔"),
                        lower: unitReelDefault()
                    ),
                )
                // バグ目
                unitReelPattern(
                    titleText: "バグ目",
                    leftReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelReplay()
                    ),
                    centerReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelReplay()
                    ),
                    rightReel: unitReelColumn(
                        upper: unitReelDefault(),
                        middle: unitReelDefault(),
                        lower: unitReelVivyCell { vivyMarkMatsumoto() }
                    ),
                )
            }
        }
    }
}


// ////////////////////////
// Vivy の図柄パーツ
// ////////////////////////

// //// 1コマ（図柄マークを枠の中に置く。xmarkBool で×印）
struct unitReelVivyCell<Content: View>: View {
    var xmarkBool: Bool = false
    @ViewBuilder var content: () -> Content

    var body: some View {
        unitReelDefault()
            .overlay {
                ZStack {
                    self.content()
                        .padding(.horizontal, 6)
                        .padding(.vertical, 8)
                    if self.xmarkBool {
                        Image(systemName: "xmark")
                            .resizable()
                            .padding(5)
                            .foregroundStyle(Color.red)
                    }
                }
            }
    }
}


// //// 1コマに2図柄（どちらかが停止）
struct unitReelVivyPair<First: View, Second: View>: View {
    var xmarkBool: Bool = false
    @ViewBuilder var first: () -> First
    @ViewBuilder var second: () -> Second

    var body: some View {
        unitReelDefault()
            .overlay {
                ZStack {
                    self.first()
                        .frame(width: 32, height: 18)
                        .offset(x: -9, y: -7)
                    self.second()
                        .frame(width: 32, height: 18)
                        .offset(x: 9, y: 7)
                    if self.xmarkBool {
                        Image(systemName: "xmark")
                            .resizable()
                            .padding(5)
                            .foregroundStyle(Color.red)
                    }
                }
            }
    }
}


// //// 左リール：チェリーが上段か下段のどちらか
struct unitReelVivyCherryEither: View {
    var body: some View {
        unitReelColumn(
            upper: unitReelText(textBody: "🍒"),
            middle: unitReelDefault()
                .overlay{
                    Text("↕︎")
                        .font(.system(size: 45))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.secondary)
                }
                .overlay {
                    Text("どちらか")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.6)
                        .foregroundStyle(Color.black)
                },
            lower: unitReelText(textBody: "🍒")
        )
    }
}


// //// マツモト図柄（ピンク）
struct vivyMarkMatsumoto: View {
    var body: some View {
        Capsule()
            .fill(
                LinearGradient(
                    colors: [Color(red: 1.0, green: 0.6, blue: 0.85), Color(red: 0.85, green: 0.25, blue: 0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .overlay {
                Capsule()
                    .stroke(Color(red: 0.55, green: 0.1, blue: 0.4), lineWidth: 1)
            }
            .overlay {
                Text("マツモト")
                    .font(.system(size: 10, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 2)
            }
    }
}


// //// VIVY図柄（紺のプレート）
struct vivyMarkLogo: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(Color(red: 0.08, green: 0.12, blue: 0.25))
            .overlay {
                RoundedRectangle(cornerRadius: 3)
                    .stroke(Color.cyan, lineWidth: 1)
            }
            .overlay {
                Text("VIVY")
                    .font(.system(size: 11, weight: .bold))
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundStyle(Color.cyan)
            }
    }
}


// //// 青7図柄
struct vivyMarkBlue7: View {
    var body: some View {
        Text("7")
            .font(.system(size: 22, weight: .heavy))
            .minimumScaleFactor(0.5)
            .foregroundStyle(
                LinearGradient(
                    colors: [Color(red: 0.2, green: 0.6, blue: 1.0), Color(red: 0.05, green: 0.25, blue: 0.75)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .shadow(color: Color(red: 0.0, green: 0.1, blue: 0.35), radius: 0, x: 1, y: 1)
    }
}


// //// 水色V図柄
struct vivyMarkLightBlueV: View {
    var body: some View {
        Text("V")
            .font(.system(size: 22, weight: .heavy))
            .minimumScaleFactor(0.5)
            .foregroundStyle(
                LinearGradient(
                    colors: [Color(red: 0.8, green: 0.95, blue: 1.0), Color(red: 0.4, green: 0.78, blue: 0.95)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .shadow(color: Color(red: 0.1, green: 0.35, blue: 0.6), radius: 0, x: 1, y: 1)
    }
}


// //// 絵文字図柄（2図柄コマ用）
struct vivyMarkEmoji: View {
    var text: String
    var body: some View {
        Text(self.text)
            .font(.title3)
            .minimumScaleFactor(0.5)
    }
}


#Preview {
    ScrollView {
        vivyTableKoyakuPattern()
            .padding(.horizontal)
    }
}
