//
//  sbjViewEndScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/08.
//

import SwiftUI

struct sbjViewEndScreen: View {
    var body: some View {
        List {
            Text("現在データはスロプラNEXTで確認できます")
                .foregroundStyle(Color.secondary)
                .font(.footnote)
            // //// 参考情報リンク
            unitLinkButton(
                title: "終了画面について",
                exview: AnyView(
                    unitExView5body2image(
                        title: "終了画面",
                        textBody1: "・ボーナス終了時のサブ液晶で示唆画面",
                        textBody2: "・エピソードボーナス中のレア役時も示唆画面が出る",
                        tableView: AnyView(sbjTableEndScreen())
//                        image1: Image("sbjEndScreen")
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
        .navigationTitle("終了画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    sbjViewEndScreen()
}
