//
//  mahjongViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/19.
//

import SwiftUI

struct mahjongViewVoice: View {
    @ObservedObject var mahjong: Mahjong
    var body: some View {
        List {
            Section {
                Text("・AT非当選のボーナス後、AT終了後にPUSHボタンでボイス発生")
                    .foregroundColor(.secondary)
                    .font(.caption)
                HStack(spacing: 0) {
                    unitTableString(
                        columTitle: "",
                        stringList: [
                            "あやか",
                            "まどか",
                            "さやか",
                            "マシロ",
                            "パトランラン"
                        ]
                    )
                    unitTableString(
                        columTitle: "示唆",
                        stringList: [
                            "-",
                            "-",
                            "チャンス!?",
                            "大チャンス!?",
                            "引き戻しに期待"
                        ],
                        maxWidth: 170
                    )
                }
            }
        }
        .navigationTitle("ボーナス,AT 終了後ボイス")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    mahjongViewVoice(mahjong: Mahjong())
}
