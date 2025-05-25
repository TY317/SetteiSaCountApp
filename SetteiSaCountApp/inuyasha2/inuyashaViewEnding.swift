//
//  inuyashaViewEnding.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/22.
//

import SwiftUI

struct inuyashaViewEnding: View {
    var body: some View {
        List {
            Text("ブった斬りボーナス中のレア役成立時にPUSHボタン\nボイスの種類で設定を示唆")
                .foregroundStyle(Color.secondary)
                .font(.footnote)
            Image("inuyashaEnding")
                .resizable()
                .scaledToFit()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "犬夜叉2",
                screenClass: screenClass
            )
        }
        .navigationTitle("エンディング")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    inuyashaViewEnding()
}
