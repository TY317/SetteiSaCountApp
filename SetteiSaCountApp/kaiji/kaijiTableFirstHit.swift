//
//  kaijiTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/23.
//

import SwiftUI

struct kaijiTableFirstHit: View {
    @ObservedObject var kaiji = Kaiji()
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "CZ初当り",
                denominateList: kaiji.ratioCz
            )
            unitTableDenominate(
                columTitle: "ボーナス初当り",
                denominateList: kaiji.ratioBonus
            )
        }
    }
}

#Preview {
    kaijiTableFirstHit()
}
