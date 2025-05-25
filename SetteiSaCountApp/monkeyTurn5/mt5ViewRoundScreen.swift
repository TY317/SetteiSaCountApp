//
//  mt5ViewRoundScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/27.
//

import SwiftUI

struct mt5ViewRoundScreen: View {
    var body: some View {
//        NavigationView {
            List {
                Image("mt5RoundScreen")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "モンキーターン5",
                screenClass: screenClass
            )
        }
            .navigationTitle("ラウンド開始画面")
            .navigationBarTitleDisplayMode(.inline)
//        }
//        .navigationTitle("ラウンド開始画面")
//        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    mt5ViewRoundScreen()
}
