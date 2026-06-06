//
//  sao2TableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/06.
//

import SwiftUI

struct sao2TableMode: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・5つのモードで液晶規定G数でのCZ当選率を管理")
                Text("・天国移行まで転落なし。AT当選時も天国でなければ転落なし")
            }
            HStack(spacing: 0) {
                unitTableGameIndex(gameList: [50,100,250,350,500,650,800])
                unitTableString(
                    columTitle: "通常A",
                    stringList: [
                        "△",
                        "◯",
                        "◯",
                        "△",
                        "◯",
                        "△",
                        "天井",
                    ]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: [
                        "△",
                        "◯",
                        "△",
                        "◎",
                        "△",
                        "◯",
                        "天井",
                    ]
                )
                unitTableString(
                    columTitle: "通常C",
                    stringList: [
                        "△",
                        "◎",
                        "◯",
                        "◎",
                        "◯",
                        "天井",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "通常D",
                    stringList: [
                        "△",
                        "◎",
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: [
                        "◯",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
            }
        }
    }
}

#Preview {
    sao2TableMode()
        .padding(.horizontal)
}
