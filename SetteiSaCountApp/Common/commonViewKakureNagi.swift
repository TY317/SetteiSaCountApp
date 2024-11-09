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
            Text("打-WINで1000G消化ごとに抽選で設定示唆が出現するため要チェック")
                .foregroundStyle(.secondary)
            Text("セリフの色で設定を示唆")
                .foregroundStyle(.secondary)
            Image("commonKakureNagi")
                .resizable()
                .scaledToFit()
        }
        .navigationTitle("隠れ凪")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    commonViewKakureNagi()
}
