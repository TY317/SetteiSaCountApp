//
//  thunderTableBbKoyaku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/03/15.
//

import SwiftUI

struct thunderTableBbKoyaku: View {
    @ObservedObject var thunder: Thunder
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [1,2,5,6])
            unitTableDenominate(
                columTitle: "🔔B",
                denominateList: thunder.ratioBbBellB,
                numberofDicimal: 1,
            )
            unitTableDenominate(
                columTitle: "🔔C",
                denominateList: [thunder.ratioBbBellC[0], thunder.ratioBbBellC[2], ],
                numberofDicimal: 0,
                lineList: [2,2]
            )
            unitTableDenominate(
                columTitle: "リーチ目",
                denominateList: [thunder.ratioBbReach[0], thunder.ratioBbReach[2], ],
                numberofDicimal: 0,
                lineList: [2,2]
            )
        }
    }
}

#Preview {
    thunderTableBbKoyaku(
        thunder: Thunder(),
    )
    .padding(.horizontal)
}
