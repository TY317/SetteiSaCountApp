//
//  dmc5TableNazoDante.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/03.
//

import SwiftUI

struct dmc5TableNazoDante: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "謎ダンテCZ",
                denominateList: [
                    21238.7,
                    17505.5,
                    14672.2,
                    10405.1,
                    9631.4,
                    9079.6
                ]
            )
        }
    }
}

#Preview {
    dmc5TableNazoDante()
}
