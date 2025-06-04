//
//  mhrTableAtFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/27.
//

import SwiftUI

struct mhrTableAtFirstHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "AT",
                denominateList: [309.5,301.4,290.8,256.4,237.1,230.8]
            )
        }
    }
}

#Preview {
    mhrTableAtFirstHit()
}
