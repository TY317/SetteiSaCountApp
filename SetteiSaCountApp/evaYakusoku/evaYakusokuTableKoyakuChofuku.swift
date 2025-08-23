//
//  evaYakusokuTableKoyakuChofuku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/23.
//

import SwiftUI

struct evaYakusokuTableKoyakuChofuku: View {
    @ObservedObject var evaYakusoku: EvaYakusoku
    var body: some View {
        VStack {
            Text("・ハズレ、ベルでの重複が特に設定差大きい")
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("・ハズレ、リプ、ベル重複の合算出現率は設定1で1/3000、設定6で1/1200程度と予想\n　(独自算出のため参考程度として下さい)")
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "ハズレ",
                    percentList: evaYakusoku.ratioChofukuHazure,
                    numberofDicimal: 2,
                )
                unitTablePercent(
                    columTitle: "リプレイ",
                    percentList: evaYakusoku.ratioChofukuReplay,
                    numberofDicimal: 2,
                )
                unitTablePercent(
                    columTitle: "🔔",
                    percentList: evaYakusoku.ratioChofukuBell,
                    numberofDicimal: 2,
                )
                unitTablePercent(
                    columTitle: "🍒",
                    percentList: evaYakusoku.ratioChofukuCherry,
                    numberofDicimal: 1,
                )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "弱🍉",
                    percentList: evaYakusoku.ratioChofukuJakuSuika,
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "強🍉",
                    percentList: evaYakusoku.ratioChofukuKyoSuika,
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "リーチ目役",
                    percentList: [100],
                    lineList: [6],
                    colorList: [.white],
                )
            }
        }
    }
}

#Preview {
    evaYakusokuTableKoyakuChofuku(
        evaYakusoku: EvaYakusoku(),
    )
    .padding(.horizontal)
}
