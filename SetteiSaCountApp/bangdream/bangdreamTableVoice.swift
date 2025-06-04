//
//  bangdreamTableVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/28.
//

import SwiftUI

struct bangdreamTableVoice: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "どうかな？",
                    "うんうん！",
                    "なるほど なるほど",
                    "チェック チェック",
                    "これは間違いないね",
                    "撃ち抜くなら最高の夢！だよ！",
                ],
                maxWidth: 160,
                lineList: [1,1,2,2,2,1],
                contentFont: .body
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "残り周期3以内のチャンス",
                    "残り周期3以内のチャンス\nかつ残り7周期以内濃厚",
                    "残り周期3以内のチャンス\nかつ残り5周期以内濃厚",
                    "残り周期1のチャンス\nかつ残り3周期以内濃厚",
                    "残り1周期濃厚"
                ],
                maxWidth: 200,
                lineList: [1,1,2,2,2,1],
                contentFont: .subheadline
            )
        }
    }
}

#Preview {
    bangdreamTableVoice()
        .padding(.horizontal)
}
