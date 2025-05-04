//
//  kaijiTableModeRatio.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/02.
//

import SwiftUI

struct kaijiTableModeRatio: View {
    var body: some View {
        VStack {
            Text("[ボーナス連チャン終了後]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "ﾓｰﾄﾞA",
                    percentList: [57.8,57.8,51.2,41.0,35.9,30.9]
                )
                unitTablePercent(
                    columTitle: "ﾓｰﾄﾞB",
                    percentList: [14.8,14.8,18.4,21.1,23.4,25]
                )
                unitTablePercent(
                    columTitle: "ﾓｰﾄﾞC",
                    percentList: [22.7,22.7,26.6,29.7,30.5,32]
                )
                unitTablePercent(
                    columTitle: "ﾓｰﾄﾞD",
                    percentList: [3.1,3.1,3.9,7.8,8.6,9.4],
                    numberofDicimal: 1
                )
            }
            .padding(.bottom)
            Text("[ボーナス単発後]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTablePercent(
                    columTitle: "ﾓｰﾄﾞA",
                    percentList: [43.8]
                )
                unitTablePercent(
                    columTitle: "ﾓｰﾄﾞB",
                    percentList: [6.3],
                    numberofDicimal: 1
                )
                unitTablePercent(
                    columTitle: "ﾓｰﾄﾞC",
                    percentList: [48.4]
                )
                unitTablePercent(
                    columTitle: "ﾓｰﾄﾞD",
                    percentList: [1.6],
                    numberofDicimal: 1
                )
            }
            .padding(.bottom)
            Text("[設定変更時]")
                .font(.title2)
            HStack(spacing: 0) {
                unitTablePercent(
                    columTitle: "ﾓｰﾄﾞA",
                    percentList: [60.2]
                )
                unitTablePercent(
                    columTitle: "ﾓｰﾄﾞB",
                    percentList: [9.4],
                    numberofDicimal: 1
                )
                unitTablePercent(
                    columTitle: "ﾓｰﾄﾞC",
                    percentList: [27.3]
                )
                unitTablePercent(
                    columTitle: "ﾓｰﾄﾞD",
                    percentList: [3.1],
                    numberofDicimal: 1
                )
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    kaijiTableModeRatio()
        .padding(.horizontal)
}
