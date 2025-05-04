//
//  dumbbellTableBonusFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct dumbbellTableBonusFirstHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "ボーナス初当り",
                denominateList: [591,576,546,532,512,504],
                maxWidth: 170
            )
        }
    }
}

#Preview {
    dumbbellTableBonusFirstHit()
}
