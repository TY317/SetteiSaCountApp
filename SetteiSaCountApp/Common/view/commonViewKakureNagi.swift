//
//  commonViewKakureNagi.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/11/09.
//

import SwiftUI

struct commonViewKakureNagi: View {
    var body: some View {
        List {
//            Text("打-WINで1000G消化ごとに抽選で設定示唆が出現するため要チェック")
//                .foregroundStyle(.secondary)
            Text("打-WINで設定示唆セリフが出現することがある")
                .foregroundStyle(.secondary)
                .font(.caption)
            Text("1000G消化ごとに出現抽選されるため、定期的にチェックを推奨")
                .foregroundStyle(.secondary)
                .font(.caption)
            Text("セリフの色で設定を示唆")
                .foregroundStyle(.secondary)
                .font(.caption)
            HStack(spacing: 0) {
                Spacer()
                unitTableString(
                    columTitle: "",
                    stringList: [
                        "白",
                        "緑",
                        "赤",
                        "銀",
                        "金"
                    ],
                    maxWidth: 70
                )
                unitTableString(
                    columTitle: "示唆",
                    stringList: [
                        "デフォルト",
                        "設定3 以上濃厚",
                        "設定4 以上濃厚",
                        "設定5 以上濃厚",
                        "設定6 濃厚"
                    ],
                    maxWidth: 180
                )
                Spacer()
            }
//            Image("commonKakureNagi")
//                .resizable()
//                .scaledToFit()
        }
        .navigationTitle("隠れ凪")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    commonViewKakureNagi()
}
