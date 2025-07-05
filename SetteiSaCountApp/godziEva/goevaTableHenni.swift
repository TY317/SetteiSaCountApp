//
//  goevaTableHenni.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/21.
//

import SwiftUI

struct goevaTableHenni: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex(settingList: [1,6])
            unitTablePercent(
                columTitle: "小役変異",
                percentList: [79.7,-1],
                numberofDicimal: 1,
                titleFont: .body,
            )
            unitTablePercent(
                columTitle: "増殖変異",
                percentList: [13.8,-1],
                numberofDicimal: 1,
                titleFont: .body,
            )
            unitTablePercent(
                columTitle: "宇宙変異",
                percentList: [4.7,-1],
                numberofDicimal: 1,
                titleFont: .body,
            )
            unitTablePercent(
                columTitle: "活性化",
                percentList: [1.9,-1],
                numberofDicimal: 1,
                titleFont: .body,
            )
        }
    }
}

#Preview {
    goevaTableHenni()
        .padding(.horizontal)
}
