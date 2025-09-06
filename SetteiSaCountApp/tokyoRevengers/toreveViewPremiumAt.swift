//
//  toreveViewPremiumAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/09/06.
//

import SwiftUI

struct toreveViewPremiumAt: View {
    @ObservedObject var toreve: Toreve
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text("・天上天下唯我独尊 成功時の一部で当選")
                    Text("・当選率に設定差あり")
                    Text("・レア役以外で当選すれば高設定の期待大!?")
                }
            } header: {
                Text("黒い衝動")
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
        .navigationTitle("東卍ラッシュバースト")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    toreveViewPremiumAt(
        toreve: Toreve(),
    )
}
