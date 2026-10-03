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
            unitTablePercentVer2(
                columTitle: "モード1",
                percentList: [10.2,10.2,1000,10.2,10.2],
            )
            unitTablePercentVer2(
                columTitle: "モード2",
                percentList: [30.1,40.2,1000,30.1,30.1],
            )
            unitTablePercentVer2(
                columTitle: "モード3",
                percentList: [1000,30.1,30.1,1000,30.1],
            )
        }
    }
}

#Preview {
    kanokariTableModeTable()
        .padding(.horizontal)
}
