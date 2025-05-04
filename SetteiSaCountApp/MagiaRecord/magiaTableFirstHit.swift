//
//  magiaTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct magiaTableFirstHit: View {
//    @ObservedObject var magia = Magia()
    @ObservedObject var magia: Magia
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ボーナス合算",
                denominateList: magia.ratioBonus
            )
            unitTableDenominate(
                columTitle: "AT",
                denominateList: magia.ratioAt
            )
        }
    }
}

#Preview {
    magiaTableFirstHit(magia: Magia())
}
