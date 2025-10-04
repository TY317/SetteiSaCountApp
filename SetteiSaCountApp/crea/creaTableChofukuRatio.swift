//
//  creaTableChofukuRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/27.
//

import SwiftUI

struct creaTableChofukuRatio: View {
    @ObservedObject var crea: Crea
    
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "🔔",
                percentList: crea.ratioChofukuBell,
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "🍒",
                percentList: crea.ratioChofukuCherry,
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "🍉",
                percentList: crea.ratioChofukuSuika,
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "チャンス目",
                percentList: crea.ratioChofukuChance
            )
        }
    }
}

#Preview {
    creaTableChofukuRatio(
        crea: Crea(),
    )
    .padding(.horizontal)
}
