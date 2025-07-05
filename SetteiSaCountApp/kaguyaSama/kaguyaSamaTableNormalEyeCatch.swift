//
//  kaguyaSamaTableNormalEyeCatch.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/14.
//

import SwiftUI

struct kaguyaSamaTableNormalEyeCatch: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "白背景",
                    "青背景",
                    "赤背景",
                ],
                maxWidth: 100,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "次回ビッグ期待度アップ",
                    "次回スーパービッグ濃厚",
                ],
                maxWidth: 250,
            )
        }
    }
}

#Preview {
    kaguyaSamaTableNormalEyeCatch()
}
