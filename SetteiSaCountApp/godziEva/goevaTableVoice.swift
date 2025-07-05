//
//  goevaTableVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/21.
//

import SwiftUI

struct goevaTableVoice: View {
    let lineList: [Int] = [1,2,2,2,2]
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "シンジ",
                    "アスカ",
                    "レイ",
                    "ミサト",
                    "加持",
                ],
                maxWidth: 60,
                lineList: self.lineList,
                contentFont: .body,
            )
            unitTableString(
                columTitle: "セリフ",
                stringList: [
                    "僕に任せて下さい",
                    "誰よりも戦果を上げて見せるわ",
                    "私もみんなの力になりたい",
                    "私たちはできる事をするだけよ",
                    "自分で考え、自分で決めろ。後悔のないように",
                ],
                lineList: self.lineList,
                contentFont: .body,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "次回ボーナスの天井到達期待度50%",
                    "前回ボーナスからAT天井回数が1回以上減算",
                    "スルー回数天井残り3回以内",
                    "スルー回数天井残り2回以内&次回ボーナス天井到達期待度50%",
                ],
                lineList: self.lineList,
                contentFont: .body,
            )
        }
    }
}

#Preview {
    goevaTableVoice()
        .padding(.horizontal)
}
