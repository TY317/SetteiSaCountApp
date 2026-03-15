//
//  kabaneriUnatoTableShokichi.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/15.
//

import SwiftUI

struct kabaneriUnatoTableShokichi: View {
    var body: some View {
        VStack {
            Text("・朝一から何回目で出るかに設定差あり")
                .padding(.bottom)
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "朝一から",
                    stringList: [
                        "1回目",
                        "2回目",
                        "3回目",
                        "4回目",
                        "5回目",
                    ],
                    maxWidth: 80,
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "設定6が最も出現しやすい",
                        "設定2,6が最も出現しやすい",
                        "設定3,6が最も出現しやすい",
                        "設定4,6が最も出現しやすい",
                        "設定5,6が最も出現しやすい",
                    ],
                    maxWidth: 250,
                )
            }
        }
    }
}

#Preview {
    kabaneriUnatoTableShokichi()
        .padding(.horizontal)
}
