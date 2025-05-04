//
//  acceleratorTableShutterOpen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct acceleratorTableShutterOpen: View {
    var body: some View {
        HStack(spacing: 0) {
            unitTableSettingIndex()
            unitTablePercent(
                columTitle: "シャッター開放率",
                percentList: [33.2,34.8,36.7,38.7,40.6,44.9],
                maxWidth: 200
            )
        }
//        .padding(.horizontal)
    }
}

#Preview {
    acceleratorTableShutterOpen()
}
