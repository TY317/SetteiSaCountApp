//
//  thunderTableKoyakuRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/14.
//

import SwiftUI

struct thunderTableKoyakuRatio: View {
    @ObservedObject var thunder: Thunder
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,5,6])
                unitTableDenominate(
                    columTitle: "🔔合算",
                    denominateList: thunder.ratioBellSum,
                    numberofDicimal: 1,
                )
                unitTableDenominate(
                    columTitle: "🍉",
                    denominateList: thunder.ratioSuika
                )
                unitTableDenominate(
                    columTitle: "🍒B",
                    denominateList: thunder.ratioCherryB,
                    numberofDicimal: 1,
                )
            }
        }
        .padding(.bottom)
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [1,2,5,6])
            unitTableDenominate(
                columTitle: "🔔A",
                denominateList: thunder.ratioBellA,
                numberofDicimal: 1,
            )
            unitTableDenominate(
                columTitle: "🔔B",
                denominateList: thunder.ratioBellB,
                numberofDicimal: 1,
            )
        }
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [1,2,5,6])
            unitTableDenominate(
                columTitle: "🍉A",
                denominateList: [108.3,109.6,99.6,101.9],
                numberofDicimal: 0,
            )
            unitTableDenominate(
                columTitle: "🍉B",
                denominateList: [322.8,329.3,296.5,303.4],
                numberofDicimal: 0,
            )
        }
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [1,2,5,6])
            unitTableDenominate(
                columTitle: "🍒A",
                denominateList: [99.8],
                numberofDicimal: 0,
                lineList: [4],
                colorList: [.white]
            )
            unitTableDenominate(
                columTitle: "🍒B",
                denominateList: thunder.ratioCherryB,
                numberofDicimal: 1,
            )
        }
    }
}

#Preview {
    thunderTableKoyakuRatio(
        thunder: Thunder(),
    )
    .padding(.horizontal)
}
