//
//  mhrTableRareDirectHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/27.
//

import SwiftUI

struct mhrTableRareDirectHit: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTableDenominate(
                columTitle: "弱レア役直撃",
                denominateList: [114335,77052,46637,36167,24277,18176]
            )
            unitTableDenominate(
                columTitle: "強レア役直撃",
                denominateList: [17877,8910,7132,5946,5098,4462]
            )
        }
    }
}

#Preview {
    mhrTableRareDirectHit()
        .padding(.horizontal)
}
