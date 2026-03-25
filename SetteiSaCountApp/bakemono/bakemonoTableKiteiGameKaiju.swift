//
//  bakemonoTableKiteiGameKaiju.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/25.
//

import SwiftUI

struct bakemonoTableKiteiGameKaiju: View {
    @ObservedObject var bakemono: Bakemono
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "100G",
                percentList: [20],
                lineList: [6],
                colorList: [.white],
            )
            unitTablePercent(
                columTitle: "200G",
                percentList: bakemono.ratioKitei200
            )
            unitTablePercent(
                columTitle: "300G",
                percentList: bakemono.ratioKitei300
            )
        }
    }
}

#Preview {
    bakemonoTableKiteiGameKaiju(
        bakemono: Bakemono(),
    )
    .padding(.horizontal)
}
