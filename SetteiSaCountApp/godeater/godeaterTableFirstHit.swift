//
//  godeaterTableFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/21.
//

import SwiftUI

struct godeaterTableFirstHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "CZ",
                denominateList: [392.0,378.3,359.1,343.4,324.3,310.6]
            )
            unitTableDenominate(
                columTitle: "AT",
                denominateList: [351.9,344.5,330.1,317.0,302.2,290.3]
            )
        }
    }
}

#Preview {
    godeaterTableFirstHit()
}
