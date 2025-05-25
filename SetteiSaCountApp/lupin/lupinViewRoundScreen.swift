//
//  lupinViewRoundScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/12.
//

import SwiftUI

struct lupinViewRoundScreen: View {
    var body: some View {
        List {
            Text("AT中のプレミアムラウンド画面で設定を示唆する場合がある")
                .foregroundStyle(Color.secondary)
                .font(.footnote)
            Image("lupinRoundScreen")
                .resizable()
                .scaledToFit()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "ルパン3世 大航海者の秘宝",
                screenClass: screenClass
            )
        }
        .navigationTitle("ラウンド開始画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    lupinViewRoundScreen()
}
