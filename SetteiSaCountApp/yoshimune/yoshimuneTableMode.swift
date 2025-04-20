//
//  yoshimuneTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/19.
//

import SwiftUI

struct yoshimuneTableMode: View {
    let numberList: [Int] = [2,1,2,2,1]
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "通常A",
                    "通常B",
                    "天国準備",
                    "天国A",
                    "天国B"
                ],
                maxWidth: 90,
                lineList: self.numberList,
                contentFont: .body
            )
            unitTableString(
                columTitle: "特徴",
                stringList: [
                    "300,500,700G\nがチャンス",
                    "200,300Gがチャンス",
                    "次回天国濃厚\nゾーンに特徴あり",
                    "100G以内の当選\nが約30%",
                    "71.1％でループ"
                ],
                maxWidth: 250,
                lineList: self.numberList,
                contentFont: .body
            )
            unitTableString(
                columTitle: "天井",
                stringList: [
                    "999G+α",
                    "465G",
                    "999G+α",
                    "193G",
                    "193G"
                ],
                maxWidth: 100,
                lineList: self.numberList,
                contentFont: .body
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    yoshimuneTableMode()
}
