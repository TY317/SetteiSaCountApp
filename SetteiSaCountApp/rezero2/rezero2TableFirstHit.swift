//
//  rezero2TableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/29.
//

import SwiftUI

struct rezero2TableFirstHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "AT",
                denominateList: [
                    417.2,408.5,387.1,354.3,332.9,305.4
                ]
            )
        }
    }
}

#Preview {
    rezero2TableFirstHit()
}
