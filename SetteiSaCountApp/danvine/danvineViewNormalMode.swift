//
//  danvineViewNormalMode.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/27.
//

import SwiftUI

struct danvineViewNormalMode: View {
    var body: some View {
        List {
            // 規定小Vベル
            Section {
                unitLinkButton(
                    title: "規定小Vベル回数表示について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "規定小Vベル回数表示",
                            textBody1: "・ダンバイン起動ミッションまでの規定小Vベル回数が表示される場合がある",
                            textBody2: "・残り3回から出現がデフォルト",
                            textBody3: "・残り4〜6回が表示されればその数字以上の設定が濃厚となる"
                        )
                    )
                )
            } header: {
                Text("規定小Vベル回数表示")
            }
        }
        .navigationTitle("通常時の演出、モード")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    danvineViewNormalMode()
}
