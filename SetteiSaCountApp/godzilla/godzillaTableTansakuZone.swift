//
//  godzillaTableTansakuZone.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/15.
//

import SwiftUI

struct godzillaTableTansakuZone: View {
    @ObservedObject var godzilla = Godzilla()
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "探索ゾーン",
                denominateList: godzilla.ratioTansakuZone
            )
        }
    }
}

#Preview {
    godzillaTableTansakuZone()
}
