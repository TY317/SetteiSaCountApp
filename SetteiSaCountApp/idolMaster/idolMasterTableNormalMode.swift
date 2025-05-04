//
//  idolMasterTableNormalMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct idolMasterTableNormalMode: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "通常",
                    "チャンス",
                    "天国"
                ]
            )
            unitTableString(
                columTitle: "天井",
                stringList: [
                    "800G+α",
                    "500G+α",
                    "100G+α"
                ]
            )
        }
    }
}

#Preview {
    idolMasterTableNormalMode()
}
