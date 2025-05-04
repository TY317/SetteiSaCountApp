//
//  mahjongViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/17.
//

import SwiftUI

struct mahjongViewFirstHit: View {
//    @ObservedObject var mahjong = Mahjong()
    @ObservedObject var mahjong: Mahjong
    
    var body: some View {
        List {
            Section {
                Text("現在値は打-WINを参照してください")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // //// 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(mahjongTableFirstHit(mahjong: mahjong))
                        )
                    )
                )
            } header: {
                Text("初当り")
            }
        }
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    mahjongViewFirstHit(mahjong: Mahjong())
}
