//
//  evaYakusokuViewScreen.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/07/02.
//

import SwiftUI

struct evaYakusokuViewScreen: View {
    @ObservedObject var evaYakusoku: EvaYakusoku
    
    var body: some View {
        List {
            Section {
                Text("詳細調査中")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("・ボーナス終了画面で設定を示唆\n・カヲルは設定6 濃厚")
                    .foregroundStyle(Color.secondary)
            }
            
            // 広告
            unitAdBannerMediumRectangle()
        }
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: evaYakusoku.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("ボーナス終了画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    evaYakusokuViewScreen(
        evaYakusoku: EvaYakusoku(),
    )
}
