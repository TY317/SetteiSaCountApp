//
//  hokutoTenseiTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/02.
//

import SwiftUI

struct hokutoTenseiTableMode: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・4種類のモードで規定あべしを管理")
                Text("・高設定ほど1000あべしを超えにくい")
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "モードA",
                        "モードB",
                        "モードC",
                        "天国",
                    ],
                    maxWidth: 100,
                )
                unitTableString(
                    columTitle: "天井",
                    stringList: [
                        "1536あべし",
                        "896あべし",
                        "576あべし",
                        "128あべし",
                    ]
                )
            }
        }
    }
}

#Preview {
    hokutoTenseiTableMode()
        .padding(.horizontal)
}
