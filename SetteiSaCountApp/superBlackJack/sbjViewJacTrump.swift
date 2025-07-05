//
//  sbjViewJacTrump.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/08.
//

import SwiftUI

struct sbjViewJacTrump: View {
    var body: some View {
        List {
            Text("現在データはスロプラNEXTで確認できます")
                .foregroundStyle(Color.secondary)
                .font(.footnote)
            // //// 参考情報リンク
            unitLinkButton(
                title: "トランプでの示唆について",
                exview: AnyView(
                    unitExView5body2image(
                        title: "トランプでの示唆",
                        textBody1: "・ALL設定バトルの結果を見るとミントの出現率が設定1・2と5・6で差があった",
                        textBody2: "・リオ、リナは低設定でも複数回出ていたので過信は禁物",
                        tableView: AnyView(sbjTableTrump())
//                        image1: Image("sbjJacTrump")
                    )
                )
            )
            
            // //// 広告
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "スーパーブラックジャック",
                screenClass: screenClass
            )
        }
        .navigationTitle("JAC中のトランプ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    sbjViewJacTrump()
}
