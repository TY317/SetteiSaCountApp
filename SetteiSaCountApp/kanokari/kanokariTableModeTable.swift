//
//  kanokariTableModeTable.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/09/26.
//

import SwiftUI

struct kanokariTableModeTable: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "100G",
                    "300G",
                    "500G",
                    "700G",
                    "900G",
                ]
            )
            unitTableString(
                columTitle: "モード1",
                stringList: [
                    "10.2%",
                    "10.2%",
                    "濃厚",
                    "10.2%",
                    "10.2%",
                ]
            )
            unitTableString(
                columTitle: "モード2",
                stringList: [
                    "30.1%",
                    "40.2%",
                    "濃厚",
                    "30.1%",
                    "30.1%",
                ]
            )
            unitTableString(
                columTitle: "モード3",
                stringList: [
                    "濃厚",
                    "30.1%",
                    "30.1%",
                    "濃厚",
                    "30.1%",
                ]
            )
        }
    }
}

#Preview {
    kanokariTableModeTable()
        .padding(.horizontal)
}
