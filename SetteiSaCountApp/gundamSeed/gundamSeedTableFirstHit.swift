//
//  gundamSeedTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/11.
//

import SwiftUI

struct gundamSeedTableFirstHit: View {
    @ObservedObject var gundamSeed: GundamSeed
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "CZ",
                denominateList: gundamSeed.ratioCz
            )
            unitTableDenominate(
                columTitle: "AT",
                denominateList: gundamSeed.ratioAt
            )
        }
    }
}

#Preview {
    gundamSeedTableFirstHit(
        gundamSeed: GundamSeed()
    )
}
