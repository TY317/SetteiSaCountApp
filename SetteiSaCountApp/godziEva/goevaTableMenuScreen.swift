//
//  goevaTableMenuScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/21.
//

import SwiftUI

struct goevaTableMenuScreen: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "白",
                    "青",
                    "緑",
                    "赤",
                ],
                maxWidth: 30,
                lineList: [3,5,5,2],
                contentFont: .body,
                colorList: [
                    .white,
                    .personalSummerLightBlue,
                    .personalSummerLightGreen,
                    .personalSummerLightRed,
                ]
            )
            unitTableString(
                columTitle: "",
                stringList: [
                    "シンジ",
                    "マリ",
                    "アスカ",
                    "ミサト",
                    "リツコ",
                    "レイ",
                    "シンジ",
                    "マリ",
                    "アスカ",
                    "ゲンドウ",
                ],
                maxWidth: 70,
                lineList: [1,1,1,2,1,2,1,2,2,2],
                contentFont: .body,
                colorList: [
                    .white,
                    .white,
                    .white,
                    .personalSummerLightBlue,
                    .personalSummerLightBlue,
                    .personalSummerLightBlue,
                    .personalSummerLightGreen,
                    .personalSummerLightGreen,
                    .personalSummerLightGreen,
                    .personalSummerLightRed,
                ]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "次回ゴジラボーナス期待度50%\n※AT後はデフォルト",
                    "次々回までにゴジラボーナス",
                    "天井550G以内 or スルー回数天井残り4回以内",
                    "次回ゴジラボーナス",
                    "次回ゴジラボーナス or 天井550G以内",
                    "次回ゴジラボーナス or スルー回数天井残り4回以内",
                    "次回ゴジラボーナス or スルー回数天井残り2回以内",
                ],
                maxWidth: 300,
                lineList: [3,2,1,2,1,2,2,2],
                contentFont: .body,
                colorList: [
                    .white,
                    .personalSummerLightBlue,
                    .personalSummerLightBlue,
                    .personalSummerLightBlue,
                    .personalSummerLightGreen,
                    .personalSummerLightGreen,
                    .personalSummerLightGreen,
                    .personalSummerLightRed,
                ]
            )
        }
    }
}

#Preview {
    goevaTableMenuScreen()
        .padding(.horizontal)
}
