//
//  akudamaTableScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/18.
//

import SwiftUI

struct akudamaTableScreen: View {
    let lineList: [Int] = [1,2,2,2,2,]
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "処刑課",
                    "遊園地",
                    "十字架",
                    "ロケット",
                    "絶対隔離領域",
                ],
                maxWidth: 100,
                lineList: self.lineList,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "次回ATはバトルが近い示唆",
                    "次回ATは6セット以内にバトル濃厚\n否定で設定4以上濃厚",
                    "次回ATは5セット以内にバトル濃厚\n否定で設定4以上濃厚",
                    "次回ATは3セット以内にバトル濃厚\n否定で設定4以上濃厚",
                    "次回ATは1セット以内にバトル濃厚\n否定で設定4以上濃厚",
                ],
                maxWidth: 300,
                lineList: self.lineList,
            )
        }
    }
}

#Preview {
    akudamaTableScreen()
        .padding(.horizontal)
}
