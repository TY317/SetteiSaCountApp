//
//  dmc5TableCzCycle.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/11.
//

import SwiftUI

struct dmc5TableCzCycle: View {
    @ObservedObject var dmc5: Dmc5
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "1周期目",
                    percentList: dmc5.ratioCzCycleUpTo1,
                )
                unitTablePercent(
                    columTitle: "4周期まで",
                    percentList: dmc5.ratioCzCycleUpTo4,
                )
                unitTablePercent(
                    columTitle: "7周期まで",
                    percentList: dmc5.ratioCzCycleUpTo7,
                )
            }
            Text("※ 4周期まで：1〜4周期のどこかで当選する確率\n   7周期まで：1〜7周期のどこかで当選する確率")
                .foregroundStyle(Color.secondary)
                .font(.subheadline)
        }
    }
}

#Preview {
    dmc5TableCzCycle(
        dmc5: Dmc5(),
    )
    .padding(.horizontal)
}
