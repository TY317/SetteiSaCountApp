//
//  godKisekiTableKoyakuRen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/25.
//

import SwiftUI

struct godKisekiTableKoyakuRen: View {
    @ObservedObject var godKiseki: GodKiseki
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "リプ 3連",
                    percentList: godKiseki.ratioReplay3Hit,
                    numberofDicimal: 1,
                )
                unitTablePercent(
                    columTitle: "リプ 4連",
                    percentList: godKiseki.ratioReplay4Hit,
                )
            }
            .padding(.bottom)
            
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "黄7 3連",
                    percentList: [0.4],
                    numberofDicimal: 1,
                    lineList: [6],
                    colorList: [.white],
                )
                unitTablePercent(
                    columTitle: "黄7 4連",
                    percentList: [20.3],
                    numberofDicimal: 0,
                    lineList: [6],
                    colorList: [.white],
                )
            }
        }
    }
}

#Preview {
    godKisekiTableKoyakuRen(
        godKiseki: GodKiseki(),
    )
}
