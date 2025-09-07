//
//  toreveViewTomanChallenge.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/06.
//

import SwiftUI

struct toreveViewTomanChallenge: View {
    @ObservedObject var toreve: Toreve
    
    var body: some View {
        List {
            Section {
                Text("東卍チャンス中の東卍ラッシュ当選（昇格？）は高設定ほど優遇されている")
            }
            
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: toreve.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("東卍チャンス")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    toreveViewTomanChallenge(
        toreve: Toreve(),
    )
}
