//
//  kerottoTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/07/19.
//

import SwiftUI

struct kerottoTableFirstHit: View {
    @ObservedObject var kerotto: Kerotto
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "SBB",
                    denominateList: kerotto.ratioFirstHitSbb
                )
                unitTableDenominate(
                    columTitle: "BB",
                    denominateList: kerotto.ratioFirstHitBb
                )
                unitTableDenominate(
                    columTitle: "REG",
                    denominateList: kerotto.ratioFirstHitReg
                )
            }
            
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "赤頭",
                    percentList: kerotto.ratioFirstHitRed
                )
                unitTablePercent(
                    columTitle: "白頭",
                    percentList: kerotto.ratioFirstHitWhite
                )
            }
        }
    }
}

#Preview {
    kerottoTableFirstHit(
        kerotto: Kerotto(),
    )
    .padding(.horizontal)
}
