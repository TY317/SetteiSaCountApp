//
//  rslTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/29.
//

import SwiftUI

struct rslTableFirstHit: View {
//    @ObservedObject var rsl = Rsl()
    @ObservedObject var rsl: Rsl
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: rsl.settingList)
                unitTableDenominate(
                    columTitle: "BIG",
                    denominateList: rsl.ratioBigSum
                )
                unitTableDenominate(
                    columTitle: "REG",
                    denominateList: rsl.ratioReg
                )
                unitTableDenominate(
                    columTitle: "CZ",
                    denominateList: rsl.ratioCz
                )
                unitTableDenominate(
                    columTitle: "AT",
                    denominateList: rsl.ratioAt
                )
            }
            .padding(.bottom)
            Text("[ BIG内訳 ]")
                .font(.title2)
                .fontWeight(.bold)
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: rsl.settingList)
                unitTableDenominate(
                    columTitle: "赤7",
                    denominateList: rsl.ratioBigRed
                )
                unitTableDenominate(
                    columTitle: "青7",
                    denominateList: rsl.ratioBigBlue
                )
            }
        }
    }
}

#Preview {
    rslTableFirstHit(rsl: Rsl())
}
