//
//  acceleratorTableGameMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct acceleratorTableGameMode: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "モードA",
                    "モードB",
                    "モードC",
                    "モードD"
                ],
                maxWidth: 120
            )
            unitTableString(
                columTitle: "天井",
                stringList: [
                    "1000G+α",
                    "900G+α",
                    "800G+α",
                    "300G+α"
                ]
            )
        }
    }
}

#Preview {
    acceleratorTableGameMode()
}
