//
//  neoplaTableStatusSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/11/16.
//

import SwiftUI

struct neoplaTableStatusSisa: View {
    let lineList: [Int] = [1,2]
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "第3停止音 遅れ",
                    "遅れから30G以内に再度遅れ発生",
                ],
                lineList: self.lineList,
            )
            unitTableString(
                columTitle: "示唆",
                stringList: [
                    "高確状態示唆",
                    "高確濃厚",
                ],
                lineList: self.lineList,
            )
        }
    }
}

#Preview {
    neoplaTableStatusSisa()
        .padding(.bottom)
}
