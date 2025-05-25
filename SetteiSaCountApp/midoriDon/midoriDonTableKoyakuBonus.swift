//
//  midoriDonTableKoyakuBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/24.
//

import SwiftUI

struct midoriDonTableKoyakuBonus: View {
    @ObservedObject var midoriDon: MidoriDon
    var body: some View {
        VStack {
            Text("[通常滞在時]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "弱🍒",
                    percentList: [
                        midoriDon.ratioKoyakuBonusJakuCherry[0],
                        midoriDon.ratioKoyakuBonusJakuCherry[4]
                    ],
                    numberofDicimal: 1,
                    lineList: [4,2]
                )
                unitTablePercent(
                    columTitle: "弱🍉",
                    percentList: [
                        midoriDon.ratioKoyakuBonusJakuSuika[0],
                        midoriDon.ratioKoyakuBonusJakuSuika[4]
                    ],
                    numberofDicimal: 1,
                    lineList: [4,2]
                )
                unitTablePercent(
                    columTitle: "ﾁｬﾝｽ目",
                    percentList: [
                        midoriDon.ratioKoyakuBonusChance[0],
                        midoriDon.ratioKoyakuBonusChance[4],
                        midoriDon.ratioKoyakuBonusChance[5]
                    ],
                    numberofDicimal: 0,
                    lineList: [4,1,1]
                )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "強🍒",
                    percentList: [
                        midoriDon.ratioKoyakuBonusKyoCherry[0],
                        midoriDon.ratioKoyakuBonusKyoCherry[4]
                    ],
                    numberofDicimal: 0,
                    lineList: [3,3]
                )
                unitTablePercent(
                    columTitle: "強🍉",
                    percentList: [
                        midoriDon.ratioKoyakuBonusKyoSuika[0],
                        midoriDon.ratioKoyakuBonusKyoSuika[4]
                    ],
                    numberofDicimal: 0,
                    lineList: [3,3]
                )
            }
            .padding(.bottom)
            Text("[高確滞在時]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "弱🍒",
                    percentList: [
                        1.6
                    ],
                    numberofDicimal: 1,
                    lineList: [6],
                    colorList: [.white]
                )
                unitTablePercent(
                    columTitle: "弱🍉",
                    percentList: [
                        3.1,
                        5.1
                    ],
                    numberofDicimal: 1,
                    lineList: [4,2]
                )
                unitTablePercent(
                    columTitle: "ﾁｬﾝｽ目",
                    percentList: [
                        33.2
                    ],
                    numberofDicimal: 0,
                    lineList: [6],
                    colorList: [.white]
                )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "強🍒",
                    percentList: [
                        50
                    ],
                    numberofDicimal: 0,
                    lineList: [6],
                    colorList: [.white]
                )
                unitTablePercent(
                    columTitle: "強🍉",
                    percentList: [
                        66.8
                    ],
                    numberofDicimal: 0,
                    lineList: [6],
                    colorList: [.white]
                )
            }
        }
    }
}

#Preview {
    ScrollView {
        midoriDonTableKoyakuBonus(
            midoriDon: MidoriDon()
        )
        .padding(.horizontal)
    }
}
