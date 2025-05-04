//
//  acceleratorTableHitaioChance.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct acceleratorTableHitaioChance: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "非対応チャンス目からの当選",
                percentList: [0.4,0.4,0.4,0.8,1.2,1.2],
                numberofDicimal: 1,
                maxWidth: 300
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    acceleratorTableHitaioChance()
}
