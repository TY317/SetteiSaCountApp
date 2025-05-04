//
//  godeaterTableCzHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/03.
//

import SwiftUI

struct godeaterTableCzHit: View {
    @ObservedObject var godeater: Godeater
    var body: some View {
        VStack {
            Text("[通常中 CZ当選率]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "チャンス目",
                    percentList: godeater.ratioChanceCzHit,
                    titleFont: .body
                )
                unitTablePercent(
                    columTitle: "弱🍒・🍉",
                    percentList: godeater.ratioCherrySuikaCzHit,
                    numberofDicimal: 1,
                    titleFont: .body
                )
                unitTablePercent(
                    columTitle: "強🍒",
                    percentList: [55.2],
                    lineList: [6]
                )
            }
        }
    }
}

#Preview {
    godeaterTableCzHit(
        godeater: Godeater()
    )
    .padding(.horizontal)
}
