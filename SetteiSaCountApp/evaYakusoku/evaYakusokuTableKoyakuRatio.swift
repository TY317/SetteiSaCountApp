//
//  evaYakusokuTableKoyakuRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/12.
//

import SwiftUI

struct evaYakusokuTableKoyakuRatio: View {
    @ObservedObject var evaYakusoku: EvaYakusoku
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "🔔",
                    denominateList: evaYakusoku.ratioBell,
                    numberofDicimal: 1,
                )
                unitTableDenominate(
                    columTitle: "🍒",
                    denominateList: evaYakusoku.ratioCherry,
                    numberofDicimal: 1,
                )
                unitTableDenominate(
                    columTitle: "強弱🍉",
                    denominateList: evaYakusoku.ratioSuikaSum,
                    numberofDicimal: 1,
                )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "リーチ目役",
                    denominateList: evaYakusoku.ratioReachMeYaku,
                    numberofDicimal: 0,
                )
//                unitTableDenominate(
//                    columTitle: "暴走リプレイ",
//                    denominateList: evaYakusoku.ratioBosoReplay,
//                    numberofDicimal: 0,
//                )
//                unitTableDenominate(
//                    columTitle: "全役合算",
//                    denominateList: evaYakusoku.ratioSuikaSum,
//                    numberofDicimal: 1,
//                )
            }
        }
    }
}

#Preview {
    evaYakusokuTableKoyakuRatio(
        evaYakusoku: EvaYakusoku(),
    )
    .padding(.horizontal)
}
