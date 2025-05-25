//
//  toloveru87ViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/21.
//

import SwiftUI

struct toloveru87ViewFirstHit: View {
    var body: some View {
        List {
            Section {
                Text("現在値は打-WINで確認下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.caption)
                // 参考情報）初当り確率
                unitLinkButton(
                    title: "初当り確率",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "初当り確率",
                            tableView: AnyView(toloveru87TableFirstHit())
                        )
                    )
                )
                // 参考情報）規定ゲーム数
                unitLinkButton(
                    title: "規定ゲーム数での当選について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "規定ゲーム数での当選",
                            textBody1: "・規定ゲーム数は150,250,45,650とあり、ボーナス当選を抽選",
                            textBody2: "・高設定ほど250,650のゾーンからの当選が優遇されている"
                        )
                    )
                )
            }
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ToLOVEるver8.7",
                screenClass: screenClass
            )
        }
        .navigationTitle("AT初当り")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    toloveru87ViewFirstHit()
}
