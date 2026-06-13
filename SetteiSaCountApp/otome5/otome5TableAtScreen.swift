//
//  otome5TableAtScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/13.
//

import SwiftUI

struct otome5TableAtScreen: View {
    let lineList: [Int] = [1,1,2,2,2,2,2]
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "ノブナガ",
                    "マサムネ＆ヒデヨシ",
                    "モトナリ＆ドウセツ＆ソウリン",
                    "敵キャラ集合",
                    "イエヤス＆シンゲン＆カンスケ＆ヨシモト",
                    "乙女集合（赤背景）",
                    "乙女集合（金背景）",
                ],
                maxWidth: 200,
                lineList: self.lineList,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "テーブルB 以上示唆",
                    "テーブルB 以上示唆＆1周期目が100G以内のチャンス",
                    "乙女ストラップモード　ヨシテル濃厚",
                    "テーブルB以上濃厚\nテーブルAなら設定4以上濃厚",
                    "テーブル天国濃厚\n天国否定で設定4以上濃厚",
                    "テーブル天国濃厚＆設定2以上濃厚",
                ],
                maxWidth: 200,
                lineList: self.lineList,
            )
        }
    }
}

#Preview {
    otome5TableAtScreen()
        .padding(.horizontal)
}
