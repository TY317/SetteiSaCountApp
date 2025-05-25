//
//  mhrViewDuringBonus.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/12/05.
//

import SwiftUI

struct mhrViewDuringBonus: View {
    var body: some View {
        List {
            Text("早期討伐時に流れるキャラ紹介ムービーでエンタライオンが登場すれば設定6濃厚")
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: "モンスターハンター ライズ",
                screenClass: screenClass
            )
        }
        .navigationTitle("ボーナス中のキャラ紹介")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    mhrViewDuringBonus()
}
