//
//  arifureTableAfterKokaku.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import SwiftUI

struct arifureTableAfterKokaku: View {
    @ObservedObject var arifure = Arifure()
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(titleLine: 2)
            unitTablePercent(
                columTitle: "設定変更時\nAT,上位AT終了後",
                percentList: [13,14,16,18,21,23],
                aboutBool: true,
                maxWidth: 180,
                titleLine: 2
            )
        }
    }
}

#Preview {
    arifureTableAfterKokaku()
}
