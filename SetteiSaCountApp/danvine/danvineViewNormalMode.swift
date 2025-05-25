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
            
            // //// モードについて
            Section {
                // モードの概要
                unitLinkButton(
                    title: "モードの概要について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "モードの概要",
                            textBody1: "・通常時は4つのモードで管理",
                            tableView: AnyView(danvineTableMode())
//                            image1: Image("danvineMode"),
//                            image2: Image("danvineGetPoint")
                        )
                    )
                )
                // 高確移行
                unitLinkButton(
                    title: "高確移行について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "高確移行について",
                            textBody1: "・赤オーラ役以外での高確移行は全般的に良い挙動",
                            textBody2: "・フェラリオボーナス終了後の高確移行も高設定ほど優遇（設定1と6で10%程度の差）",
                            textBody3: "・ST終了後の高確移行も高設定ほど優遇"
                        )
                    )
                )
                // 超高確移行
                unitLinkButton(
                    title: "超高確移行について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "超高確移行について",
                            textBody1: "・通常ステージ(昼)から超高確ステージ(夜)への直接移行は高設定ほど優遇"
                        )
                    )
                )
            } header: {
                Text("モード")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ダンバイン",
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時の演出、モード")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    danvineViewNormalMode()
}
