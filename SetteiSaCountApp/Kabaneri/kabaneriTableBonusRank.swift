//
//  kabaneriTableBonusRank.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct kabaneriTableBonusRank: View {
    var body: some View {
        VStack {
            Text("[無名CZ,生駒CZ失敗時の昇格]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "1UP",
                    percentList: [20,30,30,45,45.4,49.6]
                )
                unitTablePercent(
                    columTitle: "3UP",
                    percentList: [0.4],
                    numberofDicimal: 1,
                    lineList: [6],
                    colorList: [.white],
                )
            }
        }
    }
}

#Preview {
    kabaneriTableBonusRank()
}
