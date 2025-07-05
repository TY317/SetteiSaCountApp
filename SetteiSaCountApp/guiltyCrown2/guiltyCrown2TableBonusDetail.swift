//
//  guiltyCrown2TableBonusDetail.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/28.
//

import SwiftUI

struct guiltyCrown2TableBonusDetail: View {
    @ObservedObject var guiltyCrown2: GuiltyCrown2
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "弱🍉+赤異色",
                    denominateList: guiltyCrown2.ratioJakuRedIshoku,
                )
                unitTableDenominate(
                    columTitle: "強🍉+赤7",
                    denominateList: guiltyCrown2.ratioKyoRed,
                )
                unitTableDenominate(
                    columTitle: "強🍉+白7",
                    denominateList: guiltyCrown2.ratioKyoWhite,
                )
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTableDenominate(
                    columTitle: "強🍉+白異色",
                    denominateList: guiltyCrown2.ratioKyoWhiteIshoku,
                )
                unitTableDenominate(
                    columTitle: "合算",
                    denominateList: guiltyCrown2.ratioDetailSum,
                )
            }
        }
    }
}

#Preview {
    guiltyCrown2TableBonusDetail(
        guiltyCrown2: GuiltyCrown2(),
    )
    .padding(.horizontal)
}
