//
//  kaguyaTableEyeCatch.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/14.
//

import SwiftUI

struct kaguyaTableEyeCatch: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "白背景",
                    "青背景",
                    "赤背景",
                    "虹背景",
                ],
                maxWidth: 100,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "デフォルト",
                    "引き戻し期待度約67%",
                    "引き戻し濃厚",
                    "1G連濃厚",
                ],
                maxWidth: 200,
            )
        }
    }
}

#Preview {
    kaguyaTableEyeCatch()
}
