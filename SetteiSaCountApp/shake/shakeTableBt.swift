//
//  shakeTableBt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import SwiftUI

struct shakeTableBt: View {
    @ObservedObject var shake: Shake
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [1,2,5,6])
            unitTablePercent(
                columTitle: "終了",
                percentList: shake.ratioJackEnd,
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "継続",
                percentList: shake.ratioJackContinue,
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "S",
                percentList: [shake.ratioJackSpecial[0]],
                numberofDicimal: 1,
                lineList: [4],
                colorList: [.white]
            )
        }
    }
}

#Preview {
    shakeTableBt(
        shake: Shake(),
    )
    .padding(.horizontal)
}
