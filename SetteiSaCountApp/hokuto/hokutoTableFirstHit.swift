//
//  hokutoTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct hokutoTableFirstHit: View {
    var body: some View {
        VStack {
            Text("[BB初当り]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,4,5,6])
                unitTableDenominate(
                    columTitle: "BB",
                    denominateList: [383.4,370.5,297.8,258.7,235.1]
                )
            }
            .padding(.bottom)
            Text("[天国中の当選率]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,4,5,6])
                unitTablePercent(
                    columTitle: "弱🍉",
                    percentList: [10.7,10.8,16,17.9,19.2]
                )
                unitTablePercent(
                    columTitle: "角🍒",
                    percentList: [1.8,1.9,3.9,5.4,7.1],
                    numberofDicimal: 1,
                )
            }
        }
    }
}

#Preview {
    hokutoTableFirstHit()
}
