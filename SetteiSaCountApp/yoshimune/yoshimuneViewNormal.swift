//
//  yoshimuneViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/19.
//

import SwiftUI

struct yoshimuneViewNormal: View {
    var body: some View {
        List {
            // //// 小役停止形
            Section {
                unitLinkButton(
                    title: "小役停止形",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "小役停止形",
                            image1: Image("yoshimuneKoyakuPattern")
                        )
                    )
                )
            }
            
            // //// モード
            Section {
                unitLinkButton(
                    title: "通常時のモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "通常時のモード",
                            textBody1: "・5つのモードで規定G数を管理。対象は液晶G数で実G数ではないため注意",
                            textBody2: "・ボーナス当選時に次回モードを抽選",
                            tableView: AnyView(yoshimuneTableMode())
                        )
                    )
                )
                unitLinkButton(
                    title: "モード示唆について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "モード示唆",
                            textBody1: "・前兆タイミングや演出でモード示唆する場合あり",
                            tableView: AnyView(yoshimuneTableModeSisa())
                        )
                    )
                )
                unitLinkButton(
                    title: "鷹狩りモードについて",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "鷹狩りモード",
                            textBody1: "・高確率以降時に鷹狩りに変換する抽選を管理するモード(5種類)",
                            textBody2: "・有利区間移行時に抽選され鷹狩り当選まで転落なし",
                            textBody3: "・通常時の押し順ナビ、高確率後の連続演出失敗時、REG開始時に昇格抽選"
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
                screenName: "吉宗",
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    yoshimuneViewNormal()
}
