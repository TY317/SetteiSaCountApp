//
//  karakuriTableMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/09.
//

import SwiftUI

struct karakuriTableMode: View {
    let lineList: [Int] = [1,1,2,1]
    var body: some View {
        HStack(spacing: 0) {
            unitTableString(
                columTitle: "",
                stringList: [
                    "通常A",
                    "通常B",
                    "通常C",
                    "天国",
                ],
                maxWidth: 80,
                lineList: self.lineList,
            )
            unitTableString(
                columTitle: "特徴",
                stringList: [
                    "百の位 偶数がゾーン",
                    "百の位 奇数がゾーン",
                    "百の位 偶数がゾーン\nAT濃厚",
                    "100G以内のCZ当選濃厚",
                ],
                maxWidth: 250,
                lineList: self.lineList,
            )
            unitTableString(
                columTitle: "天井",
                stringList: [
                    "1200G",
                    "800G",
                    "1200G",
                    "100G",
                ],
                maxWidth: 80,
                lineList: self.lineList,
            )
        }
    }
}

#Preview {
    karakuriTableMode()
        .padding(.horizontal)
}
