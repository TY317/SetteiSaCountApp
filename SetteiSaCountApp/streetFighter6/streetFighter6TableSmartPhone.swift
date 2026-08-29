//
//  streetFighter6TableSmartPhone.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/22.
//

import SwiftUI

struct streetFighter6TableSmartPhone: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "JAMIE",
                    "KEN",
                    "RYU",
                ],
                maxWidth: 80,
                lineList: [1,1,2]
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "FB規定回数まで2回以下の期待度UP",
                    "FB規定回数まで2回以下濃厚",
                    "FB本前兆濃厚\n規定回数到達の期待度UP",
                ],
                maxWidth: 300,
                lineList: [1,1,2]
            )
        }
    }
}

#Preview {
    streetFighter6TableSmartPhone()
        .padding(.horizontal)
}
