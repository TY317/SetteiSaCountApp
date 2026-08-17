//
//  tonskillTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/17.
//

import SwiftUI

struct tonskillTableMode: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("・5種類のモードでゲーム数天井を管理")
            }
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "通常A",
                        "通常B",
                        "通常C",
                        "通常D",
                        "天国",
                    ],
                    maxWidth: 100,
                )
                unitTableString(
                    columTitle: "天井",
                    stringList: [
                        "1000G",
                        "650G",
                        "450G",
                        "250G",
                        "100G",
                    ])
            }
        }
    }
}

#Preview {
    tonskillTableMode()
}
