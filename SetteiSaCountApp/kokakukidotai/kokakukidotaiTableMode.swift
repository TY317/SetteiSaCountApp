//
//  kokakukidotaiTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/01.
//

import SwiftUI

struct kokakukidotaiTableMode: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・CZの規定ゲーム数は4つの通常モードとリセット専用モードで管理")
                Text("・白の境界失敗後はモード不問で最大天井が400+αとなり到達時はタチコマS.A.M濃厚となる")
            }
            .padding(.bottom)
            
            Text("[ゾーンごとの期待度]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableGameIndex(gameList: [50,100,150,200,250,300,350,400,450,500,550])
                unitTablePercent(
                    columTitle: "通常A",
                    percentList: [
                        25,
                        50,
                        1.3,
                        -90,
                        50,
                        0,
                        25,
                        -90,
                        50,
                        0,
                        -10,
                    ],
                )
                unitTablePercent(
                    columTitle: "通常B",
                    percentList: [
                        50,
                        1.3,
                        50,
                        -90,
                        25,
                        1.3,
                        50,
                        -90,
                        -10,
                        -100,
                        -100,
                    ],
                )
                unitTablePercent(
                    columTitle: "通常C",
                    percentList: [
                        25,
                        50,
                        1.3,
                        -90,
                        -10,
                        -100,
                        -100,
                        -100,
                        -100,
                        -100,
                        -100,
                    ],
                )
                unitTablePercent(
                    columTitle: "通常D",
                    percentList: [
                        100,
                        1.3,
                        -10,
                        -100,
                        -100,
                        -100,
                        -100,
                        -100,
                        -100,
                        -100,
                        -100,
                    ],
                )
                unitTablePercent(
                    columTitle: "リセット",
                    percentList: [
                        50,
                        25,
                        50,
                        -90,
                        50,
                        0,
                        -10,
                        -100,
                        -100,
                        -100,
                        -100,
                    ],
                )
            }
            Text("★：タチコマS.A.Mに期待")
        }
    }
}

#Preview {
    kokakukidotaiTableMode()
        .padding(.horizontal)
}
