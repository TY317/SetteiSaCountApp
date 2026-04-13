//
//  godKisekiViewNormal.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/13.
//

import SwiftUI

struct godKisekiViewNormal: View {
    @ObservedObject var godKiseki: GodKiseki
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @EnvironmentObject var common: commonVar
    
    var body: some View {
        List {
            
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.godKisekiMenuNormalBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: godKiseki.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("通常時")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    godKisekiViewNormal(
        godKiseki: GodKiseki(),
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
