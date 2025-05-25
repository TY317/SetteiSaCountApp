//
//  idolMasterViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import SwiftUI

struct idolMasterViewNormal: View {
    var body: some View {
        List {
            // //// 小役停止形
            Section {
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            image1: Image("idolMasterKoyakuPattern")
                        )
                    )
                )
            } header: {
                Text("小役停止形")
            }
            
            // //// 通常モード
            Section {
                unitLinkButton(
                    title: "通常モードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常モード",
                            textBody1: "・規定ゲーム数によるボーナス当選を管理するモード",
                            textBody2: "・100,300,500,800Gがゾーン",
                            textBody3: "・高設定ほど300Gでの当選、天国移行が優遇される",
                            tableView: AnyView(idolMasterTableNormalMode())
                        )
                    )
                )
            } header: {
                Text("通常モード")
            }
            
            // //// ボーナス直撃高確
            Section {
                // 参考情報）高確について
                unitLinkButton(
                    title: "ボーナス直撃高確について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "ボーナス直撃高確",
                            textBody1: "・ボーナス直撃当選率がアップする状態",
                            textBody2: "・規定ゲーム数消化時に移行抽選",
                            textBody3: "・150,200,250,400,600Gがチャンス",
                            textBody4: "・移行率、滞在G数ともに高設定ほど優遇される"
                        )
                    )
                )
                // 参考情報）示唆演出について
                unitLinkButton(
                    title: "高確示唆演出について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "高確示唆演出",
                            tableView: AnyView(idolMasterTableKokaku())
                        )
                    )
                )
            } header: {
                Text("ボーナス直撃高確")
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "アイドルマスター ミリオンライブ！",
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    idolMasterViewNormal()
}
