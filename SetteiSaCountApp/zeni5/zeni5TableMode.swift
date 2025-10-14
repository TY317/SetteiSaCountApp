//
//  zeni5TableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/10/14.
//

import SwiftUI

struct zeni5TableMode: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・規定ゲーム数を4つのモードで管理")
                Text("・高設定ほど上位のモードへ移行しやすい")
                Text("・1000Gを超えてのボーナス当選時は、次回通常B以上濃厚")
            }
            .padding(.bottom)
            Text("[ゾーンごとの期待度]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableGameIndex(gameList: [50,150,250,350,450,550,650,750,850,950,1050,1150,1250])
                unitTableString(
                    columTitle: "通常A",
                    stringList: ["◯","△","▲","◎","▲","◎","▲","◯","▲","▲","▲","▲","天井"]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: ["◯","△","▲","◎","▲","◯","▲","◯","▲","天井","grayOut","grayOut","grayOut"]
                )
                unitTableString(
                    columTitle: "通常C",
                    stringList: ["◯","△","◯","▲","◎","天井","grayOut","grayOut","grayOut","grayOut","grayOut","grayOut","grayOut"]
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: ["◯","天井","grayOut","grayOut","grayOut","grayOut","grayOut","grayOut","grayOut","grayOut","grayOut","grayOut","grayOut"]
                )
            }
        }
    }
}

#Preview {
    zeni5TableMode()
        .padding(.horizontal)
}
