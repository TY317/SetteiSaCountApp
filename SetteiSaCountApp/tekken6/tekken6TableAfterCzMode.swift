//
//  tekken6TableAfterCzMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/04.
//

import SwiftUI

struct tekken6TableAfterCzMode: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "A",
                percentList: [75,73.6,69.5,65.6,63.9,62.7],
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "B",
                percentList: [20,20.3,21.5,22.1,22.4,22.5],
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "C",
                percentList: [3.5,4.2,5.5,6.6,7.4,7.8],
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "D",
                percentList: [0.9,1.3,2.4,3.8,4.2,4.5],
                numberofDicimal: 1,
            )
            unitTablePercent(
                columTitle: "E",
                percentList: [0.6,0.6,1.2,1.9,2.2,2.5],
                numberofDicimal: 1,
            )
        }
    }
}

#Preview {
    tekken6TableAfterCzMode()
        .padding(.horizontal)
}
