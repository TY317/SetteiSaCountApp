//
//  kanokariTableModeMove.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/09/26.
//

import SwiftUI

struct kanokariTableModeMove: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("・かのかりボーナス後、1Gレンチャンス終了後は通常モードが優遇")
            Text("　高設定ほど100G,300GのゾーンでCZに当選しやすいと思われる")
            Text("・設定変更後やREG後の移行には設定差なし")
        }
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "モード1",
                    "モード2",
                    "モード3",
                ],
                titleLine: 2
            )
            unitTableString(
                columTitle: "設定変更後",
                stringList: [
                    "-",
                    "◎",
                    "◎",
                ],
                titleLine: 2
            )
            unitTableString(
                columTitle: "REG後",
                stringList: [
                    "○",
                    "○",
                    "△",
                ],
                titleLine: 2
            )
            unitTableString(
                columTitle: "かのかり\nボーナス後",
                stringList: [
                    "◎",
                    "△",
                    "△",
                ],
                titleLine: 2
            )
        }
    }
}

#Preview {
    kanokariTableModeMove()
        .padding(.horizontal)
}
