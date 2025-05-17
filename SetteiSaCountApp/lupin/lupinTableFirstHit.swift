//
//  lupinTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/11.
//

import SwiftUI

struct lupinTableFirstHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ボーナス",
                denominateList: [289.1,275.6,262.6,233.9,223.6,216.3]
            )
            unitTableDenominate(
                columTitle: "AT",
                denominateList: [371.4,353.8,330.2,300.3,289.9,274.9]
            )
        }
    }
}

#Preview {
    lupinTableFirstHit()
        .padding(.horizontal)
}
