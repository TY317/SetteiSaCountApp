//
//  mt5TableAoshimaScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct mt5TableAoshimaScreen: View {
    var body: some View {
        VStack {
            Text("[継続ストックなし]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,4,5,6])
                unitTablePercent(
                    columTitle: "ドレス",
                    percentList: [20,25,35,38,38]
                )
                unitTablePercent(
                    columTitle: "＆波多野",
                    percentList: [0,0,0,0,0]
                )
            }
            .padding(.bottom)
            Text("[継続ストックあり]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,4,5,6])
                unitTablePercent(
                    columTitle: "ドレス",
                    percentList: [20,25,35,41,41]
                )
                unitTablePercent(
                    columTitle: "＆波多野",
                    percentList: [0,0,0,5,5]
                )
            }
        }
    }
}

#Preview {
    mt5TableAoshimaScreen()
}
