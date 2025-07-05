//
//  godeaterTableKyoCherryChokugeki.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/21.
//

import SwiftUI

struct godeaterTableKyoCherryChokugeki: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "強🍒でのAT直撃",
                percentList: [0.4,1.2,2.4,4.3,5.1,5.9],
                numberofDicimal: 1,
                maxWidth: 200,
            )
        }
    }
}

#Preview {
    godeaterTableKyoCherryChokugeki()
}
