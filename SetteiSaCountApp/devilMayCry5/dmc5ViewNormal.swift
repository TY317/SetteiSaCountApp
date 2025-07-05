//
//  dmc5ViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/01.
//

import SwiftUI

struct dmc5ViewNormal: View {
    @ObservedObject var dmc5: Dmc5
    var body: some View {
        List {
            // //// 小役関連
            Section {
                // 小役停止形
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            textBody1: "・レア役はチャンス目のみ",
                            textBody2: "・DMC図柄が停止してリプレイ・ベル揃いなしでチャンス目",
                            textBody3: "・カバネリ、ToLOVEると同じ",
                            textBody4: "・全リール適当押しでOK"
                        )
                    )
                )
            } header: {
                Text("小役")
            }
            
            // //// モード
            Section {
                // 基本情報
                unitLinkButton(
                    title: "通常時のモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のモード",
                            textBody1: "・4つのモードで規定ゲーム数を管理",
                            textBody2: "・ゾーン外（100Gごと以外）のゲーム数でのボーナス当選は高設定の可能性がアップする",
                            tableView: AnyView(dmc5TableMode())
                        )
                    )
                )
                // モード推測
                unitLinkButton(
                    title: "モード推測について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "モード推測",
                            tableView: AnyView(dmc5TableModeSuisoku())
                        )
                    )
                )
            } header: {
                Text("モード")
            }
            
            // //// 広告
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: dmc5.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    dmc5ViewNormal(
        dmc5: Dmc5()
    )
}
