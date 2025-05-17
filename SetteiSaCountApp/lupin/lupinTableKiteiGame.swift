//
//  lupinTableKiteiGame.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/11.
//

import SwiftUI

struct lupinTableKiteiGame: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableGameIndex(
                    gameList: [1,50,100,200,300,400,500,600,700,800,900,1000],
                    maxWidth: 70,
                    contentFont: .body
                )
                unitTableString(
                    columTitle: "天井",
                    stringList: [
                        "-",
                        "-",
                        "×",
                        "△",
                        "▲",
                        "◯",
                        "-",
                        "-",
                        "設定変更時",
                        "-",
                        "-",
                        "天井"
                    ]
                )
                unitTableString(
                    columTitle: "CZ",
                    stringList: [
                        "△",
                        "◯",
                        "△",
                        "◎",
                        "△",
                        "◎",
                        "△",
                        "◎",
                        "△",
                        "◎",
                        "△",
                        "△"
                    ]
                )
                unitTableString(
                    columTitle: "高確移行",
                    stringList: [
                        "◎",
                        "×",
                        "◯",
                        "×",
                        "◯",
                        "×",
                        "◯",
                        "×",
                        "◯",
                        "×",
                        "◯",
                        "◯"
                    ]
                )
            }
            HStack {
                Spacer()
                Text("期待度：◎ > ◯ > △ > ▲ > ×")
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    lupinTableKiteiGame()
        .padding(.horizontal)
}
