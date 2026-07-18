//
//  karakuri2TableModeSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/18.
//

import SwiftUI

struct karakuri2TableModeSisa: View {
    let lineList1: [Int] = [6,4,4]
    let lineList2: [Int] = [2,2,2,2,2,2,2,]
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "スポット\nライト",
                    "セリフ演出",
                    "前兆ステージ",
                ],
                maxWidth: 70,
                lineList: self.lineList1,
                contentFont: .subheadline,
            )
            unitTableString(
                columTitle: "",
                stringList: [
                    "スポットライトのみ",
                    "スポットライト＋あるるかんシルエット",
                    "スポットライト＋あるるかんアップ",
                    "アンジェリーナ\n「主さんは一緒に歩いてくれる・・」",
                    "フランシーヌ\n「いつかまた…私と出会ってね」",
                    "訪れし者\n移行時",
                    "訪れし者\n連続演出失敗時",
                ],
                lineList: self.lineList2,
                contentFont: .subheadline,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "残り500G以内の期待度アップ",
                    "残り300G以内濃厚",
                    "残り200G以内濃厚",
                    "通常D濃厚",
                    "通常D濃厚",
                    "本前兆＆通常D期待度アップ",
                    "さらに通常D期待度アップ",
                ],
                lineList: self.lineList2,
                contentFont: .subheadline,
            )
        }
    }
}

#Preview {
    karakuri2TableModeSisa()
        .padding(.horizontal)
}
