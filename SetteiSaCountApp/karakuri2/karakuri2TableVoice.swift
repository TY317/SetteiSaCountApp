//
//  karakuri2TableVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/27.
//

import SwiftUI

struct karakuri2TableVoice: View {
    let lineList: [Int] = [1,1,1,1,1,2,2,2,1,1,2]
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "私の名前はしろがね",
                    "人生はそういうものだよ",
                    "何を恐れることがある",
                    "俺をしろがねと呼びな",
                    "僕は僕さ",
                    "近づいてきているようです",
                    "すぐそばまで来ているようです",
                    "何かを感じます",
                    "あるるかんがある限り…",
                    "女神が留守のようです",
                    "あなたの運命が変わる…",
                ],
                maxWidth: 200,
                lineList: self.lineList,
                contentFont: .subheadline,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "設定2 否定",
                    "設定3 否定",
                    "設定4 否定",
                    "設定5 否定",
                    "スイカ規定回数まで残り3回以下",
                    "スイカ規定回数まで残り1回以下",
                    "次回運命盤報酬が幕間チャンス以上",
                    "SHOW TIMEストック(復活)",
                    "次回運命盤報酬がAT直撃以上",
                    "次回運命盤報酬がAT＋上位AT・CZ",
                ],
                maxWidth: 200,
                lineList: self.lineList,
                contentFont: .subheadline,
            )
        }
    }
}

#Preview {
    karakuri2TableVoice()
        .padding(.horizontal)
}
