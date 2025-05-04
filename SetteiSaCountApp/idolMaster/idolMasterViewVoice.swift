//
//  idolMasterViewVoice.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/01.
//

import SwiftUI

struct idolMasterViewVoice: View {
    var body: some View {
        List {
            Section {
                VStack {
                    Text("・MSC(ミリオンセブンチャンス)終了画面でサブ液晶タッチするとボイス発生")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・ボイス種類でモードを示唆")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .foregroundStyle(Color.secondary)
                .font(.caption)
                Text("詳細調査中")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
        .navigationTitle("MSC終了後ボイス")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    idolMasterViewVoice()
}
