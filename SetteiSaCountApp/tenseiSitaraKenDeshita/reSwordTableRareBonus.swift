//
//  reSwordTableRareBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/02.
//

import SwiftUI

struct reSwordTableRareBonus: View {
    @ObservedObject var reSword: ReSword
    var body: some View {
        VStack {
            Text("・状態別のボーナス当選率に設定差があると思われる")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            Text("[通常]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "弱チャンス目",
                    percentList: reSword.ratioBonusJakuChance,
                )
                unitTablePercent(
                    columTitle: "スイカ",
                    percentList: reSword.ratioBonusSuika,
                )
                unitTablePercent(
                    columTitle: "強チャンス目",
                    percentList: reSword.ratioBonusKyoSuika,
                )
            }
            .padding(.bottom)
            Text("[ボーナス高確]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "弱チャンス目",
                    percentList: reSword.ratioBonusKokakuJakuChance,
                )
                unitTablePercent(
                    columTitle: "スイカ",
                    percentList: reSword.ratioBonusKokakuSuika,
                )
                unitTablePercent(
                    columTitle: "強チャンス目",
                    percentList: reSword.ratioBonusKokakuKyoSuika,
                )
            }
            .padding(.bottom)
            Text("[超高確]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "弱チャンス目",
                    percentList: reSword.ratioBonusChokokakuJakuChance,
                )
                unitTablePercent(
                    columTitle: "スイカ",
                    percentList: reSword.ratioBonusChokokakuSuika,
                )
                unitTablePercent(
                    columTitle: "強チャンス目",
                    percentList: reSword.ratioBonusChokokakuKyoSuika,
                )
            }
        }
    }
}

#Preview {
    ScrollView {
        reSwordTableRareBonus(
            reSword: ReSword(),
        )
        .padding(.horizontal)
    }
}
