//
//  hihodenTableLengedMoveBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/07.
//

import SwiftUI

struct hihodenTableLengedMoveBonus: View {
    @ObservedObject var hihoden: Hihoden
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("・ショートとロングの2種類があり")
                Text("・偶数設定は伝説モードに移行しやすく、ショートの割合が多い")
                Text("・奇数設定は初当りが重い代わりに、ロングに入りやすい")
            }
            .padding(.bottom)
            Text("[BIG終了後]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "3の倍数連以外",
                    percentList: hihoden.ratioLegendAfterBig
                )
                unitTablePercent(
                    columTitle: "3の倍数連",
                    percentList: [100],
                    lineList: [6],
                    colorList: [.white],
                )
            }
            .padding(.bottom)
            Text("[REG終了後]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "3の倍数連以外",
                    percentList: hihoden.ratioLegendAfterReg
                )
                unitTablePercent(
                    columTitle: "3の倍数連",
                    percentList: [50,55.2,52.9,56,54.9,57.3]
                )
            }
        }
    }
}

#Preview {
    hihodenTableLengedMoveBonus(
        hihoden: Hihoden(),
    )
    .padding(.horizontal)
}
