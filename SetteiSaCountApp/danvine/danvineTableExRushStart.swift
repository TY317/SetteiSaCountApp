//
//  danvineTableExRushStart.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/05.
//

import SwiftUI

struct danvineTableExRushStart: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(titleLine: 2)
            unitTablePercent(
                columTitle: "上位ラッシュ後\n上位スタート当選率",
                percentList: [0.4,0.8,2.0,6.3,10.2,15.2],
                numberofDicimal: 1,
                maxWidth: 200,
                titleLine: 2
            )
        }
    }
}

#Preview {
    danvineTableExRushStart()
}
