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
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "BIG合算",
                denominateList: evaYakusoku.ratioBigSum
            )
            unitTableDenominate(
                columTitle: "REG",
                denominateList: evaYakusoku.ratioReg
            )
            unitTableDenominate(
                columTitle: "合算",
                denominateList: evaYakusoku.ratioBonusSum
            )
        }
    }
}

#Preview {
    evaYakusokuTableFirstHit(
        evaYakusoku: EvaYakusoku(),
    )
    .padding(.horizontal)
}
