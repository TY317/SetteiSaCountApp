//
//  inuyashaTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/11.
//

import SwiftUI

struct inuyashaTableFirstHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "CZ",
                denominateList: [249,244,240,234,217,210]
            )
            unitTableDenominate(
                columTitle: "AT",
                denominateList: [435,420,402,366,336,313]
            )
        }
    }
}

#Preview {
    inuyashaTableFirstHit()
}
