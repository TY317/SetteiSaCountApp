//
//  tekken6TextScreenCaution.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/31.
//

import SwiftUI

struct tekken6TextScreenCaution: View {
    var body: some View {
        HStack {
            Text("⚠️")
            VStack(alignment: .leading) {
                Text("鉄拳チャンス中のBIG終了画面のみ設定示唆")
                Text("(それ以外は鉄拳チャンス期待度示唆)")
            }
            .font(.footnote)
        }
    }
}

#Preview {
    List {
        Section {
            tekken6TextScreenCaution()
        }
    }
}
