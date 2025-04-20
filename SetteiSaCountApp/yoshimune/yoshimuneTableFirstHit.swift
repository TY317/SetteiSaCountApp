//
//  yoshimuneTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/19.
//

import SwiftUI

struct yoshimuneTableFirstHit: View {
    @ObservedObject var yoshimune: Yoshimune
    
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "初当り",
                denominateList: yoshimune.ratioBonusFirstHit
            )
        }
    }
}

#Preview {
    yoshimuneTableFirstHit(yoshimune: Yoshimune())
}
