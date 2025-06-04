//
//  rezero2TableKiteiPtRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/29.
//

import SwiftUI

struct rezero2TableKiteiPtRatio: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "百の位 偶数",
                percentList: [25,25.4,25.8,28.5,29.7,31.3]
            )
            unitTablePercent(
                columTitle: "百の位 奇数",
                percentList: [1.2,1.6,2.0,2.3,2.7,3.1],
                numberofDicimal: 1
            )
        }
    }
}

#Preview {
    rezero2TableKiteiPtRatio()
}
