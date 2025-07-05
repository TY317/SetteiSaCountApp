//
//  watakonTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/30.
//

import SwiftUI

struct watakonTableFirstHit: View {
    @ObservedObject var watakon: Watakon
    
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ボーナス",
                denominateList: watakon.ratioBonus
            )
            unitTableDenominate(
                columTitle: "AT",
                denominateList: watakon.ratioAt
            )
        }
    }
}

#Preview {
    watakonTableFirstHit(
        watakon: Watakon(),
    )
}
