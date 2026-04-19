//
//  godKisekiTableGaisen3ren.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/19.
//

import SwiftUI

struct godKisekiTableGaisen3ren: View {
    var body: some View {
        VStack {
            Text("[リプ 3連時のG-STOP当選率]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "G-STOP当選",
                    percentList: [5,5,7.5,12.5,15,20],
                    numberofDicimal: 1,
                )
            }
            .padding(.bottom)
            Text("[黄7 3連時のGG当選率]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "GG当選",
                    percentList: [20,20,22.5,25,30,33.3],
                    numberofDicimal: 0,
                )
            }
        }
    }
}

#Preview {
    godKisekiTableGaisen3ren()
}
