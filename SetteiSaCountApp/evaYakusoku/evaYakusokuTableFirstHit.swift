//
//  evaYakusokuTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/29.
//

import SwiftUI

struct evaYakusokuTableFirstHit: View {
    @ObservedObject var evaYakusoku: EvaYakusoku
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "黄BB",
                    denominateList: evaYakusoku.ratioYellowBB
                )
                unitTableDenominate(
                    columTitle: "赤SBB",
                    denominateList: evaYakusoku.ratioRedSBB
                )
                unitTableDenominate(
                    columTitle: "青SBB",
                    denominateList: evaYakusoku.ratioBlueSBB
                )
    //            unitTableDenominate(
    //                columTitle: "BIG合算",
    //                denominateList: evaYakusoku.ratioBigSum
    //            )
    //            unitTableDenominate(
    //                columTitle: "REG",
    //                denominateList: evaYakusoku.ratioReg
    //            )
    //            unitTableDenominate(
    //                columTitle: "合算",
    //                denominateList: evaYakusoku.ratioBonusSum
    //            )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "REG",
                    denominateList: evaYakusoku.ratioReg
                )
                unitTableDenominate(
                    columTitle: "暴走モード",
                    denominateList: evaYakusoku.ratioBosoReplay
                )
                unitTableDenominate(
                    columTitle: "合算",
                    denominateList: evaYakusoku.ratioBonusSum
                )
            }
        }
    }
}

#Preview {
    evaYakusokuTableFirstHit(
        evaYakusoku: EvaYakusoku(),
    )
    .padding(.horizontal)
}
