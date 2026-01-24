//
//  enen2ViewFirstHit.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/11.
//

import SwiftUI

struct enen2ViewFirstHit: View {
    @ObservedObject var enen2: Enen2
    @ObservedObject var bayes: Bayes   // BayesClassのインスタンス
    @ObservedObject var viewModel: InterstitialViewModel   // 広告クラスのインスタンス
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            // 初当り
            Section {
                
            } header: {
                Text("初当り")
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.enen2MenuFirstHitBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: enen2.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("初当り")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    enen2ViewFirstHit(
        enen2: Enen2(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
