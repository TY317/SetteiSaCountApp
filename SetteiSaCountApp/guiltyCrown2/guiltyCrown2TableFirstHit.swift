//
//  guiltyCrown2TableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/07.
//

import SwiftUI

struct guiltyCrown2TableFirstHit: View {
    @ObservedObject var guiltyCrown2: GuiltyCrown2
    
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ボーナス",
                denominateList: guiltyCrown2.ratioBonus
            )
            unitTableDenominate(
                columTitle: "AT",
                denominateList: guiltyCrown2.ratioAt
            )
            unitTableDenominate(
                columTitle: "合算",
                denominateList: guiltyCrown2.ratioFirstTotal
            )
        }
    }
}

#Preview {
    guiltyCrown2TableFirstHit(
        guiltyCrown2: GuiltyCrown2()
    )
    .padding(.horizontal)
}
