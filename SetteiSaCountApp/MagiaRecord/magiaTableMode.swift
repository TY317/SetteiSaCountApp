//
//  magiaTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/10.
//

import SwiftUI

struct magiaTableMode: View {
    let lineNumberList: [Int] = [1,2,2,2,2,1]
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "いろはモード",
                    "やちよモード",
                    "さなモード",
                    "鶴乃モード",
                    "フェリシアモード",
                    "黒江モード"
                ],
                maxWidth: 160,
                lineList: self.lineNumberList,
                contentFont: .body
            )
            unitTableString(
                columTitle: "恩恵",
                stringList: [
                    "デフォルト",
                    "ポイント倍増ゾーン\n当選率アップ",
                    "スイカでのCZ\n当選率アップ",
                    "強チェリーでのボーナス\n当選率アップ",
                    "チャンス目でのボーナス\n当選率アップ",
                    "穢れの獲得量アップ"
                ],
                maxWidth: 250,
                lineList: self.lineNumberList,
                contentFont: .body
            )
        }
    }
}

#Preview {
    magiaTableMode()
}
