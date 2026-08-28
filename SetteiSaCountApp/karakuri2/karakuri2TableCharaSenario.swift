//
//  karakuri2TableCharaSenario.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/27.
//

import SwiftUI

struct karakuri2TableCharaSenario: View {
    @ObservedObject var karakuri2: Karakuri2
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "奇数示唆合算",
                percentList: karakuri2.ratioCharaKisu
            )
            unitTablePercent(
                columTitle: "偶数示唆合算",
                percentList: karakuri2.ratioCharaGusu
            )
        }
        .padding(.bottom)
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "奇数示唆",
                    "偶数示唆",
                    "偶数かつ高設定示唆",
                    "奇数かつ高設定示唆",
                ]
            )
            unitTablePercent(
                columTitle: "設定1",
                percentList: [
                    karakuri2.ratioChara1[0],
                    karakuri2.ratioChara2[0],
                    karakuri2.ratioChara3[0],
                    karakuri2.ratioChara4[0],
                ],
                maxWidth: 65,
            )
            unitTablePercent(
                columTitle: "設定2",
                percentList: [
                    karakuri2.ratioChara1[1],
                    karakuri2.ratioChara2[1],
                    karakuri2.ratioChara3[1],
                    karakuri2.ratioChara4[1],
                ],
                maxWidth: 65,
            )
            unitTablePercent(
                columTitle: "設定3",
                percentList: [
                    karakuri2.ratioChara1[2],
                    karakuri2.ratioChara2[2],
                    karakuri2.ratioChara3[2],
                    karakuri2.ratioChara4[2],
                ],
                maxWidth: 65,
            )
        }
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "奇数示唆",
                    "偶数示唆",
                    "偶数かつ高設定示唆",
                    "奇数かつ高設定示唆",
                ]
            )
            unitTablePercent(
                columTitle: "設定4",
                percentList: [
                    karakuri2.ratioChara1[3],
                    karakuri2.ratioChara2[3],
                    karakuri2.ratioChara3[3],
                    karakuri2.ratioChara4[3],
                ],
                maxWidth: 65,
            )
            unitTablePercent(
                columTitle: "設定5",
                percentList: [
                    karakuri2.ratioChara1[4],
                    karakuri2.ratioChara2[4],
                    karakuri2.ratioChara3[4],
                    karakuri2.ratioChara4[4],
                ],
                maxWidth: 65,
            )
            unitTablePercent(
                columTitle: "設定6",
                percentList: [
                    karakuri2.ratioChara1[5],
                    karakuri2.ratioChara2[5],
                    karakuri2.ratioChara3[5],
                    karakuri2.ratioChara4[5],
                ],
                maxWidth: 65,
            )
        }
    }
}

#Preview {
    karakuri2TableCharaSenario(
        karakuri2: Karakuri2(),
    )
    .padding(.horizontal)
}
