//
//  worldDaiStarTableKiteiGame.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/08/03.
//

import SwiftUI

struct worldDaiStarTableKiteiGame: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("・上位AT後の100Gゾーンは引き戻しCZに移行。そのためボーナス前兆へは移行しない")
            HStack(spacing: 0) {
                unitTableGameIndex(gameList: [100,200,300,400,500,600,700,800,900,999])
                unitTableZoneKitai(
                    columTitle: "ボーナス前兆",
                    kitaiList: [2,0,2,0,0,2,0,0,0,10]
                )
                unitTableZoneKitai(
                    columTitle: "高確移行",
                    kitaiList: [0,2,0,2,2,0,2,2,0,0,]
                )
            }
        }
    }
}

#Preview {
    worldDaiStarTableKiteiGame()
        .padding(.horizontal)
}
