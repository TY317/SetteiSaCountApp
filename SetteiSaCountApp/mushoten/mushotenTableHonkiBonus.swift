//
//  mushotenTableHonkiBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/15.
//

import SwiftUI

struct mushotenTableHonkiBonus: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "本気ボーナス",
                denominateList: [
                    105345.5,
                    106693.6,
                    69766.4,
                    66245.2,
                    49130.9,
                    45596.8,
                ]
            )
        }
    }
}

#Preview {
    mushotenTableHonkiBonus()
        .padding(.horizontal)
}
