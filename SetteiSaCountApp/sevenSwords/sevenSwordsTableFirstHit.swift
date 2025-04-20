//
//  sevenSwordsTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/12.
//

import SwiftUI

struct sevenSwordsTableFirstHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ボーナス",
                denominateList: [228.0,222.0,209.7,185.6,173.5,164.7]
            )
            unitTableDenominate(
                columTitle: "ST",
                denominateList: [408.3,394.9,366.4,314.0,289.2,272.3]
            )
        }
    }
}

#Preview {
    sevenSwordsTableFirstHit()
}
