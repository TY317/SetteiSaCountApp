//
//  hokutoTenseiTableTengeki.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/31.
//

import SwiftUI

struct hokutoTenseiTableTengeki: View {
    @ObservedObject var hokutoTensei: HokutoTensei
    var body: some View {
        VStack {
            Text("・全4G（第3停止後にケンシロウとラオウの顔アップのゲーム〜どちらが攻撃するかの当落ゲーム）が全てハズレだった場合の成功期待度")
                .padding(.bottom)
            HStack(spacing: 0) {
                unitTableSettingIndex()
                unitTablePercent(
                    columTitle: "期待度",
                    percentList: hokutoTensei.ratioTengeki
                )
            }
        }
    }
}

#Preview {
    hokutoTenseiTableTengeki(
        hokutoTensei: HokutoTensei(),
    )
    .padding(.horizontal)
}
