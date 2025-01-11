//
//  dumbbellViewCheatDay.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/01/03.
//

import SwiftUI

struct dumbbellViewCheatDay: View {
    var body: some View {
        List {
            Text("摂取カロリー数で設定を示唆する場合がある")
                .foregroundStyle(Color.secondary)
                .font(.footnote)
            Image("dumbbellCalorieSisa")
                .resizable()
                .scaledToFit()
        }
        .navigationTitle("チートデイ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    dumbbellViewCheatDay()
}
