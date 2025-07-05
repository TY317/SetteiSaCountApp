//
//  shamanKingViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/01.
//

import SwiftUI

struct shamanKingViewScreen: View {
    var body: some View {
        List {
            Section {
                Text("現在のカウントはユニメモで確認下さい")
                    .foregroundStyle(Color.secondary)
                    .font(.footnote)
                unitLinkButton(
                    title: "AT終了画面について",
                    exview: AnyView(
                        unitExView5body2image(
                            title: "AT終了画面",
                            textBody1: "キャラカスタムによってデフォルト画面が変化",
                            tableView: AnyView(shamanKingTableEndScreen())
//                            image1: Image("shamanKingAtEndScreen")
                        )
                    )
                )
            }
            
            // //// 広告
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "シャーマンキング",
                screenClass: screenClass
            )
        }
        .navigationTitle("AT終了画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    shamanKingViewScreen()
}
