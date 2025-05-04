//
//  danvineTable11Pt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct danvineTable11Pt: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "11Pt選択率",
                percentList: [2.0,2.0,2.7,3.5,4.3,5.1],
                numberofDicimal: 1
            )
        }
    }
}

#Preview {
    danvineTable11Pt()
        .padding(.horizontal)
}
