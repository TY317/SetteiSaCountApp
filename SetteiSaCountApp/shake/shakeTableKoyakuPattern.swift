//
//  shakeTableKoyakuPattern.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import SwiftUI

struct shakeTableKoyakuPattern: View {
    var body: some View {
        // //// 1段目
        HStack(spacing: 15) {
            // チェリー
            VStack {
                unitReelPattern(
                    titleText: "🍒",
                    leftReel: unitReelColumn(
                        upper: unitReelReplay(),
                        middle: unitReelBar(),
                        lower: unitReelText(textBody: "🍒")
                    ),
                    centerReel: unitReelAny(),
                    rightReel: unitReelAny(),
                )
                Text("※ 強弱なし,平行揃いもあり")
                    .foregroundStyle(Color.clear)
                    .font(.caption)
            }
            // スイカ
            VStack {
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
                Text("※ 強弱なし,平行揃いもあり")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    shakeTableKoyakuPattern()
}
