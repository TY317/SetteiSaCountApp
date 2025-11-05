//
//  tokyoGhoulTableSuperHigh.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/05.
//

import SwiftUI

struct tokyoGhoulTableSuperHigh: View {
    @ObservedObject var tokyoGhoul: TokyoGhoul
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "13G",
                percentList: [
                    tokyoGhoul.ratioSuperHighGame13[0],
                    tokyoGhoul.ratioSuperHighGame13[2],
                    tokyoGhoul.ratioSuperHighGame13[3],
                    tokyoGhoul.ratioSuperHighGame13[4],
                    tokyoGhoul.ratioSuperHighGame13[5],
                ],
                lineList: [2,1,1,1,1],
            )
            unitTablePercent(
                columTitle: "23G",
                percentList: [
                    tokyoGhoul.ratioSuperHighGame23[0],
                    tokyoGhoul.ratioSuperHighGame23[2],
                    tokyoGhoul.ratioSuperHighGame23[4],
                ],
                lineList: [2,2,2],
            )
            unitTablePercent(
                columTitle: "33G",
                percentList: [
                    tokyoGhoul.ratioSuperHighGame33[0],
                    tokyoGhoul.ratioSuperHighGame33[2],
                    tokyoGhoul.ratioSuperHighGame33[3],
                    tokyoGhoul.ratioSuperHighGame33[4],
                    tokyoGhoul.ratioSuperHighGame33[5],
                ],
                lineList: [2,1,1,1,1],
            )
        }
    }
}

#Preview {
    tokyoGhoulTableSuperHigh(
        tokyoGhoul: TokyoGhoul(),
    )
    .padding(.horizontal)
}
