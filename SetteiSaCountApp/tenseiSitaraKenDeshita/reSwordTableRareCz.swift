//
//  reSwordTableRareCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/03.
//

import SwiftUI

struct reSwordTableRareCz: View {
    @ObservedObject var reSword: ReSword
    
    var body: some View {
        VStack {
            Text("・状態別のCZ当選率に設定差があると思われる")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            Text("[通常]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "弱🍒",
                    percentList: reSword.ratioCzJakuCherry,
                )
                unitTablePercent(
                    columTitle: "強🍒",
                    percentList: reSword.ratioCzKyoCherry,
                )
            }
            .padding(.bottom)
            Text("[ボーナス高確]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "弱🍒",
                    percentList: reSword.ratioCzKokakuJakuCherry,
                )
                unitTablePercent(
                    columTitle: "強🍒",
                    percentList: reSword.ratioCzKokakuKyoCherry,
                )
            }
            .padding(.bottom)
            Text("[超高確]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "弱🍒",
                    percentList: reSword.ratioCzChokokakuJakuCherry,
                )
                unitTablePercent(
                    columTitle: "強🍒",
                    percentList: reSword.ratioCzChokokakuKyoCherry,
                )
            }
        }
    }
}

#Preview {
    reSwordTableRareCz(
        reSword: ReSword(),
    )
}
