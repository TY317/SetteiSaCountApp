//
//  creaTableKoyakuRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/27.
//

import SwiftUI

struct creaTableKoyakuRatio: View {
    @ObservedObject var crea: Crea
    
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "🔔",
                denominateList: crea.ratioKoyakuBell,
                numberofDicimal: 1,
            )
            unitTableDenominate(
                columTitle: "🍒",
                denominateList: crea.ratioKoyakuCherry
            )
            unitTableDenominate(
                columTitle: "🍉",
                denominateList: crea.ratioKoyakuSuika
            )
            unitTableDenominate(
                columTitle: "チャンス目",
                denominateList: crea.ratioKoyakuChance
            )
        }
    }
}

#Preview {
    creaTableKoyakuRatio(
        crea: Crea(),
    )
    .padding(.horizontal)
}
