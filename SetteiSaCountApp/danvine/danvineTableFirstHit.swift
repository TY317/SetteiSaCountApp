//
//  danvineTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct danvineTableFirstHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ボーナス",
                denominateList: [355.8,351.6,342.7,332.9,319.7,307.7]
            )
            unitTableDenominate(
                columTitle: "ST",
                denominateList: [597.7,588.4,572.5,552.5,528.0,505.6]
            )
        }
    }
}

#Preview {
    danvineTableFirstHit()
}
