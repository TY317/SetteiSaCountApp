//
//  rslTableReg3Yaku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/29.
//

import SwiftUI

struct rslTableReg3Yaku: View {
//    @ObservedObject var rsl = Rsl()
    @ObservedObject var rsl: Rsl
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: rsl.settingList)
            unitTableDenominate(
                columTitle: "キラめき目",
                denominateList: rsl.ratioRegKirameki,
                titleFont: .subheadline
            )
            unitTableDenominate(
                columTitle: "スイカ",
                denominateList: rsl.ratioRegSuika
            )
            unitTableDenominate(
                columTitle: "チャンス目",
                denominateList: rsl.ratioRegChance,
                titleFont: .subheadline
            )
            unitTableDenominate(
                columTitle: "合算",
                denominateList: rsl.ratioReg3YakuSum
            )
        }
    }
}

#Preview {
    rslTableReg3Yaku(rsl: Rsl())
}
