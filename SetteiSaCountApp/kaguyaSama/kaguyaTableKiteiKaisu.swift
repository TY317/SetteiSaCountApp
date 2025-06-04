//
//  kaguyaTableKiteiKaisu.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/29.
//

import SwiftUI

struct kaguyaTableKiteiKaisu: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "1〜5回",
                    "6〜10回",
                    "11〜15回",
                    "16〜20回",
                    "21〜25回",
                    "26〜30回"
                ],
                contentFont: .body
            )
            unitTablePercent(
                columTitle: "通常A",
                percentList: [
                    6,12,12,23,16,31
                ],
                maxWidth: 60,
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "通常B",
                percentList: [
                    23,13,29,16,12,7
                ],
                maxWidth: 60,
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "通常C",
                percentList: [
                    22,24,26,28,0,0
                ],
                maxWidth: 60,
                titleFont: .body
            )
            unitTablePercent(
                columTitle: "通常D",
                percentList: [
                    100,0,0,0,0,0
                ],
                maxWidth: 70,
                titleFont: .body
            )
        }
    }
}

#Preview {
    kaguyaTableKiteiKaisu()
        .padding(.horizontal)
}
