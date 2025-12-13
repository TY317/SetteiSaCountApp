//
//  bakemonoTableMaisuSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/06.
//

import SwiftUI

struct bakemonoTableMaisuSisa: View {
    var body: some View {
        VStack {
            Text("・特殊な枚数表示パターンもあり")
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "174枚OVER",
                        "331枚OVER",
                        "543枚OVER",
                    ],
                    lineList: [1,1,1,],
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "設定2 以上濃厚",
                        "設定6 濃厚",
                        "設定3 以上濃厚",
                    ],
                    lineList: [1,1,1,],
                )
            }
        }
    }
}

#Preview {
    bakemonoTableMaisuSisa()
}
