//
//  mhrTableKiteiReplay.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/14.
//

import SwiftUI

struct mhrTableKiteiReplay: View {
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "80回以下",
                    percentList: [25,26.6,31.2,39,43.8,45.4]
                )
                unitTablePercent(
                    columTitle: "120回以上",
                    percentList: [75,73.4,68.7,60.9,56.3,54.8]
                )
            }
            .padding(.bottom)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "40回",
                    percentList: [12.5,13.3,15.6,19.5,21.9,22.7],
                    titleFont: .body,
                    contentFont: .body
                )
                unitTablePercent(
                    columTitle: "80回",
                    percentList: [12.5,13.3,15.6,19.5,21.9,22.7],
                    titleFont: .body,
                    contentFont: .body
                )
                unitTablePercent(
                    columTitle: "120回",
                    percentList: [25,24.2,21.9,20.3,19.5,18.8],
                    titleFont: .body,
                    contentFont: .body
                )
                unitTablePercent(
                    columTitle: "160回",
                    percentList: [25,24.6,23.4,20.3,18.4,18],
                    titleFont: .body,
                    contentFont: .body
                )
                unitTablePercent(
                    columTitle: "200回",
                    percentList: [25,24.6,23.4,20.3,18.4,18],
                    titleFont: .body,
                    contentFont: .body
                )
            }
        }
    }
}

#Preview {
    mhrTableKiteiReplay()
        .padding(.horizontal)
}
