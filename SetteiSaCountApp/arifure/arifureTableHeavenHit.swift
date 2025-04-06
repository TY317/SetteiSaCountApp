//
//  arifureTableHeavenHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct arifureTableHeavenHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(titleLine: 2)
            unitTablePercent(
                columTitle: "リセット後\nAT終了後",
                percentList: [15,16,19,20,21,22],
                aboutBool: true,
                titleLine: 2
            )
            unitTablePercent(
                columTitle: "上位AT終了後",
                percentList: [15,16,19,24,31,40],
                aboutBool: true,
                titleLine: 2
            )
        }
    }
}

#Preview {
    arifureTableHeavenHit()
}
