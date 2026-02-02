//
//  enen2TableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/02.
//

import SwiftUI

struct enen2TableMode: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・ボーナス規定ゲーム数を5つのモードで管理")
                Text("・前作と違い150Gでの抽選は無いが250Gでの当選率がアップ")
            }
            .padding(.bottom)
            
            Text("[モードごとの天井ゲーム数]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "通常A",
                        "通常B",
                        "通常C",
                        "通常D",
                        "通常E",
                    ],
                    maxWidth: 100,
                )
                unitTableString(
                    columTitle: "天井",
                    stringList: [
                        "850G+α",
                        "650G+α",
                        "450G+α",
                        "250G+α",
                        "88G+α",
                    ]
                )
            }
        }
    }
}

#Preview {
    enen2TableMode()
        .padding(.horizontal)
}
