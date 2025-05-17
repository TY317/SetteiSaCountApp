//
//  inuyashaTableCz333.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/11.
//

import SwiftUI

struct inuyashaTableCz333: View {
    var body: some View {
        VStack {
            Text("[CZ当選 100万回シミュレート値]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "333天井越えでの当選",
                    percentList: [17.7,17.2,16.8,13.8,8.1,5.1],
                    numberofDicimal: 1,
                    maxWidth: 250
                )
            }
            Text("※ 独自計算での算出値です。精度を保証するものではありません")
                .foregroundStyle(Color.secondary)
                .font(.caption)
                .padding(.bottom)
            Text("[CZ回数別の333G天井選択率]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "1周期",
                    percentList: [37.5,50.0,62.5,75.0],
                    lineList: [3,1,1,1]
                )
                unitTablePercent(
                    columTitle: "2周期",
                    percentList: [22.7,28.1,62.5,75.0],
                    lineList: [3,1,1,1]
                )
                unitTablePercent(
                    columTitle: "3周期",
                    percentList: [12.5,28.1,62.5,75.0],
                    lineList: [3,1,1,1]
                )
                unitTablePercent(
                    columTitle: "4周期",
                    percentList: [75.0,87.5],
                    lineList: [5,1]
                )
            }
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "5周期",
                    percentList: [6.3,22.7,62.5,75],
                    lineList: [3,1,1,1]
                )
                unitTablePercent(
                    columTitle: "6周期",
                    percentList: [25.0,37.5,50,62.5,75],
                    lineList: [2,1,1,1,1]
                )
                unitTablePercent(
                    columTitle: "7周期",
                    percentList: [10.2,12.5,16.4,22.7,62.5,75],
                    lineList: [1,1,1,1,1,1]
                )
                unitTablePercent(
                    columTitle: "8周期",
                    percentList: [37.5,50.0,75.0,87.5],
                    lineList: [3,1,1,1]
                )
            }
        }
    }
}

#Preview {
    inuyashaTableCz333()
        .padding(.horizontal)
}
