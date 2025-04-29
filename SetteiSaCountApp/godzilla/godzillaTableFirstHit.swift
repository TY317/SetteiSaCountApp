//
//  godzillaTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/15.
//

import SwiftUI

struct godzillaTableFirstHit: View {
    @ObservedObject var godzilla: Godzilla
    
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "CZ",
                denominateList: godzilla.ratioCz
            )
            unitTableDenominate(
                columTitle: "AT",
                denominateList: godzilla.ratioAt
            )
        }
    }
}

#Preview {
    godzillaTableFirstHit(godzilla: Godzilla())
}
