//
//  tokyoGhoulTableJakuCherryCz.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/02.
//

import SwiftUI

struct tokyoGhoulTableJakuCherryCz: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "通常",
                    percentList: [0.27,0.29,0.31,0.33,0.38,0.43],
                    numberofDicimal: 2
                )
                unitTablePercent(
                    columTitle: "高確",
                    percentList: [0.59,0.63,0.69,0.73,0.83,0.95],
                    numberofDicimal: 2
                )
            }
        }
    }
}

#Preview {
    tokyoGhoulTableJakuCherryCz()
}
