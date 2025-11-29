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
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "🔔",
                    percentList: [crea.ratioChofukuBell[0]],
                    numberofDicimal: 1,
                    lineList: [6],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "チャンス目",
                    percentList: crea.ratioChofukuChance,
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "🍒",
                    percentList: crea.ratioChofukuCherry,
                    numberofDicimal: 1,
                )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "🍉",
                    percentList: crea.ratioChofukuSuika,
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "滑り🍉",
                    percentList: crea.ratioChofukuSuberiSuika,
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "ピラミッド",
                    percentList: [100],
                    numberofDicimal: 0,
                    lineList: [6],
                    colorList: [.white],
                )
            }
        }
    }
}

#Preview {
    creaTableChofukuRatio(
        crea: Crea(),
    )
    .padding(.horizontal)
}
