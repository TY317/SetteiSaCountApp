//
//  danvineTableHazure3ren.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct danvineTableHazure3ren: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "ハズレ3連",
                percentList: [19.9,20.3,20.7,24.6,27.3,30.1]
            )
            unitTablePercent(
                columTitle: "ハズレ4連",
                percentList: [50.4,50.4,50.8,51.6,52.3,53.1]
            )
        }
    }
}

#Preview {
    danvineTableHazure3ren()
        .padding(.horizontal)
}
