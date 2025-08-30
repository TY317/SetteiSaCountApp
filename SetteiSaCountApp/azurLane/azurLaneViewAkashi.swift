//
//  azurLaneViewAkashi.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/29.
//

import SwiftUI

struct azurLaneViewAkashi: View {
    @ObservedObject var azurLane: AzurLane
    var body: some View {
        List {
            Section {
                VStack {
                    Text("・告知時の残りゲーム数で設定を示唆！？")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("・残りゲーム数が奇数or偶数かに注目！？")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: azurLane.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("明石チャレンジ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    azurLaneViewAkashi(
        azurLane: AzurLane(),
    )
}
