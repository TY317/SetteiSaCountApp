//
//  otome5TableCycleTable.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/03.
//

import SwiftUI

struct otome5TableCycleTable: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・3種類のテーブルで周期を管理")
                Text("・天井到達でAT濃厚")
                Text("・設定変更時は天井が4周期に短縮")
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "1周期",
                        "2周期",
                        "3周期",
                        "4周期",
                        "5周期",
                        "6周期",
                    ]
                )
                unitTableString(
                    columTitle: "通常A",
                    stringList: [
                        "",
                        "",
                        "",
                        "",
                        "",
                        "天井",
                    ]
                )
                unitTableString(
                    columTitle: "通常B",
                    stringList: [
                        "",
                        "",
                        "天井",
                        "grayOut",
                        "grayOut",
                        "grayOut",
                    ]
                )
                unitTableString(
                    columTitle: "天国",
                    stringList: [
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
    otome5TableCycleTable()
        .padding(.horizontal)
}
