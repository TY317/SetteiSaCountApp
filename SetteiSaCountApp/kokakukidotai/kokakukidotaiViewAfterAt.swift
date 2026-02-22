//
//  kokakukidotaiViewAfterAt.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/22.
//

import SwiftUI

struct kokakukidotaiViewAfterAt: View {
    @ObservedObject var kokakukidotai: Kokakukidotai
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            // 注意書き
            Text("設定変更時も同様の振分け")
                .foregroundStyle(Color.secondary)
                .font(.caption)
            
            // 振分け表
            kokakukidotaiTableAfterAt(kokakukidotai: kokakukidotai)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.kokakukidotaiMenuAfterAtBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: kokakukidotai.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("AT終了後")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    kokakukidotaiViewAfterAt(
        kokakukidotai: Kokakukidotai(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
