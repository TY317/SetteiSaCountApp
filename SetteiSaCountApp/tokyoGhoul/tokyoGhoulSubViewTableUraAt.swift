//
//  tokyoGhoulSubViewTableUraAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/22.
//

import SwiftUI

struct tokyoGhoulSubViewTableUraAt: View {
    @ObservedObject var tokyoGhoul = TokyoGhoul()
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "裏AT振分け",
                    percentList: tokyoGhoul.ratioUraAt,
                    numberofDicimal: 1
                )
            }
        }
    }
}

#Preview {
    tokyoGhoulSubViewTableUraAt()
}
