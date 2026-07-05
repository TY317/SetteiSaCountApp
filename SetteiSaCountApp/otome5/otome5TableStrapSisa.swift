//
//  otome5TableStrapSisa.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/03.
//

import SwiftUI

struct otome5TableStrapSisa: View {
    let lineList1: [Int] = [2,2]
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "ストラップ出現"
                ],
                maxWidth: 80,
                lineList: [4]
            )
            unitTableString(
                columTitle: "",
                stringList: [
                    "同一キャラ2個",
                    "同一キャラ3個",
                ],
                maxWidth: 100,
                lineList: self.lineList1,
            )
            unitTableString(
                columTitle: "",
                stringList: [
                    "当該キャラのモード滞在期待度 32%",
                    "当該キャラのモード滞在期待度 95%",
                ],
                maxWidth: 250,
                lineList: self.lineList1,
            )
        }
    }
}

#Preview {
    otome5TableStrapSisa()
        .padding(.horizontal)
}
