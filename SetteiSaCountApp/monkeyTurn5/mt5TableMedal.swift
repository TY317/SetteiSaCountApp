//
//  mt5TableMedal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct mt5TableMedal: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "青メダル",
                        "黄メダル",
                        "黒メダル",
                    ],
                    maxWidth: 100,
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "偶数示唆",
                        "高設定示唆 弱",
                        "高設定示唆 強",
                    ],
                    maxWidth: 200,
                )
            }
            .padding(.bottom)
            Text("[黒メダル出現率]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex(settingList: [1,2,4,5,6])
                unitTablePercent(
                    columTitle: "黒メダル",
                    percentList: [1.25,1.5,4,4.5,4.5],
                    numberofDicimal: 1,
                )
            }
        }
    }
}

#Preview {
    mt5TableMedal()
}
