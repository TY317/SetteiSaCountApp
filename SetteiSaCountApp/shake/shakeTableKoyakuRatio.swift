//
//  shakeTableKoyakuRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import SwiftUI

struct shakeTableKoyakuRatio: View {
    @ObservedObject var shake: Shake
    var body: some View {
        HStack {
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,5,6])
                unitTableDenominate(
                    columTitle: "🔔",
                    denominateList: shake.ratioKoyakuBell,
                    numberofDicimal: 1,
                )
                unitTableDenominate(
                    columTitle: "🍒",
                    denominateList: shake.ratioKoyakuCherry,
                    numberofDicimal: 1,
                )
                unitTableDenominate(
                    columTitle: "🍉",
                    denominateList: shake.ratioKoyakuSuika,
                    numberofDicimal: 1,
                )
            }
        }
    }
}

#Preview {
    shakeTableKoyakuRatio(
        shake: Shake(),
    )
    .padding(.horizontal)
}
